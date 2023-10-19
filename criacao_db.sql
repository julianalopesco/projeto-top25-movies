CREATE DATABASE imdb_top250_movies;
USE imdb_top250_movies;

-- Criando uma tabela com estrutura correspondente ao arquivo CSV

CREATE TABLE tb_top250_movies (
    id INT,
    Num INT,
    Title VARCHAR(255),
    Year INT,
    Released VARCHAR(255),
    Runtime VARCHAR(255),
    Genre VARCHAR(255),
    Director VARCHAR(255),
    Writer VARCHAR(255),
    Actors VARCHAR(255),
    Plot TEXT,
    Language VARCHAR(255),
    Country VARCHAR(255),
    Awards VARCHAR(255),
    Metascore INT,
    imdbRating FLOAT,
    imdbVotes VARCHAR(255),
    imdbID VARCHAR(255),
    Type VARCHAR(255),
    DVD VARCHAR(255),
    BoxOffice VARCHAR(255),
    Production VARCHAR(255),
    Website VARCHAR(255),
    PRIMARY KEY (id)
);

-- alterando o formado da coluna metascore para comportar os dados
ALTER TABLE tb_top250_movies MODIFY COLUMN Metascore VARCHAR(255) NULL;

-- importando o arquivo CSV:
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/imdb_top250_movies.csv'
INTO TABLE tb_top250_movies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Buscando por Diretor
SELECT * FROM tb_top250_movies WHERE Director LIKE '%James Gunn%';

-- Buscando por Produtora 
SELECT * FROM tb_top250_movies WHERE Production='Walt Disney Pictures';

-- Buscando por Duração
SELECT * FROM tb_top250_movies WHERE CAST(SUBSTRING(Runtime, 1, CHAR_LENGTH(Runtime) - 4) AS SIGNED) > 120;

-- Mostrando o Top 10: 
SELECT * FROM tb_top250_movies LIMIT 10;

-- Mostrando os mais votados: 
SELECT * FROM tb_top250_movies ORDER BY imdbVotes DESC LIMIT 10;

-- Agrupando por ano: 
SELECT Year, COUNT(*) as QtdFilmes FROM tb_top250_movies GROUP BY Year;

-- Agrupando por década: 
SELECT FLOOR(Year/10)*10 AS Decade, COUNT(*) as QtdeFilmes -- (Year/10)*10: obtém a década a partir do ano
FROM tb_top250_movies
GROUP BY FLOOR(Year/10)*10; -- FLOOR: função que arredonda o decimal para o inteiro mais próximo 

-- Diretores que mais aparecem:
SELECT Director, COUNT(*) as Count
FROM tb_top250_movies
GROUP BY Director
ORDER BY Count DESC LIMIT 10;