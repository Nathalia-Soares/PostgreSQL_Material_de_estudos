/* Criando uma database no Postgre */

CREATE DATABASE nomeDaDatabase;

/* Deletando uma database no Postgre */

DROP DATABASE nomeDaDatabase;

/* Tipos de dados em Postgre */
/* Dados numericos */

INTEGER
REAL
SERIAL
NUMERIC

/* Dados de caracteres */

VARCHAR(numero de caracteres max = 255)
CHAR(numero de caracteres)
TEXT

/* Dados booleanos (verdadeiro e falso) */

BOOLEAN

/* Dados de data e hora */

DATE
TIME
TIMESTAMP

/* Criando uma tabela */

CREATE TABLE aluno (
	id SERIAL,
	nome VARCHAR(255),
	cpf CHAR(11),
	observacao TEXT,
	idade INTEGER,
	salario NUMERIC(10,2),
	/* DEZ CASAS DECIMAIS E DOIS NUMEROS DEPOIS DA VIRGULA */
	altura REAL,
	ativo BOOLEAN,
	data_nascimento DATE,
	hora_aula TIME,
	matriculado_em TIMESTAMP
);

/* Visualizando dados de uma tabela */

SELECT * FROM aluno;

/* Inserindo dados de uma tabela - Crud */

INSERT INTO aluno (nome, cpf, observacao, idade, salario, altura, ativo, data_nascimento, hora_aula, matriculado_em) VALUES ('Diogo', '12345678901','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 35, 100.50, 1.81, TRUE, '1984-08-27', '17:30:00', '2023-09-05 03:12:50');

/* Lendo dados de uma tabela - cRud */

SELECT * FROM aluno;

/* Lendo dados de um ou mais campos em uma tabela - cRud */

SELECT nome AS "Nome do Aluno" FROM aluno;
SELECT nome, idade matriculado_em AS quando_se_matriculou FROM aluno;

/* Atualizando dados de uma tabela - crUd */
/* Selecionando o registro em que queremos atualizar os dados */

SELECT * FROM aluno WHERE id = 1;

UPDATE aluno SET nome = 'Nico', cpf = '98765432189', observacao = 'Teste', idade = 38, salario = 15.23, altura = 1.90, ativo = FALSE, data_nascimento = '1990-10-19', hora_aula = '13:00:00', matriculado_em = '2020-01-02 15:00:00' WHERE id = 1;

/* Excluindo dados de uma tabela - cruD */

SELECT * FROM aluno WHERE nome = 'Nico';

DELETE FROM aluno WHERE nome = 'Nico';

/* Filtros na tabela */

SELECT * FROM aluno WHERE nome = 'Diogo';

SELECT * FROM aluno WHERE nome != 'Diogo';

SELECT * FROM aluno WHERE nome LIKE 'Di_go';

SELECT * FROM aluno WHERE nome NOT LIKE 'Di_go';

/* Filtros para achar nomes iniciados com D na tabela */

SELECT * FROM aluno WHERE nome LIKE 'D%';

/* Filtros para achar nomes terminados com S na tabela */

SELECT * FROM aluno WHERE nome LIKE '%s';

/* Filtrando campos para encontrar CPFs NULL */

SELECT * FROM aluno WHERE cpf IS NULL;

/* Filtrando campos para encontrar CPFs que não são nulos */

SELECT * FROM aluno WHERE cpf IS NOT NULL;

/* Filtrando campos para encontrar idades maiores ou menores */

SELECT * FROM aluno WHERE idade > 35;
SELECT * FROM aluno WHERE idade >= 35;
SELECT * FROM aluno WHERE idade < 35;
SELECT * FROM aluno WHERE idade <= 35;

/* Filtrando campos para encontrar idades entre 18 e 60 anos */

SELECT * FROM aluno WHERE idade BETWEEN 18 AND 60;

/* Filtrando campos booleanos */

SELECT * FROM aluno WHERE ativo = TRUE;

/* Operadores lógicos E e OU */

SELECT * FROM aluno WHERE nome LIKE 'D%' AND cpf IS NOT NULL;

SELECT * FROM aluno WHERE nome LIKE 'Diogo' OR nome LIKE 'Rodrigo';

/* Criação de registro não nulo e único (não pode ter outro valor igual) */

CREATE TABLE curso (
	id INTEGER NOT NULL UNIQUE,
	nome VARCHAR(255) NOT NULL
);

/* Criação de chave primária */

CREATE TABLE curso (
	id INTEGER PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

/* Criação de chave estrangeira */

CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	FOREIGN KEY (aluno_id) REFERENCES aluno (id),
	FOREIGN KEY (curso_id) REFERENCES curso (id)
);

/* Joins (ou INNER JOIN) com relacionamentos entre campos (não mostra campos nulos)*/
/* Comparando duas tabelas em que o registro ids sejam iguais em aluno(id) e aluno_curso (aluno_id) */

SELECT * FROM aluno JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id;

/* Comparando duas tabelas em que o registro ids sejam iguais em aluno(id), curso (id) e aluno_curso (aluno_id e curso_id) */

SELECT * FROM aluno JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id JOIN curso ON curso.id = aluno_curso.curso_id;

/* Comparando duas tabelas em que sejam mostrados os nomes dos alunos e dos cursos */

SELECT aluno.nome as nome_aluno, curso.nome as curso_nome FROM aluno JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id JOIN curso ON curso.id = aluno_curso.curso_id;

/* Left Join (Tenho o dado na tabela esquerda, mas não tenho o dado na tabela direita) */

SELECT aluno.nome as nome_aluno, curso.nome as curso_nome FROM aluno LEFT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id LEFT JOIN curso ON curso.id = aluno_curso.curso_id;

/* Right Join (Tenho o dado na tabela direita, mas não tenho o dado na tabela esquerda) */

SELECT aluno.nome as nome_aluno, curso.nome as curso_nome FROM aluno RIGHT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id RIGHT JOIN curso ON curso.id = aluno_curso.curso_id;

/* Full Join (Faltam dados na tabela direita e esquerda) */

SELECT aluno.nome as nome_aluno, curso.nome as curso_nome FROM aluno FULL JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id FULL JOIN curso ON curso.id = aluno_curso.curso_id;

/* Cross Join (Vincula todos os dados da tabela 1 com a tabela 2) */


SELECT aluno.nome AS "Nome do Aluno", curso.nome AS "Nome do Curso" FROM aluno CROSS JOIN curso;

/* Restrição de chave-estrangeira (Padrão no PostgreSQL)*/
/* Não permite que um registro seja apagado se a sua chave é estrangeira de outra tabela */

FOREIGN KEY (aluno_id) REFERENCES aluno (id) ON DELETE RESTRICT;

/* Restrição de chave-estrangeira (Cascade)*/
/* Permite que, assim que um registro for apagado na tabela original, sua instância (chave estrangeira) seja também apagada de outra(s) tabela(s) */

FOREIGN KEY (aluno_id) REFERENCES aluno (id) ON DELETE CASCADE;

/* *** UPDATE *** */

UPDATE aluno SET id = 10 WHERE id = 2;

/* *** UPDATE COM CASCADE *** */

FOREIGN KEY (aluno_id) REFERENCES aluno (id) ON UPDATE CASCADE;

/* *** ORDENANDO CONSULTAS *** */

/* Ordem crescente */
SELECT * FROM funcionarios ORDER BY nome;

/* Ordem decrescente */
SELECT * FROM funcionarios ORDER BY nome DESC;

/* Ordenando dois campos */
SELECT * FROM funcionarios ORDER BY nome, matricula;

/* Ordenando dois campos decrescente */
SELECT * FROM funcionarios ORDER BY nome, matricula DESC;

/* Ordenando pelo numero da coluna (Colunas 3, 4 e 2)*/
SELECT * FROM funcionarios ORDER BY 3, 4, 2;

/* Quando houver duas tabelas, deve-se sempre colocar tabela.coluna */

SELECT * FROM funcionarios, departamentos ORDER BY funcionarios.id, departamentos.id DESC;

/* *** LIMITANDO CONSULTAS *** */

/* Limitando para cinco tuplas */
SELECT * FROM funcionarios LIMIT 5;

/* Quando se quer "pular" tuplas na tabela para receber os valores depois delas (No caso, pulando as duas primeiras tuplas) */
SELECT * FROM funcionarios LIMIT 5 OFFSET 2;

/* Quando se quer selecionar os ids de 2001 a 3000 */
SELECT * FROM funcionarios LIMIT 1000 OFFSET 2000;

/* *** FUNÇÕES DE AGREGAÇÃO *** */

/* 
-- COUNT - Retorna a quantidade de registros
-- SUM -   Retorna a soma dos registros
-- MAX -   Retorna o maior valor dos registros
-- MIN -   Retorna o menor valor dos registros
-- AVG -   Retorna a média dos registros 
*/

/* Para saber quantos ids existem na tabela */

SELECT COUNT (id) FROM funcionarios;

/*O comando SUM() soma os valores. Ao codarmos SUM(id) ele retornará "28", ou seja, o somatório do valor de cada "id". Em outras palavras, esse comando calculou "1+2+3+4+5+6+7 = 28" */

SELECT SUM (id) FROM funcionarios;

/* Para saber o maior id da tabela */

SELECT MAX (id) FROM funcionarios;

/* Para saber o menor id da tabela */

SELECT MIN (id) FROM funcionarios;

/* Para saber a média de id da tabela */

SELECT AVG (id) FROM funcionarios;

/* Para arredondar valor com duas casas decimais */

SELECT ROUND (AVG (id), 2) FROM funcionarios;

/* *** AGRUPANDO CONSULTAS *** */

/* Para não mostrar dados repetidos (no caso, o nome) */
SELECT DISTINCT nome FROM funcionarios ORDER BY nome;

/* Para não mostrar dados repetidos (no caso, o nome e sobrenome) */
SELECT DISTINCT nome, sobrenome FROM funcionarios ORDER BY nome;

/* Para agrupar e mostrar quantos registros aquele nome e sobrenome têm */
/* OBS.: a função COUNT não funciona com DISTINCT, apenas com GROUP BY  */
SELECT nome, sobrenome, COUNT(*) FROM funcionarios GROUP BY nome, sobrenome ORDER BY nome;

/* *** FILTRANDO CONSULTAS AGRUPADAS *** */

 /* Quando temos um GROUP BY, não podemos utilizar o filtro WHERE e sim HAVING */

/* Quando queremos saber qual curso não tem nenhum aluno matriculado */
 SELECT * FROM curso LEFT JOIN aluno_curso ON aluno.curso_id = curso.id LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id GROUP BY 1 HAVING COUNT (aluno.id) = 0;

 /* Quando queremos saber quantos nomes duplicados existem na tabela */
 SELECT nome FROM funcionarios GROUP BY nome HAVING COUNT(id) > 1;