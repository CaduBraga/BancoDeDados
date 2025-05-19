#Criando usuários no MySQL Workbench

select user, host from mysql.user;
select current_user();
show grants for 'cadu'@'localhost';
create user 'cadu'@'localhost' identified by 'cadu';
use fabrica;
insert into clientes (nome, data_nascimento, email, foto, cidade) values
('joão pedro', '1985-05-15', 'joao.pedro@example.com', null, 'são paulo');
select * from clientes;