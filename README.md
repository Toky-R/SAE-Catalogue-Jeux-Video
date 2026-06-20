# SAE-Catalogue-Jeux-Video

SAE INFOA1 / INFO1 - Sup Galilee
Application web dynamique de gestion d'un catalogue de jeux video.

Presentation:

Notre catalogue de jeux video permet de consulter et ajouter des jeux video depuis une interface web moderne. L'application repose sur une base de donnees MySQL interrogee en PHP via PDO.

Les donnees initiales proviennent de sources ouvertes et fiables.


## Structure du projet

SAEJeuxVideo/
├── index.php               <-Interface principale
├── schema.sql              <-Creation BDD + donnees reelles
├── includes/
│   └── db.php              <-Connexion PDO
├── api/
│   ├── jeux.php            <-jeux (GET / POST / DELETE)
│   ├── genres.php          <-Liste des genres
│   ├── plateformes.php     <-Liste des plateformes
│   └── devs.php            <-Liste des developpeurs
└── README.md


# Installation :

Prerequis : XAMPP (Apache + MySQL)

Etapes : 

1. Cloner le depot dans htdocs/ :

 C:/xampp/htdocs/SAE-Catalogue-Jeux-Video-main


2. Importer la base de donnees :
   - Ouvrir phpMyAdmin : http://localhost/phpmyadmin
   - Onglet "Importer" -> selectionner schema.sql -> Executer

3. Lancer l'application :
   - Ouvrir : http://localhost/SAE-Catalogue-Jeux-Video-main/
