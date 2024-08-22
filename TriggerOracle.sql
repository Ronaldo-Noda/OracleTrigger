CREATE TABLE TB_PEDIDOS(ID NUMBER,
COD_PEDIDO NUMBER,
DATA_CRIACAO DATE,
DATA_ATUAL DATE,
STATUS VARCHAR2(10));

CREATE OR REPLACE TRIGGER trg_pedido
    BEFORE INSERT ON TB_PEDIDOS
    FOR EACH ROW
BEGIN
    IF :NEW.STATUS IS NULL THEN
       :NEW.STATUS := 'Novo Pedido';  
    END IF;
END;

INSERT INTO tb_pedidos VALUES (
    1,
    2255,
    sysdate,
    sysdate + 2,
    'Pedido Novo'
);

SELECT * FROM tb_pedidos;

INSERT INTO tb_pedidos (
    id,
    cod_pedido,
    data_criacao,
    data_atual
)
VALUES (
    111,
    555,
    sysdate,
    sysdate + 8
);

ALTER TABLE tb_pedidos MODIFY STATUS VARCHAR2 (30);

CREATE TABLE TB_AUDITORIA
(
    id  NUMBER generated always as identity,
    tabela VARCHAR2(30),
    operacao varchar2(30),
    data DATE,
    usuario varchar2(30)
)

CREATE OR REPLACE TRIGGER trg_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON TB_PEDIDOS
    FOR EACH ROW
DECLARE
    operacao VARCHAR2(30);
    nome_usuario VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        operacao := 'INSERT';
    ELSIF UPDATING THEN
        operacao := 'UPDATE';
    ELSIF DELETING THEN
        operacao := 'DELETE';
    END IF;
    
    nome_usuario := SYS_CONTEXT('USERENV', 'SESSION_USER');
    
    INSERT INTO TB_AUDITORIA
        (tabela, operacao, DATA, usuario)
    VALUES
        ('PEDIDOS_NOVOS', operacao, sysdate, nome_usuario);
    END;
    

SELECT * FROM TB_AUDITORIA
    
UPDATE TB_PEDIDOS SET ID = 222 WHERE ID=1;
DELETE FROM TB_PEDIDOS

    

