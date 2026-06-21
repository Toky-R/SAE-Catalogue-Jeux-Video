DROP TABLE IF EXISTS Jeu_Genre;
DROP TABLE IF EXISTS Jeu_Plateforme;
DROP TABLE IF EXISTS Jeu;
DROP TABLE IF EXISTS Developpeur;
DROP TABLE IF EXISTS Studio;
DROP TABLE IF EXISTS Plateforme;
DROP TABLE IF EXISTS Genre;

CREATE TABLE Studio (
    id_studio INT AUTO_INCREMENT PRIMARY KEY,
    nom  VARCHAR(150) NOT NULL,
    adresse  VARCHAR(255),
    pays  VARCHAR(100) NOT NULL
);

CREATE TABLE Developpeur (
    id_dev    INT AUTO_INCREMENT PRIMARY KEY,
    nom      VARCHAR(150) NOT NULL,
    site_web  VARCHAR(255),
    id_studio INT UNIQUE,
    FOREIGN KEY (id_studio) REFERENCES Studio(id_studio)
        ON DELETE SET NULL
);

CREATE TABLE Jeu (
    id_jeu  INT AUTO_INCREMENT PRIMARY KEY,
    titre   VARCHAR(200) NOT NULL,
    date_sortie  DATE,
    description  TEXT,
    prix    DECIMAL(6,2) DEFAULT 0.00,
    note_moyenne DECIMAL(3,1),
    image_url    VARCHAR(255),
    id_dev   INT,
    FOREIGN KEY (id_dev) REFERENCES Developpeur(id_dev)
        ON DELETE SET NULL
);

CREATE TABLE Plateforme (
    id_plateforme INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    fabricant VARCHAR(100)
);

CREATE TABLE Genre (
    id_genre INT AUTO_INCREMENT PRIMARY KEY,
    nom      VARCHAR(100) NOT NULL
);

CREATE TABLE Jeu_Plateforme (
    id_jeu  INT NOT NULL,
    id_plateforme INT NOT NULL,
    PRIMARY KEY (id_jeu, id_plateforme),
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE,
    FOREIGN KEY (id_plateforme) REFERENCES Plateforme(id_plateforme) ON DELETE CASCADE
);



CREATE TABLE Jeu_Genre (
    id_jeu INT NOT NULL,
    id_genre INT NOT NULL,
    PRIMARY KEY (id_jeu, id_genre),
    FOREIGN KEY (id_jeu)   REFERENCES Jeu(id_jeu)  ON DELETE CASCADE,
    FOREIGN KEY (id_genre) REFERENCES Genre(id_genre) ON DELETE CASCADE
);



INSERT INTO studio (nom, adresse, pays) VALUES
('Rockstar North','10 Albany Street, Edinburgh','Royaume-Uni'),
('CD Projekt RED','ul. Jagiellonska 74, Varsovie','Pologne'),
('FromSoftware','2-10-14 Higashi-Gotanda, Tokyo','Japon'),
('Naughty Dog','3310 W Olympic Blvd, Santa Monica', 'Etats-Unis'),
('Nintendo EPD','11-1 Kamitoba hokotate-cho, Kyoto', 'Japon'),
('Larian Studios','Vrijdagmarkt 10, Gand','Belgique'),
('Guerrilla Games','Postbus 151, Amsterdam','Pays-Bas'),
('Insomniac Games','2255 N Ontario St, Burbank','Etats-Unis'),
('Valve Corporation', '10400 NE 4th St, Bellevue','Etats-Unis'),
('Mojang Studios',    'Sodermalm, Stockholm','Suede');



INSERT INTO developpeur (nom, site_web, id_studio) VALUES
('Rockstar Games','https://www.rockstargames.com', 1),
('CD Projekt RED',  'https://www.cdprojektred.com',  2),
('FromSoftware','https://www.fromsoftware.jp', 3),
('Naughty Dog','https://www.naughtydog.com', 4),
('Nintendo','https://www.nintendo.com', 5),
('Larian Studios', 'https://larian.com', 6),
('Guerrilla Games', 'https://www.guerrilla-games.com', 7),
('Insomniac Games', 'https://insomniac.games', 8),
('Valve','https://www.valvesoftware.com', 9),
('Mojang','https://www.minecraft.net', 10);


INSERT INTO plateforme (nom, fabricant) VALUES
('PC', 'Multiple'),
('PlayStation 5',   'Sony'),
('PlayStation 4', 'Sony'),
('Xbox Series X', 'Microsoft'),
('Xbox One', 'Microsoft'),
('Nintendo Switch', 'Nintendo');




INSERT INTO genre (nom) VALUES
('Action'),
('RPG'),
('Open World'),
('Aventure'),
('Souls-like'),
('FPS'),
('Plateforme'),
('Survie'),
('Simulation'),
('Strategie');




