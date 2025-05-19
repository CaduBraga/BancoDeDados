CREATE DATABASE Biblioteca;
USE Biblioteca;

GRANT ALL PRIVILEGES ON Biblioteca.* TO 'cadu'@'localhost';
drop database Biblioteca;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON Biblioteca.* TO 'admin'@'localhost';
CREATE USER 'bibliotecario'@'localhost' IDENTIFIED BY 'livros123';
GRANT SELECT, INSERT, UPDATE ON Biblioteca.* TO 'bibliotecario'@'localhost';
CREATE USER 'visitante'@'localhost' IDENTIFIED BY 'leitor123';
GRANT SELECT ON Biblioteca.* TO 'visitante'@'localhost';
REVOKE INSERT ON Biblioteca.* FROM 'bibliotecario'@'localhost';
REVOKE ALL PRIVILEGES ON Biblioteca.* FROM 'visitante'@'localhost';


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
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_livro) REFERENCES Livro(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id) ON DELETE cascade ON UPDATE CASCADE
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
-- Simulação de erro: tentar inserir um empréstimo com um usuário inexistente
-- INSERT INTO Emprestimo (id_usuario, id_livro, id_funcionario, data_devolucao)
-- VALUES (999, 2, 3, '2025-03-10');  -- Isso geraria um erro
COMMIT;
