CREATE PROCEDURE sp_registrar_manutencao(
    IN p_responsavel INT,
    IN p_produto INT,
    IN p_prazo_finalizacao DATE,
    IN p_andamento ENUM('Finalizado', 'Em andamento', 'Perda total'),
    IN p_departamento_solicitante VARCHAR(50),
    IN p_id_departamento INT
)
BEGIN
    INSERT INTO manutencao (responsavel, produto, prazo_finalizacao, andamento, departamento_solicitante, id_departamento) 
    VALUES (p_responsavel, p_produto, p_prazo_finalizacao, p_andamento, p_departamento_solicitante, p_id_departamento);
END;