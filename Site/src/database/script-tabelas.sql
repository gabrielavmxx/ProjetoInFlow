CREATE DATABASE inflow;
USE inflow;

-- Tabela endereco
CREATE TABLE endereco(
    id INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(30),
    estado VARCHAR(20),
    bairro VARCHAR(30),
    logradouro VARCHAR(100),
    cep CHAR(10),
    complemento VARCHAR(60),
    numero VARCHAR(10)
);

-- Tabela empresa
CREATE TABLE empresa(
    id INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(50),
    cnpj CHAR(14),
    codigo_ativacao VARCHAR(20),
    fkEndereco INT,
    CONSTRAINT fk_end_em FOREIGN KEY (fkEndereco) REFERENCES endereco(id)
);

-- Tabela supermercado
CREATE TABLE supermercado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj CHAR(14),
    fkempresa INT,
    fkEndereco INT,
    CONSTRAINT fk_em_sup FOREIGN KEY (fkempresa) REFERENCES empresa(id),
    CONSTRAINT fk_end_sup FOREIGN KEY (fkEndereco) REFERENCES endereco(id)
);

-- Tabela usuario
CREATE TABLE usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cpf VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    fotoPerfil VARCHAR(255),
    acesso VARCHAR(10),
    fkempresa INT,
    FOREIGN KEY(fkempresa) REFERENCES empresa(id),
	UNIQUE ix_email (email),
    UNIQUE ix_cpf (cpf),
    CONSTRAINT ck_acesso CHECK(acesso IN('Admin', 'Analista', 'Gestor'))
);

-- Tabela areas (mantive plural)
CREATE TABLE areas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

CREATE TABLE areas_supermercado(
	fkareas INT,
    fksupermercados INT,
    PRIMARY KEY(fkareas, fksupermercados),
    CONSTRAINT fk_a_as FOREIGN KEY (fkareas) REFERENCES areas(id),
    CONSTRAINT fk_s_as FOREIGN KEY (fksupermercados) REFERENCES supermercado(id)
);

-- Tabela corredor
CREATE TABLE corredor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkarea INT,
    fksupermercado INT,
    posicao VARCHAR(20),
    FOREIGN KEY(fkarea, fksupermercado) REFERENCES areas_supermercado(fkareas, fksupermercados)
);

-- Tabela sensor
CREATE TABLE sensor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    statuses VARCHAR(10) DEFAULT 'Ativo',
    CONSTRAINT chk_status CHECK(statuses IN ('Ativo','Inativo')),
    fkcorredor INT,
    numero_serie CHAR(8),
    UNIQUE ix_ns (numero_serie),
    FOREIGN KEY(fkcorredor) REFERENCES corredor(id)
);

-- Tabela registros
CREATE TABLE registros(
    id INT PRIMARY KEY AUTO_INCREMENT,
    datahora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fksensor INT,
    presenca INT,
    FOREIGN KEY(fksensor) REFERENCES sensor(id)
);


INSERT INTO endereco (cidade, estado, bairro, logradouro, cep, complemento, numero)
VALUES ('Barueri', 'São Paulo', 'Tamboré', 'Avenida Tucunare', '06460020', 'Bloco C Sala 1 C101', '125'),
('São Paulo', 'São Paulo', 'Vila Guilherme', 'Avenida Morvan Dias de Figueiredo', '02063002', null, '3177'),
('Santo André', 'São Paulo', 'Vila Humalta', 'Avenida Pedro Américo', '09110560', null, '23'),
('Porto Alegre', 'Rio Grande do Sul', 'Higienopolis', 'Avenida Plinio Brasil Milano', '90520000', null, '1000'),
('São Paulo', 'São Paulo', 'Vila Andrade', 'Avenida Giovanni Gronchi', '05724002', null, '5930');

INSERT INTO empresa (razao_social, cnpj, codigo_ativacao, fkEndereco)
VALUES('CARREFOUR COMERCIO E INDUSTRIA LTDA', '45543915000181', 'C04RRIS', 1),
('COMPANHIA ZAFFARI COMERCIO E INDUSTRIA', '93015006000113', 'ZAFF895', 4);

INSERT INTO supermercado (nome, cnpj, fkEmpresa, fkEndereco)
VALUES ('Carrefour Hypermarket Tietê', '45543915002125', 1, 2),
('Carrefour Hipermercado', '45543915072689', 1, 3),
('Hipermercado Zaffari Morumbi Town', '93015006003309', 2, 5);

-- Inserir usuários
INSERT INTO usuario (nome, cpf, telefone, email, senha, fotoPerfil, acesso, fkempresa)
VALUES 
('João Silva', '12345678901', '11999998888', 'joao.silva@email.com', 'senha123', null, 'Admin', 1),
('Maria Oliveira', '98765432100', '11999997777', 'maria.oliveira@email.com', 'senha456', null, 'Analista', 1),
('Carlos Souza', '11223344556', '11988887777', 'carlos.souza@email.com', 'senha789', null, 'Gestor', 1);

