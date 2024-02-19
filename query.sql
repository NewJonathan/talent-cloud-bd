-- Criação da base de dados
CREATE DATABASE PetShopDB;

-- Tabela de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50),
    Email VARCHAR(50),
    Telefone VARCHAR(15)
);

-- Tabela de animais
CREATE TABLE Animais (
    AnimalID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50),
    Tipo VARCHAR(20),
    DonoID INT,
    FOREIGN KEY (DonoID) REFERENCES Clientes(ClienteID)
);

-- Tabela de produtos
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50),
    Preco DECIMAL(10, 2)
);

-- Tabela de vendas
CREATE TABLE Vendas (
    VendaID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    Data DATE,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela de itens de venda
CREATE TABLE ItensVenda (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    VendaID INT,
    ProdutoID INT,
    Quantidade INT,
    FOREIGN KEY (VendaID) REFERENCES Vendas(VendaID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Inserção de dados nas tabelas
INSERT INTO Clientes (Nome, Email, Telefone) VALUES 
('João', 'joao@email.com', '123456789'),
('Maria', 'maria@email.com', '987654321');

INSERT INTO Animais (Nome, Tipo, DonoID) VALUES 
('Rex', 'Cachorro', 1),
('Mimi', 'Gato', 2);

INSERT INTO Produtos (Nome, Preco) VALUES 
('Ração para Cachorro', 50.00),
('Ração para Gato', 40.00);

INSERT INTO Vendas (ClienteID, Data, ValorTotal) VALUES 
(1, '2024-02-19', 90.00),
(2, '2024-02-19', 40.00);

INSERT INTO ItensVenda (VendaID, ProdutoID, Quantidade) VALUES 
(1, 1, 1),
(2, 2, 1);

-- Consulta utilizando JOIN para obter informações sobre as vendas de um cliente, incluindo os produtos comprados
SELECT Clientes.Nome AS Cliente, Vendas.Data, Produtos.Nome AS Produto, ItensVenda.Quantidade
FROM Clientes
JOIN Vendas ON Clientes.ClienteID = Vendas.ClienteID
JOIN ItensVenda ON Vendas.VendaID = ItensVenda.VendaID
JOIN Produtos ON ItensVenda.ProdutoID = Produtos.ProdutoID
WHERE Clientes.Nome = 'João';
