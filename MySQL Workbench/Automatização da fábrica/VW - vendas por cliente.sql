CREATE VIEW vw_vendas_por_cliente AS
SELECT 
    c.id_cliente,
    c.nome AS nome_cliente,
    v.produto,
    p.nome AS nome_produto,
    v.vendedor,
    f.nome AS nome_vendedor,
    v.valor,
    v.hora_da_compra
FROM
    vendas v
JOIN 
    clientes c ON v.cliente = c.id_cliente
JOIN 
    produtos p ON v.produto = p.id_produto
JOIN 
    funcionarios f ON v.vendedor = f.id_funcionario;