-- Inserir áreas
INSERT INTO areas (nome)
VALUES 
('Padaria'),
('Hortifruti'),
('Açougue'),
('Laticínios');

-- Vincular áreas aos supermercados
INSERT INTO areas_supermercado (fkareas, fksupermercados)
VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 3);

INSERT INTO corredor (fkarea, fksupermercado, posicao)
VALUES 
(1, 1, 'Corredor 1'),
(2, 1, 'Corredor 2'),
(3, 2, 'Corredor 1'),
(4, 3, 'Corredor 1');

INSERT INTO sensor (statuses, fkcorredor, numero_serie)
VALUES
('Ativo', 1, 'AABBCCD1'),
('Ativo', 2, 'AABBCCD2'),
('Ativo', 3, 'AABBCCD3'),
('Ativo', 4, 'AABBCCD4'),
('Ativo', 1, 'AABBCCD5');

SELECT * FROM areas;
SELECT * FROM corredor;
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM registros ORDER BY id DESC;
SELECT * FROM sensor;
SELECT * FROM supermercado;
SELECT * FROM usuario;

SELECT fksensor, COUNT(presenca) FROM registros r
INNER JOIN sensor s ON r.fksensor = s.id
INNER JOIN corredor c ON s.fkcorredor = c.id
INNER JOIN supermercado sm ON c.fksupermercado = sm.id
INNER JOIN empresa em ON sm.fkempresa = em.id
WHERE sm.id = 1 AND datahora > DATE_SUB(('2025-05-19 08:11:00'), INTERVAL 5 MINUTE)
AND s.numero_serie = 'AABBCCD1'
GROUP BY fksensor;
select * from registros where month(datahora) = 'May'

SELECT 
    sm.nome AS supermercado,
    c.posicao AS corredor,
    MONTH(r.datahora) AS mes,
    YEAR(r.datahora) AS ano,
    COUNT(r.presenca) AS total_movimentacoes
FROM registros r
INNER JOIN sensor s ON r.fksensor = s.id
INNER JOIN corredor c ON s.fkcorredor = c.id
INNER JOIN supermercado sm ON c.fksupermercado = sm.id
GROUP BY sm.nome, c.posicao, mes, ano
ORDER BY ano DESC, mes DESC, sm.nome, c.posicao;
--OUTRO BANCO DE TESTE INSERTS CORRETOS
CREATE DATABASE inflow;
USE inflow;


-- Tabela endereco
CREATE TABLE endereco(
    id INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(30),
    estado VARCHAR(20),
    bairro VARCHAR(30),
    logradouro VARCHAR(100),
    cep CHAR(10),
    complemento VARCHAR(60),
    numero VARCHAR(10)
);

-- Retirei tabela empresa
/*CREATE TABLE empresa(
    id INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(50),
    cnpj CHAR(14),
    codigo_ativacao VARCHAR(20),
    fkEndereco INT,
    CONSTRAINT fk_end_em FOREIGN KEY (fkEndereco) REFERENCES endereco(id)
);*/

-- Tabela supermercado
CREATE TABLE supermercado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj CHAR(14),
    fkEndereco INT,
    CONSTRAINT fk_end_sup FOREIGN KEY (fkEndereco) REFERENCES endereco(id)
);

-- Tabela usuario
CREATE TABLE usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cpf VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    fotoPerfil VARCHAR(255),
    acesso VARCHAR(10),
    fksupermercado INT,
    FOREIGN KEY(fksupermercado) REFERENCES supermercado(id),
	UNIQUE ix_email (email),
    UNIQUE ix_cpf (cpf),
    CONSTRAINT ck_acesso CHECK(acesso IN('Admin', 'Analista', 'Gestor'))
);

-- Tabela areas 
CREATE TABLE areas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

CREATE TABLE areas_supermercado(
	fkareas INT,
    fksupermercados INT,
    PRIMARY KEY(fkareas, fksupermercados),
    CONSTRAINT fk_a_as FOREIGN KEY (fkareas) REFERENCES areas(id),
    CONSTRAINT fk_s_as FOREIGN KEY (fksupermercados) REFERENCES supermercado(id)
);

-- Tabela corredor
CREATE TABLE corredor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkarea INT,
    fksupermercado INT,
    posicao VARCHAR(20),
    FOREIGN KEY(fkarea, fksupermercado) REFERENCES areas_supermercado(fkareas, fksupermercados)
);

-- Tabela sensor
CREATE TABLE sensor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    statuses VARCHAR(10) DEFAULT 'Ativo',
    CONSTRAINT chk_status CHECK(statuses IN ('Ativo','Inativo')),
    fkcorredor INT,
    numero_serie CHAR(8),
    UNIQUE ix_ns (numero_serie),
    FOREIGN KEY(fkcorredor) REFERENCES corredor(id)
);

