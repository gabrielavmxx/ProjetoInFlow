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
-- Inserindo endereços
INSERT INTO endereco (cidade, estado, bairro, logradouro, cep, complemento, numero)
VALUES 
('São Paulo', 'SP', 'Centro', 'Rua das Flores', '01001-000', 'Próximo ao metrô', '100'),
('Campinas', 'SP', 'Jardim Brasil', 'Avenida Brasil', '13000-000', NULL, '500');

-- Inserindo empresas
INSERT INTO empresa (razao_social, cnpj, codigo_ativacao, fkEndereco)
VALUES 
('Supermercados ABC LTDA', '12345678000199', 'ABC123', 1),
('Hipermercado XPTO SA', '98765432000188', 'XPTO456', 2);

-- Inserindo supermercados
INSERT INTO supermercado (nome, cnpj, fkempresa, fkEndereco)
VALUES 
('ABC Supermercado - Unidade Centro', '12345678000101', 1, 1),
('XPTO Hipermercado - Campinas', '98765432000102', 2, 2);

-- Inserindo usuários
INSERT INTO usuario (nome, cpf, telefone, email, senha, acesso, fkempresa)
VALUES 
('João Silva', '12345678900', '11999999999', 'joao@abc.com', 'senha123', 'Admin', 1),
('Maria Souza', '98765432100', '11988888888', 'maria@xpto.com', 'senha123', 'Gestor', 2);

-- Inserindo áreas
INSERT INTO areas (nome)
VALUES 
('Padaria'),
('Hortifruti'),
('Açougue'),
('Bebidas');

-- Relacionando áreas com supermercados
INSERT INTO areas_supermercado (fkareas, fksupermercados)
VALUES 
(1, 1), (2, 1), (3, 1), (4, 1), -- Áreas do supermercado ABC
(1, 2), (2, 2), (3, 2), (4, 2); -- Áreas do supermercado XPTO

-- Inserindo corredores
INSERT INTO corredor (fkarea, fksupermercado, posicao)
VALUES 
(1, 1, '1'), -- Padaria do ABC
(2, 1, '2'), -- Hortifruti do ABC
(3, 1, '3'), -- Açougue do ABC
(4, 1, '4'), -- Bebidas do ABC

(1, 2, '1'), -- Padaria do XPTO
(2, 2, '2'), -- Hortifruti do XPTO
(3, 2, '3'), -- Açougue do XPTO
(4, 2, '4'); -- Bebidas do XPTO

-- Inserindo sensores nos corredores
INSERT INTO sensor (statuses, fkcorredor, numero_serie)
VALUES 
('Ativo', 1, 'SENS0001'),
('Ativo', 2, 'SENS0002'),
('Ativo', 3, 'SENS0003'),
('Ativo', 4, 'SENS0004'),
('Ativo', 5, 'SENS0005'),
('Ativo', 6, 'SENS0006'),
('Ativo', 7, 'SENS0007'),
('Ativo', 8, 'SENS0008');

-- Inserindo registros de fluxo (presença detectada)
-- Supermercado ABC - Simulando fluxo
INSERT INTO registros (fksensor, presenca, datahora) VALUES
(1, 1, '2025-05-27 10:00:00'),
(1, 1, '2025-05-27 10:05:00'),
(1, 1, '2025-05-27 10:10:00'),

(2, 1, '2025-05-27 10:00:00'),
(2, 1, '2025-05-27 10:03:00'),
(2, 1, '2025-05-27 10:06:00'),
(2, 1, '2025-05-27 10:09:00'),
(2, 1, '2025-05-27 10:12:00'),

(3, 1, '2025-05-27 10:00:00'),
(3, 1, '2025-05-27 10:08:00'),

(4, 1, '2025-05-27 10:00:00'),
(4, 1, '2025-05-27 10:02:00'),
(4, 1, '2025-05-27 10:04:00'),
(4, 1, '2025-05-27 10:06:00'),
(4, 1, '2025-05-27 10:08:00'),
(4, 1, '2025-05-27 10:10:00'),

-- Supermercado XPTO - Simulando fluxo
(5, 1, '2025-05-27 10:00:00'),
(5, 1, '2025-05-27 10:07:00'),

(6, 1, '2025-05-27 10:00:00'),
(6, 1, '2025-05-27 10:05:00'),
(6, 1, '2025-05-27 10:10:00'),

(7, 1, '2025-05-27 10:00:00'),

(8, 1, '2025-05-27 10:00:00'),
(8, 1, '2025-05-27 10:03:00'),
(8, 1, '2025-05-27 10:06:00');
SELECT 
    corredor.id AS id_corredor,
    corredor.posicao AS corredor,
    COUNT(registros.id) AS fluxo_pessoas
FROM registros
JOIN sensor ON registros.fksensor = sensor.id
JOIN corredor ON sensor.fkcorredor = corredor.id
WHERE corredor.fksupermercado = 1 -- ou 2, para o supermercado específico
GROUP BY corredor.id, corredor.posicao;
  SELECT 
            corredor.id AS idCorredor,
            corredor.posicao AS corredor,
            COUNT(registros.id) AS fluxoPessoas
        FROM registros
        JOIN sensor ON registros.fksensor = sensor.id
        JOIN corredor ON sensor.fkcorredor = corredor.id
        WHERE corredor.fksupermercado = 1
        GROUP BY corredor.id, corredor.posicao
        ORDER BY idCorredor ;
