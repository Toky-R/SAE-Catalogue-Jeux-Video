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
    nom           VARCHAR(100) NOT NULL,
    fabricant     VARCHAR(100)
);

CREATE TABLE Genre (
    id_genre INT AUTO_INCREMENT PRIMARY KEY,
    nom      VARCHAR(100) NOT NULL
);

CREATE TABLE Jeu_Plateforme (
    id_jeu  INT NOT NULL,
    id_plateforme INT NOT NULL,
    PRIMARY KEY (id_jeu, id_plateforme),
    FOREIGN KEY (id_jeu)        REFERENCES Jeu(id_jeu)          ON DELETE CASCADE,
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
('Rockstar North',    '10 Albany Street, Edinburgh',       'Royaume-Uni'),
('CD Projekt RED',    'ul. Jagiellonska 74, Varsovie',     'Pologne'),
('FromSoftware',      '2-10-14 Higashi-Gotanda, Tokyo',    'Japon'),
('Naughty Dog',       '3310 W Olympic Blvd, Santa Monica', 'Etats-Unis'),
('Nintendo EPD',      '11-1 Kamitoba hokotate-cho, Kyoto', 'Japon'),
('Larian Studios',    'Vrijdagmarkt 10, Gand',             'Belgique'),
('Guerrilla Games',   'Postbus 151, Amsterdam',            'Pays-Bas'),
('Insomniac Games',   '2255 N Ontario St, Burbank',        'Etats-Unis'),
('Valve Corporation', '10400 NE 4th St, Bellevue',         'Etats-Unis'),
('Mojang Studios',    'Sodermalm, Stockholm',              'Suede');
