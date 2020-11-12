--Fábio Piovani Viviani 2017006774
--Ygor Salles Aniceto Carvalho 2017014382

-- A)
CREATE TYPE t_endereco AS(
	rua character varying(80),
	numero smallint,
	bairro character varying(30),
	cidade character varying(50),
	cep character varying(8)
);

CREATE TABLE cliente 
(
	cpf character varying(11) NOT NULL,
	endereco t_endereco NOT NULL,
	nome character varying(50) NOT NULL,
	telefone text[3],
	PRIMARY KEY (cpf)
);

CREATE TABLE financiamento 
(
	numero int NOT NULL,
	cpf_cliente character varying(11) NOT NULL,
	data date NOT NULL,
	valor real NOT NULL,
	prazo int NOT NULL,
	PRIMARY KEY (numero),
	FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE veiculo 
(
	num_renavam int NOT NULL,
	num_financ int NOT NULL,
	valor real NOT NULL,
	marca character varying(20) NOT NULL,
	ano smallint NOT NULL,
	PRIMARY KEY (num_renavam),
	FOREIGN KEY (num_financ) REFERENCES financiamento(numero) 
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE passeio 
(
	qtd_passageiros smallint NOT NULL
)INHERITS(veiculo);

CREATE TYPE num_eixos AS ENUM ('um','dois','tres','quatro','cinco','seis','sete','oito','nove');

CREATE TABLE carga 
(
	carga_maxima int NOT NULL,
	numero_eixos num_eixos
)INHERITS(veiculo);

-- B)
INSERT INTO cliente VALUES ('12345678911', 
	row('Av.BPS', 1400, 'BPS', 'Itajuba', '37500000'), 'Lucas', '{{"98820-4561"}, {"99127-9018"}}');
INSERT INTO cliente VALUES ('11987654321', 
	row('Rua Porto Seguro', 10, 'Centro', 'Santa Rita do Sapucai', '37540010'), 'Gabriel', '{{"98840-7953"}}');
INSERT INTO cliente VALUES ('98765432108', 
	row('Rua Santo Antônio', 105, 'Centro', 'Pouso Alegre', '37550000'), 'Ana Julia', '{{"98890-9565"}, {"99127-9878"}, {"99937-4083"}}');
INSERT INTO cliente VALUES ('42345972604', 
	row('Rua Doutor Silvestre Ferraz', 1, 'Centro', 'Itajuba', '37500031'), 'Maria', '{{"98723-9015"}}');
INSERT INTO cliente VALUES ('72345678911', 
	row('Av.BPS', 1400, 'BPS', 'Itajuba', '37500000'), 'Laura', '{{"99820-4701"}}');
INSERT INTO cliente VALUES ('90345678923', 
	row('Rua Projetada', 238, 'Recanto das Chácaras', 'Santa Rita do Sapucai', '37540700'), 'Rodrigo', '{{"98862-0838"}}');
INSERT INTO cliente VALUES ('32345602847', 
	row('Rua Eurico Arantes', 77, 'Fernandes', 'Santa Rita do Sapucai', '37540833'), 'Marina', '{{"99872-0429"}, {"99111-6662"}}');
INSERT INTO cliente VALUES ('87345678850', 
	row('Rua Carlos Prestes', 1003, 'Monte Belo', 'Pouso Alegre', '37550518'), 'Jonas', '{{"99920-1489"}}');
INSERT INTO cliente VALUES ('51345678993', 
	row('Av.Salvador', 515, 'Centro', 'Pouso Alegre', '37550071'), 'Alexandre', '{{"99184-1981"}, {"98172-1987"}}');
INSERT INTO cliente VALUES ('60345678981', 
	row('Rua Costa Manso', 7, 'Varginha', 'Itajuba', '37501326'), 'Marcela', '{{"99854-0832"}}');

INSERT INTO financiamento VALUES (1, '12345678911', '2019-06-17', 3000000.0, 14);
INSERT INTO financiamento VALUES (2, '11987654321', '2019-08-13', 175300.5, 7);
INSERT INTO financiamento VALUES (3, '98765432108', '2019-09-24', 6500000.0, 16);
INSERT INTO financiamento VALUES (4, '42345972604', '2019-12-22', 200000.5, 5);
INSERT INTO financiamento VALUES (5, '72345678911', '2020-01-10', 2750000.0, 9);
INSERT INTO financiamento VALUES (6, '90345678923', '2020-02-25', 380000.0, 6);
INSERT INTO financiamento VALUES (7, '32345602847', '2020-02-29', 490000.0, 8);
INSERT INTO financiamento VALUES (8, '87345678850', '2020-04-27', 230000.0, 7);
INSERT INTO financiamento VALUES (9, '51345678993', '2020-06-06', 780000.5, 10);
INSERT INTO financiamento VALUES (10, '60345678981', '2020-07-10', 100000.0, 12);

INSERT INTO passeio VALUES (0111111111, 1, 150000.0, 'Chevrolet', 2018, 4);
INSERT INTO passeio VALUES (0222222222, 5, 250000.5, 'Volkswagen', 2020, 5);
INSERT INTO passeio VALUES (0333333333, 3, 60000.0, 'Fiat', 2017, 4);
INSERT INTO passeio VALUES (0444444444, 4, 21500.5, 'Chevrolet', 2015, 1);
INSERT INTO passeio VALUES (0555555555, 1, 275000.0, 'Volkswagen', 2019, 3);
INSERT INTO passeio VALUES (0666666666, 6, 36000.0, 'Fiat', 2018, 2);
INSERT INTO passeio VALUES (0777777777, 5, 210000.0, 'Ford', 2020, 4);
INSERT INTO passeio VALUES (0888888888, 8, 34000.0, 'Volkswagen', 2015, 3);
INSERT INTO passeio VALUES (0999999999, 9, 480000.5, 'Chevrolet', 2019, 4);
INSERT INTO passeio VALUES (0123456789, 2, 70100.0, 'Fiat', 2018, 3);

INSERT INTO carga VALUES (1111111111, 1, 75000.0, 'Ford', 2018, 3200, 'dois');
INSERT INTO carga VALUES (1222222222, 5, 650000.5, 'HYUNDAI', 2020, 10000, 'nove');
INSERT INTO carga VALUES (1333333333, 3, 450000.0, 'KIA', 2020, 5600, 'seis');
INSERT INTO carga VALUES (1444444444, 3, 345000.5, 'Ford', 2020, 8500, 'sete');
INSERT INTO carga VALUES (1555555555, 3, 800000.0, 'HYUNDAI', 2019, 10500, 'nove');
INSERT INTO carga VALUES (1666666666, 4, 120000.0, 'KIA', 2019, 3850, 'quatro');
INSERT INTO carga VALUES (1777777777, 7, 470000.0, 'Volvo', 2019, 3650, 'tres');
INSERT INTO carga VALUES (1888888888, 8, 98000.0, 'Ford', 2019, 3700, 'tres');
INSERT INTO carga VALUES (1999999999, 2, 70000.5, 'HYUNDAI', 2016, 3000, 'dois');
INSERT INTO carga VALUES (1123456789, 10, 83500.0, 'Ford', 2018, 3500, 'dois');

-- C)
CREATE FUNCTION realizaFinanciamento(int, character varying(11), date, real, int, int, real, character varying(20), int, int)
RETURNS bool AS
$BODY$
	declare
		numFinanciamento alias for $1;
		cpfCliente alias for $2;
		dataFinanciamento alias for $3;
		valorFinanciamento alias for $4;
		prazo alias for $5;
		numRenavam alias for $6;
		valor alias for $7;
		marca alias for $8;
		ano alias for $9;
		qtdPassageiros alias for $10;
	begin
		insert into financiamento values (numFinanciamento, cpfCliente, dataFinanciamento, valorFinanciamento, prazo);
		insert into passeio values (numRenavam, numFinanciamento, valor, marca, ano, qtdPassageiros);
		RAISE NOTICE 'Financiamento do veículo de PASSEIO realizado com sucesso!';
	RETURN true;
	end;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE FUNCTION realizaFinanciamento(int, character varying(11), date, real, int, int, real, character varying(20), int, int, num_eixos)
