create database LojaRoupa;
use LojaRoupa;

create table cliente(
nome varchar(50) not null,
cpf int(11) primary key not null,
rg int(10) unique not null,
telefone int(12),
endereco varchar(80),
Ncadastro varchar(10) unique not null
);

alter table cliente add dataCadastro date;

create table produto(
codProd int(10) not null primary key,
preco double(4, 2) not null check (preco > 2.5),
dataValidade date,
dataFabricacao date,
descricao varchar(100),
desconto double(3, 2) check (preco > desconto)
);

create table funcionario(
nomeFunc varchar(50) not null,
cpfFunc int(11) primary key not null,
rgFunc int(10) unique not null,
telefoneFunc int(12),
enderecoFunc varchar(80),
Ncontrato varchar(10) unique not null
);

create table venda(
dia date,
hora time,
cpfFunc int(11) not null,
codProd int(10) not null,
precoTotal double(5, 2) not null,
cpf int(11) not null,
primary key (cpfFunc, codProd, cpf),
foreign key (cpfFunc) references funcionario (cpfFunc),
foreign key (codProd) references produto (codProd),
foreign key (cpf) references cliente (cpf)
);

insert into produto(codProd, preco, dataValidade, dataFabricacao, descricao, desconto) values
(1012, 200, '2022/09/16', '2020/09/16', 'Vestido', 20),
(1032, 200, '2022/05/13', '2020/05/13', 'Blusa', 13.5),
(1012, 200, '2022/12/26', '2012/12/26', 'Calça', 32),
(1012, 200, '2022/11/23', '2018/11/23', 'Meia', 25.99),
(1012, 200, '2022/04/13', '2019/04/13', 'Shorts', 1.45);


/*cliente, produto, funcionario, venda*/