create database Aula1;
use Aula1;

create table notarfiscal (
idNF int(2) primary key not null,
idItem int(2), 
codProd int(10),
valorUnit double (4,2),
qtde int(10),
desconto int(4) 
);

insert into notarfiscal (idNF, idItem, codProd, valorUnit, qtde, desconto) values
(1,1,1,25,10,5);

insert into notarfiscal (idNF, idItem, codProd, valorUnit, qtde, desconto) values
(24,2,2,13.50,3,0),
(2,3,3,15,2,0),
(3,4,4,10,1,0),
(4,5,5,30,1,0),
(5,1,3,15,4,0),
(6,2,4,10,5,0),
(7,3,5,30,7,0),
(8,1,1,25,5,0),
(9,2,4,10,4,0),
(10,3,5,30,5,0),
(11,4,2,13.50,7,0),
(12,1,5,30,10,15),
(13,2,4,10,12,5),
(14,3,1,25,13,5),
(15,4,2,13.50,15,5),
(16,1,3,15,3,0),
(17,2,5,30,6,0),
(18,1,1,25,22,15),
(19,2,3,15,25,20),
(20,1,1,25,10,3),
(21,2,2,13.50,10,4),
(22,3,3,15,10,4),
(23,4,5,30,10,1);

select * from notarfiscal;

/*B*/
select idNf, idItem, codProd, valorUnit from notarfiscal;

/*C*/
select idNf, idItem, codProd, valorUnit, (valorUnit - (valorUnit * (desconto / 100))) as valorVendido from notarfiscal;

/*D*/
set sql_safe_updates=0; /*desabilitar segurança do sql para poder alterar as tabelas*/ 
update notarfiscal set desconto = null where desconto = 0;
update notarfiscal set desconto = 0 where desconto = null; 

/*E*/
select idNf, idItem, codProd, valorUnit, (qtde * valorUnit) as valorTotal, desconto, (valorUnit - (valorUnit * (desconto / 100))) as valorVendido from notarfiscal;

/*F*/ 
select

/*G*/


/*H*/


/*I*/


/*J*/


/*K*/


/*L*/


/*M*/