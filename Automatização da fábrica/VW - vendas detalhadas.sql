CREATE VIEW vw_vendas_detalhadas AS
SELECT 
    v.hora_da_compra,
    c.nome AS cliente,
    p.nome AS produto,
    v.valor,
    f.nome AS vendedor
FROM
    vendas v
JOIN 
    clientes c ON v.cliente = c.id_cliente
JOIN 
    produtos p ON v.produto = p.id_produto
JOIN 
    funcionarios f ON v.vendedor = f.id_funcionario;
