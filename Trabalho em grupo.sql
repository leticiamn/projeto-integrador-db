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


/* B)*/
/* Procedimento 1: */
/* Procedimento 2: */
/* Procedimento 3: */
/* Procedimento 4: */

/* C)*/
/* Procedimento 1: */
/* Procedimento 2: */
/* Procedimento 3: */
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
/* Trigger 3: */
/* Trigger 4: */


