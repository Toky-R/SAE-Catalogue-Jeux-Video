<?php
require_once '../config/db.php';
header('Content-Type: application/json; charset=utf-8');
$resultat = $pdo->query("SELECT * FROM plateforme ORDER BY nom");
$plateformes = $resultat->fetchAll();
echo json_encode($plateformes);
