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

CREATE USER 'usuario_vendas'@'localhost' IDENTIFIED BY 'senha_vendas';
CREATE USER 'usuario_estoque'@'localhost' IDENTIFIED BY 'senha_estoque';
CREATE USER 'usuario_administrador'@'localhost' IDENTIFIED BY 'senha_administrador';
GRANT SELECT, INSERT, UPDATE ON fabrica.vendas TO 'usuario_vendas'@'localhost';
GRANT SELECT ON fabrica.produtos TO 'usuario_vendas'@'localhost';
GRANT SELECT, UPDATE ON fabrica.produtos TO 'usuario_estoque'@'localhost';
GRANT SELECT, UPDATE ON fabrica.inventario TO 'usuario_estoque'@'localhost';
GRANT ALL PRIVILEGES ON fabrica.* TO 'usuario_administrador'@'localhost';

CREATE INDEX idx_nome_funcionario ON funcionarios(nome);
CREATE INDEX idx_nome_cliente ON clientes(nome);
CREATE INDEX idx_nome_produto ON produtos(nome);

insert into departamentos (nome, gastos) values
('produção', 50000),
('vendas', 30000),
('rh', 15000),
('ti', 20000),
('logística', 25000),
('marketing', 18000),
('financeiro', 22000),
('compras', 16000),
('qualidade', 14000),
('pesquisa e desenvolvimento', 27000);
insert into funcionarios (nome, sexo, salario, data_nascimento, email, departamento) values
('joão silva', 'm', 3000.00, '1985-05-15', 'joao.silva@empresa.com', 1),
('maria oliveira', 'f', 3200.00, '1990-08-22', 'maria.oliveira@empresa.com', 2),
('carlos souza', 'm', 2800.00, '1982-11-30', 'carlos.souza@empresa.com', 3),
('ana costa', 'f', 3500.00, '1995-02-10', 'ana.costa@empresa.com', 4),
('pedro lima', 'm', 2900.00, '1988-07-19', 'pedro.lima@empresa.com', 5),
('fernanda alves', 'f', 3100.00, '1992-03-25', 'fernanda.alves@empresa.com', 6),
('lucas pereira', 'm', 2700.00, '1987-09-12', 'lucas.pereira@empresa.com', 7),
('juliana martins', 'f', 3300.00, '1991-12-05', 'juliana.martins@empresa.com', 8),
('rafael santos', 'm', 3400.00, '1984-06-17', 'rafael.santos@empresa.com', 9),
('beatriz rocha', 'f', 3600.00, '1993-01-28', 'beatriz.rocha@empresa.com', 10);
insert into produtos (nome, preco, descricao, qtd_estoque) values
('produto a', 100, 'descrição do produto a', 50),
('produto b', 150, 'descrição do produto b', 30),
('produto c', 200, 'descrição do produto c', 20),
('produto d', 250, 'descrição do produto d', 40),
('produto e', 300, 'descrição do produto e', 60),
('produto f', 350, 'descrição do produto f', 70),
('produto g', 400, 'descrição do produto g', 80),
('produto h', 450, 'descrição do produto h', 90),
('produto i', 500, 'descrição do produto i', 100),
('produto j', 550, 'descrição do produto j', 110);
insert into fornecedores (nome, produtos, inicio_contrato) values
('fornecedor 1', 'produto a, produto b', '2020-01-01'),
('fornecedor 2', 'produto c, produto d', '2020-02-01'),
('fornecedor 3', 'produto e, produto f', '2020-03-01'),
('fornecedor 4', 'produto g, produto h', '2020-04-01'),
('fornecedor 5', 'produto i, produto j', '2020-05-01'),
('fornecedor 6', 'produto a, produto c', '2020-06-01'),
('fornecedor 7', 'produto b, produto d', '2020-07-01'),
('fornecedor 8', 'produto e, produto g', '2020-08-01'),
('fornecedor 9', 'produto f, produto h', '2020-09-01'),
('fornecedor 10', 'produto i, produto j', '2020-10-01');
insert into materia_prima (nome, descricao, preco, qtd_estoque, unidade_de_medida) values
('matéria prima a', 'descrição a', 10.00, 100, 'litros'),
('matéria prima b', 'descrição b', 20.00, 200, 'gramas'),
('matéria prima c', 'descrição c', 30.00, 300, 'metros'),
('matéria prima d', 'descrição d', 40.00, 400, 'unidade'),
('matéria prima e', 'descrição e', 50.00, 500, 'litros'),
('matéria prima f', 'descrição f', 60.00, 600, 'gramas'),
('matéria prima g', 'descrição g', 70.00, 700, 'metros'),
('matéria prima h', 'descrição h', 80.00, 800, 'unidade'),
('matéria prima i', 'descrição i', 90.00, 900, 'litros'),
('matéria prima j', 'descrição j', 100.00, 1000, 'gramas');
insert into op (responsavel, produto, prazo) values
(1, 1, '2023-12-01'),
(2, 2, '2023-12-02'),
(3, 3, '2023-12-03'),
(4, 4, '2023-12-04'),
(5, 5, '2023-12-05'),
(6, 6, '2023-12-06'),
(7, 7, '2023-12-07'),
(8, 8, '2023-12-08'),
(9, 9, '2023-12-09'),
(10, 10, '2023-12-10');
insert into produtos_producao (produto_id, numero_op, andamento) VALUES
(1, 101, 'Em andamento'),
(2, 102, 'Finalizado'),
(3, 103, 'Falha'),
(4, 104, 'Em andamento'),
(5, 105, 'Finalizado'),
(6, 106, 'Em andamento'),
(7, 107, 'Falha'),
(8, 108, 'Em andamento'),
(9, 109, 'Finalizado'),
(10, 110, 'Em andamento');
insert into clientes (nome, data_nascimento, email, foto, cidade) values
('joão silva', '1985-05-15', 'joao.silva@example.com', null, 'são paulo'),
('maria oliveira', '1990-08-22', 'maria.oliveira@example.com', null, 'rio de janeiro'),
('carlos pereira', '1978-12-30', 'carlos.pereira@example.com', null, 'belo horizonte'),
('ana costa', '1995-03-10', 'ana.costa@example.com', null, 'curitiba'),
('lucas santos', '1982-07-25', 'lucas.santos@example.com', null, 'porto alegre'),
('fernanda lima', '1993-11-05', 'fernanda.lima@example.com', null, 'salvador'),
('ricardo gomes', '1980-01-15', 'ricardo.gomes@example.com', null, 'fortaleza'),
('juliana rocha', '1988-09-18', 'juliana.rocha@example.com', null, 'florianópolis'),
('gabriel almeida', '1992-04-12', 'gabriel.almeida@example.com', null, 'manaus'),
('patrícia martins', '1986-06-20', 'patricia.martins@example.com', null, 'recife');
insert into vendas (cliente, produto, vendedor, valor) values
(1, 1, 1, 150.00),
(2, 2, 2, 200.00),
(3, 3, 3, 300.00),
(4, 4, 4, 250.00),
(5, 5, 5, 100.00),
(6, 6, 6, 400.00),
(7, 7, 7, 350.00),
(8, 8, 8, 450.00),
(9, 9, 9, 500.00),
(10, 10, 10, 600.00);
insert into pagamentos (horario_pagamento, valor, id_cliente, cliente) values
(now(), 150.00, 1, 'joão silva'),
(now(), 200.00, 2, 'maria oliveira'),
(now(), 300.00, 3, 'carlos pereira'),
(now(), 250.00, 4, 'ana costa'),
(now(), 100.00, 5, 'lucas santos'),
(now(), 400.00, 6, 'fernanda lima'),
(now(), 350.00, 7, 'ricardo gomes'),
(now(), 450.00, 8, 'juliana rocha'),
(now(), 500.00, 9, 'gabriel almeida'),
(now(), 600.00, 10, 'patrícia martins');
insert into inventario (setor, nome, quantidade, descricao, id_responsavel, nome_responsavel) values
('almoxarifado a', 'produto a', 100, 'descrição do produto a', '1', 'funcionário 1'),
('almoxarifado b', 'produto b', 200, 'descrição do produto b', '2', 'funcionário 2'),
('armazém 1', 'produto c', 150, 'descrição do produto c', '3', 'funcionário 3'),
('armazém 2', 'produto d', 250, 'descrição do produto d', '4', 'funcionário 4'),
('almoxarifado a', 'produto e', 300, 'descrição do produto e', '5', 'funcionário 5'),
('almoxarifado b', 'produto f', 50, 'descrição do produto f', '6', 'funcionário 6'),
('armazém 1', 'produto g', 75, 'descrição do produto g', '7', 'funcionário 7'),
('armazém 2', 'produto h', 125, 'descrição do produto h', '8', 'funcionário 8'),
('almoxarifado a', 'produto i', 90, 'descrição do produto i', '9', 'funcionário 9'),
('almoxarifado b', 'produto j', 60, 'descrição do produto j', '10', 'funcionário 10');
insert into manutencao (responsavel, produto, prazo_finalizacao, andamento, departamento_solicitante, id_departamento) values
(1, 1, '2023-12-31', 'em andamento', 'departamento a', 1),
(2, 2, '2023-11-30', 'finalizado', 'departamento b', 2),
(3, 3, '2023-10-15', 'em andamento', 'departamento c', 3),
(4, 4, '2023-09-20', 'perda total', 'departamento d', 4),
(5, 5, '2023-08-10', 'em andamento', 'departamento e', 5),
(6, 6, '2023-07-05', 'finalizado', 'departamento f', 6),
(7, 7, '2023-06-15', 'em andamento', 'departamento g', 7),
(8, 8, '2023-05-25', 'perda total', 'departamento h', 8),
(9, 9, '2023-04-30', 'em andamento', 'departamento i', 9),
(10, 10, '2023-03-15', 'finalizado', 'departamento j', 10);
insert into equipamentos (responsavel, equipamento, funcao, disponibilidade) values
(1, 1, 'manutenção preventiva', 'livre'),
(2, 2, 'manutenção corretiva', 'em uso'),
(3, 3, 'calibração', 'livre'),
(4, 4, 'instalação', 'em manutencao'),
(5, 5, 'verificação', 'livre'),
(6, 6, 'substituição de peças', 'em uso'),
(7, 7, 'teste de funcionamento', 'livre'),
(8, 8, 'limpeza', 'em manutencao'),
(9, 9, 'atualização de software', 'livre'),
(10, 10, 'inspeção', 'em uso');
insert into projetos (id_responsavel, nome_responsavel, id_produto, produto, prazo, andamento, tipo_projeto, departamento_solicitante, id_departamento) values
(1, 'funcionário 1', 1, 'produto a', '2023-12-31', 'em andamento', 'melhoria', 'departamento a', 1),
(2, 'funcionário 2', 2, 'produto b', '2023-11-30', 'finalizado', 'novo produto', 'departamento b', 2),
(3, 'funcionário 3', 3, 'produto c', '2023-10-15', 'em andamento', 'alteracao de processos', 'departamento c', 3),
(4, 'funcionário 4', 4, 'produto d', '2023-09-20', 'descartado', 'melhoria', 'departamento d', 4),
(5, 'funcionário 5', 5, 'produto e', '2023-08-10', 'em andamento', 'novo produto', 'departamento e', 5),
(6, 'funcionário 6', 6, 'produto f', '2023-07-05', 'finalizado', 'alteracao de processos', 'departamento f', 6),
(7, 'funcionário 7', 7, 'produto g', '2023-06-15', 'em andamento', 'melhoria', 'departamento g', 7),
(8, 'funcionário 8', 8, 'produto h', '2023-05-25', 'descartado', 'novo produto', 'departamento h', 8),
(9, 'funcionário 9', 9, 'produto i', '2023-04-30', 'em andamento', 'alteracao de processos', 'departamento i', 9),
(10, 'funcionário 10', 10, 'produto j', '2023-03-15', 'finalizado', 'melhoria', 'departamento j', 10);

