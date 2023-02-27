create database Clinica;

use Clinica;

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

insert into Pacientes (nome, idade, cidade, cpf, doenca, codp)
values ('Ana', 20, 'Florianopoles', 20000200000, 'gripe', 1);

insert into Pacientes (nome, idade, cidade, cpf, doenca, codp)
values ('Paulo', 24, 'Palhoca', 20000220000, 'fratura', 2),
('Lucia', 30, 'Biguacu', 22000200000, 'tendinite', 3),
('Carlos', 28, 'Joinville', 11000110000, 'sarampo', 4);

insert into Consultas (codm, codp, data, hora) values ;


alter table Pacientes add codp int primary key not null;

select * from Pacientes;