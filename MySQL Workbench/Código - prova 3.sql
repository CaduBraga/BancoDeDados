CREATE DATABASE miniWEG;
USE miniWEG;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE, -- não há 2 produtos com o mesmo nome
    descricao TEXT,
    preco_unitario DECIMAL(10,2) NOT NULL
);

CREATE TABLE materia_prima (
    id_materia_prima INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    unidade_de_medida ENUM ('litros', 'gramas', 'metros', 'unidade') NOT NULL,
    custo_unitario DECIMAL(10,2) NOT NULL
);
-- tabela associativa:
CREATE TABLE produto_materia (
    id_produto INT,
    id_mp INT,
    quantidade DECIMAL(10,2) NOT NULL, 
    /*a atividade pede para usar decimal(10,2), 
    mas eu usaria int, pois a quantidade sempre será um número natural (inteiro e >0)*/
    PRIMARY KEY (id_produto, id_mp),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_mp) REFERENCES materia_prima(id_materia_prima)
);

CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE
);
-- tabela associativa:
CREATE TABLE fornecimento (
    id_fornecedor INT,
    id_mp_fornecida INT,
    PRIMARY KEY (id_fornecedor, id_mp_fornecida),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (id_mp_fornecida) REFERENCES materia_prima(id_materia_prima)
);

CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
    -- não existem dois departamentos com o mesmo nome
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    dpto_pertencente INT,
    FOREIGN KEY (dpto_pertencente) REFERENCES departamentos(id_departamento)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20) UNIQUE NOT NULL,
    /*não há dois clientes com o mesmo telefone, e é obrigatório, 
    para podermos entrar em contato com eles, já o email é opicional*/
    email VARCHAR(100) UNIQUE
);
-- tabela superclasse:
CREATE TABLE ordem_producao (
    id_ordem INT PRIMARY KEY AUTO_INCREMENT,
    data_op DATE NOT NULL,
    func_responsavel INT,
    observacoes TEXT,
    FOREIGN KEY (func_responsavel) REFERENCES funcionarios(id_funcionario)
);
-- tabela subclasse:
CREATE TABLE ordem_item (
    id_ordem INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_ordem, id_produto),
    FOREIGN KEY (id_ordem) REFERENCES ordem_producao(id_ordem),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
-- tabela superclasse:
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
-- tabela subclasse:
CREATE TABLE venda_item (
    id_venda INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    /*é o preço do momento exato da venda, 
    por isso não devemos usar uma chave estrangeira para preencher esse campo*/
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
/*troquei a ordem de algumas entidades para ficar uma legibilidade melhor,
tendo uma subclasse (classe filho) logo depois da sua superclasse (classe pai),
e mantendo também as tabelas associativas o mais próximo possível das tabelas associadas*/
