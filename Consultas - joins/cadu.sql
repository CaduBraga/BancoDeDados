CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) UNIQUE,
    data_nascimento DATE NOT NULL
);
CREATE TABLE Livro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    ano_publicacao YEAR NOT NULL CHECK (ano_publicacao >= 1800),
    genero ENUM('Ficção', 'Não Ficção', 'Técnico', 'Acadêmico') NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);
CREATE TABLE Funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo ENUM('Bibliotecário', 'Atendente') NOT NULL
);
CREATE TABLE Emprestimo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_devolucao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_livro) REFERENCES Livro (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Usuario (nome, email, telefone, data_nascimento) VALUES
('Ana Souza', 'ana.souza@email.com', '11987654321', '1995-04-12'),
('Carlos Pereira', 'carlos.pereira@email.com', '11976543210', '1988-07-25'),
('Mariana Lima', 'mariana.lima@email.com', '11965432109', '2000-01-15'),
('Pedro Almeida', 'pedro.almeida@email.com', '11954321098', '1992-11-30'),
('Juliana Costa', 'juliana.costa@email.com', '11943210987', '1997-05-18'),
('Fernando Oliveira', 'fernando.oliveira@email.com', '11932109876', '1985-08-09'),
('Camila Santos', 'camila.santos@email.com', '11921098765', '1999-09-21'),
('Roberto Mendes', 'roberto.mendes@email.com', '11910987654', '1994-12-10'),
('Bianca Ribeiro', 'bianca.ribeiro@email.com', '11909876543', '1989-03-07'),
('Diego Martins', 'diego.martins@email.com', '11908765432', '2002-06-05');

INSERT INTO Livro (titulo, autor, ano_publicacao, genero, disponivel) VALUES
('1984', 'George Orwell', 1949, 'Ficção', TRUE),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 'Ficção', TRUE),
('O Código Da Vinci', 'Dan Brown', 2003, 'Ficção', TRUE),
('Sapiens', 'Yuval Noah Harari', 2011, 'Não Ficção', TRUE),
('Uma Breve História do Tempo', 'Stephen Hawking', 1988, 'Não Ficção', TRUE),
('Introdução à Programação com Python', 'Nilo Neves', 2010, 'Técnico', TRUE),
('Banco de Dados Relacional', 'Elmasri & Navathe', 2019, 'Técnico', TRUE),
('Inteligência Artificial', 'Stuart Russell', 2020, 'Acadêmico', TRUE),
('A Revolução dos Bichos', 'George Orwell', 1945, 'Ficção', TRUE),
('Clean Code', 'Robert C. Martin', 2008, 'Técnico', TRUE);

INSERT INTO Funcionario (nome, cargo) VALUES
('Luciana Braga', 'Bibliotecário'),
('André Souza', 'Atendente'),
('Beatriz Nunes', 'Bibliotecário'),
('João Silva', 'Atendente'),
('Fernanda Rocha', 'Bibliotecário'),
('Paulo Mendes', 'Atendente'),
('Carla Figueiredo', 'Bibliotecário'),
('Bruno Castro', 'Atendente'),
('Vanessa Moreira', 'Bibliotecário'),
('Ricardo Alves', 'Atendente');

INSERT INTO Emprestimo (id_usuario, id_livro, id_funcionario, data_devolucao) VALUES
(1, 2, 3, '2025-03-10'),
(2, 5, 1, '2025-03-15'),
(3, 8, 2, '2025-03-20'),
(4, 10, 4, '2025-03-25'),
(5, 1, 5, '2025-04-01'),
(6, 3, 6, '2025-04-05'),
(7, 7, 7, '2025-04-10'),
(8, 9, 8, '2025-04-15'),
(9, 4, 9, '2025-04-20'),
(10, 6, 10, '2025-04-25');

START TRANSACTION;
SAVEPOINT antes_do_emprestimo;
INSERT INTO Emprestimo (id_usuario, id_livro, id_funcionario, data_devolucao)
VALUES (1, 2, 3, '2025-03-10');
UPDATE Livro 
SET disponivel = FALSE 
WHERE id = 2;

/*
Simulação de erro: tentar inserir um empréstimo com um usuário inexistente
INSERT INTO Emprestimo (id_usuario, id_livro, id_funcionario, data_devolucao)
VALUES (999, 2, 3, '2025-03-10');
*/

COMMIT;

-- Consultas:

SELECT * FROM Usuario;
SELECT * FROM Livro WHERE genero = 'Ficção';
SELECT * FROM Emprestimo WHERE id_usuario >= 5;
SELECT * FROM Emprestimo WHERE data_devolucao IS NULL;
SELECT * FROM Livro WHERE ano_publicacao > 2000;
SELECT * FROM Usuario WHERE data_nascimento < '1990-01-01';
SELECT * FROM Usuario WHERE email = 'mariana.lima@email.com';
SELECT * FROM Livro WHERE ano_publicacao > 2000;
SELECT * FROM Usuario ORDER BY nome ASC;
SELECT * FROM Livro ORDER BY ano_publicacao DESC;
SELECT * FROM Livro LIMIT 5;
SELECT * FROM Usuario WHERE telefone = 11987654321;
SELECT * FROM Livro ORDER BY ano_publicacao ASC;
SELECT COUNT(*) FROM Usuario;
SELECT DISTINCT genero FROM Livro;
SELECT nome, email FROM Usuario;

