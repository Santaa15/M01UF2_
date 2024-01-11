DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS characters_items;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS characters;

CREATE TABLE characters (
        id_character INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(24) NOT NULL,
        age INT NOT NULL,
        gender CHAR(1) NOT NULL,
        level INT NOT NULL,
        health INT NOT NULL,
        height FLOAT NOT NULL,
        weight FLOAT NOT NULL,
        origin CHAR(2) NOT NULL
);

INSERT INTO characters (name, age, gender, level, health, height, weight, origin)
VALUES
('El Fary', 86, 'N', 200, 70, 1.2, 47, 'GY'),
('El Cigala', 45, 'M', 150, 60, 2.4, 150, 'RU'),
('El Churumbel', 33, 'M', 33, 33, 3.3, 333, 'AS'),
('El Kiko', 1, 'F', 69, 100, 1.1, 420, 'RE');

CREATE TABLE stats (
        id_stat INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        reputation INT NOT NULL,
        speed INT NOT NULL,
        morality INT NOT NULL,
        defense INT NOT NULL,
        hunger INT NOT NULL,
        reflex INT NOT NULL,
        stamina INT NOT NULL,
        id_character INT UNSIGNED NOT NULL,
        FOREIGN KEY(id_character) REFERENCES characters(id_character)
);

INSERT INTO stats (reputation, speed, morality, defense, hunger, reflex, stamina, id_character)
VALUES (100, 40, 80, 10, 0, 0, -1, 1),
(60, 50, 40, 5, 0, 1, 10, 2),
(75, 30, 75, 7, 0, 0, 50, 3),
(90, 60, 80, 4, 0, 1, 30, 4);

CREATE TABLE items (
        id_item INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        item VARCHAR(24) NOT NULL,
        type VARCHAR(16) NOT NULL,
        weight FLOAT NOT NULL,
        shape INT NOT NULL,
        equipable BOOLEAN NOT NULL,
        rarity INT NOT NULL,
        uses INT NOT NULL,
        quantity INT NOT NULL
);

INSERT INTO items (item, type, weight, shape, equipable, rarity, uses, quantity)
VALUES ('Bollo', 'Comida', 0.1, 3, 0, 4, 1, 1),
('Guitarra Flamenca', 'Instrumento', 2, 3, 1, 100, 100, 1),
('Piti', 'Droga', 0.01, 1, 1, 10, 1, 1),
('Portátil', 'Tecnología', 2, 5, 1, 30, 50, 1),
('Pandereta', 'Instrumento', 0.2, 1, 1, 40, 1000, 1),
('Piano', 'Instrumento', 7, 1, 1, 75, 2000, 1),
('Escobilla del water', 'Limpieza', 0.1, 1, 1, 20, 1000, 1);


CREATE TABLE characters_items (
        id_character_item INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        id_character INT UNSIGNED NOT NULL,
        id_item INT UNSIGNED NOT NULL,
        FOREIGN KEY (id_character) REFERENCES characters(id_character),
        FOREIGN KEY (id_item) REFERENCES items(id_item)
);

INSERT INTO characters_items (id_character, id_item)
VALUES (1, 5),
(2,5),
(4,5),
(2,7),
(1,6),
(2,2),
(2,6),
(1,2),
(3,6),
(1,7);
