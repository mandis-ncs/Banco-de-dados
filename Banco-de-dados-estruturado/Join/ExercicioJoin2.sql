create database ExJoin;
use ExJoin;
  
create table Assinante(
cdAss int(30) primary key not null,
nAss int(30)
);

alter table Assinante add nome varchar(30);
select * from Assinante;

create table RamoAtiv(
cdRamo int(30) primary key not null,
dsRamo varchar(100),
cdAss int(30) not null,
foreign key (cdAss) references Assinante (cdAss) 
);


create table TipoAtiv(
cdAtiv int(30) primary key not null,
dsAtiv varchar(100),
cdAss int(30) not null,
foreign key (cdAss) references Assinante (cdAss) 
);

create table Endereco(
cdEnd int(30) primary key not null,
dsEnd varchar(100),
complemento varchar(30),
bairro varchar(30),
cep int(20),
cdAss int(30),
foreign key (cdAss) references Assinante (cdAss) 
);

create table Tel(
cdTel int(30) primary key not null,
ddd int(2),
nTel int(9),
cdEnd int(30),
foreign key (cdEnd) references Endereco (cdEnd) 
);

create table Municipio(
cdMuni int(30) primary key not null,
dsMun varchar(100),
cdEnd int(30),
foreign key (cdEnd) references Endereco (cdEnd) 
);

/*ADICIONANDO DADOS*/

insert into Assinante (cdAss, nAss, nome) values
(1,'10','Joao'),
(2,'20','Maria'),
(3,'30','Ana');

insert into RamoAtiv (cdRamo, dsRamo, cdAss) values
(11,'Secretario',2),
(12,'Auxiliar',3),
(13,'Administrativo',1);

insert into TipoAtiv (cdAtiv, dsAtiv, cdAss) values
(20,'premium',2),
(21,'prata',3),
(22,'premium',1);

insert into TipoAtiv (cdAtiv, dsAtiv, cdAss) values
(24,'comercial',1);

insert into Endereco (cdEnd, dsEnd, complemento, bairro, cep, cdAss) values
(30,'rua','casa','Paulista',11990000,1),
(31,'alameda','Paulista','Rio',11900000,2),
(32,'avenida','sobrado','cajati',11930000,3);

insert into Tel(cdTel,ddd,nTel,cdEnd) values
(40,11,912345678,30),
(41,12,87654321,31),
(42,13,12348765,32);

insert into Tel(cdTel,ddd,nTel,cdEnd) values
(48,13,45348768,32);

insert into Municipio(cdMuni,dsMun,cdEnd) values
(50,'Pelotas',30),
(51,'Natal',31),
(52,'Joao Camara',32);

/*CONSULTANDO*/

select * from Assinante;
/*1 Listar os nomes dos assinantes, seguido dos dados do endereço e os telefones correspondentes.
*/
/*SELECIONAR O NOME, TODOS DADOS DO ENDEREÇO E SÓ O NÚMERO DO TELEFONE - SELECIONAR TODOS OS DADOS DO LADO DIREITO ENDERECO QUE
TENHAM EM COMUM (ON) O cdAss, AI SELECIONAR O QUE TIVER DE COMUM INNER COM OS ATRIBS DO TELEFONE QUANDO EM COMUM O cdTel*/
select Assinante.nome, Endereco.*, Tel.ddd, Tel.nTel from Endereco right join Assinante on Endereco.cdAss = Assinante.cdAss 
inner join Tel on Endereco.cdEnd = Tel.cdEnd;


/*2 Listar os nomes dos assinantes, seguido do seu ramo, ordenados por ramo e posteriormente por nome.
*/
/*PARA MOSTRAR O RAMO DEPOIS O NOME É SÓ SELECT OS ATRIBUTOS DO RAMO PRIMEIRO*/
select RamoAtiv.*, Assinante.nome from RamoAtiv right join Assinante on Assinante.cdAss = RamoAtiv.cdAss order by RamoAtiv.dsRamo;


/*3 Listar os assinantes do municipio de Pelotas que são do tipo residencial.
*/
select Assinante.nome, Municipio.dsMun from Assinante inner join Endereco on Assinante.cdAss = Endereco.cdAss inner join Municipio
on Municipio.cdEnd = Endereco.cdEnd where Municipio.dsMun in ('Pelotas', 'Joao Camara');


/*4 Listar os nomes dos assinantes que possuem mais de um telefone.
*/
select Assinante.nome, Tel.nTel, count(Tel.nTel) from Assinante inner join Endereco on Assinante.cdAss = Endereco.cdAss inner join Tel on 
Endereco.cdEnd = Tel.cdEnd group by Assinante.nome having count(Tel.cdEnd)>1;


/*5 Listar os nomes dos assinantes seguido do número do telefone, tipo de assinante comercial, com endereço em Natal ou João Câmara.
*/
select Assinante.nome, Tel.ddd, Tel.nTel, TipoAtiv.dsAtiv, Municipio.dsMun from 
Assinante inner join Endereco on Assinante.cdAss = Endereco.cdAss 
inner join Tel on Endereco.cdENd = Tel.cdEnd
inner join TipoAtiv on Assinante.cdAss = TipoAtiv.cdAss
inner join Municipio on Endereco.cdEnd = Municipio.cdEnd where Municipio.dsMun in ('Natal', 'Joao Camara')
group by Assinante.nome; /*group by organiza por grupo, no caso por nome, evitando que a Ana apareça duplicada pois tem 2 telefones*/
