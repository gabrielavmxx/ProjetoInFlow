create database inflow;
use inflow;
 -- Hipermercado
create table Hipermercado (
    idHipermercado int auto_increment,
    nome VARCHAR(100),
    endereco varchar(200),
    primary key(idHipermercado)
);

-- 2. Area
create table Area (
    idArea int,
    nome varchar(100),
    fkHipermercado int,
    descricao varchar (100),
    primary key(idArea),
    foreign key (fkHipermercado) references Hipermercado(idHipermercado)
);

-- 3. Sensor
CREATE TABLE Sensor (
    idSensor int,
    fkArea int,
    estado varchar(10) check(estado in ('Ativo','Inativo')),
    primary key(idSensor),
    foreign key (fkArea) references Area(idArea)
);

CREATE TABLE Usuario (
    idUsuario int,
    nome varchar(100),
    email varchar(100) UNIQUE,
    senha varchar(20),
    cargo varchar(100),
    primary key(idUsuario)
    
);


CREATE TABLE Registro (
    idRegistro int,
    fkSensor int,
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida TIMESTAMP,
    primary key(idRegistro),
    foreign key (fkSensor) references Sensor(fkSensor)
    
);