INSERT INTO jeu (titre, date_sortie, description, prix, note_moyenne, id_dev) VALUES
('Red Dead Redemption 2', '2018-10-26', 'Western epique en monde ouvert situe en 1899. Incarnez Arthur Morgan, hors-la-loi dans un des derniers gangs du Far West.', 39.99, 9.7, 1),
('The Witcher 3: Wild Hunt', '2015-05-19', 'RPG fantasy acclaime par la critique. Incarnez Geralt de Riv, un chasseur de monstres dans un monde ouvert immense.', 29.99, 9.3, 2),
('Elden Ring', '2022-02-25', 'Action-RPG de FromSoftware cree avec George R.R. Martin. Explorez les Terres Intermediaires dans un monde ouvert hostile.', 59.99, 9.5, 3),
('The Last of Us Part II', '2020-06-19', 'Jeu action-aventure post-apocalyptique. Ellie part en quete de vengeance dans un monde ravage par une infection fongique.', 69.99, 9.3, 4),
('The Legend of Zelda: Tears of the Kingdom', '2023-05-12', 'Suite de Breath of the Wild. Link explore Hyrule et ses iles celestes pour retrouver Zelda disparue.', 59.99, 9.6, 5),
('Baldur\'s Gate 3', '2023-08-03', 'RPG base sur Donjons et Dragons 5e edition. Survivez a une invasion de flagelleurs mentaux dans les Royaumes Oublies.', 59.99, 9.6, 6),
('Horizon Zero Dawn', '2017-02-28', 'Action-RPG dans un monde post-apocalyptique peuple de machines-animaux. Incarnez Aloy, chasseuse redoutable.', 59.99, 8.8, 7),
('Marvel\'s Spider-Man 2', '2023-10-20', 'Incarnez Peter Parker et Miles Morales dans une aventure epique a New York face a Venom et Kraven le Chasseur.', 69.99, 9.2, 8),
('Half-Life: Alyx', '2020-03-23', 'Jeu de tir VR immersif dans l\'univers Half-Life. Alyx Vance combat les Combines pour liberer la Terre.', 59.99, 9.4, 9),
('Minecraft', '2011-11-18', 'Jeu de survie et de construction par blocs. Explorez un monde infini et construisez tout ce que vous imaginez.', 26.95, 9.0, 10),
('Dark Souls III', '2016-04-12', 'Action-RPG exigeant dans un royaume en declin. Affrontez des ennemis redoutables dans un univers sombre.', 59.99, 9.0, 3),
('Cyberpunk 2077', '2020-12-10', 'RPG en monde ouvert dans la megalopole Night City. Incarnez V, mercenaire a la recherche d\'un implant qui menace votre existence.', 59.99, 9.5 , 2),
('God of War Ragnarok', '2022-11-09', 'Suite de God of War 2018. Kratos et Atreus affrontent le Ragnarok dans un monde nordique somptueux.', 49.99, 9.4, 8),
('Hollow Knight', '2017-02-24', 'Metroidvania exigeant dans un royaume d''insectes souterrain en decadence. Exploration, combat et secrets caches.', 14.99, 9.2, 6),
('Hades', '2020-09-17', 'Rogue-like d''action ou vous incarnez Zagreus tentant de s''echapper des Enfers grecs.', 24.99, 9.3, 9),
('Sekiro: Shadows Die Twice', '2019-03-22', 'Action-aventure de FromSoftware dans le Japon feodal. Combat exigeant base sur le parry et la posture.', 39.99, 9.1, 3),
('Portal 2', '2011-04-18', 'Puzzle-game emblematique de Valve. Resolvez des enigmes avec un portail spatial dans les laboratoires Aperture.', 9.99, 9.5, 9),
('It Takes Two', '2021-03-26', 'Jeu d''aventure cooperatif. Un couple transforme en poupees doit cooperer pour sauver leur mariage.', 29.99, 8.9, 7),
('Diablo IV', '2023-06-06', 'Action-RPG sombre dans le monde de Sanctuaire. Combattez les forces demoniaques de Lilith.', 69.99, 8.4, 1),
('Stardew Valley', '2016-02-26', 'Simulation de ferme et de vie a la campagne. Cultivez, peche, et tissez des liens avec les habitants du village.', 13.99, 9.0, 10),
('Ghost of Tsushima', '2020-07-17', 'Action-aventure en monde ouvert dans le Japon feodal envahi par les Mongols. Incarnez le samourai Jin Sakai.', 39.99, 9.0, 4),
('Fortnite', '2017-07-25', 'Battle royale gratuit ou 100 joueurs s''affrontent sur une ile en construisant des structures.', 0.00, 8.0, 1);