RETURNS bool AS
$BODY$
	declare
		numFinanciamento alias for $1;
		cpfCliente alias for $2;
		dataFinanciamento alias for $3;
		valorFinanciamento alias for $4;
		prazo alias for $5;
		numRenavam alias for $6;
		valor alias for $7;
		marca alias for $8;
		ano alias for $9;
		cargaMaxima alias for $10;
		numEixos alias for $11;
	begin
		insert into financiamento values (numFinanciamento, cpfCliente, dataFinanciamento, valorFinanciamento, prazo);
		insert into carga values (numRenavam, numFinanciamento, valor, marca, ano, cargaMaxima, numEixos);
		RAISE NOTICE 'Financiamento do veículo de CARGA realizado com sucesso!';
	RETURN true;
	end;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

-- D)
SELECT realizaFinanciamento(11, '60345678981', '2020-09-11', 650000.0, 2, 0012345678, 650000.0, 'Toyota', 2019, 4);
SELECT realizaFinanciamento(12, '11987654321', '2020-11-08', 940000.0, 4, 1023456789, 940000.0, 'Honda', 2019, 6400, 'quatro');

-- E)
CREATE TYPE t_endereco AS(
	rua character varying(80),
	numero smallint,
	bairro character varying(30),
	cidade character varying(50),
	cep character varying(8)
);

CREATE TYPE t_cliente AS(
	cpf character varying(11),
	endereco t_endereco,
	nome character varying(50),
	telefone text[3]
);

CREATE TABLE financiamento 
(
	numero int NOT NULL,
	cliente t_cliente NOT NULL,
	data date NOT NULL,
	valor real NOT NULL,
	prazo int NOT NULL,
	PRIMARY KEY (numero)
);

CREATE TABLE veiculo 
(
	num_renavam int NOT NULL,
	num_financ int NOT NULL,
	valor real NOT NULL,
	marca character varying(20) NOT NULL,
	ano smallint NOT NULL,
	PRIMARY KEY (num_renavam),
	FOREIGN KEY (num_financ) REFERENCES financiamento(numero) 
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE passeio 
(
	qtd_passageiros smallint NOT NULL
)INHERITS(veiculo);

CREATE TYPE num_eixos AS ENUM ('um','dois','tres','quatro','cinco','seis','sete','oito','nove');

CREATE TABLE carga 
(
	carga_maxima int NOT NULL,
	numero_eixos num_eixos
)INHERITS(veiculo);
