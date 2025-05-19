#drop database feedback-cell; aqui por algum motivo estava dando ero de sintaxe, mesmo estando tudo certo
DROP DATABASE biblioteca;
create database primeiroBanco;
CrEaTe DaTaBaSe TeSte;
create database a;
create database h;
create database g;
create database f;
create database e;
create database d;
create database b;
create database q;
create database r;
create database w;
create database t;
create database z;
create database c;
create database y;
create database x;
drop database teste;
drop database primeiroBanco;
drop database a;
drop database h;
drop database g;
drop database f;
drop database e;
drop database d;
drop database b;
drop database q;
drop database r;
drop database w;
drop database t;
drop database z;
drop database x;
drop database c;
drop database y;
create database valentimfofo;
create database valentimquerido;
create database amoovalentim;
create database valentimlindo;
create database valentimtop;
create database valetimtopzeira;
create database valentimmelhorprofessor;
create database amobancodedados;
create database pizzanasexta;
create database cadu;
create database melhoraula;
create database deznaprova;
create database valentimlegalzao;
create database we_love_valentim;
create database cadu_é_fã_do_valentim;
-- create database teste espaço; esse não funciona, pois usamos _ ao invés de espaço
create database tropa_do_vava;
create database valentim_eh_legal;
show databases;
use sakila;
drop database valentimfofo;
drop database valentimquerido;
drop database amoovalentim;
drop database valentimlindo;
drop database valentimtop;
drop database valetimtopzeira;
drop database valentimmelhorprofessor;
drop database amobancodedados;
drop database pizzanasexta;
drop database cadu;
drop database melhoraula;
drop database deznaprova;
drop database valentimlegalzao;
drop database we_love_valentim;
drop database cadu_é_fã_do_valentim;
drop database tropa_do_vava;
drop database valentim_eh_legal;
# comentario em linha unica
-- comentario em linha unica tambem
/*
assim podemos fazer comentarios
em mais de uma linha
assim como no Java e no Portugol
*/
-- valentim é filosofo
/*create database <nome> = cria o banco de dados
drop database <nome> = apaga o banco de dados*/
-- aqui não importa se a letra está em caixa alta ou baixa, o código vai rodar da mesma forma

create database escola;
drop database escola;
create database banco_escola;
use banco_escola;
create table tabela_alunos(
id_aluno int,
nome_aluno     varchar (60),
endereco_aluno varchar (70),
bairro_aluno   varchar (30),
telefone_aluno varchar (15),
email_aluno    varchar (50),
dta_nasc_aluno date
);
create table tabela_professores(
id_professor int,
nome_professor     varchar (60),
endereco_professor varchar (70),
CPF_professor      varchar (11),
email_aluno        varchar (50),
esp_professor      varchar (25)
);
create table tabela_salas(
id_sala          int,
bloco_sala       varchar (10),
numero_sala      int,
tamanho_sala_m2 int,
capacidade_sala  int
);
/* create table tabela_sala_teste(
tamanho_sala(m2) int
);
Esse bloco não funciona por causa do parenteses, 
mas temos formas de arrumar esse problema, 
com algo semelhantes às aspas do java print("int a"), por exemplo
pois não vai puxar a variável, e nesse caso, ele não puxa as propriedades do parenteses.
Também podemos mudar nas views dos usuários, ali eu posso mexer como quiser */
-- ótima aula, muito legal programar de verdade!
select * from banco_escola.tabela_alunos;
#mostra as informaçõe (linhas ou tuplas) da entidade em questão
describe tabela_alunos;
#sdescribe nos mostram a tabela desejada com seus atributos
show tables;
#show tables funciona da mesma forma que o show database, mas para entidades específicas.
