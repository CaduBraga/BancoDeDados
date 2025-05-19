CREATE DATABASE Biblioteca;
CREATE USER 'cadu'@'localhost' IDENTIFIED BY 'cadu';
GRANT ALL PRIVILEGES ON Biblioteca.* TO 'cadu'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON Biblioteca.* TO 'admin'@'localhost';
CREATE USER 'bibliotecario'@'localhost' IDENTIFIED BY 'livros123';
GRANT SELECT, INSERT, UPDATE ON Biblioteca.* TO 'bibliotecario'@'localhost';
CREATE USER 'visitante'@'localhost' IDENTIFIED BY 'leitor123';
GRANT SELECT ON Biblioteca.* TO 'visitante'@'localhost';
REVOKE INSERT ON Biblioteca.* FROM 'bibliotecario'@'localhost';
REVOKE ALL PRIVILEGES ON Biblioteca.* FROM 'visitante'@'localhost';
-- ele aparece como erro pois o all priveleges deve ser utilizado quando há mais de um privilégio além do select, porém, ele roda sem problemas
