create database hospital;
use hospital;

create table pacientes (
    id_paciente int auto_increment primary key,
    nome varchar(100) not null,
    data_nascimento date not null,
    email varchar(100) unique,
    foto blob,
    data_cadastro timestamp default current_timestamp
);

create table medicos (
    id_medico int auto_increment primary key,
    nome varchar(100) not null,
    especialidade varchar(100),
    salario decimal(8, 2) check (salario > 1412),
    ano_contratacao year,
    ativo boolean default true
);

create table especialidades (
    id_especialidade int auto_increment primary key,
    nome varchar(100) not null unique,
    descricao text
);

create table leitos (
    id_leito int auto_increment primary key,
    numero varchar(50) not null,
    andar int not null,
    tipo set ('clínico', 'cirúrgico', 'UTI') not null,
    status enum ('ocupado', 'vago') default 'vago',
    data_criacao timestamp default current_timestamp
);

create table internacoes (
    id_internacao int auto_increment primary key,
    paciente_id int not null,
    leito_id int not null,
    data_internacao date not null,
    data_saida date,
    foreign key (paciente_id) references pacientes(id_paciente),
    foreign key (leito_id) references leitos(id_leito)
);

create table consultas (
    id_consulta int auto_increment primary key,
    paciente_id int not null,
    medico_id int not null,
    especialidade_id int not null,
    data_consulta datetime not null,
    diagnostico text,
    foreign key (paciente_id) references pacientes(id_paciente),
    foreign key (medico_id) references medicos(id_medico),
    foreign key (especialidade_id) references especialidades(id_especialidade)
);

create table exames (
    id_exame int auto_increment primary key,
    paciente_id int not null,
    tipo_exame varchar(100) not null,
    data_exame datetime not null,
    resultado text,
    foreign key (paciente_id) references pacientes(id_paciente)
);

insert into pacientes (nome, data_nascimento, email, foto, data_cadastro) values
    ('João da Silva', '1985-01-01', 'joao.silva@email.com', null, now()),
    ('Maria dos Santos', '1990-06-15', 'maria.santos@email.com', null, now()),
    ('Pedro Oliveira', '1978-03-20', 'pedro.oliveira@email.com', null, now()),
    ('Ana Paula', '1982-09-10', 'ana.paula@email.com', null, now()),
    ('Luís Fernando', '1995-11-25', 'luis.fernando@email.com', null, now());

insert into medicos (nome, especialidade, salario, ano_contratacao, ativo) values
    ('Dr. José', 'Cardiologia', 7000.00, 2010, true),
    ('Dra. Maria', 'Neurologia', 6000.00, 2012, true),
    ('Dr. João', 'Ortopedia', 7500.00, 2015, true),
    ('Dra. Ana', 'Pediatria', 5000.00, 2018, true),
    ('Dr. Leandro', 'Fisioterapia', 4000.00, 2020, true);

insert into especialidades (nome, descricao) values
    ('Cardiologia', 'Tratamento das doenças do coração'),
    ('Neurologia', 'Tratamento de doenças neurológicas'),
    ('Ortopedia', 'Tratamento de doenças ósseas e musculares'),
    ('Pediatria', 'Tratamento de crianças e adolescentes'),
    ('Fisioterapia', 'Reabilitação física e motora');

insert into leitos (numero, andar, tipo, status) values
    ('101', 1, 'clínico', 'vago'),
    ('102', 1, 'cirúrgico', 'vago'),
    ('103', 2, 'UTI', 'ocupado'),
    ('104', 2, 'clínico', 'vago'),
    ('105', 3, 'cirúrgico', 'ocupado');

insert into internacoes (paciente_id, leito_id, data_internacao) values
    (1, 1, '2024-01-10'),
    (2, 2, '2024-01-15'),
    (3, 3, '2024-01-18');

insert into consultas (paciente_id, medico_id, especialidade_id, data_consulta, diagnostico) values
    (1, 1, 1, '2024-01-11 09:00:00', 'Hipertensão'),
    (2, 2, 2, '2024-01-16 10:00:00', 'Enxaqueca crônica'),
    (3, 3, 3, '2024-01-19 11:00:00', 'Fratura no fêmur');

insert into exames (paciente_id, tipo_exame, data_exame, resultado) values
    (1, 'Eletrocardiograma', '2024-01-11 08:00:00', 'Normal'),
    (2, 'Ressonância Magnética', '2024-01-16 09:00:00', 'Lesões cerebrais leves'),
    (3, 'Raio-X', '2024-01-19 12:00:00', 'Fratura confirmada');
