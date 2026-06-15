<?php
header('Content-Type: application/json; charset=utf-8');
require_once '../config/db.php';
echo json_encode($pdo->query("SELECT * FROM genre ORDER BY nom")->fetchAll());
