<?php
require_once '../config/db.php';
header('Content-Type: application/json; charset=utf-8');
$resultat = $pdo->query("SELECT id_dev, nom FROM developpeur ORDER BY nom");
$developpeurs = $resultat->fetchAll();
echo json_encode($developpeurs);
