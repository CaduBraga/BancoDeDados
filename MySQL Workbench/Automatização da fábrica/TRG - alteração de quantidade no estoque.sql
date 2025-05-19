CREATE TRIGGER trg_alteracao_qtd_estoque
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    UPDATE produtos 
    SET qtd_estoque = qtd_estoque - 1 
    WHERE id_produto = NEW.produto;
END;