-- Tabela registros
CREATE TABLE registros(
    id INT PRIMARY KEY AUTO_INCREMENT,
    datahora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fksensor INT,
    presenca INT,
    FOREIGN KEY(fksensor) REFERENCES sensor(id)
);



INSERT INTO endereco (cidade, estado, bairro, logradouro, cep, complemento, numero) VALUES 
('São Paulo', 'SP', 'Guaianazes', 'Estrada Itaquera guaianazes', '01310-000', 'Conjunto 1001', '1500'), 
('São Paulo', 'SP', 'São Matheus', 'Rua joão velho do rego', '04010-000', 'Loja 1', '1000');



INSERT INTO supermercado (nome, cnpj,fkEndereco) VALUES 
('Supermercado Leticia', '45678912000777',  1),
('Supermercado Isabella', '45678912000888', 2);


-- 🔹 ÁREAS
INSERT INTO areas (nome) VALUES 
('Padaria'),
('Hortifruti'),
('Açougue'),
('Bebidas'),
('Limpeza');

-- 🔹 ÁREAS_SUPERMERCADO
-- Supermercado Leticia
INSERT INTO areas_supermercado (fkareas, fksupermercados) VALUES 
(1,1 ), (2, 1), (3, 1), (4, 1), (5, 1);

-- Supermercado Isabella
INSERT INTO areas_supermercado (fkareas, fksupermercados) VALUES 
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2);

-- 🔹 CORREDORES
-- Mercado isabella
INSERT INTO corredor (fkarea, fksupermercado, posicao) VALUES 
(1, 2,'Corredor 1' ),       
(2, 2, 'Corredor 2'),         
(3, 2, 'Corrqedor 3'),         
(4, 2, 'Corredor 4'),   
(5, 2, 'Corredor 5');
select * from corredor;
-- Supercado leticia
INSERT INTO corredor (fkarea, fksupermercado, posicao) VALUES 
(1, 1,'Corredor 1' ),       
(2, 1, 'Corredor 2'),         
(3, 1, 'Corrqedor 3'),         
(4, 1, 'Corredor 4'),   
(5, 1, 'Corredor 5');
-- 🔹 SENSORES
select * from corredor;
update  corredor set  posicao="Corredor 3" where id=8;
select* from registros;
-- SENSORES LETICIA
INSERT INTO sensor (statuses, fkcorredor, numero_serie) VALUES 
('Ativo', 1, 'SENeVM01'),
('Ativo',2, 'SENVrM02'),
('Ativo', 3, 'SENVwM03'),
('Ativo', 4, 'SENqVM04'),
('Ativo', 5, 'SENqVM05');
-- SENSSORES ISABELLA
-- Moema
INSERT INTO sensor (statuses, fkcorredor, numero_serie) VALUES 
('Ativo', 6, 'SENMO01'),
('Ativo', 7, 'SENMO02'),
('Ativo', 8, 'SENMO03'),
('Ativo', 9, 'SENMO04'),
('Ativo', 10, 'SENMO05');
select* from corredor;
-- 🔹 REGISTROS DE PRESENÇA
-- Supermercado leticia (sensores 1 a 5)
INSERT INTO registros (fksensor, presenca,datahora) VALUES 
(1,1,"2024-07-29"),(1,1,"2024-07-29"),(2,1,"2024-07-29"),(1,1,"2024-07-29"),(1,1,"2024-07-29"),(3,1,"2024-07-29"),
(3,1,"2024-07-29"),(3,1,"2024-07-29"),(3,1,"2024-07-29"),(1,1,"2024-07-29"),(1,1,"2024-07-29");

select* from registros;


-- Supermercado isabella (sensores 6 a 10)
INSERT INTO registros (fksensor, presenca) VALUES 
(6,1),(6,1),(6,1),(6,1),(6,1),
(7,1),(7,1),(7,1),(7,1),(7,1),
(8,1),(8,1),(8,1),(8,1),(8,1);
select* from registros;

-- Usuarios do supermercado
INSERT INTO usuario (nome, cpf, telefone, email, senha, acesso, fksupermercado) VALUES 
('Carlos Lima', '11122233344', '11999990001', 'leticia.com', 'senha123', 'Admin', 1),
('Fernanda Alves', '55566677788', '11999990002', 'isabella.com', 'senha123', 'Gestor', 2);
select* from usuario;
SELECT 
    *
FROM
    supermercado
WHERE
    id = 4;
    SELECT 
            corredor.id AS idCorredor,
            corredor.posicao AS corredor,
            COUNT(registros.id) AS fluxoPessoas
        FROM registros
        JOIN sensor ON registros.fksensor = sensor.id
        JOIN corredor ON sensor.fkcorredor = corredor.id
        WHERE corredor.fksupermercado = 1 and month(datahora)=5 and year(datahora)=2025
        GROUP BY corredor.id, corredor.posicao
        ORDER BY idCorredor;
        select cor.id, ar.nome from corredor cor inner join supermercado sup on sup.id=cor.fksupermercado inner join areas ar on cor.fkarea=ar.id where fksupermercado=2;
        


