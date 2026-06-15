<?php
require_once '../config/db.php';
header('Content-Type: application/json; charset=utf-8');
$methode = $_SERVER['REQUEST_METHOD'];
if ($methode === 'GET') {
    $requete = "
        SELECT j.id_jeu, j.titre, j.date_sortie, j.description,
               j.prix, j.note_moyenne,
               d.nom AS developpeur,
               GROUP_CONCAT(DISTINCT g.nom ORDER BY g.nom SEPARATOR ', ') AS genres,
               GROUP_CONCAT(DISTINCT p.nom ORDER BY p.nom SEPARATOR ', ') AS plateformes
        FROM jeu j
        LEFT JOIN developpeur d ON j.id_dev = d.id_dev
        LEFT JOIN jeu_genre jg ON j.id_jeu = jg.id_jeu
        LEFT JOIN genre g ON jg.id_genre = g.id_genre
        LEFT JOIN jeu_plateforme jp ON j.id_jeu = jp.id_jeu
        LEFT JOIN plateforme p ON jp.id_plateforme = p.id_plateforme
        GROUP BY j.id_jeu
        ORDER BY j.titre ASC
    ";
    $resultat = $pdo->query($requete);
    $jeux = $resultat->fetchAll();
    echo json_encode($jeux);
}


if ($methode === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $requete = $pdo->prepare("
        INSERT INTO jeu (titre, date_sortie, description, prix, note_moyenne, id_dev)
        VALUES (:titre, :date_sortie, :description, :prix, :note_moyenne, :id_dev)
    ");

    $requete->execute([
        ':titre' => $data['titre'],
        ':date_sortie' => $data['date_sortie'] ?? null,
        ':description' => $data['description'] ?? null,
        ':prix' => $data['prix'],
        ':note_moyenne' => $data['note_moyenne'] ?? null,
        ':id_dev' => $data['id_dev'],
    ]);
    $id = $pdo->lastInsertId();
    if (!empty($data['genres'])) {
        $ins = $pdo->prepare("INSERT INTO jeu_genre (id_jeu, id_genre) VALUES (?, ?)");
        foreach ($data['genres'] as $id_genre) {
            $ins->execute([$id, $id_genre]);
        }
    }
    if (!empty($data['plateformes'])) {
        $ins = $pdo->prepare("INSERT INTO jeu_plateforme (id_jeu, id_plateforme) VALUES (?, ?)");
        foreach ($data['plateformes'] as $id_plateforme) {
            $ins->execute([$id, $id_plateforme]);
        }
    }
    echo json_encode(['success' => true, 'id_jeu' => $id]);
}


if ($methode === 'DELETE') {
    $id = $_GET['id'];
    $requete = $pdo->prepare("DELETE FROM jeu WHERE id_jeu = ?");
    $requete->execute([$id]);
    echo json_encode(['success' => true]);
}
