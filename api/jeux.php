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
