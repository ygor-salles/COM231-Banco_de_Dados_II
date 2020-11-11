CREATE TYPE t_endereco AS (
	rua varchar(50),
	numero smallint,
	bairro varchar(30),
	cidade varchar(30),
	cep varchar(9)
);

CREATE TYPE t_financiamento AS(
	numero integer PRIMARY KEY,
	data date,
	valor numeric,
	prazo integer,
	veiculo t_veiculo[]
);


CREATE TYPE t_veiculo AS(
	num_renavam integer PRIMARY KEY,
	valor numeric,
	marca varchar(20),
	ano smallint
);

CREATE TYPE t_passeio AS(
	qtd_passageiros smallint
) INHERITS(t_veiculo);

CREATE TYPE eixo AS ENUM ('1', '2', '3', '4', '5');

CREATE TYPE t_carga AS(
	carga_maxima integer,
	numero_eixos eixo
) INHERITS(t_veiculo);

CREATE TABLE cliente(
	cpf varchar(11) PRIMARY KEY,
	endereco t_endereco,
	name varchar(100),
	telefone text[],
	financiamento t_finaciamento[]
);