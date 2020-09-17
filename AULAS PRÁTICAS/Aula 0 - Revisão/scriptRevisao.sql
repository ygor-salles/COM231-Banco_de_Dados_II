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