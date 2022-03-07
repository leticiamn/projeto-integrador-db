CREATE database uberbeer;
use uberbeer;

/* drop database uberbeer;

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
    telefone varchar(30)
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
 ('ALLES BLAU BELGIAN WITBIER','Pilsen',4.6,'Alles Blau',355,11.90,80),
 ('MANIACS BELGIAN WIT','Pilsen',4.6,'Maniacs',350,9.90,60),
 ('OL BEER ODIN WITBIER','Pilsen',5.2,'ØL Beer',500,21.90,30),
 ('BODEBROWN BLANCHE','Pilsen',5.2,'Bodebrown',473,25.90,99),
 ('Goose Island Midway Long Neck','IPA',12,'Goose Island',355,19.25,80);
 
INSERT INTO CLIENTE(cpf,
    nome,
    endereco,
    email,
    data_nasc,
    login,
    senha) VALUES 
(68228480962, 'Sebastião Hugo Henry Pereira', 'cep 60184-210, Rua João Avelino, numero 988, bairro Vicente Pinzon, Fortaleza, CE',
 'sebastiao_hugo_pereira@dpauladecor.com.br',
 '1942-12-01','hugo@henry','458155494'), 
 (89419533409,'Gael Raul Vinicius da Luz', 
 'cep 79905-314 Rua Afrânio Gonçalves numero 433, bairro da Granja, Ponta Porã, MS',
 'gael_raul_daluz@signatreinamentos.com.br','1958-04-02','raul@vinicius', 
 '323382289'),
  (46300151670,'Ester Maria Emanuelly Duarte', 
 'cep 72313-710 Quadra QR 511 Conjunto 10 numero 957, bairro Samambaia Sul (Samambaia), Brasília, DF',
 'estermariaduarte@allianceconsultoria.com.br','1968-03-05','estermariaduarte@alliance', 
 '251709437'),
  (36550432600,'Joana Marcela Mariana Rodrigues', 
 null,
 'joanamarcelarodrigues@mailinator.com','1975-02-13','joanamarcelarodrigues@mailinator', 
 '318098714'),
  (34903808270,'Breno Raul Sales', 
 'cep 86037-769 Rua Lady Diana, bairro Residencial Abussafe, Londrina, PR',
 'breno-sales71@mailnull.com','1952-04-13','breno-sales71@mail', 
 '186781076'),
  (97792267458,'Fernando Roberto Oliveira', 
 'cep 57046-470 Rua dos Tupis numero 478, bairro Serraria, Maceió, AL',
 'fernando-oliveira75@octagonbrasil.com.br','1995-01-17','fernando@octagon', 
 '439057206'),
  (53574114419,'Pietro Jorge Cauê Assunção', 
 'cep 79901-406 Travessa Pitangui numero 212, bairro Residencial Manoel Padial Urel, Ponta Porã MS',
 'gpietro.jorge.assuncao@edbrasil.net','1958-04-02','gpietro@edbrasil', 
 '296440723'),
  (99369677046,'Daniela Isabel Melo', 
 'cep 59161-585 Avenida São Sebastião numero 433, bairro Pirangi do Norte (Distrito Litoral), Parnamirim, RN',
 'daniela_isabel_melo@eclatt.com.br','1950-01-02','daniela@eclatt', 
 '141938961'),
  (99445216474,'Ruan Geraldo Lima', 
 'cep 69094-650 Rua 82 numero 433, bairro Cidade Nova, Manaus, AM',
 'ruan_geraldo_lima@dpi.ig.br','1944-01-01','ruanlima@dpi', 
 '394272286'),
 (94755260213,'Isis Pietra Camila Rocha', 'cep 93348-230 Rua Alto Uruguai numero 652, bairro Rincão, Novo Hamburgo, RS',
'isis_pietra_rocha@zulix.com.br', '1992-10-14','pietra@camila','305758999');
 
 
 INSERT INTO Fornecedor (
    cnpj,
    nome,
    endereco,
    telefone)
values 
(18494425765123,'AMBEV','RUA 105, NUMERO 55, BAIRRO ALPHAVILLE, BRASILIA DF', '041468465'),
(62141591000174,'Bebidas S.A','Rua Porto Rico, NUMERO 476, BAIRRO Petrópolis, João Monlevade, MG', '3139514921'),
(40088169000160,'Alcool S.A','Rua Weber, NUMERO 746, BAIRRO Santana, Sabará MG', '3125299363'),
(61552990000165,'Cachaçaria EIRELI','Rua Geraldina Sarmento Mourão, NUMERO 935, BAIRRO Jardim São Luiz, Montes Claros MG', '3839108243'),
(79739429000155,'Água Doce Cachaçaria','Rua Carlos Chagas, NUMERO 616, BAIRRO Xangri-Lá, Contagem MG', '3137119781'),
(78044821000117,'Alambique Cachaça de Engenho','Rua Oriental, NUMERO 632, BAIRRO Nossa Senhora Aparecida, Belo Horizonte MG', '3129248360'),
(55570083000146,'Bebidas Triangulo','RUA Vila Edval, NUMERO 930, BAIRRO Barra do Ceará, Fortaleza CE', '8537457520'),
(69300024000162,'BK distribuidora de bebidas','Rua Hove, NUMERO 55, BAIRRO Goiabal, Barra Mansa RJ', '2429063593'),
(70312979000119,'Darvibeer','Avenida Engenheiro Darcy Nogueira do Pinho, NUMERO 542, BAIRRO Vila Cristina, Betim MG', '3128129733'),
(12341787008983, 'BADEN BADEN', 'BR 195, KM 500, UBERLANDIA MG', '349985466');


 INSERT INTO Compra (
    data_compra,
    valor_total,
    cod_fornecedor) VALUES 
    ('2022-03-20', 3140.00, 1),
    ('2020-08-15', 10950.00, 2),
    ('2019-09-10', 9420.00, 3),
    ('2021-12-09', 11990.00, 4),
    ('2021-12-09', 499.00, 5),
    ('2022-07-30', 595.00, 2);
    
 INSERT INTO pedido (
    data_pedido,
    valor_total,
    cod_cliente) VALUES 
    ('2022-01-04', 279.30, 1),
    ('2020-02-06', 107.65, 2),
    ('2022-03-10', 266.96, 3),
    ('2020-01-12', 388.50, 4),
    ('2019-05-10', 297.0, 5);
    
#select * from pedido;
    
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
(2, 3, 10, 21.90),
(9, 4, 15, 25.90),
(7, 5, 30, 9.90);
    
#SELECT * from venda_item;

INSERT INTO compra_item (
    cod_produto,
    cod_compra,
    qtd_compra,
    valor_unit)
values 
(1, 1, 200, 15.70),
(2, 2, 500, 21.90),
(3, 3, 600, 15.70),
(4, 4, 1000, 11.99),
(5, 5, 100, 4.99),
(6, 6, 50, 11.90);

#select * from compra_item;


	 