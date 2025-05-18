CREATE DATABASE supermercado;
USE supermercado;

drop database supermercado;

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
    fkEmpresa INT,
    fkEndereco INT,
    CONSTRAINT fk_em_sup FOREIGN KEY (fkEmpresa) REFERENCES empresa(id),
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

-- Tabela areas (mantive plural)
CREATE TABLE areas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    fksupermercado INT,
    FOREIGN KEY(fksupermercado) REFERENCES supermercado(id)
);

-- Tabela corredor
CREATE TABLE corredor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkarea INT,
    FOREIGN KEY(fkarea) REFERENCES areas(id)
);

-- Tabela sensor
CREATE TABLE sensor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    statuses VARCHAR(10) DEFAULT 'Ativo',
    CONSTRAINT chk_status CHECK(statuses IN ('Ativo','Inativo')),
    fkcorredor INT,
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

INSERT INTO usuario (nome, cpf, telefone, email, senha, fotoPerfil, acesso, fksupermercado)
VALUES ();

INSERT INTO area (nome, fksupermercado)
VALUES ();

INSERT INTO corredor (id, fkarea)
VALUES ();

INSERT INTO sensor (statuses, fkcorredor)
VALUES ();

INSERT INTO registro (datahora, fksensor, presenca)
VALUES ();

SELECT * FROM area;
SELECT * FROM corredor;
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM registros;
SELECT * FROM sensor;
SELECT * FROM supermercado;
SELECT * FROM usuario;