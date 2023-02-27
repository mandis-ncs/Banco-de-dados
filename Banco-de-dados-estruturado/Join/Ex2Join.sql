create database Estacionamento;
use Estacionamento;

create table Cliente(
cpf int(15) primary key not null,
nome varchar(50),
dtNasc date
);

create table Modelo(
cdMod int(5) primary key not null,
Descr varchar(100)
);

create table Veiculo(
placa varchar(10) primary key not null,
cdMod int(5),
cpf int(15),
cor varchar(10),
foreign key(cdMod) references Modelo(cdMod),
foreign key(cpf) references Cliente(cpf)
);

create table Patio(
num int(20) primary key not null,
ender varchar(50),
capac int(4)
);

create table Estaciona(
cod int(20),
num int(20),
placa varchar(10),
dtEnt date,
datSai date,
hrEnt time,
hrSai time,
foreign key(num) references Patio(num),
foreign key(placa) references Veiculo(placa)
);

select * from estaciona;

insert into Cliente(cpf, nome, dtNasc) values
(123456789, 'Maria Ada', '2000/08/19'),
(987654321, 'Paulo Joao', '1988/05/18'),
(123498765, 'Lauro Luiz', '2001/08/11');

insert into Modelo (cdMod, Descr) values
(111, 'Ferrari'),
(222, 'Porsha'),
(333, 'Audi');

insert Veiculo(placa, cdMod, cpf, cor) values
('abc123', 111, 123456789, 'azul'),
('dfg456', 222, 987654321, 'rosa'),
('hij789', 333, 123498765, 'verde');

insert into Patio(num, ender, capac) values
(1212, 'Rua Paula - Sp', 200),
(1313, 'Av Lata - Rj', 50),
(1414, 'Av Pata - Sa', 120);

insert into Estaciona(cod, num, placa, dtEnt, datSai, hrEnt, hrSai) values
(1111111111, 1212, 'abc123', '2022/08/18', '2022/08/18', '14:00', '15:30'),
(22222222222, 1313, 'dfg456', '2022/10/28', '2022/10/28', '17:00', '19:30'),
(3333333333, 1414, 'hij789', '2022/03/15', '2022/03/15', '09:00', '17:30');

/*SELECIONANDO*/

/*Exiba a placa e o nome dos donos de todos os veículos.*/
select Cliente.nome, Modelo.Descr from Cliente inner join Veiculo on Cliente.cpf = Veiculo.cpf inner join
Modelo on Veiculo.cdMod = Modelo.cdMod;

/*Exiba o CPF e o nome do cliente que possui o veículo de placa “abc123”.*/
select Cliente.nome, Cliente.cpf from Cliente inner join Veiculo on Cliente.cpf = Veiculo.cpf where 
Veiculo.placa = 'abc123';

/*Exiba a placa e a cor do veículo que possui o código de estacionamento 1111111111.*/
select Veiculo.placa, Veiculo.cor from Veiculo inner join Estaciona on Veiculo.placa = Estaciona.placa
where Estaciona.cod = 1111111111;

/*Exiba a placa e o ano do veículo que possui o código de estacionamento 1111111111.*/
select Veiculo.placa from Veiculo inner join Estaciona on Veiculo.placa = Estaciona.placa
where Estaciona.cod = 1111111111;

/*Exiba a placa, o ano do veículo e a descrição de seu modelo, se ele possuir ano a partir de 2000.*/
select Veiculo.placa, Modelo.Descr from Veiculo inner join Modelo on Modelo.cdMod = Veiculo.cdMod;

/*Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “dfg456”.*/
select Patio.ender, Estaciona.dtEnt, Estaciona.datSai from Estaciona inner join Patio on Patio.num = Estaciona.num where Estaciona.placa = 'dfg456';

/*Exiba a quantidade de vezes que os veículos de cor verde estacionaram.*/
select Estaciona.placa, count(Estaciona.placa) as Vezes, Veiculo.cor from Estaciona inner join Veiculo on Estaciona.placa = Veiculo.placa where Veiculo.cor = 'verde';

/*Liste todos os clientes que possuem carro de modelo 111.*/
select Cliente.nome, Modelo.cdMod from Cliente inner join Veiculo on Cliente.cpf = Veiculo.cpf inner join
Modelo on Veiculo.cdMod = Modelo.cdMod where Modelo.cdMod=111;

/*Liste as placas, os horários de entrada e saída dos veículos de cor verde.*/
select Estaciona.placa, Estaciona.dtEnt, Estaciona.datSai, Veiculo.cor from Estaciona inner join Veiculo on Estaciona.placa = Veiculo.placa where Veiculo.cor = 'verde';

/*Liste todos os estacionamentos do veículo de placa “hij789”*/
select Estaciona.*, Veiculo.* from Estaciona inner join Veiculo on Estaciona.placa = Veiculo.placa where Estaciona.placa = 'hij789';

/*Exiba o nome do cliente que possui o veículo cujo código do estacionamento é 1111111111.*/
select Cliente.nome, Veiculo.placa, Estaciona.cod from Cliente inner join Veiculo on Cliente.cpf = Veiculo.cpf inner join Estaciona on Veiculo.placa = Estaciona.placa where Estaciona.cod = 1111111111;

/*Exiba o CPF do cliente que possui o veículo cujo código do estacionamento é 2147483647.*/
select Cliente.cpf, Estaciona.cod, Veiculo.placa from Cliente right join Veiculo on Cliente.cpf = Veiculo.cpf inner join Estaciona on Veiculo.placa = Estaciona.placa where Estaciona.cod = 2147483647;

/*Exiba a descrição do modelo do veículo cujo código do estacionamento é 1111111111.*/
select Veiculo.placa, Modelo.Descr, Estaciona.cod from Veiculo inner join Modelo on Modelo.cdMod = Veiculo.cdMod inner join Estaciona on Veiculo.placa = Estaciona.placa where Estaciona.cod = 1111111111;

/*Exiba a placa, o nome dos donos e a descrição dos os modelos de todos os veículos.*/
select Veiculo.placa, Cliente.nome, Modelo.Descr from Cliente inner join Veiculo on Cliente.cpf = Veiculo.cpf inner join Modelo on Modelo.cdMod = Veiculo.cdMod;


