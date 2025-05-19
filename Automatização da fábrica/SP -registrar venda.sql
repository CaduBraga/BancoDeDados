CREATE PROCEDURE sp_registrar_venda(
    IN p_cliente INT,
    IN p_produto INT,
    IN p_vendedor INT,
    IN p_valor DECIMAL(10, 2)
)
BEGIN
    DECLARE v_qtd_estoque INT;
    DECLARE v_venda_existente INT;

    SELECT qtd_estoque INTO v_qtd_estoque 
    FROM produtos 
    WHERE id_produto = p_produto;

    IF v_qtd_estoque > 0 THEN
        SELECT COUNT(*) INTO v_venda_existente 
        FROM vendas 
        WHERE cliente = p_cliente AND produto = p_produto;

        IF v_venda_existente = 0 THEN
            INSERT INTO vendas (cliente, produto, vendedor, valor) 
            VALUES (p_cliente, p_produto, p_vendedor, p_valor);
        ELSE
            UPDATE vendas 
            SET valor = p_valor, vendedor = p_vendedor 
            WHERE cliente = p_cliente AND produto = p_produto;
        END IF;

        UPDATE produtos 
        SET qtd_estoque = qtd_estoque - 1 
        WHERE id_produto = p_produto;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para realizar a venda.';
    END IF;
END;





/*sei que algumas das coisas que estão no código ainda não aprendemos 
(if, else, que são condicionais, declare, que declara variáveis, 
e o signal sqlstate, que avisa que não há 
estoque suficiente para a venda), mas busquei na internet para 
fazer a implementação do código da forma que eu queria*/