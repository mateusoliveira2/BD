-- Mateus de Lima Oliveira 117110219

CREATE TABLE automovel(
  marca varchar(10),
  modelo varchar(15),
  placa varchar(7),
  cor varchar(10),
  num_portas integer,
  ano integer,
  num_chassi integer
);

CREATE TABLE segurado(
  nome varchar(15),
  cpf varchar(11),
  rg varchar(7),
  data_nascimento date,
  sexo varchar(9),
  telefone varchar(15),
  inicio_seguro date
);

CREATE TABLE perito(
  nome varchar(15),
  cadastro_perito NOT NULL,
  cpf varchar(11),
  rg varchar(6),
  telefone varchar(15)
);

CREATE TABLE oficina(
  nome varchar(15),
  cnpj varchar(18),
  endereco varchar(50)
);

CREATE TABLE seguro(
  data_contrato date,
  valor numeric,
  num_registro integer,
  tipo varchar(30)
);

CREATE TABLE sinistro(
  data_sinistro date,
  tipo varchar(20),
  local varchar(30),
  descricao_ocorrido text
);

CREATE TABLE pericia(
  danos text,
  valor_estimado numeric,
  data_pericia date
);

CREATE TABLE reparo(
  data_pericia date,
  autorizacao boolean,
  valor numeric
);

ALTER TABLE automovel ADD PRIMARY KEY (placa);
ALTER TABLE segurado ADD PRIMARY KEY (cpf);
ALTER TABLE perito ADD PRIMARY KEY (cpf);
ALTER TABLE seguro ADD PRIMARY KEY (num_registro);
ALTER TABLE oficina ADD PRIMARY KEY (cnpj);

-- criando FK ligando um veiculo ao proprietario
ALTER TABLE segurado ADD COLUMN veiculo varchar(7);
ALTER TABLE segurado ADD CONSTRAINT automovel FOREIGN KEY (veiculo) REFERENCES automovel(placa);

-- criando FK's ligando um perito e um veiculo a uma pericia
ALTER TABLE pericia ADD COLUMN veiculo_analisado varchar(7);
ALTER TABLE pericia ADD COLUMN perito_analista varchar(11);

ALTER TABLE pericia ADD CONSTRAINT perito_analista FOREIGN KEY (perito_analista) REFERENCES perito(cpf);
ALTER TABLE pericia ADD CONSTRAINT veiculo_analisado FOREIGN KEY (veiculo_analisado) REFERENCES automovel(placa);

-- criando uma FK para ligar perito à oficina que trabalha
ALTER TABLE perito ADD COLUMN oficina_empregado varchar(18);
ALTER TABLE perito ADD CONSTRAINT oficina_empregado FOREIGN KEY (oficina_empregado) REFERENCES oficina(cnpj);

-- criando FK's para seguro ao veiculo e proprietario a um seguro
ALTER TABLE seguro ADD COLUMN segurado varchar(11);
ALTER TABLE seguro ADD COLUMN veiculo varchar(7);

ALTER TABLE seguro ADD CONSTRAINT segurado FOREIGN KEY (segurado) REFERENCES segurado(cpf);
ALTER TABLE seguro ADD CONSTRAINT veiculo FOREIGN KEY (veiculo) REFERENCES automovel(placa);

-- criando FK ligar o reparo ao veiculo e à oficina
ALTER TABLE reparo ADD COLUMN veiculo varchar(7);
ALTER TABLE reparo ADD COLUMN oficina varchar(18);

ALTER TABLE reparo ADD CONSTRAINT oficina FOREIGN KEY (oficina) REFERENCES oficina(cnpj);
ALTER TABLE reparo ADD CONSTRAINT veiculo FOREIGN KEY (veiculo) REFERENCES automovel(placa);

-- criando FK ligar o sinistro ao veiculo 
ALTER TABLE sinistro ADD COLUMN veiculo varchar(7);
ALTER TABLE sinistro ADD CONSTRAINT veiculo FOREIGN KEY (veiculo) REFERENCES automovel(placa);

-- apagando todas as tabelas
DROP TABLE pericia CASCADE;
DROP TABLE perito CASCADE ;
DROP TABLE reparo ;
DROP TABLE seguro;
DROP TABLE sinistro;
DROP TABLE segurado CASCADE;
DROP TABLE automovel CASCADE;
DROP TABLE oficina CASCADE;

-- CREATES COM CONSTRAINTS

CREATE TABLE automovel(
  marca varchar(10) NOT NULL,
  modelo varchar(15) NOT NULL,
  placa varchar(7) PRIMARY KEY,
  cor varchar(10),
  num_portas integer NOT NULL,
  ano integer NOT NULL,
  num_chassi integer NOT NULL
);

CREATE TABLE segurado(
  nome varchar(15) NOT NULL,
  cpf varchar(11) PRIMARY KEY,
  rg varchar(7) NOT NULL,
  data_nascimento date NOT NULL,
  sexo varchar(9),
  telefone varchar(15) NOT NULL,
  inicio_seguro date NOT NULL,
  veiculo varchar(7) REFERENCES automovel(placa)
);

CREATE TABLE oficina(
  nome varchar(15),
  cnpj varchar(18) PRIMARY KEY,
  endereco varchar(50) NOT NULL
);

CREATE TABLE perito(
  nome varchar(15) NOT NULL,
  cadastro_perito varchar(7) NOT NULL,
  cpf varchar(11) PRIMARY KEY,
  rg varchar(6) NOT NULL,
  oficina_empregado varchar(18) REFERENCES oficina(cnpj),
  telefone varchar(15)
);

CREATE TABLE seguro(
  data_contrato date NOT NULL,
  valor numeric NOT NULL,
  num_registro integer PRIMARY KEY,
  veiculo varchar(7) REFERENCES automovel(placa),
  segurado varchar(11) REFERENCES segurado(cpf),
  tipo varchar(30) NOT NULL
);

CREATE TABLE sinistro(
  data_sinistro date,
  tipo varchar(20),
  local varchar(30),
  veiculo varchar(7) REFERENCES automovel(placa),
  descricao_ocorrido text NOT NULL
);

CREATE TABLE pericia(
  danos text,
  valor_estimado numeric NOT NULL,
  perito_analista varchar(11) REFERENCES perito(cpf),
  veiculo_analisado varchar(7) REFERENCES automovel(placa),
  data_pericia date
);

CREATE TABLE reparo(
  data_pericia date,
  autorizacao boolean NOT NULL,
  veiculo varchar(7) REFERENCES automovel(placa),
  oficina varchar(18) REFERENCES oficina(cnpj),
  valor numeric
);

-- apagando todas as tabelas
DROP TABLE pericia CASCADE;
DROP TABLE perito CASCADE ;
DROP TABLE reparo ;
DROP TABLE seguro;
DROP TABLE sinistro;
DROP TABLE segurado CASCADE;
DROP TABLE automovel CASCADE;
DROP TABLE oficina CASCADE;