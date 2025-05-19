CREATE VIEW vw_estoque_produtos AS
SELECT 
    p.id_produto,
    p.nome AS nome_produto,
    p.preco,
    p.qtd_estoque,
    CASE
        WHEN p.qtd_estoque = 0 THEN 'Fora de Estoque'
        WHEN p.qtd_estoque < 5 THEN 'Estoque Baixo'
        ELSE 'Em Estoque'
    END AS status_estoque
FROM
    produtos p;


/* sei que parte disso, como o THEN, 
que exibe a mensagem dependendo do nível do estoque 
(baseado no WHEN, que lê e confirma ou nega a afirmação)  e o CASE, 
que cria uma nova coluna, nós ainda não aprendemos, 
mas dei uma pesquisada na internet para conseguir 
implementar o meu código da forma que eu queria / *