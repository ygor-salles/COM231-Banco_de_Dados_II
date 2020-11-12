--Fábio Piovani Viviani - 2017006774
--Ygor Salles Aniceto Carvalho - 2017014382

--Questão A

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

--Questão B

INSERT INTO cliente VALUES
('17879612544', ROW('Rua Almeida de Claro', 144, 'Centro', 'Ipatinga', '37510-999'), 'João', '{"3598741-3625", "3597841-3621"}'),
('17879612549', ROW('Rua Tancredo', 144, 'Centro', 'Ipatinga', '37510-012'), 'João', '{"3598741-3625", "3597841-3621"}'),
('17879612542', ROW('Rua Acencio', 145, 'Centro', 'São João', '37510-336'), 'Maria', '{"3598745-5412", "2154215-2154"}'),
('17879612543', ROW('Rua Joaquim Francisco', 146, 'Centro', 'Ipatinga', '37698-999'), 'Pedro', '{"2121542-5451", "21215457-6568"}'),
('17879612541', ROW('Rua das palmeiras', 147, 'Centro', 'Itajubá', '37000-999'), 'Assis', '{"3598741-3625", "3597841-3621"}'),
('17879612540', ROW('Rua Toledo', 148, 'Centro', 'Ipatinga', '37000-999'), 'Antonio', '{"3598741-0000", "3597841-0023"}'),
('17879612545', ROW('Rua Sem Fim', 149, 'Centro', 'Ipatinga', '37001-123'), 'Benedito', '{"3598741-2445", "3597841-2154"}'),
('17879612546', ROW('Rua Pastel de Bis', 150, 'Centro', 'Ipatinga', '41698-999'), 'Carol', '{"3598741-4544", "3597841-5454"}'),
('17879612547', ROW('Rua Marcelo Leite', 198, 'Centro', 'Recife', '37510-387'), 'Joaquina', '{"3598741-5454", "3597841-5454"}'),
('17879612548', ROW('Rua Padre Mello', 100, 'Centro', 'Ipatinga', '54789-999'), 'Francisco', '{"3598741-5454", "4512154-3621"}')

INSERT INTO financiamento VALUES 
(1, '17879612548', '2020-02-20', 2500.36, 20),
(2, '17879612548', '2020-03-20', 3000, 15),
(3, '17879612548', '2020-04-15', 3500.36, 10),
(4, '17879612547', '2020-02-01', 4500.36, 10),
(5, '17879612546', '2020-03-01', 5500, 15),
(6, '17879612545', '2020-02-04', 6000, 20),
(7, '17879612540', '2020-07-18', 1250.50, 10),
(8, '17879612540', '2020-06-06', 15000, 20),
(9, '17879612541', '2020-02-20', 20000, 20),
(10, '17879612541', '2020-02-15', 12000, 5)

INSERT INTO veiculo VALUES
(123, 32000, 'chevrolet', 2017, 1),
(234, 40000, 'ford', 2017, 1),
(345, 15000, 'chevrolet', 2002, 2),
(456, 45000, 'fiat', 2020, 3),
(567, 33500, 'VolksWagen', 2014, 4),
(678, 32000, 'chevrolet', 2016, 5),
(789, 35000, 'chevrolet', 2018, 1),
(910, 52000, 'Renault', 2021, 2),
(911, 33000, 'Peugot', 2019, 7),
(912, 32000, 'chevrolet', 2015, 8)

INSERT INTO passeio VALUES
(1, 50000, 'chevrolet', 2019, 1, 5),
(2, 50000, 'chevrolet', 2019, 2, 5),
(3, 45000, 'chevrolet', 2019, 2, 5),
(4, 180000, 'chevrolet', 2015, 3, 2),
(5, 70000, 'hyunday', 2019, 4, 5),
(6, 100000, 'ford', 2019, 4, 5),	
(7, 220000, 'BMW', 2019, 4, 5),
(8, 32000, 'VolksWagen', 2019, 5, 5),
(9, 42000, 'Fiat', 2019, 6, 5),
(10, 50000, 'chevrolet', 2019, 5, 5)

INSERT INTO carga VALUES
(10, 50000, 'fiat', 2019, 1, 10, '1'),
(20, 50000, 'chevrolet', 2018, 2, 12, '1'),
(30, 45000, 'fiat', 2018, 2, 15, '2'),
(40, 180000, 'chevrolet', 2015, 3, 15, '2'),
(50, 70000, 'hyunday', 2019, 4, 15, '2'),
(60, 100000, 'ford', 2016, 4, 6, '3'),	
(70, 220000, 'BMW', 2019, 4, 20, '4'),
(80, 32000, 'VolksWagen', 2016, 5, 20, '5'),
(90, 42000, 'Fiat', 2019, 6, 15, '5'),
(100, 50000, 'chevrolet', 2015, 5, 15, '4')

--Questão C 

--Função para financimento de veículo de passeio
CREATE OR REPLACE FUNCTION realizaFinanciamento(int, numeric, varchar(20), int, int, int)
RETURNS bool AS
$BODY$
	DECLARE
		num_renavam ALIAS FOR $1;
		valor ALIAS FOR $2;
		marca ALIAS FOR $3;
		ano ALIAS FOR $4;
		num_financiamento ALIAS FOR $5;
		qtd_passageiros ALIAS FOR $6;
	BEGIN
		INSERT INTO passeio VALUES (num_renavam, valor, marca, ano, num_financiamento, qtd_passageiros);
		RAISE NOTICE 'Financiamento para veículo de passeio realizado';
		RETURN true;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;


--Função para financimento de veículo de carga
CREATE OR REPLACE FUNCTION realizaFinanciamento(int, numeric, varchar(20), int, int, int, eixo)
RETURNS bool AS
$BODY$
	DECLARE
		num_renavam ALIAS FOR $1;
		valor ALIAS FOR $2;
		marca ALIAS FOR $3;
		ano ALIAS FOR $4;
		num_financiamento ALIAS FOR $5;
		carga_maxima ALIAS FOR $6;
		numero_eixos ALIAS FOR $7;
	BEGIN
		INSERT INTO carga VALUES (num_renavam, valor, marca, ano, num_financiamento, carga_maxima, numero_eixos);
		RAISE NOTICE 'Financiamento para veículo de carga realizado';
		RETURN true;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

--Questão D

--Rodando a função para veículo de passeio
SELECT realizaFinanciamento(11, 22000, 'VolksWagen', 2017, 1, 5);

--Rodando a função para veículo de carga
SELECT realizaFinanciamento(110, 120000, 'Ford', 2018, 1, 10, '1');


--Questão E

create TYPE t_endereco AS (
	rua character varying(80),
	numero smallint,
	bairro character varying(30),
	cidade character varying(50),
	cep character varying(8)
);

create TYPE t_cliente AS(
	cpf varchar(11),
	endereco t_endereco,
	nome varchar(100),
	telefone text[3]	
);

create TYPE t_financiamento AS(
	numero int ,
	cliente t_cliente,
	dataa date,
	valor real,
	prazo int 
);

create table veiculo(
	num_renavam int primary key,
	valor real,
	marca varchar(20),
	ano smallint,
	financiamento t_financiamento
);

create table passeio(
	qtd_passageiros smallint not null
)inherits(veiculo);

CREATE TYPE eixos AS ENUM ('1', '2', '3', '4', '5');

create table carga(
	carga_maxima int not null,
	numero_eixos eixos not null
)inherits(veiculo);