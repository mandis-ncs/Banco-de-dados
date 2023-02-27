create database campeonato;
use campeonato;

create table cidade(
codCidade varchar(20) primary key not null,
nome varchar(50),
uf char(20),
pais varchar(20)
);

insert into cidade (codCidade, nome, uf, pais) values
('011', 'Cajati', 'SP', 'Brazil'),
('012', 'Registro', 'SP', 'Brazil'),
('013', 'Pariquera', 'SP', 'Brazil'),
('014', 'Curitiba', 'SP', 'Brazil');

insert into cidade (codCidade, nome, uf, pais) values
('015', 'Maringá', 'SP', 'Brazil');

create table atleta(
codAtleta varchar(20) primary key not null,
nome varchar(50),
dtNascimento date,
codCidade varchar(20),
foreign key (codCidade) references cidade(codCidade)
);

select * from atleta;

insert into atleta (codAtleta, nome, dtNascimento, codCidade) values
('110','Pedro','2000-05-12','011'),
('120','Paulo','1998-06-15','012'),
('130','Ana','1989-06-16','013'),
('140','Daila','1999-06-16','014'),
('150','Lola','1999-06-16','014');

insert into atleta (codAtleta, nome, dtNascimento, codCidade) values
('160','Joao','1999-06-16','014'),
('170','Maria','1999-06-16','014');

alter table atleta drop column codCidade;
alter table atleta add column codCidade varchar(20);

/*ALTER TABLE table_name
ADD FOREIGN KEY (column_name)
REFERENCE table_name(Referencing column_name in table_name); */

alter table atleta add foreign key (codCidade) references cidade(codCidade);

create table multa(
codMulta varchar(20) primary key not null,
nome varchar(50),
valorMulta double(10,2),
grauGravidade varchar(20)
);

insert into multa (codMulta, nome, valorMulta, grauGravidade) values
('122','Infração',120.56,'nivel 3'),
('123','Drogas',100.46,'nivel 1'),
('124','Roubo',1200.80,'nivel 2');

create table competicao(
codCompeticao varchar(20) primary key not null,
nome varchar(50),
dtInicio date,
dtTermino date,
codCidade varchar(20),
foreign key (codCidade) references cidade(codCidade)
);

insert into competicao (codCompeticao, nome, dtInicio, dtTermino, codCidade) values
('158','Competicao nivel 1','2022-05-12','2022-05-13','011'),
('157','Competicao nivel 2','2022-06-15','2022-06-17','012'),
('156','Competicao nivel 3','2022-07-20','2022-07-22','013');

create table participacao(
codCompeticao varchar(20), 
foreign key (codCompeticao) references competicao(codCompeticao),
codAtleta varchar(20),
foreign key (codAtleta) references atleta(codAtleta)
);

insert into participacao (codCompeticao, codAtleta) values
('158', '110'),
('157', '120'),
('156', '130');

insert into participacao (codCompeticao, codAtleta) values
('158', '120');

create table penalidade(
codPenalidade varchar(20) primary key not null,
codCompeticao varchar(20),
codAtleta varchar(20),
codMulta varchar(20),
dtPenalidade date,
foreign key (codCompeticao) references competicao(codCompeticao),
foreign key (codAtleta) references atleta(codAtleta),
foreign key (codMulta) references multa(codMulta)
);

insert into penalidade (codPenalidade, codCompeticao, codAtleta, codMulta, dtPenalidade) values
('222', '158', '110', '122', '2022-05-13'),
('333', '157', '120', '123', '2022-06-17'),
('444', '156', '130', '124', '2022-07-22'),
('442', '156', '130', '124', '2022-07-22'),
('334', '157', '120', '123', '2022-06-17');

insert into penalidade (codPenalidade, codCompeticao, codAtleta, codMulta, dtPenalidade) values
('336', '156', '120', '123', '2022-06-17');

select * from penalidade;

/*1.Mostre o nome de todos os atletas que moram em Curitiba;*/
select nome from atleta where codCidade = '014';

/*2.Mostre a relação de todos os atletas que sofreram penalidades*/
select * from atleta right join penalidade on atleta.codAtleta = penalidade.codAtleta;

/*3.Mostre apenas a relação de todos os atletas que sofreram Penalidades;*/
select * from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta;

/*4.Mostre  apenas  a  relação  dos  nomes  de  todos  os  atletas  que  sofreram Penalidades;*/
select distinct atleta.nome from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta;

/*5-Mostre o número dos atletas que receberam mais de duas Penalidades;*/
select atleta.nome from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta group by penalidade.codAtleta having count(penalidade.codAtleta) > 1;

/*6.Mostre a relação das cidades de onde provêm os atletas.*/
select atleta.nome, cidade.nome from atleta inner join cidade on atleta.codCidade = cidade.codCidade;

/*7.Mostre quantos atletas moram em Maringá.*/
select count(atleta.codAtleta) from atleta where codCidade = '015';

/*8.Mostre o número total de penalidades aplicadas na Competição ocorrida em Janeiro de 2011.*/
select count(codPenalidade) from penalidade where dtPenalidade between '2011-01-01' and '2011-12-31';

/*9.Mostre a penalidade de maior valor;*/
select multa.*, max(valorMulta) from multa; 

