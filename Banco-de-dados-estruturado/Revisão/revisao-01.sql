create database bancoFiscal;
use bancoFiscal;

create table notaFiscal(
	id_nf int not null,
    id_item int not null,
    cod_prod int not null,
    valor_unit float(10,2),
    quantidade int,
    desconto float(10,2) null
);

insert into notaFiscal(id_nf, id_item, cod_prod, valor_unit, 
quantidade, desconto) values
(1,1,1,25.00,10,5),
(1,2,2,13.50,3, null),
(1,3,3,15.00,3, null),
(1,4,4,10.00,2, null),
(1,5,5,30.00,1, null),
(2,1,3,15.00,4, null),
(2,2,4,10.00,5, null),
(2,3,5,30.00,7, null),
(3,1,1,25.00,5, null),
(3,2,4,10.00,4, null),
(3,3,5,30.00,5, null),
(3,4,2,13.50,7, null),
(4,1,5,30.00,10,15),
(4,2,4,10.00,12,5),
(4,3,1,25.00,13,5),
(4,4,2,13.50,15,5),
(5,1,3,15.00,3, null),
(5,2,5,30.00,6, null),
(6,1,1,25.00,22,15),
(6,2,3,15.00,25,20),
(7,1,1,25.00,10,3),
(7,2,2,13.50,10,4),
(7,3,3,15.00,10,4),
(7,4,5,30.00,10,1);

/*Exercício B*/
select id_nf, id_item, cod_prod, valor_unit from notaFiscal
where desconto is null;

/*Exercício C*/
select id_nf, id_item, cod_prod, valor_unit, 
(valor_unit - (valor_unit*(desconto/100))) as Valor_Vendido 
from notaFiscal where desconto is not null;

/*Exercício D*/
set sql_safe_updates = 0;
update notaFiscal set desconto = 0 where desconto is null;

/*Exercício E*/
select id_nf, id_item, cod_prod, valor_unit,
desconto, (valor_unit - (valor_unit*(desconto/100))) as 
Valor_Vendido, (quantidade * valor_unit) as Valor_Total
from notaFiscal where (quantidade * valor_unit) > 0;

/*Exercício F*/
select id_nf, (quantidade*valor_unit) as Valor_Total from notaFiscal
group by id_nf order by Valor_Total desc;

/*Exercício G*/
select id_nf, (valor_unit - (valor_unit*(desconto/100))) as Valor_Vendido from notaFiscal
group by id_nf order by Valor_Vendido desc;

/*Exercício H*/
select cod_prod, sum(quantidade) as Quantidade from notaFiscal
group by cod_prod order by Quantidade desc limit 1;

/*Exercício I*/
select id_nf, cod_prod, quantidade from notaFiscal
group by id_nf, cod_prod having quantidade > 10;

/*Exercício J*/
select id_nf, sum(quantidade * valor_unit) as Valor_Total from notaFiscal
group by id_nf having Valor_Total > 500 order by Valor_Total desc;

/*Exercício K*/
select cod_prod, avg(desconto) as Media from notaFiscal
group by cod_prod;

/*Exercício L*/
select cod_prod, min(desconto) as Menor, max(desconto) as Maior, avg(desconto) as Valor_Medio
from notaFiscal
group by cod_prod;

/*Exercício M*/
select id_nf, count(id_item) as Qtd_Itens from notaFiscal
group by id_nf having Qtd_Itens > 3;