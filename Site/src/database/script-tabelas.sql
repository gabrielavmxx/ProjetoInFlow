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
    FOREIGN KEY(fkarea, fksupermercado) REFERENCES areas_supermercado(fkareas, fksupermercados)
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

INSERT INTO corredor (fkarea, fksupermercado)
VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 3);

INSERT INTO sensor (statuses, fkcorredor)
VALUES
('Ativo', 1),
('Ativo', 2),
('Ativo', 3),
('Ativo', 4),
('Ativo', 1);

INSERT INTO registros (datahora, fksensor, presenca) VALUES
();

SELECT * FROM areas;
SELECT * FROM corredor;
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM registros;
SELECT * FROM sensor;
SELECT * FROM supermercado;
SELECT * FROM usuario;

SELECT fksensor, COUNT(presenca) FROM registros r
INNER JOIN sensor s ON r.fksensor = s.id
INNER JOIN corredor c ON s.fkcorredor = c.id
INNER JOIN supermercado sm ON c.fksupermercado = sm.id
GROUP BY fksensor;
