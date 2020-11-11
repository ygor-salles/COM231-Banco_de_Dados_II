--Função para financimento de veículo de passeio
CREATE OR REPLACE FUNCTION realizaFinanciamento(int, numeric, varchar(20), smallint, int, smallint)
RETURNS BOOL AS
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
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;


--Função para financimento de veículo de carga
CREATE OR REPLACE FUNCTION realizaFinanciamento(int, numeric, varchar(20), smallint, int, int, eixo)
RETURNS BOOL AS
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
		INSERT INTO passeio VALUES (num_renavam, valor, marca, ano, num_financiamento, carga_maxima, numero_eixos);
		RAISE NOTICE 'Financiamento para veículo de carga realizado';
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;