-- fazer 7 tabelas de qualquer coisa e fazer alterações nelas
create database teste;
drop database teste;
create database escola;
use escola;
#criei e selecionei o meu banco de dados
create table professores(
idProfessor int (10),
CPF_professor varchar (11),
telefoneProfessor varchar (15),
nomeProfessor varchar (85)
);
create table alunos(
idAluno int (10),
CPF_aluno varchar (11),
telefoneAluno varchar (15),
nomeAluno varchar (40),
sexoAluno varchar (1)
);
create table turmas(
cod_turma int (10),
sala int (5),
capacidade_maxima int (4)
);
create table cursos(
cod_curso int (10),
nomeCurso varchar (30),
coordenadorCurso varchar (40),
tipoCurso varchar (40)
);
create table materiais(
id_compra int (10),
valor int (14),
responsavel varchar (40),
dataCompra date
);
create table computadores(
id_Computador int (10),
valor int (8),
sala int (5),
dataCompra date
);
create table armarios(
id_armario int (10),
responsavel varchar (40),
localizacao varchar (20)
);
# aqui todas as tabelas foram criadas

alter table professores add column especialidade varchar (30);
alter table alunos add column turma int (4);
alter table turmas add column curso varchar (30);
alter table cursos add column cargaHoraria int (8);
alter table materiais add column solicitante varchar (40);
alter table computadores add column utimoAcesso date;
alter table armarios add column descricao varchar (30);
# add column serve para adicionar atributos na entidade

alter table professores change telefoneProfessor email varchar (30);
alter table alunos change sexoAluno dataNascimento date;
alter table turmas change capacidade_maxima qtd_alunos int (3);
alter table cursos change tipoCurso descricao_curso varchar (35);
alter table materiais change responsavel comprador varchar (40);
alter table computadores change valor descricao varchar (50);
alter table armarios change localizacao bloco varchar (3);
# change altera o valor de um atributo, como o VARCHAR (30)

alter table professores modify column idProfessor int (8);
alter table alunos modify column idAluno int (8);
alter table turmas modify column sala int (3);
alter table cursos modify column  cod_curso int (6);
alter table materiais modify column  id_compra int (12);
alter table computadores modify column sala  int (3);
alter table armarios modify column  id_armario int (5);
# modify column altera o valor de um atributo específico

alter table materiais rename compras;
# rename, obviamente, renomeia uma entidade

alter table cursos change cod_curso id_curso int (6);
# change muda o nome e o tipo de valor que recebe (varchar, int, date...)

alter table alunos drop CPF_Aluno;
alter table cursos drop descricao_curso;
# aqui eu apaguei alguns atributos do meu banco de dados

insert into professores values();

-- falta ainda:
-- insert into
-- update 
-- delete
-- select