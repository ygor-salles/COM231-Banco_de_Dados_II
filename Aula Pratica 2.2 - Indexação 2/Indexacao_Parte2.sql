--1) A
Explain analyze select * from cep.log_logradouro;

--1) B
select * from pg_indexes where tablename = 'log_logradouro';

--1) C
Explain Analyze select * from cep.log_logradouro where log_nu_sequencial < 10;

--1) D
Explain Analyze select * from cep.log_logradouro where log_nu_sequencial > 10;

--1) E
Explain Analyze select * from cep.log_logradouro where log_nu_sequencial = 15;

--1) F
Explain Analyze delete from cep.log_logradouro where log_nu_sequencial = 15;


--2) A
Explain Analyze select * from cep.log_logradouro where ufe_sg='AC' and log_tipo_logradouro='Avenida';

--2) B
Create index logradouro_ufe_sg on cep.log_logradouro using btree (ufe_sg);

--2) C
Explain Analyze select * from cep.log_logradouro where ufe_sg='AC' and log_tipo_logradouro='Avenida';

--2) D
Create index logradouro_log_tipo_logradouro on cep.log_logradouro using btree (log_tipo_logradouro);


--3) A
Drop index cep.logradouro_ufe_sg;
Drop index cep.logradouro_log_tipo_logradouro;

--3) B
Create index logradouro_ufe_tipo on cep.log_logradouro  using btree (ufe_sg, log_tipo_logradouro);

--3) C
Explain Analyze  

--3) D

--3) E
Explain Analyze select * from cep.log_logradouro where ufe_sg = 'MG';

--3) F
Explain Analyze select * from cep.log_logradouro where log_tipo_logradouro = 'Avenida';

--3) G
Explain Analyze select * from cep.log_logradouro where 'AC' or log_tipo_logradouro = 'Avenida';

--4) A
Explain Analyze select * from cep.log_logradouro where ufe_sg = 'AC' and log_tipo_logradouro = 'Avenida' limit 20;

--4) B
Explain Analyze select * from cep.log_logradouro where ufe_sg = 'AC' and log_tipo_logradouro = 'Avenida' order by cep;

--4) C
Explain Analyze select * from cep.log_logradouro where ufe_sg = 'AC' and log_tipo_logradouro = 'Avenida' group by bai_nu_sequencial_ini;

--4) D
EXPLAIN ANALYZE
	SELECT * FROM cep.log_bairro WHERE bai_nu_sequencial_ini IN
	(SELECT bai_nu_sequencial_ini
		FROM cep.log_faixa_bairro
		WHERE fcb_rad_ini = '69918')

--5) A
SELECT pg_size_pretty(pg_relation_size('cep.logradouro_ufe_tipo'));

--5) B
SELECT pg_size_pretty(pg_relation_size('cep.log_logradouro'));

--5) C
SELECT pg_size_pretty(pg_total_relation_size('cep.log_logradouro'));