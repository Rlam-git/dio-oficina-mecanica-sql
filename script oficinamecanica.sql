-- criar o banco de dados

CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

-- criar a tabela

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco TEXT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL,
    ano INT NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    descricao TEXT NOT NULL UNIQUE,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100) NOT NULL,
    endereco TEXT NOT NULL
);

CREATE TABLE Peca (
    id_peca INT PRIMARY KEY,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE MetodoPagamento (
    id_metodo_pagamento INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL UNIQUE-- 'PIX', 'Cartão de Crédito', 'Boleto', etc.
);

CREATE TABLE FormaPagamento (
    id_forma_pagamento INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL UNIQUE-- 'À vista', 'Parcelado', etc.
);

CREATE TABLE OrdemServico (
    id_ordem_servico INT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    data DATE,
    total DECIMAL(10, 2),
    status VARCHAR(20),
    id_metodo_pagamento INT,
    id_forma_pagamento INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_metodo_pagamento) REFERENCES MetodoPagamento(id_metodo_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id_forma_pagamento)
);

CREATE TABLE OrdemServicoServico (
    id_ordem_servico_servico INT PRIMARY KEY,
    id_ordem_servico INT,
    id_servico INT,
    id_mecanico INT,
    quantidade INT,
    preco DECIMAL(10, 2),
    FOREIGN KEY (id_ordem_servico) REFERENCES OrdemServico(id_ordem_servico),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);

CREATE TABLE OrdemServicoPeca (
    id_ordem_servico_peca INT PRIMARY KEY,
    id_ordem_servico INT,
    id_peca INT,
    quantidade INT,
    preco DECIMAL(10, 2),
    FOREIGN KEY (id_ordem_servico) REFERENCES OrdemServico(id_ordem_servico),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);

CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    id_ordem_servico INT,
    valor DECIMAL(10, 2),
    data_pagamento DATE,
    id_metodo_pagamento INT,
    FOREIGN KEY (id_ordem_servico) REFERENCES OrdemServico(id_ordem_servico),
    FOREIGN KEY (id_metodo_pagamento) REFERENCES MetodoPagamento(id_metodo_pagamento)
);

-- 	PREENCHENDO AS TABELAS --
-- Preenchendo a tabela Cliente
INSERT INTO Cliente (id_cliente, nome, endereco, telefone, email) VALUES
(1, 'João Silva', 'Rua A, 123', '1111-1111', 'joao@gmail.com'),
(2, 'Maria Oliveira', 'Rua B, 456', '2222-2222', 'maria@gmail.com'),
(3, 'Carlos Souza', 'Rua C, 789', '3333-3333', 'carlos@gmail.com'),
(4, 'Ana Costa', 'Rua D, 1011', '4444-4444', 'ana@gmail.com');

-- Preenchendo a tabela Veiculo
INSERT INTO Veiculo (id_veiculo, placa, modelo, ano, id_cliente) VALUES
(1, 'ABC-1234', 'Civic', 2015, 1),
(2, 'DEF-5678', 'Corolla', 2018, 1),
(3, 'GHI-9101', 'Fiesta', 2016, 2),
(4, 'JKL-1121', 'Onix', 2020, 3),
(5, 'MNO-1314', 'HB20', 2019, 4);

-- Preenchendo a tabela Servico
INSERT INTO Servico (id_servico, descricao, preco) VALUES
(1, 'Troca de Óleo', 100.00),
(2, 'Alinhamento', 150.00),
(3, 'Balanceamento', 80.00);

-- Preenchendo a tabela Mecanico
INSERT INTO Mecanico (id_mecanico, nome, especialidade, telefone) VALUES
(1, 'Carlos Mendes', 'Motor', '5555-5555'),
(2, 'Ana Costa', 'Suspensão', '6666-6666'),
(3, 'Lucas Ferreira', 'Elétrica', '7777-7777');

-- Preenchendo a tabela Fornecedor
INSERT INTO Fornecedor (id_fornecedor, nome, contato, endereco) VALUES
(1, 'Fornecedor A', 'fornecedorA@gmail.com', 'Rua E, 1517'),
(2, 'Fornecedor B', 'fornecedorB@gmail.com', 'Rua F, 1819');