SELECT * FROM Emprestimo 
WHERE data_devolucao BETWEEN '2025-03-01' AND '2025-03-15';

SELECT Livro.genero, COUNT(Emprestimo.id) AS total_emprestimos
FROM Emprestimo
JOIN Livro ON Emprestimo.id_livro = Livro.id
GROUP BY Livro.genero;

SELECT Livro.titulo, COUNT(Emprestimo.id) AS total_emprestimos
FROM Livro
JOIN Emprestimo ON Livro.id = Emprestimo.id_livro
GROUP BY Livro.id
ORDER BY total_emprestimos DESC;

SELECT Funcionario.nome, COUNT(Emprestimo.id) AS total_emprestimos
FROM Funcionario
JOIN Emprestimo ON Funcionario.id = Emprestimo.id_funcionario
GROUP BY Funcionario.id
ORDER BY total_emprestimos DESC;

SELECT Livro.titulo
FROM Livro
LEFT JOIN Emprestimo ON Livro.id = Emprestimo.id_livro
WHERE Emprestimo.id = 2;

SELECT Livro.titulo, COUNT(Emprestimo.id) AS total_emprestimos
FROM Livro
JOIN Emprestimo ON Livro.id = Emprestimo.id_livro
GROUP BY Livro.id
HAVING total_emprestimos > 1;

SELECT * FROM Usuario 
WHERE YEAR(CURDATE()) - YEAR(data_nascimento) > 30;

SELECT 
    E.id AS emprestimo_id, 
    U.nome AS usuario, 
    L.titulo AS livro, 
    F.nome AS funcionario, 
    E.data_emprestimo, 
    E.data_devolucao 
FROM Emprestimo E
JOIN Usuario U ON E.id_usuario = U.id
JOIN Livro L ON E.id_livro = L.id
JOIN Funcionario F ON E.id_funcionario = F.id;

SELECT Usuario.nome, Livro.titulo, Emprestimo.data_emprestimo 
FROM Usuario 
INNER JOIN Emprestimo ON Usuario.id = Emprestimo.id_usuario 
INNER JOIN Livro ON Emprestimo.id_livro = Livro.id;

SELECT Usuario.nome, Emprestimo.id 
FROM Usuario 
LEFT JOIN Emprestimo ON Usuario.id = Emprestimo.id_usuario 
WHERE Emprestimo.id IS NULL;

SELECT Livro.titulo, Usuario.nome 
FROM Livro 
RIGHT JOIN Emprestimo ON Livro.id = Emprestimo.id_livro 
RIGHT JOIN Usuario ON Emprestimo.id_usuario = Usuario.id;

SELECT Usuario.nome, Livro.titulo
FROM Usuario 
CROSS JOIN Livro;

SELECT Usuario.nome, Emprestimo.id
FROM Usuario  -- Tabela da ESQUERDA
LEFT JOIN Emprestimo  -- Tabela da DIREITA
ON Usuario.id = Emprestimo.id_usuario;

SELECT Usuario.nome, Livro.titulo, Emprestimo.data_emprestimo
FROM Emprestimo
INNER JOIN Usuario ON Emprestimo.id_usuario = Usuario.id
INNER JOIN Livro ON Emprestimo.id_livro = Livro.id
INNER JOIN funcionario ON Emprestimo.id_funcionario = funcionario.id;

SELECT Usuario.nome, Emprestimo.data_emprestimo
FROM Usuario
LEFT JOIN Emprestimo ON Usuario.id = Emprestimo.id_usuario;

SELECT Livro.titulo, Emprestimo.data_emprestimo
FROM Livro
RIGHT JOIN Emprestimo ON Livro.id = Emprestimo.id_livro;

SELECT Usuario.nome, Livro.titulo
	FROM Usuario 
    LEFT JOIN Emprestimo ON Usuario.id = Emprestimo.id_usuario
	LEFT JOIN Livro ON Emprestimo.id_livro = Livro.id 
	UNION 
    SELECT Usuario.nome, Livro.titulo
	FROM Usuario
	RIGHT JOIN Emprestimo ON Usuario.id = Emprestimo.id_usuario
	RIGHT JOIN Livro ON Emprestimo.id_livro = Livro.id;

SELECT Usuario.nome, Livro.titulo
FROM Usuario
CROSS JOIN Livro;

SELECT Livro.titulo, Usuario.nome AS usuario, Funcionario.nome AS funcionario
	FROM Emprestimo 
    JOIN Livro ON Emprestimo.id_livro = Livro.id 
    JOIN Usuario ON Emprestimo.id_usuario = Usuario.id 
    JOIN Funcionario ON Emprestimo.id_funcionario = Funcionario.id
	WHERE Emprestimo.id_funcionario >= 5;

SELECT Usuario.nome, Livro.titulo, Emprestimo.data_emprestimo 
    FROM Emprestimo 
    INNER JOIN Usuario ON Emprestimo.id_usuario = Usuario.id 
    INNER JOIN Livro ON Emprestimo.id_livro = Livro.id 
    INNER JOIN funcionario ON Emprestimo.id_funcionario = funcionario.id;
