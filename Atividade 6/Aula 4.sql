-- fazer 7 tabelas de qualquer coisa e fazer alterações nelas
create database teste;
drop database teste;
create database escola;
use escola;
#criei e selecionei o meu banco de dados

create table professores(
idProfessor int (11) not null auto_increment primary key,
CPF_professor varchar (11),
telefoneProfessor varchar (15),
nomeProfessor varchar (85)
);
create table alunos(
idAluno int (10) not null auto_increment primary key,
CPF_aluno varchar (11),
telefoneAluno varchar (15),
nomeAluno varchar (40),
sexoAluno varchar (1)
);
create table turmas(
cod_turma int (10) not null auto_increment primary key,
sala int (5),
capacidade_maxima int (4)
);
create table cursos(
cod_curso int (10) not null auto_increment primary key,
nomeCurso varchar (30),
coordenadorCurso varchar (40),
tipoCurso varchar (40)
);
create table materiais(
id_compra int (10) not null auto_increment primary key,
valor int (14),
responsavel varchar (40),
dataCompra date
);
create table computadores(
id_Computador int (10) not null auto_increment primary key,
valor int (8),
sala int (5),
dataCompra date
);
create table armarios(
id_armario int (10) not null auto_increment primary key,
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
alter table cursos change tipoCurso descricao_curso varchar (35);
alter table materiais change responsavel comprador varchar (40);
alter table armarios change localizacao bloco varchar (3);
# change altera o valor de um atributo, como o VARCHAR (30)

alter table turmas modify column sala int (3);
alter table computadores modify column sala  int (3);
# modify column altera o valor de um atributo específico

alter table materiais rename compras;
# rename, obviamente, renomeia uma entidade

alter table cursos change cod_curso id_curso int (6);
# change muda o nome e o tipo de valor que recebe (varchar, int, date...)

alter table alunos drop CPF_Aluno;
alter table cursos drop descricao_curso;
# aqui eu apaguei alguns atributos do meu banco de dados

insert into professores values(default, 12332345645,  'mariozin@yahoo.com', 'Mário Felippe Souza', 'Geografia'),
(default, 85669812774,  'prof_pedro.nobr@gmail.com', 'Pedro Alberto de Nóbrega', 'Artes'),
(default, 85789625145,  'professora_marareth@outlook', 'Margareth Silva', 'Matemática'),
(default, 78556889521,  'pedrin.vampetinha@gmail.com', 'Pedro Vampeta Soares', 'Física');
#com essas linhas eu inseri os valores na tabela professores, então esse processo é repetido para todas as tabelas

-- falta ainda:
-- insert into (continuar)
-- update 
-- delete
-- select