CREATE VIEW vw_projetos_em_andamento AS
SELECT 
    id_responsavel,
    nome_responsavel,
    id_produto,
    produto,
    prazo,
    andamento,
    tipo_projeto,
    departamento_solicitante,
    id_departamento
FROM
    projetos
WHERE
    andamento <> 'Finalizado';