UPDATE produtos 
SET qtd_estoque = qtd_estoque - 1 
WHERE id_produto = 2
LIMIT 1;

DELETE FROM inventario 
WHERE id_item = 5
LIMIT 1;

INSERT INTO produtos (id_produto, nome, qtd_estoque)
VALUES (15, 'Produto Exemplo', 50);

START TRANSACTION;
SAVEPOINT antes_da_venda;
INSERT INTO vendas (cliente, produto, valor) 
VALUES (1, 2, 200.00);
UPDATE produtos 
SET qtd_estoque = qtd_estoque - 1 
WHERE id_produto = 2;
COMMIT;

/*
START TRANSACTION;
SAVEPOINT antes_da_ordem;
INSERT INTO Ordens_Producao (id_funcionario, id_produto, quantidade_produto, data_inicio, data_fim)
VALUES (1, 2, 500, '2025-02-25', '2025-03-01');
ROLLBACK TO antes_da_ordem;
INSERT INTO Ordens_Producao (id_funcionario, id_produto, quantidade_produto, data_inicio, data_fim)
VALUES (1, 2, 100, '2025-02-25', '2025-03-01');
COMMIT;
*/

-- consultas:
SELECT * FROM funcionarios;
SELECT * FROM produtos WHERE preco > 100;
SELECT * FROM funcionarios WHERE id_funcionario >= 5;
-- duas formas de fazaer a mesma pesquisa
SELECT * FROM funcionarios WHERE id_funcionario LIKE '5%';
SELECT * FROM manutencao WHERE andamento IS NULL;
-- o andamento nunca vai ser null, por causa do default
SELECT * FROM produtos WHERE preco > 200;
SELECT * FROM funcionarios WHERE data_nascimento < '1990-01-01';
SELECT * FROM funcionarios WHERE email = 'mariana.lima@email.com';
SELECT * FROM produtos WHERE preco > 200;
SELECT * FROM funcionarios ORDER BY nome ASC;
SELECT * FROM produtos ORDER BY preco DESC;
SELECT * FROM produtos LIMIT 5;
SELECT * FROM produtos ORDER BY preco ASC;
SELECT COUNT(*) FROM funcionarios;
SELECT DISTINCT nome FROM departamentos;
SELECT nome, email FROM funcionarios;

