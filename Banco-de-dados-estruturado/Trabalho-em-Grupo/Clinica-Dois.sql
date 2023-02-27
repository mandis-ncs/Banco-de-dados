create database ClinicaDois;

use ClinicaDois;

create table Pacientes (
nome varchar (40) not null,
idade smallint not null,
cidade char (30), 
cpf numeric (11) not null,
doenca varchar (40) not null,
codp int primary key not null
);

create table Consultas (
codm int not null,
foreign key (codm) references Medicos (codm),
codp int,
foreign key (codp) references Pacientes (codp),
data date not null,
hora time not null
);

create table Medicos (
codm int primary key not null,
nome varchar (40) not null,
idade smallint not null,
especialidade char (20),
cpf numeric (11) not null,
cidade varchar (30),
nroa int
);

create table Funcionarios (
codf int primary key not null,
nome varchar (40) not null,
idade smallint,
cpf numeric (11) not null,
cidade varchar (30),
salario numeric (10), 
cargo varchar (20)
);

create table Ambulatorios (
nroa int primary key not null,
andar numeric (3) not null,
capacidade smallint
);

select * from Ambulatorios;
select * from Funcionarios;
select * from Medicos;
select * from Pacientes;
select * from Consultas;

insert into Consultas (codm, codp, data, hora)
values (1,1,'2006/06/12', '14:00'),
(1,4,'2006/06/13', '10:00'),
(2,1,'2006/06/13', '9:00'),
(2,2,'2006/06/13', '11:00'),
(2,3,'2006/06/14', '14:00'),
(2,4,'2006/06/14', '17:00'),
(3,1,'2006/06/19', '18:00'),
(3,3,'2006/06/12', '10:00'),
(3,4,'2006/06/19', '13:00'),
(4,4,'2006/06/20', '13:00'),
(4,4,'2006/06/22', '19:30');

insert into Funcionarios (codf, nome, idade, cidade, salario, cpf)
values (1, 'Rita', 32, 'Sao Jose', 1200, 20000100000),
(2, 'Maria', 55, 'Palhoca', 1220, 30000110000),
(3, 'Caio', 44, 'Florianopolis', 1100, 41000100000),
(4, 'Carlos', 44, 'Florianopolis', 1200, 51000110000),
(5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);

insert into Medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
values (1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1),
(2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
(3, 'Pedro', 51, 'pediatria', 11000100000, 'São José', 2),
(4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', null),
(5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);

insert into Ambulatorios (nroa, andar, capacidade)
values (1,1,30),
(2,1,50),
(3,2,40),
(4,2,25),
(5,2,55);

insert into Pacientes (nome, idade, cidade, cpf, doenca, codp)
values ('Ana', 20, 'Florianopoles', 20000200000, 'gripe', 1),
('Paulo', 24, 'Palhoca', 20000220000, 'fratura', 2),
('Lucia', 30, 'Biguacu', 22000200000, 'tendinite', 3),
('Carlos', 28, 'Joinville', 11000110000, 'sarampo', 4);

/*UPDATE Ambulatorios SET capacidade = 12, andar = 3 WHERE nroa = 2;*/

alter table Funcionarios add nroa int; /*aed attrib nroa tipo int na table Funcionarios*/

/*CREATE UNIQUE INDEX nome_índice ON nome_tabela (nome_atributo1)
CREATE UNIQUE INDEX indPac_CPF ON Pacientes (CPF)*/

create unique index IndMedicos on Medicos (cpf); /*NÃO APARECE O ÍNDICE NA TABELA*/

create unique index IndPac on Pacientes (doenca);

drop index IndPac on Pacientes;

set sql_safe_updates=0;

alter table Funcionarios drop column cargo;
alter table Funcionarios drop column nroa;

update Pacientes set cidade = 'Ilhota' where nome = 'Paulo';

update Consultas set data = '2006/07/04', hora = '12:00' where codm = 1 and codp = 4;

update Pacientes set doenca = 'cancer' where nome = 'Ana';

/*9 - 1*/
select nome, cpf, especialidade from Medicos where idade < 40 and especialidade <> 'traumatologia';

select * from Consultas where data > '2006/06/19' and hora >= '12:00';

select nome, idade from Pacientes where cidade <> 'Florianopolis';

select hora, data from Consultas where data between '2006/06/14' and '2006/06/20';

select hora from Consultas where data < '2006/06/14' and data > '2006/06/20'; 

select distinct cidade from Funcionarios;

 select min(salario) as Maximo, max(salario) as Minimo from Funcionarios where cidade = 'Florianopolis';
 
 /**/
 
 select codf, nome, salario = salario - (salario*0.2) as salarioLiq from Funcionarios;
 
 select nome from funcionarios where nome like '%a'; /*nomes q terminam com A*/
 select nome from funcionarios where nome like 'p%'; /*nomes q iniciam com P*/
 
 /*
 select max(hora) from Consultas where data ='2006/06/13';
 
 select avg(idade), count(nroa) from Medicos;
 
 select codf, nome, salario = salario - (salario*0.2) as salarioLiq from Funcionarios;
 
 select nome from Funcionarios where nome like '%a';
 
 select nome, cpf from Funcionarios where cpf not like '%00000%';
 
 select nome, especialidade from Medicos where nome like '_o%o';
 
 select codp, nome from Pacientes where idade > 25 and doenca in ('tendinite','fratura','gripe','sarampo');
*/