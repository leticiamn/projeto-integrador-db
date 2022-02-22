create database uberbeer;
use uberbeer;
/* uberbeerlogico: */

CREATE TABLE Cliente (
    cod_cliente int PRIMARY KEY,
    cpf numeric(11),
    nome_ varchar(255),
    endereco varchar(255),
    email varchar(100),
    data_nasc date,
    login varchar(100),
    senha varchar(50)
);

CREATE TABLE Pedido (
    cod_pedido int PRIMARY KEY,
    data_pedido date,
    cod_cliente int,
    FOREIGN KEY (cod_cliente)
    REFERENCES Cliente (cod_cliente)
);

CREATE TABLE Produto (
    cod_produto int PRIMARY KEY,
    nome varchar(65),
    tipo varchar(65),
    teor_alcolico decimal(4,2),
    fabricante varchar(65),
    volume int,
    valor_unitario numeric(7,2),
    qtd_estoque int
);

CREATE TABLE Fornecedor (
    cod_fornecedor int PRIMARY KEY,
    cnpj numeric(14),
    nome varchar(255),
    endereco varchar(255),
    telefone int
);

CREATE TABLE Compra (
    cod_compra int PRIMARY KEY,
    data_compra date,
    valor_total numeric(10,2),
    cod_fornecedor int,
    FOREIGN KEY (cod_fornecedor)
    REFERENCES Fornecedor (cod_fornecedor)
);

CREATE TABLE venda (
    cod_produto int,
    cod_pedido int,
    qtd_pedido int,
    valor_venda numeric(7,2),
    cod_venda int PRIMARY KEY,
    FOREIGN KEY (cod_produto)
    REFERENCES Produto (cod_produto),
    FOREIGN KEY (cod_pedido)
    REFERENCES Pedido (cod_pedido)
);

CREATE TABLE compra_produto (
    cod_produto int,
    cod_compra int,
    cod_compra_prod int PRIMARY KEY,
    qtd_compra int,
    valor_unit numeric(7,2),
    FOREIGN KEY (cod_produto)
    REFERENCES Produto (cod_produto),
    FOREIGN KEY (cod_compra)
    REFERENCES Compra (cod_compra)
);
 

 