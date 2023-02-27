create database escola;

use escola;

create table professor(
	nroMatricula int,
    nome varchar(30),
    endereco varchar(60),
    telefone varchar(60)
);

create table aluno(
	codAluno int,
    nome varchar(30),
    dtNasc date,
    endereco varchar(60),
    telefone varchar(11)
);

insert into professor (nroMatricula, nome, endereco, telefone) values 
(1, 'Maria', 'Rua São Judas', '1312345678'),
(2, 'Joao', 'Rua um', '13903746256'),
(3, 'Mario', 'Rua dois', '13253784653'),
(4, 'Ana', 'Rua tres', '13947364903'),
(5, 'Livia', 'Rua quatro', '13947364528'),
(6, 'Caio', 'Rua cinco', '13312345678');

insert into aluno (codAluno, nome, dtNasc, endereco, telefone) values 
(1, 'Maria', '2006/05/01', 'Rua São Judas', '1312345678'),
(2, 'Joao', '2005/06/18', 'Rua Vinte', '13726354894'),
(3, 'Leia', '2004/05/01', 'Rua Quarenta', '13847562537'),
(4, 'Ana', '2026/05/01', 'Rua Silva', '13846273645'),
(5, 'Caio', '2017/05/01', 'Rua Alecrim', '1312345479'),
(6, 'Pedro', '2093/05/01', 'Rua Judases', '1312325677');

select * from aluno;
select * from professor;

/*INNER JOIN  -----  só seleciona os elementos em comum*/
select aluno.nome, aluno.endereco from aluno inner join professor on aluno.endereco=professor.endereco;

/*LEFT JOIN  -----  seleciona os em comum e TUDO da tabela esquerda (no caso a Aluno)*/
select * from aluno left join professor on aluno.endereco=professor.endereco;

/*LEFT RIGHT  -----  seleciona os em comum e TUDO da tabela direita (no caso a Professor)*/
select * from aluno right join professor on aluno.endereco=professor.endereco;

/*FULL OUTER JOIN  -----  seleciona TUDO das tabelas*/
select * from aluno full outer join professor on aluno.nome=professor.nome;