SELECT manutencao.responsavel, produtos.nome AS produto, manutencao.prazo_finalizacao
FROM manutencao
JOIN produtos ON manutencao.produto = produtos.id_produto
WHERE manutencao.prazo_finalizacao BETWEEN '2025-03-01' AND '2025-03-15';

SELECT produtos.nome, COUNT(manutencao.produto) AS total_manutencao
FROM manutencao
JOIN produtos ON manutencao.produto = produtos.id_produto
GROUP BY produtos.nome;

SELECT departamentos.nome, COUNT(manutencao.id_departamento) AS total_manutencao
FROM manutencao
JOIN departamentos ON manutencao.id_departamento = departamentos.id_departamento
GROUP BY departamentos.nome;

SELECT produtos.nome, COUNT(produtos_producao.produto_id) AS total_producoes
FROM produtos_producao
JOIN produtos ON produtos_producao.produto_id = produtos.id_produto
GROUP BY produtos.id_produto
HAVING total_producoes > 1;

SELECT * FROM clientes WHERE YEAR(CURDATE()) - YEAR(data_nascimento) > 30;

SELECT vendas.cliente, clientes.nome AS cliente_nome, produtos.nome AS produto_nome, funcionarios.nome AS vendedor_nome, vendas.valor 
FROM vendas
JOIN clientes ON vendas.cliente = clientes.id_cliente
JOIN produtos ON vendas.produto = produtos.id_produto
JOIN funcionarios ON vendas.vendedor = funcionarios.id_funcionario;

