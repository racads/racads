CREATE DATABASE streaming;

USE streaming;

CREATE TABLE filmes (
filme_id INT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
genero VARCHAR(100) NOT NULL,
ano_lancamento INT,
duracao_min INT,
classificacao DECIMAL(10,2),
nota_imdb DECIMAL(10,2));

CREATE TABLE usuarios (
usuario_id INT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
plano VARCHAR(100) NOT NULL,
pais VARCHAR(100) NOT NULL,
data_cadastro DATE); 

CREATE TABLE avaliacoes (
avaliacao_id INT,
usuario_id INT,
filme_id INT,
nota DECIMAL(10,2),
data_avaliacao DATE, 
assistiu_completo VARCHAR(100) NOT NULL,
FOREIGN KEY (filme_id) REFERENCES filmes(filme_id),
FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id));

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/Users/rafael.armando/Desktop/filmes.csv'
INTO TABLE filmes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(filme_id, titulo, genero, ano_lancamento, duracao_min, classificacao, nota_imdb);

LOAD DATA INFILE "C:/Users/rafael.armando/Desktop/usuarios.csv"
INTO TABLE usuarios
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(usuario_id, nome, email, pais, plano, data_cadastro);

DROP TABLE filmes;
DROP TABLE avaliacoes;

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/Users/rafael.armando/Desktop/filmes.csv'
INTO TABLE filmes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(filme_id, titulo, genero, ano_lancamento, duracao_min, classificacao, nota_imdb);

CREATE DATABASE streaming;

USE streaming;

CREATE TABLE filmes (
filme_id INT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
genero VARCHAR(100) NOT NULL,
ano_lancamento INT,
duracao_min INT,
classificacao VARCHAR(100) NOT NULL,
nota_imdb DECIMAL(3,1));

DROP TABLE filmes;

DROP TABLE avaliacoes;

DROP TABLE filmes;

DROP TABLE usuarios;

USE streaming;

CREATE TABLE filmes (
filme_id INT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
genero VARCHAR(100) NOT NULL,
ano_lancamento INT,
duracao_min INT,
classificacao VARCHAR(100) NOT NULL,
nota_imdb DECIMAL(3,1));

CREATE TABLE usuarios (
usuario_id INT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
plano VARCHAR(100) NOT NULL,
pais VARCHAR(100) NOT NULL,
data_cadastro DATE); 

CREATE TABLE avaliacoes (
avaliacao_id INT,
usuario_id INT,
filme_id INT,
nota DECIMAL(10,2),
data_avaliacao DATE, 
assistiu_completo VARCHAR(100) NOT NULL,
FOREIGN KEY (filme_id) REFERENCES filmes(filme_id),
FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id));

# *obs: na dimensão basta colocar "id"

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/Users/rafael.armando/Desktop/filmes.csv'
INTO TABLE filmes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(filme_id, titulo, genero, ano_lancamento, duracao_min, classificacao, nota_imdb);

LOAD DATA INFILE "C:/Users/rafael.armando/Desktop/usuarios.csv"
INTO TABLE usuarios
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(usuario_id, nome, email, pais, plano, data_cadastro);

LOAD DATA INFILE 'C:/Users/rafael.armando/Desktop/avaliacoes.csv'
INTO TABLE avaliacoes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(avaliacao_id, usuario_id, filme_id, nota, data_avaliacao, assistiu_completo);

-- Consulta 01
SELECT usuarios.nome, filmes.titulo, avaliacoes.nota
FROM avaliacoes
JOIN usuarios ON usuarios.usuario_id = avaliacoes.usuario_id
JOIN filmes ON filmes.filme_id = avaliacoes.filme_id;

-- Consulta 02
SELECT filmes.titulo, avaliacoes.nota, usuarios.nome
FROM avaliacoes
JOIN filmes ON filmes.filme_id = avaliacoes.filme_id
JOIN usuarios ON usuarios.usuario_id = avaliacoes.usuario_id;

-- Consulta 03
SELECT filmes.titulo, avaliacoes.nota, usuarios.nome
FROM avaliacoes
JOIN filmes ON filmes.filme_id = avaliacoes.filme_id
JOIN usuarios ON avaliacoes.usuario_id = usuarios.usuario_id
WHERE avaliacoes.nota = 5;

-- Consulta 04
SELECT avaliacoes.usuario_id, usuarios.nome, COUNT(avaliacoes.avaliacao_id) AS total_avaliacoes
FROM avaliacoes
JOIN usuarios ON avaliacoes.usuario_id = usuarios.usuario_id
GROUP BY avaliacoes.usuario_id, usuarios.nome
ORDER BY total_avaliacoes
DESC; 

-- Consulta 05
SELECT filmes.titulo, ROUND(AVG(avaliacoes.nota),2) AS media_notas
FROM filmes
JOIN avaliacoes ON filmes.filme_id = avaliacoes.filme_id
GROUP BY filmes.titulo;

-- Consulta 06
SELECT filmes.titulo, filmes.genero, COUNT(avaliacoes.avaliacao_id) AS total_avaliacoes
FROM avaliacoes
LEFT JOIN filmes ON filmes.filme_id = avaliacoes.avaliacao_id
GROUP BY filmes.titulo;

-- Consulta 07
SELECT filmes.titulo, filmes.genero
FROM filmes
LEFT JOIN avaliacoes ON filmes.filme_id = avaliacoes.filme_id
WHERE avaliacoes.avaliacao_id = NULL;

-- Consulta 08
SELECT usuarios.nome, usuarios.pais, filmes.titulo, usuarios.plano
FROM avaliacoes
LEFT JOIN usuarios ON usuarios.usuario_id = avaliacoes.usuario_id
LEFT JOIN filmes ON avaliacoes.filme_id = filmes.filme_id
WHERE usuarios.plano= "Premium"
GROUP BY usuarios.nome;

-- Consulta 09
SELECT filmes.titulo, filmes.genero, COUNT(avaliacoes.avaliacao_id) AS notas_brasileiros
FROM avaliacoes
JOIN filmes ON filmes.filme_id = avaliacoes.filme_id
JOIN usuarios ON avaliacoes.usuario_id = usuarios.usuario_id
WHERE usuarios.pais = "Brasil"
GROUP BY filmes.titulo
ORDER BY notas_brasileiros
DESC;

-- Consulta 10
SELECT usuarios.nome, filmes.titulo, avaliacoes.nota, avaliacoes.assistiu_completo
FROM avaliacoes
JOIN usuarios ON usuarios.usuario_id = avaliacoes.usuario_id
JOIN filmes ON avaliacoes.filme_id = filmes.filme_id
WHERE assistiu_completo = "N";

