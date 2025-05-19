create database escola;
use escola;
create table alunos (
    id_aluno int auto_increment primary key,
    nome varchar(100) not null,
    data_nascimento date not null,
    email varchar(100) unique,
    foto blob,
    data_cadastro timestamp default current_timestamp
);
create table professores (
    id_professor int auto_increment primary key,
    nome varchar(100) not null,
    especialidade varchar(100),
    salario decimal(8, 2) check (salario > 1412),
    ano_contratacao year,
    ativo boolean default true
);
create table disciplinas (
    id_disciplina int auto_increment primary key,
    nome varchar(100) not null unique,
    carga_horaria int not null check (carga_horaria > 20),
    descricao text
);
create table turmas (
    id_turma int auto_increment primary key,
    nome varchar(50) not null,
    ano_letivo year not null,
    turno set ('manhã', 'tarde', 'noite') not null,
    data_criacao timestamp default current_timestamp
);
create table matriculas (
    id_matricula int auto_increment primary key,
    aluno_id int not null,
    turma_id int not null,
    data_matricula date not null,
    foreign key (aluno_id) references alunos(id_aluno),
    foreign key (turma_id) references turmas(id_turma),
    unique (aluno_id, turma_id)
);
create table notas (
    id_nota int auto_increment primary key,
    aluno_id int not null,
    disciplina_id int not null,
    nota_final double not null check (nota_final >= 0 and nota_final <= 10),
    data_avaliacao datetime not null,
    foreign key (aluno_id) references alunos(id_aluno),
    foreign key (disciplina_id) references disciplinas(id_disciplina)
);
create table frequencias (
    id_frequencia int auto_increment primary key,
    aluno_id int not null,
    turma_id int not null,
    data_frequencia date not null,
    status enum ('P', 'F') NOT NULL,
    foreign key (aluno_id) references alunos(id_aluno),
    foreign key (turma_id) references turmas(id_turma)
);
create table atividades (
    id_atividade int auto_increment primary key,
    turma_id int not null,
	titulo varchar(30) not null,
    descricao text,
    data_atividade date not null,
    hora_atividade time not null,
    foreign key (turma_id) references turmas(id_turma)
);
insert into alunos (nome, data_nascimento, email, foto, data_cadastro) values
    ('João da Silva', '2002-01-01', 'joao.silva@email.com', null, now()),
    ('Maria dos Santos', '2001-06-15', 'maria.santos@email.com', null, now()),
    ('Pedro Oliveira', '2003-03-20', 'pedro.oliveira@email.com', null, now()),
    ('Ana Paula', '2002-09-10', 'ana.paula@email.com', null, now()),
    ('Luís Fernando', '2001-11-25', 'luis.fernando@email.com', null, now());
insert into professores (nome, especialidade, salario, ano_contratacao, ativo) values
    ('Prof. José', 'Matemática', 5000.00, 2010, false),
    ('Prof. Maria', 'Português', 4500.00, 2012, true),
    ('Prof. João', 'História', 5500.00, 2015, true),
    ('Prof. Ana', 'Geografia', 4000.00, 2018, true),
    ('Prof. Leandro', 'Física', 6000.00, 2020, true);
insert into disciplinas (nome, carga_horaria, descricao) values
    ('Matemática', 60, 'Disciplina de matemática'),
    ('Português', 40, 'Disciplina de português'),
    ('História', 50, 'Disciplina de história'),
    ('Geografia', 30, 'Disciplina de geografia'),
    ('Física', 70, 'Disciplina de física');
insert into turmas (nome, ano_letivo, turno, data_criacao) values
    ('1º ano A', 2022, 'manhã', now()),
    ('1º ano B', 2022, 'tarde', now()),
    ('2º ano A', 2022, 'manhã', now()),
    ('2º ano B', 2022, 'tarde', now()),
    ('3º ano A', 2022, 'manhã', now());
insert into matriculas (aluno_id, turma_id, data_matricula) values
    (1, 1, '2022-02-01'),
    (2, 1, '2022-02-01'),
    (3, 2, '2022-02-01'),
    (4, 2, '2022-02-01'),
    (5, 3, '2022-02-01');
insert into notas (aluno_id, disciplina_id, nota_final, data_avaliacao) values
    (1, 1, 8.5, '2022-03-15'),
    (1, 2, 7.0, '2022-03-15'),
    (2, 1, 9.0, '2022-03-15'),
    (2, 2, 8.0, '2022-03-15'),
    (3, 3, 7.5, '2022-03-15');
insert into frequencias (aluno_id, turma_id, data_frequencia, status) values
    (1, 1, '2022-02-10', 'p'),
    (1, 1, '2022-02-15', 'p'),
    (2, 1, '2022-02-10', 'p'),
    (2, 1, '2022-02-15', 'f'),
    (3, 2, '2022-02-10', 'p');
insert into atividades (turma_id, titulo, descricao, data_atividade, hora_atividade) values
    (1, 'Aula de Matemática', 'Aula introdutória sobre álgebra.', '2022-02-10', '08:00:00'),
    (1, 'Aula de Português', 'Leitura e interpretação de textos.', '2022-02-15', '09:00:00'),
    (2, 'Aula de História', 'Estudo sobre a Idade Média.', '2022-02-10', '10:00:00'),
    (2, 'Aula de Geografia', 'Geografia do Brasil.', '2022-02-12', '11:00:00'),
    (3, 'Aula de Ciências', 'Introdução à biologia.', '2022-02-14', '08:30:00'),
    (3, 'Aula de Física', 'Conceitos básicos de mecânica.', '2022-02-16', '09:30:00'),
    (4, 'Aula de Artes', 'História da arte moderna.', '2022-02-18', '10:00:00'),
    (4, 'Aula de Educação Física', 'Atividades esportivas e recreativas.', '2022-02-20', '11:00:00'),
    (5, 'Aula de Matemática', 'Resolução de problemas matemáticos.', '2022-02-22', '08:00:00'),
    (5, 'Aula de Português', 'Produção textual.', '2022-02-24', '09:00:00');