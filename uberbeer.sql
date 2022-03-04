CREATE database uberbeer;
use uberbeer;

/*drop database uberbeer;

/* uberbeerlogico: */

CREATE TABLE Cliente (
    cod_cliente int PRIMARY KEY auto_increment,
    cpf numeric(11),
    nome varchar(255),
    endereco varchar(255),
    email varchar(100),
    data_nasc date,
    login varchar(100),
    senha varchar(50)
);

CREATE TABLE Pedido (
    cod_pedido int PRIMARY KEY auto_increment,
    data_pedido date,
    valor_total numeric(7,2),
    cod_cliente int,
    FOREIGN KEY (cod_cliente)
    REFERENCES Cliente (cod_cliente)
);

CREATE TABLE Produto (
    cod_produto int PRIMARY KEY auto_increment,
    nome varchar(65),
    tipo varchar(65),
    teor_alcolico decimal(4,2),
    fabricante varchar(65),
    volume int,
    valor_unitario numeric(7,2),
    qtd_estoque int
);

CREATE TABLE Fornecedor (
    cod_fornecedor int PRIMARY KEY auto_increment,
    cnpj numeric(14),
    nome varchar(255),
    endereco varchar(255),
    telefone numeric(20)
);

CREATE TABLE Compra (
    cod_compra int PRIMARY KEY auto_increment,
    data_compra date,
    valor_total numeric(10,2),
    cod_fornecedor int,
    FOREIGN KEY (cod_fornecedor)
    REFERENCES Fornecedor (cod_fornecedor)
);

CREATE TABLE venda_item (
	cod_venda_item int PRIMARY KEY auto_increment,
    cod_produto int,
    cod_pedido int,
    qtd_pedido int,
    valor_item numeric(7,2),
    FOREIGN KEY (cod_produto)
    REFERENCES Produto (cod_produto),
    FOREIGN KEY (cod_pedido)
    REFERENCES Pedido (cod_pedido)
);

CREATE TABLE compra_item (
	cod_compra_item int PRIMARY KEY auto_increment,
    cod_produto int,
    cod_compra int,
    qtd_compra int,
    valor_unit numeric(7,2),
    FOREIGN KEY (cod_produto)
    REFERENCES Produto (cod_produto),
    FOREIGN KEY (cod_compra)
    REFERENCES Compra (cod_compra)
);
 
/* inserção de dados: */
 
 INSERT INTO PRODUTO(nome, tipo, teor_alcolico, fabricante, volume, valor_unitario, qtd_estoque)
 VALUES('Capunga Pilsen Praia','Pilsen',5,'Capunga',275,15.70,50),
 ('Capunga Pet Growler Ipa Cumade Florzinha','IPA',6,'Capunga',1000,21.90,20),
 ('Enseada Premium Lager','Premium Lager',4.7,'Capunga',275,15.70,50),
 ('Witbier Baden','Pilsen',4.9,'Witbier',600,11.99,150),
 ('Hoegaarden Witbier','Pilsen',5.99,'Witbier',269,4.99,100),
 ('Goose Island Midway Long Neck','IPA',12,'Goose Island',355,19.25,80);
 
INSERT INTO CLIENTE(cpf,
    nome,
    endereco,
    email,
    data_nasc,
    login,
    senha) VALUES 
(68228480962, 'Sebastião Hugo Henry Pereira', 'cep 60184-210, Rua João Avelino, numero 988, bairro Vicente Pinzon, Fortaleza CE',
 'sebastiao_hugo_pereira@dpauladecor.com.br',
 '1942-12-01','hugo@henry','458155494'), 
 (89419533409,'Gael Raul Vinicius da Luz', 
 'cep 79905-314 Rua Afrânio Gonçalves numero 433, bairro Bairro da Granja, Ponta Porã MS',
 'gael_raul_daluz@signatreinamentos.com.br','1958-04-02','raul@vinicius', 
 '323382289'),
 (94755260213,'Isis Pietra Camila Rocha', 'cep 93348-230 Rua Alto Uruguai numero 652, bairro Rincão, Novo Hamburgo RS',
'isis_pietra_rocha@zulix.com.br', '1992-10-14','pietra@camila','305758999');
 
 
 INSERT INTO Fornecedor (
    cnpj,
    nome,
    endereco,
    telefone)
values 
(18494425765123,'AMBEV','RUA 105, NUMERO 55, BAIRRO ALPHAVILLE, BRASILIA DF', 041468465),
(12341787008983, 'BADEN BADEN', 'BR 195, KM 500, UBERLANDIA MG', 349985466);


 INSERT INTO Compra (
    data_compra,
    valor_total,
    cod_fornecedor) VALUES 
    ('2022-02-22', 50.00, 1),
    ('2022-02-23', 40.00, 2);
    
 INSERT INTO pedido (
    data_pedido,
    valor_total,
    cod_cliente) VALUES 
    ('2022-03-04', 279.30, 1),
    ('2022-03-06', 107.65, 2),
    ('2022-03-10', 266.96, 3);
    
select * from pedido;
    
INSERT INTO venda_item (
    cod_produto,
    cod_pedido,
    qtd_pedido,
    valor_item)
values 
(1, 1, 10, 15.70),
(3, 1, 5, 15.70),
(2, 1, 2, 21.90),
(5, 2, 10, 4.99),
(6, 2, 3, 19.25),
(4, 3, 4, 11.99),
(2, 3, 10, 21.90);
    
SELECT * from venda_item;

INSERT INTO compra_item (
    cod_produto,
    cod_compra,
    qtd_compra,
    valor_unit)
values 
(1, 1, 20, 5.00),
(2, 2, 40, 10.00);

select * from compra_item;



	 