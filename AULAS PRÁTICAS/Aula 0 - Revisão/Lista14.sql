CREATE TABLE plano (
  id integer NOT NULL,
  nome varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO plano VALUES (1,'Unimed'),(2,'Bradesco'),(3,'Saude');

CREATE TABLE paciente (
  id integer NOT NULL DEFAULT 0,
  nome varchar(100) DEFAULT NULL,
  rua varchar(100) DEFAULT NULL,
  numero varchar(50) DEFAULT NULL,
  complemento varchar(50) DEFAULT NULL,
  bairro varchar(50) DEFAULT NULL,
  cidade varchar(50) DEFAULT NULL,
  estado varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
); 

INSERT INTO paciente VALUES (1,'Luana','Rua A','111','A','Centro','Itajuba','MG'),(2,'Paula','Rua B','111','A','Porto','Itajuba','MG'),(3,'Melina','Rua A','111','A','Centro','Itajuba','MG'),(4,'Simone','Rua B','111','A','Porto','Itajuba','MG'),(5,'Saulo','Rua C','111','A','Barra','Itajuba','MG'),(6,'Felipe','Rua A','111','A','Centro','Itajuba','MG');


CREATE TABLE medico (
  id integer NOT NULL DEFAULT 0,
  nome varchar(100) DEFAULT NULL,
  especialidade varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO medico VALUES (1,'Jose Geraldo','Dermatologista'),(2,'Lucia Maria','Oftalmologista'),(3,'Joana Fonseca','Geriatra');

CREATE TABLE consulta (
  idMedico integer NOT NULL DEFAULT 0,
  idPaciente integer NOT NULL DEFAULT 0,
  idPlano integer DEFAULT NULL,
  data date NOT NULL,
  PRIMARY KEY (idMedico,idPaciente,data),
  CONSTRAINT consulta_ibfk_1 FOREIGN KEY (idMedico) REFERENCES medico (id),
  CONSTRAINT consulta_ibfk_2 FOREIGN KEY (idPaciente) REFERENCES paciente (id),
  CONSTRAINT consulta_ibfk_3 FOREIGN KEY (idPlano) REFERENCES plano (id)
);

INSERT INTO consulta VALUES (1,1,1,'2011-09-19'),(3,6,1,'2011-08-04'),(1,2,2,'2011-10-11'),(1,3,2,'2011-05-24'),(1,5,2,'2011-07-28'),(1,6,2,'2010-05-28'),(2,6,2,'2011-02-18'),(1,4,3,'2011-02-24');

/* 01 */
SELECT m.nome, p.nome, pl.nome, c.data
FROM consulta c inner join medico m on c.idMedico = m.id 
inner join paciente p on c.idPaciente = p.id inner join plano pl on c.idPlano = pl.id
WHERE c.data BETWEEN '2009-01-01' and '2011-05-01'

/* 02 */
SELECT m.nome as medico, p.nome as paciente
FROM medico m left join consulta c on m.id = c.idmedico left join paciente p on c.idpaciente = p.id
ORDER BY M.nome asc

/* 03 */
SELECT p.nome
FROM paciente p
WHERE p.nome in (SELECT m.nome
				FROM medico m)

/* 04 */
SELECT pl.nome as Plano, COUNT (distinct p.nome) as Quantidade
FROM consulta c INNER JOIN plano pl ON c.idPlano = pl.id INNER JOIN paciente p on c.idPaciente = p.id
GROUP BY (pl.nome)


/* 05 */	
SELECT  pl.nome as Plano, COUNT(distinct p.nome) as Quantidade
FROM consulta c INNER JOIN plano pl ON c.idPlano = pl.id INNER JOIN paciente p on c.idPaciente = p.id
GROUP BY (pl.nome)
HAVING COUNT(distinct p.nome) > 5

/* 06 */
SELECT distinct pl.nome, p.nome
FROM paciente p LEFT JOIN consulta c on p.id = c.idPaciente LEFT JOIN plano pl on c.idPlano = pl.id
ORDER BY pl.nome asc


/* 07 */
SELECT p.nome as Paciente, COUNT(p.nome) as Consultas
FROM consulta c JOIN paciente p ON c.idPaciente = p.id
GROUP BY p.nome
			
/* 08 */
SELECT m.nome as Medico, COUNT(m.nome) as Consultas
FROM consulta c JOIN medico m ON c.idMedico = m.id
GROUP BY m.nome

/* 09 */
SELECT p.nome as Paciente, COUNT(p.nome) as Consultas
FROM consulta c JOIN paciente p ON c.idPaciente = p.id
GROUP BY p.nome
HAVING COUNT(p.nome) > 10

/* 10 */
SELECT c.data
FROM consulta c
ORDER BY (c.data) asc LIMIT 1

/* 11 */
SELECT c.data
FROM consulta c
ORDER BY(c.data) desc LIMIT 1

/* 12 */
SELECT p.nome as Paciente, m.nome as Medico, pl.nome as Plano, c.data
FROM consulta c JOIN paciente p ON c.idPaciente=p.id JOIN medico m ON c.idMedico = m.id
JOIN plano pl on c.idPlano = pl.id
WHERE c.data in (SELECT c.data
				 FROM consulta c
				 ORDER BY(c.data) desc LIMIT 1)
				
/* 13 */
SELECT m.nome as Medico
FROM consulta c JOIN medico m on c.idMedico = m.id
WHERE c.data in (SELECT c.data
				 FROM consulta c
				 ORDER BY (c.data) desc LIMIT 1)
				 
/* 14 */	  
SELECT m.id
FROM medico m
WHERE NOT EXISTS ((SELECT id FROM paciente)
EXCEPT (SELECT idpaciente FROM consulta c WHERE c.idMedico=m.id))	  

/* 15 */
SELECT p.id
FROM paciente p
WHERE NOT EXISTS ((SELECT id FROM medico)
EXCEPT (SELECT idmedico FROM consulta c WHERE c.idPaciente=p.id))

/* 16*/	
SELECT p.nome
FROM paciente p
WHERE NOT EXISTS ((SELECT id FROM medico)
EXCEPT (SELECT idmedico FROM consulta c WHERE c.idPaciente=p.id))
		
		
		