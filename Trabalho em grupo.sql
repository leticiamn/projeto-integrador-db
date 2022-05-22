use uberbeer;

/* 1 - Criação de procedimentos*/

/* A)*/
/* Procedimento 1: utilizado para inserir ou alterar dos dados do cliente */
/* Procedimento 2: utilizado para inserir ou alterar dos dados do pedido*/
DELIMITER |
create procedure pedido ()
begin

end
$
Delimiter ;


/* Procedimento 3: utilizado para inserir ou alterar dos dados do produto*/


/* Procedimento 4: utilizado para inserir ou alterar dos dados do fornecedor*/
delimiter $
create procedure sp_insere_fornecedor(cod_fornecedor int, nome varchar(50),
cnpj char(14), endereco varchar(50), telefone char(15))
begin
if(cnpj is null) then
select 'Você deve informar um CNPJ válido!' as msg;
else 
if (nome is null) then
select 'Você deve informar um nome!' as msg;
else
if(endereco is null) then
select 'Você deve informar o endereço!' as msg;
else 
if(telefone is null) then
select 'Você deve informar o telefone!' as msg;
else 
insert into fornecedor(cod_fornecedor,nome,cnpj,endereco,telefone) values
(cod_fornecedor,nome,cnpj,endereco,telefone);

end if;
end if;
end if;
end if;
end $

delimiter ;

/* B)*/
/* Procedimento 1: */
/* Procedimento 2: */

/* Procedimento 3: Relatorio com dados dos fornecedores que realizaram vendas no ano de ???? superior a R$ ??*/
delimiter $
create procedure sp_consultaRelatorio_fornecedor(var_ano int, var_valor_venda numeric(9,2))
begin

if(var_ano IS NULL AND var_valor_venda IS NULL) then
select 'Você precisa informar o ano e o valor da venda!' as msg;
else
SELECT f.cod_fornecedor AS FORNECEDOR, f.cnpj AS CNPJ, f.nome AS NOME, f.endereco AS ENDERECO, f.telefone AS TELEFONE 
FROM fornecedor f
INNER JOIN compra c ON f.cod_fornecedor = c.cod_fornecedor
WHERE year(data_compra) = var_ano AND valor_total > var_valor_venda
GROUP BY f.cod_fornecedor;

end if;
end $

delimiter ;

call sp_consultaRelatorio_fornecedor('2022', 3000);

/* Procedimento 4: */

/* C)*/
/* Procedimento 1: */


/* Procedimento 2: */

/* Procedimento 3: Somatoria das compras de produtos dos fornecedores no ano de ????*/

delimiter $
create procedure sp_consultaRelatorio_fornecedor_totalCompras(var_ano int)
begin

if(var_ano IS NULL) then
select 'Você precisa informar o ano!' as msg;
else
SELECT f.cod_fornecedor AS FORNECEDOR, f.cnpj AS CNPJ, f.nome AS NOME, sum(valor_total) AS TOTAL
FROM fornecedor f
INNER JOIN compra c ON f.cod_fornecedor = c.cod_fornecedor
WHERE year(data_compra) = var_ano
GROUP BY f.cod_fornecedor
ORDER BY TOTAL DESC;

end if;
end $

delimiter ;

call sp_consultaRelatorio_fornecedor_totalCompras('2020');

/* Procedimento 4: */


/* 2 - Criação de funções*/

/* Função 1: utilizada para formatar a data para o formato brasileiro adicionando os separadores*/
DELIMITER |
CREATE FUNCTION to_brasil_date(dataAntiga date)
RETURNS char(10)
DETERMINISTIC
BEGIN
DECLARE dataAtual char(10);
set dataAtual = concat_ws("-",day(dataAntiga),month(dataAntiga),year(dataAntiga));
RETURN dataAtual;
END |
Delimiter ;

Drop function to_brasil_date;

select to_brasil_date(current_date) AS DataBrasil;


/* Função 2: utilizada para formatar o CNPJ adicionando os separadores*/
DELIMITER |
CREATE FUNCTION to_cnpj(cnpjAntigo char(14))
RETURNS varchar(30)
DETERMINISTIC
BEGIN
DECLARE formatador varchar(30);
set formatador = concat(SUBSTRING(cnpjAntigo,1,2), '.',SUBSTRING(cnpjAntigo,3,3),'.',SUBSTRING(cnpjAntigo,6,3), '/', SUBSTRING(cnpjAntigo,9,4),'-', SUBSTRING(cnpjAntigo,13,2));
RETURN formatador;
END |
Delimiter ;

Drop function to_cnpj;

select to_cnpj(12345678910256) as CNPJ;


/* Função 3: utilizada para formatar valores para moeda adicionando R$*/
DELIMITER |
CREATE FUNCTION to_convert_money(valor numeric(7,2))
RETURNS varchar(30)
DETERMINISTIC
BEGIN
DECLARE valor_formatado varchar(30);
SET valor_formatado =  replace(concat('R$', valor), '.',',');
RETURN valor_formatado;
END |
Delimiter ;

drop function to_convert_money;

select to_convert_money(1000.50);


/* Função 4: utilizada para determinar há quantos dias foi feita a venda do produto, e caso tenha mais de 365 dias irã retornar quantos anos*/
DELIMITER |
CREATE FUNCTION to_date_seller(dataVenda DATE)
RETURNS varchar(12)
DETERMINISTIC
BEGIN
DECLARE valor_data varchar(12);
SET valor_data =  concat(TIMESTAMPDIFF(DAY,dataVenda,current_date), ' dia(s)!');
	if(valor_data > 365)then
		SET valor_data = concat(TIMESTAMPDIFF(YEAR,dataVenda,current_date), ' ano(s)!');
end if;
RETURN valor_data;
END |
Delimiter ;

DROP FUNCTION to_date_seller;

select to_date_seller('2022-05-01') AS DataVenda;


/* 3 - Criação de triggers*/

/* Trigger 1: */
/* Trigger 2: */

/* Trigger 3: Não aplicar desconto em compras abaixo de valor R$ 5000,00*/
delimiter $
CREATE TRIGGER tr_fornecedor_desconto BEFORE UPDATE ON compra
FOR EACH ROW
BEGIN
DECLARE msg varchar(255);
DECLARE valorUnitario numeric(9,2);
DECLARE quantidadeVenda numeric(9,2);
DECLARE valorVenda numeric(9,2);
DECLARE valorDesconto numeric(9,2);
DECLARE erro CONDITION FOR SQLSTATE '45000';

SET valorUnitario = (SELECT valor_unit from compra_item c where c.cod_compra = new.cod_compra);
SET quantidadeVenda = (SELECT qtd_compra from compra_item c where c.cod_compra = new.cod_compra);
	if (new.valor_total < 5000.00) THEN
		SET valorVenda = (valorUnitario * quantidadeVenda);
		if(valorVenda <> new.valor_total)THEN
				SIGNAL erro
				SET MESSAGE_TEXT = 'Não é possivel aplicar desconto em uma compra inferior a R$ 5000,00!';
			if(valorVenda = new.valor_total) then
				UPDATE compra SET valor_total = new.valor_total WHERE cod_compra = new.cod_compra;
end if;
end if;
end if;
END $
delimiter ;

drop trigger tr_fornecedor_desconto;

UPDATE compra SET valor_total = 4999 WHERE cod_compra = 9;

/* Trigger 4: */


