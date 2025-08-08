# Guia de Contribuição

Obrigado por considerar contribuir para este projeto educacional de Banco de Dados!

## Como Contribuir

### 1. Fork e Clone

1. Faça um fork deste repositório
2. Clone o fork para sua máquina local:
   ```bash
   git clone https://github.com/CaduBraga/banco-de-dados.git
   ```

### 2. Crie uma Branch

Crie uma branch para sua contribuição:
```bash
git checkout -b feature/nova-consulta-sql
```

### 3. Desenvolva

- Mantenha os scripts SQL limpos e bem documentados
- Siga os padrões de nomenclatura SQL
- Adicione comentários explicativos quando necessário
- Teste seus scripts em diferentes versões do MySQL
- Mantenha a performance das consultas otimizada

### 4. Commit

Faça commits com mensagens descritivas:
```bash
git commit -m "Adiciona nova stored procedure para relatório de vendas"
```

### 5. Push e Pull Request

1. Faça push para sua branch:
   ```bash
   git push origin feature/nova-consulta-sql
   ```

2. Crie um Pull Request no GitHub

## Padrões de Código

### SQL

- Use nomes descritivos para tabelas, colunas e procedures
- Mantenha a consistência na nomenclatura (snake_case para tabelas/colunas)
- Use comentários para explicar lógicas complexas
- Organize as cláusulas SQL em ordem lógica

### Estrutura de Scripts

```sql
-- =============================================
-- Nome: Nome do Script
-- Descrição: Descrição detalhada
-- Autor: Seu Nome
-- Data: YYYY-MM-DD
-- =============================================

-- Configurações iniciais
SET @variavel = valor;

-- Criação de tabelas
CREATE TABLE nome_tabela (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_coluna VARCHAR(100) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserção de dados de exemplo
INSERT INTO nome_tabela (nome_coluna) VALUES ('exemplo');

-- Consultas principais
SELECT * FROM nome_tabela WHERE condicao;
```

### Comentários

```sql
-- Comentário de linha única

/*
 * Comentário de múltiplas linhas
 * Para explicar lógicas complexas
 */

-- Seção de criação de tabelas
-- =============================
```

### Stored Procedures

```sql
DELIMITER //

CREATE PROCEDURE NomeProcedure(
    IN parametro_entrada VARCHAR(100),
    OUT parametro_saida INT
)
BEGIN
    -- Lógica da procedure
    SELECT COUNT(*) INTO parametro_saida 
    FROM tabela 
    WHERE coluna = parametro_entrada;
END //

DELIMITER ;
```

### Triggers

```sql
DELIMITER //

CREATE TRIGGER nome_trigger
BEFORE INSERT ON tabela
FOR EACH ROW
BEGIN
    -- Lógica do trigger
    SET NEW.data_modificacao = NOW();
END //

DELIMITER ;
```

## Tipos de Contribuição

### 🐛 Correção de Bugs
- Descreva o bug claramente
- Inclua passos para reproduzir
- Teste em diferentes versões do MySQL
- Adicione logs de erro se necessário

### ✨ Novas Funcionalidades
- Explique a funcionalidade proposta
- Mantenha consistência com a estrutura existente
- Adicione documentação SQL
- Teste a performance das consultas

### 📚 Melhorias na Documentação
- Corrija erros de gramática
- Adicione exemplos de uso
- Melhore a clareza das instruções
- Atualize diagramas se necessário

### 🎨 Melhorias de Performance
- Otimize consultas existentes
- Adicione índices apropriados
- Refatore stored procedures
- Mantenha a integridade dos dados

### 🔒 Melhorias de Segurança
- Implemente validações adequadas
- Use prepared statements
- Adicione controle de acesso
- Documente práticas de segurança

## Estrutura de Projetos

```
projeto/
├── scripts/
│   ├── criacao_tabelas.sql
│   ├── dados_exemplo.sql
│   └── procedures.sql
├── consultas/
│   ├── relatorios.sql
│   └── analises.sql
├── documentacao/
│   ├── dicionario_dados.pdf
│   └── diagrama_er.pdf
└── README.md
```

## Processo de Review

1. **Análise de Código**: Seu script SQL será revisado
2. **Testes**: Verifique se funciona em diferentes versões do MySQL
3. **Performance**: Teste a performance das consultas
4. **Documentação**: Atualize documentação se necessário
5. **Merge**: Após aprovação, será mergeado

## Boas Práticas

### Segurança
- Nunca inclua dados sensíveis ou pessoais
- Use sempre dados fictícios para exemplos
- Implemente validações adequadas
- Use prepared statements quando apropriado

### Performance
- Otimize consultas com EXPLAIN
- Use índices apropriados
- Evite SELECT * desnecessários
- Considere o impacto em grandes volumes de dados

### Manutenibilidade
- Documente adequadamente
- Use nomes descritivos
- Mantenha consistência no código
- Comente lógicas complexas

## Código de Conduta

- Seja respeitoso e construtivo
- Ajude outros estudantes de banco de dados
- Mantenha o foco educacional do projeto
- Reporte problemas de forma profissional
- Respeite as diretrizes de segurança de dados

## Contato

Para dúvidas ou sugestões:
- Abra uma issue no GitHub
- Entre em contato com o autor

---

**Obrigado por contribuir para o aprendizado de banco de dados!** 🗄️🎓