-- Preenchendo a tabela Peca
INSERT INTO Peca (id_peca, descricao, preco, estoque, id_fornecedor) VALUES
(1, 'Filtro de Óleo', 20.00, 50, 1),
(2, 'Pneu', 300.00, 20, 2),
(3, 'Pastilha de Freio', 120.00, 30, 1);

-- Preenchendo a tabela MetodoPagamento
INSERT INTO MetodoPagamento (id_metodo_pagamento, descricao) VALUES
(1, 'PIX'),
(2, 'Cartão de Crédito'),
(3, 'Boleto');

-- Preenchendo a tabela FormaPagamento
INSERT INTO FormaPagamento (id_forma_pagamento, descricao) VALUES
(1, 'À vista'),
(2, 'Parcelado');

-- Preenchendo a tabela OrdemServico
INSERT INTO OrdemServico (id_ordem_servico, id_cliente, id_veiculo, data, total, status, id_metodo_pagamento, id_forma_pagamento) VALUES
(1, 1, 1, '2024-12-20', 200.00, 'Concluído', 1, 1),
(2, 1, 2, '2024-12-21', 450.00, 'Em Andamento', 2, 2),
(3, 3, 4, '2024-12-22', 230.00, 'Pendente', 3, 1),
(4, 1, 1, '2024-12-23', 180.00, 'Concluído', 1, 1),
(5, 2, 3, '2024-12-24', 120.00, 'Concluído', 1, 1),
(6, 4, 5, '2024-12-25', 300.00, 'Em Andamento', 2, 2);

-- Preenchendo a tabela OrdemServicoServico
INSERT INTO OrdemServicoServico (id_ordem_servico_servico, id_ordem_servico, id_servico, id_mecanico, quantidade, preco) VALUES
(1, 1, 1, 1, 1, 100.00),
(2, 2, 2, 2, 1, 150.00),
(3, 3, 3, 3, 1, 80.00),
(4, 4, 1, 2, 1, 100.00),
(5, 5, 2, 3, 1, 150.00),
(6, 6, 3, 1, 1, 300.00);

-- Preenchendo a tabela OrdemServicoPeca
INSERT INTO OrdemServicoPeca (id_ordem_servico_peca, id_ordem_servico, id_peca, quantidade, preco) VALUES
(1, 1, 1, 1, 20.00),
(2, 2, 2, 2, 600.00),
(3, 3, 3, 1, 120.00),
(4, 4, 1, 1, 20.00),
(5, 5, 2, 4, 1200.00),
(6, 6, 3, 1, 120.00);

-- Preenchendo a tabela Pagamento

INSERT INTO Pagamento (id_pagamento, id_ordem_servico, valor, data_pagamento, id_metodo_pagamento) VALUES
(1, 1, 200.00, '2024-12-20', 1),
(2, 2, 450.00, '2024-12-21', 2),
(3, 3, 230.00, '2024-12-22', 3),
(4, 4, 180.00, '2024-12-23', 1),
(5, 5, 120.00, '2024-12-24', 1),
(6, 6, 300.00, '2024-12-25', 2);

-- CONSULTA BASICAS COM SELECT -- 

-- Recuperações simples com SELECT Statement;

select * from cliente;
select * from veiculo;
select * from mecanico;

-- Filtros com WHERE Statement;

select * from ordemservico where status = 'Concluido';
select nome, data, placa, modelo from cliente as c , ordemservico as o, veiculo as v 
	where o.status = 'Pendente' and c.id_cliente = o.id_cliente and v.id_veiculo = o.id_veiculo; 
select * from  ordemservico as o 
	where o.id_cliente = ( select id_cliente from cliente where cliente.nome like "João%") limit 1;
    
-- Crie expressões para gerar atributos derivados;
select sum(total) as total_ja_pago from ordemservico where ordemservico.id_cliente = 1 and status = "Concluido";

-- Defina ordenações dos dados com ORDER BY;

select * from cliente order by nome;

-- Condições de filtros aos grupos – HAVING Statement;

select status, count(*) as quantidade from ordemservico group by (status) having quantidade >= 2;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;