/*10.Mostre  os  nomes  distintos  das  cidades  de  onde  provêm  os  atletas. (mostrar apenas uma vez o nome de cadacidade);*/
select distinct cidade.nome from cidade inner join atleta on cidade.codCidade = atleta.codCidade; /*como usar distinct para mostar só uma vez*/

/*11.Mostre  o nome dos  atletas  cujo  valor  total  das  penalidades  aplicadas à ele ultrapassam R$ 1000,00;*/
select atleta.nome, avg(multa.valorMulta) as MediaMulta from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta inner join multa on penalidade.codMulta = multa.codMulta 
group by atleta.nome having avg(multa.valorMulta) > 1000;

/*12.Mostre o nome dos atletas cujo valor médio das penalidades aplicadas é menor que R$ 150,00;*/
select atleta.nome, avg(multa.valorMulta) as MediaMulta from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta inner join multa on penalidade.codMulta = multa.codMulta 
group by atleta.nome having avg(multa.valorMulta) < 150;

/*13.Mostre todas as cidades que tem pelo menos 4 atletas provenientes;*/
select cidade.nome, atleta.codCidade from cidade inner join atleta on cidade.codCidade = atleta.codCidade group by cidade.nome having count(atleta.codCidade) > 3;

/*14.Mostre todos os atletas que participaram de pelo menos 2 competições;*/
select atleta.nome, participacao.codCompeticao from participacao inner join atleta on participacao.codAtleta = atleta.codAtleta 
group by atleta.nome having count(participacao.codAtleta) > 1;

/*15.Mostre a relação de competições e a qualificação dos seus participantes organizados por competição e por atletas;*/


/*16.Mostre a relação de competições e o mais bemqualificado em cada uma delas;*/


/*17.Liste os nomes dos atletas que sofreram mais de duas penalidades;*/
select atleta.nome, count(penalidade.codAtleta) from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta
group by atleta.nome having count(penalidade.codAtleta) > 2;

/*18.Liste  os  códigos  e  nomes  dos  atletas  que  sofreram  mais  de  uma penalidade;*/
select atleta.nome, atleta.codAtleta, count(penalidade.codAtleta) from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta
group by atleta.nome having count(penalidade.codAtleta) > 1;

/*19.Liste  os  códigos  e  nomes  dos  atletas  que  sofreram  mais  de  duas penalidades;*/
select  atleta.codAtleta, atleta.nome, count(penalidade.codAtleta) from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta
group by atleta.nome having count(penalidade.codAtleta) > 2;

/*20.Liste  os  nomes  dos  atletas  que  sofreram  mais  de  uma  penalidades ordenando por nome;*/
select  atleta.nome, count(penalidade.codAtleta) from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta
group by atleta.nome having count(penalidade.codAtleta) > 1 order by atleta.nome;

/*21.Liste os códigos dos atletas que sofreram mais de uma penalidade com valor superior a 300 Reais e ordene o resultado pelo código dos atletas;*/
select atleta.codAtleta from penalidade inner join atleta on penalidade.codAtleta = atleta.codAtleta inner join multa on penalidade.codMulta = multa.codMulta 
group by penalidade.codAtleta having count(penalidade.codAtleta) > 2 and count(multa.valorMulta > 300) > 1 order by penalidade.codAtleta;

/*22.Liste  os  nomes  e  códigos  dos  atletas  que  sofreram  mais  de  uma penalidade  com  valor  superior  a  300  Reais  e  ordene  o  resultado  pelo nome dos atletas;*/
select atleta.codAtleta, atleta.nome from penalidade inner join atleta on penalidade.codAtleta = atleta.codAtleta inner join multa on penalidade.codMulta = multa.codMulta 
group by penalidade.codAtleta having count(penalidade.codAtleta) > 2 and count(multa.valorMulta > 300) > 1 order by penalidade.codAtleta;

/*23.Liste  os  códigos  e  nomes  dos  atletas  que  participaram  de  pelo  menos duas competições;*/
select  atleta.codAtleta, atleta.nome, count(participacao.codCompeticao) as qtde from atleta inner join participacao on atleta.codAtleta = participacao.codAtleta 
group by atleta.nome having count(participacao.codCompeticao) > 1;

/*24.Qual o total de penalidades aplicadas por competição;*/
select competicao.nome, competicao.codCompeticao, count(penalidade.codPenalidade) as total from competicao inner join penalidade on competicao.codCompeticao = penalidade.codCompeticao
group by competicao.codCompeticao;

/*25.Mostre  o  nome  dos  jogadores  que  receberam  alguma  penalidade  (sem repetição).*/
select distinct atleta.nome from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta;

/*26.Mostre o número de atletas que moram em cada cidade*/
select cidade.nome, count(atleta.codAtleta) as qtde from atleta right join cidade on atleta.codCidade = cidade.codCidade;

/*27.Mostre o número de penalidades que cada atleta recebeu*/
select atleta.nome, count(penalidade.codAtleta) as qtde from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta 
group by atleta.nome;

/*28.Mostre o valor total das penalidades recebidas por cada atleta;*/
select atleta.nome, sum(multa.valorMulta) as total from atleta inner join penalidade on atleta.codAtleta = penalidade.codAtleta 
inner join multa on penalidade.codMulta = multa.codMulta
group by atleta.nome;

/*29.Mostre os códigos dos atletas cujo valor total de penalidades recebidas é maior que o valor médio de penalidades aplicadas aos atletas;*/


/**/