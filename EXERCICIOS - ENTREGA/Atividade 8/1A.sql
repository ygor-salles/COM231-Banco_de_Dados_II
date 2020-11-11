CREATE TYPE t_endereco AS (
	rua varchar(50),
	numero smallint,
	bairro varchar(30),
	cidade varchar(30),
	cep varchar(9)
);

CREATE TABLE cliente(
	cpf varchar(11) PRIMARY KEY,
	endereco t_endereco,
	name varchar(100),
	telefone text[]
);

CREATE TABLE financiamento (
	numero integer PRIMARY KEY,
	cpf_cliente varchar(11),
	data date,
	valor numeric,
	prazo integer,
		FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);

CREATE TABLE veiculo (
	num_renavam integer PRIMARY KEY,
	valor numeric,
	marca varchar(20),
	ano smallint,
	num_financiamento integer,
		FOREIGN KEY (num_financiamento) REFERENCES financiamento(numero)
);

CREATE TABLE passeio (
	qtd_passageiros smallint
) INHERITS(veiculo);

CREATE TYPE eixo AS ENUM ('1', '2', '3', '4', '5');

CREATE TABLE carga (
	carga_maxima integer,
	numero_eixos eixo
) INHERITS(veiculo);