DROP SCHEMA IF EXISTS rh CASCADE;
CREATE SCHEMA rh;
SET search_path TO rh;

-- TABELAS AUXILIARES

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE estado_civil (
    id_estado_civil SERIAL PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE grau_educacional (
    id_grau_educacional SERIAL PRIMARY KEY,
    descricao VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE grau_hierarquico (
    id_grau_hierarquico SERIAL PRIMARY KEY,
    descricao VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE tipo_contrato (
    id_tipo_contrato SERIAL PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE turno (
    id_turno SERIAL PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE nacionalidade (
    id_nacionalidade SERIAL PRIMARY KEY,
    descricao VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE tipo_contato (
    id_tipo_contato SERIAL PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE NOT NULL
);


-- ENTIDADE PRINCIPAL

CREATE TABLE colaborador (
    id_colaborador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    rg VARCHAR(20),
    data_nascimento DATE,
    id_nacionalidade INT REFERENCES nacionalidade(id_nacionalidade) ON DELETE SET NULL,
    id_genero INT REFERENCES genero(id_genero) ON DELETE SET NULL,
    id_estado_civil INT REFERENCES estado_civil(id_estado_civil) ON DELETE SET NULL,
    id_grau_educacional INT REFERENCES grau_educacional(id_grau_educacional) ON DELETE SET NULL,
    id_grau_hierarquico INT REFERENCES grau_hierarquico(id_grau_hierarquico) ON DELETE SET NULL,
    id_tipo_contrato INT REFERENCES tipo_contrato(id_tipo_contrato) ON DELETE SET NULL,
    id_turno INT REFERENCES turno(id_turno) ON DELETE SET NULL,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    motivo_demissao TEXT,
    salario NUMERIC(12,2) NOT NULL,
    pis VARCHAR(30),
    ctps VARCHAR(30),
    reservista VARCHAR(30),
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Índice para consultas rápidas por colaboradores ativos
CREATE INDEX idx_colaborador_ativos ON colaborador(data_demissao);

-- CONTA BANCÁRIA (1:N)
CREATE TABLE conta_bancaria (
    id_conta_bancaria SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    banco VARCHAR(100),
    agencia VARCHAR(20),
    conta VARCHAR(50),
    tipo_conta VARCHAR(50)
);

-- CONTRATO (1:N)
CREATE TABLE contrato (
    id_contrato SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_expiracao DATE,
    status VARCHAR(30) NOT NULL CHECK (status IN ('ativo','encerrado','suspenso'))
);

-- DEPARTAMENTO (N:N)
CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT
);

CREATE TABLE colaborador_departamento (
    id SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    id_departamento INT NOT NULL REFERENCES departamento(id_departamento) ON DELETE CASCADE,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    UNIQUE (id_colaborador, id_departamento, data_inicio)
);

-- BENEFÍCIOS (N:N)
CREATE TABLE beneficio (
    id_beneficio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    valor_total NUMERIC(12,2) DEFAULT 0,
    valor_descontado NUMERIC(12,2) DEFAULT 0,
    descricao TEXT,
    status VARCHAR(30) CHECK (status IN ('ativo','inativo'))
);

CREATE TABLE colaborador_beneficio (
    id SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    id_beneficio INT NOT NULL REFERENCES beneficio(id_beneficio) ON DELETE CASCADE,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    UNIQUE (id_colaborador, id_beneficio, data_inicio)
);

-- CONTATOS (1:N)
CREATE TABLE contato (
    id_contato SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    id_tipo_contato INT REFERENCES tipo_contato(id_tipo_contato) ON DELETE SET NULL,
    valor TEXT,
    observacao TEXT
);

-- DEPENDENTES (1:N)
CREATE TABLE dependente (
    id_dependente SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11),
    rg VARCHAR(20),
    data_nascimento DATE,
    relacionamento VARCHAR(50) NOT NULL
);

-- FÉRIAS (1:N)
CREATE TABLE ferias (
    id_ferias SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE RESTRICT,
    data_inicio DATE,
    data_fim DATE,
    vencimento DATE,
    dias INT,
    abono BOOLEAN,
    descricao TEXT,
    status VARCHAR(30) CHECK (status IN ('agendado','realizado','cancelado'))
);

-- EXAMES MÉDICOS (1:N)
CREATE TABLE exame (
    id_exame SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE RESTRICT,
    data_exame DATE,
    medico VARCHAR(150),
    crm VARCHAR(30),
    cid VARCHAR(30),
    descricao TEXT,
    status VARCHAR(30) CHECK (status IN ('agendado','realizado','cancelado')),
    apto BOOLEAN,
    proximo_exame DATE,
    dias_folga INT
);

CREATE INDEX idx_exame_proximo_exame ON exame(proximo_exame);

-- HISTÓRICOS
CREATE TABLE historico_salarial (
    id_historico SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    salario NUMERIC(12,2) NOT NULL
);

CREATE TABLE promocao (
    id_promocao SERIAL PRIMARY KEY,
    id_colaborador INT NOT NULL REFERENCES colaborador(id_colaborador) ON DELETE RESTRICT,
    cargo VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    observacao TEXT
);