SELECT clientes.nome
FROM clientes
LEFT JOIN vendas ON clientes.id_cliente = vendas.cliente
WHERE vendas.cliente IS NULL;

SELECT produtos.nome, fornecedores.nome AS fornecedor_nome
FROM fornecedores
JOIN produtos ON FIND_IN_SET(produtos.nome, fornecedores.produtos) > 0;

SELECT clientes.nome, produtos.nome AS produto_nome
FROM clientes
JOIN vendas ON clientes.id_cliente = vendas.cliente
JOIN produtos ON vendas.produto = produtos.id_produto;

SELECT produtos.nome AS produto, clientes.nome AS cliente, funcionarios.nome AS funcionario
FROM vendas
JOIN produtos ON vendas.produto = produtos.id_produto
JOIN funcionarios ON vendas.vendedor = funcionarios.id_funcionario
JOIN clientes ON vendas.cliente = clientes.id_cliente;

SELECT 
    v.hora_da_compra, 
    c.nome AS cliente, 
    p.nome AS produto, 
    v.valor 
FROM vendas v
JOIN clientes c ON v.cliente = c.id_cliente
JOIN produtos p ON v.produto = p.id_produto
ORDER BY v.hora_da_compra DESC;

SELECT 
    produtos.nome AS produto, 
    clientes.nome AS cliente, 
    funcionarios.nome AS funcionario
