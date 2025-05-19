create database fabrica;
use fabrica;

create table departamentos (
    id_departamento int auto_increment primary key,
    nome varchar(50) not null,
    gastos int not null
);
create table funcionarios (
    id_funcionario int auto_increment primary key,
    nome varchar(100) not null,
    sexo char check (sexo in ('F', 'M')),
	salario decimal(8, 2) check (salario > 1412),
    data_nascimento date not null,
    email varchar(100) unique,
    foto blob,
    ativo boolean default true,
    data_cadastro timestamp default current_timestamp,
    departamento int,
	foreign key (departamento) references departamentos(id_departamento)
);
-- Tabela Superclasse (produtos)
create table produtos (
    id_produto int auto_increment primary key,
    nome varchar(100) not null unique,
    preco int not null,
    descricao text,
    qtd_estoque int not null
);
create table fornecedores (
    id_fornecedor int auto_increment primary key,
    nome varchar(50) not null,
    produtos text not null,
    inicio_contrato date not null
);
create table materia_prima (
    id_mp int auto_increment primary key,
	nome varchar(50) not null,
    descricao text,
    preco decimal (10, 2) not null,
    qtd_estoque int not null,
    unidade_de_medida enum ('litros', 'gramas', 'metros', 'unidade') not null
);
create table op (
	responsavel int,
	produto int,
	primary key (responsavel, produto),
	foreign key (responsavel) references funcionarios(id_funcionario),
	foreign key (produto) references produtos(id_produto),
	prazo date not null
    );
-- Tabela Subclasse (produtos_producao)
create table produtos_producao (
    produto_id int primary key,
    numero_op int unique not null,
    foreign key (produto_id) references produtos(id_produto),
    andamento enum ('Finalizado', 'Em andamento', 'Falha') default 'Em andamento'
);
create table clientes (
    id_cliente int auto_increment primary key,
    nome varchar(100) not null,
    data_nascimento date not null,
    email varchar(100) unique,
    foto blob,
    cidade varchar (40)
);
create table vendas (
	cliente int,
	produto int,
    vendedor int,
	primary key (cliente, produto),
	foreign key (cliente) references clientes(id_cliente) on update cascade,
	foreign key (produto) references produtos(id_produto),
    foreign key (vendedor) references funcionarios(id_funcionario),
    hora_da_compra timestamp default current_timestamp,
    valor decimal (10, 2) not null
);
create table pagamentos (
    id_pagamento int auto_increment primary key,
    horario_pagamento timestamp default current_timestamp,
    valor decimal (10, 2) not null,
    id_cliente int,
    cliente varchar (100),
    foreign key (id_cliente) references clientes(id_cliente)
); 
create table  inventario (
    setor set ('Almoxarifado A', 'Almoxarifado B', 'Armazém 1', 'Armazém 2') not null,
    /* escolhi o set ao invés do enum, pois por exemplo:
    tenho o produto: transformador trifásico, 
    tenho 5 unidades dele, que estão alocadas no amarzém 1 e 2, 
    o Enum não seria a melhor opção, pois eu deveria escolher apenas um dos setores*/
    id_item int primary key auto_increment,
    nome varchar (100),
    quantidade float not null,
    -- usei o float para que todos os tipos de dados sejam utilizados
    descricao text,
    id_responsavel int,
    nome_responsavel varchar (100),
    foto_produto blob,
    foreign key (id_responsavel) references funcionarios(id_funcionario) on delete cascade on update cascade
);
create table  manutencao (
    responsavel int,
	produto int,
	primary key (responsavel, produto),
	foreign key (responsavel) references funcionarios(id_funcionario) on update cascade,
	foreign key (produto) references produtos(id_produto),
	prazo_finalizacao date not null,
	andamento enum ('Finalizado', 'Em andamento', 'Perda total') default 'Em andamento',
	departamento_solicitante varchar (50),
    id_departamento int,
	foreign key (id_departamento) references departamentos(id_departamento) on update cascade
-- não usei o delete cascade pois quero os registros das manutenções mesmo que um departamento deixe de existir
);
create table  equipamentos (
	responsavel int,
	equipamento int,
	primary key (responsavel, equipamento),
	foreign key (responsavel) references funcionarios(id_funcionario),
	foreign key (equipamento) references inventario(id_item) on delete cascade on update cascade,
    funcao text,
    disponibilidade enum ('Livre', 'Em uso', 'Em manutencao')
);
create table  projetos (
	id_responsavel int,
	nome_responsavel varchar (100),
	id_produto int,
	produto varchar (100),
	primary key (id_responsavel, id_produto),
	foreign key (id_responsavel) references funcionarios(id_funcionario) on update cascade,
	foreign key (id_produto) references produtos(id_produto),
    prazo date,
    andamento enum ('Nao iniciado', 'Em andamento', 'Finalizado', 'Descartado'),
    tipo_projeto set ('Melhoria', 'Novo Produto', 'Alteracao de processos'),
    departamento_solicitante varchar (50),
    id_departamento int,
	foreign key (id_departamento) references departamentos(id_departamento) on update cascade
);