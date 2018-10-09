
CREATE TABLE funcionario(
    nome varchar(30) NOT NULL,
    cpf varchar(11) PRIMARY KEY,
    funcao varchar(20) NOT NULL,
    CHECK (funcao IN ('farmacêutico', 'vendedor', 'entregador', 'caixa', 'administrador'))
);

CREATE TYPE uf AS ENUM ('PB', 'PE', 'MA', 'RN', 'BA', 'AL', 'CE','PI','SE');

CREATE TABLE farmacia(
    nome varchar(20) NOT NULL,
    tipo varchar(6) NOT NULL,
    bairro varchar(20) UNIQUE,
    gerente varchar(11) REFERENCES funcionario(cpf),
    estado uf,
    id serial PRIMARY KEY,
    EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'sede')
);

CREATE TABLE vinculo(
    funcionario_cpf varchar(11) REFERENCES funcionario(cpf) UNIQUE,
    funcao varchar(20) NOT NULL,
    gerencia boolean,
    farmacia_id integer REFERENCES farmacia(id) NOT NULL,
    CHECK (gerencia IS true AND funcao IN ('farmacêutico', 'administrador'))
);

CREATE TABLE cliente(
    cpf varchar(11) PRIMARY KEY,
    nome varchar(30) NOT NULL,
    data_nascimento date NOT NULL,
    CHECK (date_part('year', INTERVAL age(data_nascimento) > 18)
);

CREATE TABLE endereco(
    rua varchar(20) NOT NULL,
    tipo varchar(20) NOT NULL,
    numero varchar(6) NOT NULL,
    bairro varchar(20) NOT NULL,
    nome_cliente varchar(30) NOT NULL,
    cpf_cliente varchar(11) REFERENCES cliente(cpf),
    CHECK (tipo IN ('residência', 'trabalho', 'outro'))
);

CREATE TABLE medicamento(
    nome varchar(20) NOT NULL,
    cod_cadastro integer PRIMARY KEY,
    controlado boolean NOT NULL,
    marca varchar(20) NOT NULL
);

CREATE TABLE venda(
    id_venda serial PRIMARY KEY,
    cod_cadastro_medicamento integer REFERENCES medicamento(cod_cadastro) NOT NULL,
    controlado boolean NOT NULL,
    cpf_cliente varchar(11) REFERENCES cliente(cpf),
    cpf_funcionario varchar(11) REFERENCES  funcionario(cpf)
    CHECK (controlado IS TRUE AND cpf_cliente IS NOT NULL)
);

CREATE TABLE entrega(
    cpf_cliente varchar(11) REFERENCES endereco(cpf_cliente) NOT NULL,
    id_venda integer
);