FROM vendas
JOIN produtos ON vendas.produto = produtos.id_produto
JOIN clientes ON vendas.cliente = clientes.id_cliente
JOIN funcionarios ON vendas.vendedor = funcionarios.id_funcionario 
LIMIT 10;

-- testando a primeira view:
SELECT * FROM vw_vendas_detalhadas;
SELECT * FROM vw_vendas_detalhadas WHERE vendedor = 'ana costa';
SELECT * FROM vw_vendas_detalhadas ORDER BY valor ASC;
SELECT * FROM vw_vendas_detalhadas ORDER BY hora_da_compra DESC LIMIT 10;
SELECT COUNT(*) AS total_vendas FROM vw_vendas_detalhadas;
-- FUNCIONOU

-- testando a segunda view:
SELECT * FROM vw_vendas_por_cliente;
SELECT COUNT(*) AS total_vendas FROM fabrica.vw_vendas_por_cliente;
SELECT * FROM fabrica.vw_vendas_por_cliente WHERE id_cliente = 1;
SELECT id_cliente, nome_cliente, 
    COUNT(*) AS total_compras, 
    SUM(valor) AS total_gasto 
FROM fabrica.vw_vendas_por_cliente 
GROUP BY id_cliente, nome_cliente;
SELECT vendedor, nome_vendedor, 
    COUNT(*) AS total_vendas, 
    SUM(valor) AS total_vendido 
FROM fabrica.vw_vendas_por_cliente 
GROUP BY vendedor, nome_vendedor;
SELECT * FROM fabrica.vw_vendas_por_cliente WHERE hora_da_compra >= '2025-03-31 15:00:00';
-- FUNCIONOU

-- testando a terceira view:
SELECT * FROM vw_estoque_produtos;
SELECT COUNT(*) AS total_produtos_em_estoque 
FROM fabrica.vw_estoque_produtos 
WHERE status_estoque = 'Em Estoque';
SELECT * FROM fabrica.vw_estoque_produtos WHERE id_produto = 1;
SELECT * FROM fabrica.vw_estoque_produtos ORDER BY preco ASC;
SELECT * FROM fabrica.vw_estoque_produtos ORDER BY qtd_estoque DESC;
-- FUNCIONOU

-- testando a quarta view:
SELECT * FROM vw_projetos_em_andamento;
SELECT COUNT(*) FROM projetos; -- 10 projetos
SELECT COUNT(*) FROM projetos WHERE andamento <> 'Finalizado'; -- 7 em andamento (deve ser igual o da minha view)
SELECT COUNT(*) FROM projetos WHERE andamento = 'Finalizado'; -- 3 projetos finalizados (totalizando 10)
SELECT COUNT(*) FROM vw_projetos_em_andamento; -- 7, o que eu esperava
-- FUNCIONOU

-- testando o primeiro stored procedure:
SELECT * FROM vendas WHERE vendedor = 2; -- apenas uma venda
CALL sp_registrar_venda(1, 3, 2, 150.00); -- o número de linhas deve aumentar em 1
SELECT * FROM vendas WHERE vendedor = 2; -- duas vendas, 
-- FUNCIONOU

-- testando o segundo stored procedure:
SELECT * FROM manutencao WHERE responsavel = 1; -- apenas uma manutencao
CALL sp_registrar_manutencao(1, 2, '2023-12-31', 'Em andamento', 'Departamento A', 1); -- o número de linhas deve aumentar em 1
SELECT * FROM manutencao WHERE responsavel = 1; -- duas manutencoes, 
-- FUNCIONOU

-- testando a trigger:
SELECT qtd_estoque FROM produtos WHERE id_produto = 4; -- resultado: 40
INSERT INTO vendas (cliente, produto, vendedor, valor) VALUES (1, 4, 1, 200.00); -- o estoque deve ser diminuído em 1
SELECT * FROM produtos WHERE id_produto = 4; -- resultado: 39
-- FUNCIONOU
