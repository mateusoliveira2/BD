CREATE TABLE tarefas(
    codigo_tarefa integer,
    funcao text,
    cpf_funcionario varchar(11),
    prioridade integer,
    status varchar(1)
    CHECK (prioridade >= 0)
);

-- QUESTÃO 1
-- inserções para dar certo 

INSERT INTO tarefas VALUES(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432112', 1, 'F');
INSERT INTO tarefas VALUES(null, null, null, null, null);

-- inserções erradas 
INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '987654323211', 1, 'F');
-- ERROR:  value too long for type character varying(11) 

INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432321', 1, 'FF');
-- ERROR:  value too long for type character varying(1)



-- QUESTÃO 2

INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');
-- modificação do tipo para BIGINT
ALTER TABLE tarefas ALTER COLUMN codigo_tarefa TYPE bigint;

INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- QUESTÃO 3
ALTER TABLE tarefas ALTER COLUMN prioridade TYPE smallint;

-- QUESTÃO 4

DELETE FROM tarefas WHERE codigo_tarefa is null;

ALTER TABLE tarefas 
    ALTER COLUMN codigo_tarefa SET NOT NULL;
ALTER TABLE tarefas 
    RENAME COLUMN codigo_tarefa TO id;
    
ALTER TABLE tarefas 
    ALTER COLUMN funcao SET NOT NULL;
ALTER TABLE tarefas 
    RENAME COLUMN funcao TO descricao;
    
ALTER TABLE tarefas 
    ALTER COLUMN cpf_funcionario SET NOT NULL;
ALTER TABLE tarefas 
    RENAME COLUMN cpf_funcionario TO func_resp_cpf;
    
ALTER TABLE tarefas 
    ALTER COLUMN prioridade SET NOT NULl;
    
ALTER TABLE tarefas 
    ALTER COLUMN status SET NOT NULL;

-- QUESTÃO 5
-- tornando id uma PK, eu garanto que o id de cada tupla seja unico 
ALTER TABLE tarefas ADD PRIMARY KEY (id);
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911',2,'A');

-- QUESTÃO 6
-- A
ALTER TABLE tarefas ADD CONSTRAINT func_resp_cpf CHECK (length(func_resp_cpf) = 11);
-- B
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT status CHECK (status IN ('P', 'E', 'C'));

-- QUESTÃO 7
ALTER TABLE tarefas ADD CONSTRAINT prioridade CHECK (prioridade < 6 AND prioridade > -1);

--QUESTÃO 8
CREATE TABLE funcionario(
    cpf varchar(11) PRIMARY KEY,
    data_nasc date NOT NULL,
    nome varchar(20) NOT NULL,
    funcao varchar(20) NOT NULL,
    nivel varchar(1) NOT NULL,
    superior_cpf varchar(11) REFERENCES funcionario(cpf),
    CHECK (funcao IN ('SUP_LIMPEZA') OR (funcao IN ('LIMPEZA') AND superior_cpf IS NOT NULL)),
    CHECK (nivel IN ('J', 'P', 'S'))
);

INSERT INTO funcionario VALUES('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678912', '1980-05-07', 'Pedro da Silva', 'LIMPEZA', 'S', '12345678911');

--QUESTÃO 9
-- funciona
INSERT INTO funcionario VALUES('12345678000', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678001', '1980-05-07', 'Jose da Silva', 'LIMPEZA', 'S', '12345678911');
INSERT INTO funcionario VALUES('12345678011', '1980-05-07', 'Mauridio da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678111', '1980-05-07', 'Amandio da Silva', 'LIMPEZA', 'S', '12345678000');
INSERT INTO funcionario VALUES('12345678110', '1980-05-07', 'Mateus da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678100', '1980-05-07', 'Maria da Silva', 'LIMPEZA', 'S', '12345678110');
INSERT INTO funcionario VALUES('12345678101', '1980-05-07', 'Milena da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678010', '1980-05-07', 'Carlos da Silva', 'LIMPEZA', 'S', '12345678101');
INSERT INTO funcionario VALUES('12345678092', '1980-05-07', 'Stefany da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678245', '1980-05-07', 'Lady da Silva', 'LIMPEZA', 'S', '12345678092');
--nao funiona
INSERT INTO funcionario VALUES(null, null, null, null, null, null);
INSERT INTO funcionario VALUES('12345678001', '1980-05-07', 'Jose da Silva', 'LIMPEZA', 'S', null;
INSERT INTO funcionario VALUES('12345678011', '1980-05-07', 'Mauridio da Silva', 'SUP_LIMPEZA', 'A', null);
INSERT INTO funcionario VALUES('12345678111', '1980-05-07', 'Amandio da Silva', 'LIMPEZA', 'B', '12345678000');
INSERT INTO funcionario VALUES('12345678110', '1980-05-07', 'Mateus da Silva', 'SUP_LIMPEZA', 'C', null);
INSERT INTO funcionario VALUES(null, '1980-05-07', 'Maria da Silva', 'LIMPEZA', 'S', '12345678110');
INSERT INTO funcionario VALUES('12345678101', null, 'Milena da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678010', '1980-05-07', null, 'LIMPEZA', 'S', '12345678101');
INSERT INTO funcionario VALUES('12345678092', '1980-05-07', 'Stefany da Silva', null, 'S', null);
INSERT INTO funcionario VALUES('12345678245', '1980-05-07', 'Lady da Silva', 'LIMPEZA', null, '12345678092');

-- QUESTAO 11
ALTER TABLE tarefas
    ALTER COLUMN func_resp_cpf DROP NOT NULL;

ALTER TABLE tarefas
    ADD CHECk (func_resp_cpf IS NOT NULL AND status IN ('P', 'C'));

