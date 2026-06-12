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