INSERT INTO jeu_plateforme (id_jeu, id_plateforme) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),
(2,1),(2,2),(2,3),(2,4),(2,5),
(3,1),(3,2),(3,4),
(4,2),(4,3),
(5,6),
(6,1),(6,2),
(7,1),(7,2),(7,3),
(8,2),
(9,1),
(10,1),(10,2),(10,4),(10,6),
(11,1),(11,2),(11,3),(11,4),(11,5),
(12,1),(12,2),(12,4)
(13,1),(13,2),(13,3),
(14,1),(14,6),
(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),
(16,1),(16,2),(16,3),
(17,1),(17,2),(17,3),(17,4),(17,5),
(18,1),(18,2),(18,3),(18,4),(18,5),(18,6),
(19,1),(19,2),(19,3),(19,4),(19,5),
(20,1),(20,6),
(21,2),
(22,1),(22,2),(22,3),(22,4),(22,5),(22,6);

INSERT INTO jeu_genre (id_jeu, id_genre) VALUES
(1,1),(1,3),(1,4),
(2,2),(2,3),(2,4),
(3,1),(3,2),(3,5),
(4,1),(4,4),
(5,1),(5,3),(5,4),
(6,2),(6,4),(6,10),
(7,1),(7,2),(7,3),
(8,1),(8,4),
(9,1),(9,6),
(10,8),(10,9),
(11,1),(11,2),(11,5),
(12,1),(12,2),(12,3)
(13,1),(13,2),(13,4),
(14,1),(14,7),(14,5),
(15,1),(15,4),
(16,1),(16,5),
(17,1),
(18,4),
(19,1),(19,2),(19,3),
(20,9),(20,4),
(21,1),(21,3),(21,4),
(22,1),(22,6);


UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/4/44/Red_Dead_Redemption_II.jpg?_=20230109164036' WHERE id_jeu = 1;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/0/0c/Witcher_3_cover_art.jpg?_=20210716120347' WHERE id_jeu = 2;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/d/de/Elden-Ring-Shadow-of-the-Erdtree-cover-art.jpg?_=20260611055700' WHERE id_jeu = 3;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/4/4f/TLOU_P2_Box_Art_2.png?_=20260225000247' WHERE id_jeu = 4;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/f/fb/The_Legend_of_Zelda_Tears_of_the_Kingdom_cover.jpg?_=20220920000406' WHERE id_jeu = 5;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/1/12/Baldur%27s_Gate_3_cover_art.jpg' WHERE id_jeu = 6;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/3/3e/Horizon_Zero_Dawn_cover_art.jpg' WHERE id_jeu = 7;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/0/0f/SpiderMan2PS5BoxArt.jpeg' WHERE id_jeu = 8;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/pt/4/49/Half-Life_Alyx_Cover_Art.jpg?_=20200206013134' WHERE id_jeu = 9;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/ru/f/f4/Minecraft_Cover_Art.png?_=20230227140118' WHERE id_jeu = 10;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/tr/b/bb/Dark_souls_3_cover_art.jpg?_=20201209221300' WHERE id_jeu = 11;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/9/9f/Cyberpunk_2077_box_art.jpg?_=20230118153839' WHERE id_jeu = 12;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/e/ee/God_of_War_Ragnar%C3%B6k_cover.jpg' WHERE id_jeu = 13;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/d/de/Hollow_Knight_2026_cover_art.jpg' WHERE id_jeu = 14;
UPDATE jeu SET image_url = 'https://static.wikia.nocookie.net/hades_gamepedia_en/images/a/a0/Hades_Pack_Art.png/revision/latest?cb=20181213192439' WHERE id_jeu = 15;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/6/6e/Sekiro_art.jpg/250px-Sekiro_art.jpg' WHERE id_jeu = 16;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/f/f9/Portal2cover.jpg/250px-Portal2cover.jpg' WHERE id_jeu = 17;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/a/aa/It_Takes_Two_cover_art.png/250px-It_Takes_Two_cover_art.png' WHERE id_jeu = 18;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Diablo_IV_cover_art.png/250px-Diablo_IV_cover_art.png' WHERE id_jeu = 19;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/f/fd/Logo_of_Stardew_Valley.png/250px-Logo_of_Stardew_Valley.png' WHERE id_jeu = 20;
UPDATE jeu SET image_url = 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b6/Ghost_of_Tsushima.jpg/250px-Ghost_of_Tsushima.jpg' WHERE id_jeu = 21;
UPDATE jeu SET image_url = 'https://wiki.gamedetectives.net/images/thumb/7/78/FortniteLogo.jpg/1200px-FortniteLogo.jpg' WHERE id_jeu = 22;
