create database teste;
use teste;

SELECT somar_dois_numeros(5, 3);

SET @resultado := somar_dois_numeros (10, 5); 
SELECT @resultado;

SET @nome := 'Maria';
SET @idade := 25;
SELECT @nome, @idade;

/*
DECLARE nome VARCHAR(100);
DECLARE idade INT;
SET nome = 'João';
SET idade = 21;
*/

CREATE DEFINER=`root`@`localhost` FUNCTION `somar_dois_numeros`(a INT, b INT) RETURNS int
    DETERMINISTIC
BEGIN

RETURN a + b;
END

