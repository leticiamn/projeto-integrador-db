use uberbeer;

/* 1 - Criação de procedimentos*/

/* A)*/
/* Procedimento 1: utilizado para inserir ou alterar dos dados do cliente - Arthur*/

delimiter $
create procedure updateClient(var_cpf char(11), var_nome varchar(50), var_endereco varchar(255), var_email varchar(255), var_data_nasc date, var_login varchar(50), var_senha varchar(50), auxiliar int)
begin
update cliente set cpf = var_cpf, nome = var_nome, endereco = var_endereco, email = var_email, data_nasc = var_data_nasc, login = var_login, senha = var_senha
where cod_cliente = auxiliar;
end $
delimiter $

delimiter $
create procedure insertClient(var_cpf char(11), var_nome varchar(50), var_endereco varchar(255), var_email varchar(255), var_data_nasc date, var_login varchar(50), var_senha varchar(50))
begin
declare auxiliar int;
set auxiliar = (select cod_cliente from cliente where cpf = var_cpf);
if(var_cpf is null) then
select "Favor, inserir o cpf.";
else if(var_nome is null) then
select "Favor, inserir o nome.";
else if(var_endereco is null) then
select "Favor, inserir o endereço.";
else if(var_email is null) then
select "Favor, inserir o e-mail.";
else if(var_data_nasc is null) then
select "Favor, inserir a data de nascimento.";
else if(var_login is null) then
select "Favor, inserir o login.";
else if(var_senha is null) then
select "Favor, inserir a senha.";
else if((select cod_cliente from cliente where cpf = var_cpf) is not null) then
call updateClient(var_cpf, var_nome, var_endereco, var_email, var_data_nasc, var_login, var_senha, auxiliar);
else
insert into cliente(cpf, nome, endereco, email, data_nasc, login, senha)
values(var_cpf, var_nome, var_endereco, var_email, var_data_nasc, var_login, var_senha);
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end $
delimiter $

call insertClient("36550432600", "Joana Mariana Rodrigues", "Rua dos bobos, 0", "joanamarcelarodrigues@mailinator.com", '1975-02-13', "joanamarcelarodrigues@mailinator", "318098714");

select * from cliente;

/* Procedimento 2: utilizado para inserir ou alterar os dados do pedido- Leticia*/
DELIMITER $
create procedure insert_alter_pedido (var_cod_pedido int, var_data_pedido date, var_valor_total decimal(7,2), var_cod_cliente int)
begin
    if var_cod_pedido is null then 
        if var_data_pedido is null then select "Favor, inserir data válida" as msg;
        else if var_valor_total is null then select "Favor, inserir valor total" as msg;
        else if var_cod_cliente is null then select "Favor, inserir código do cliente válido" as msg;
        else insert into pedido(data_pedido, valor_total, cod_cliente) values (var_data_pedido, var_valor_total, var_cod_cliente);
        end if;
        end if;
        end if;
    else update pedido set data_pedido = var_data_pedido, valor_total = var_valor_total, cod_cliente = var_cod_cliente
            where cod_pedido = var_cod_pedido;
    end if;
end
$
Delimiter ;

#insert
call insert_alter_pedido(null, current_date(),300,5);

#update
call insert_alter_pedido(6, current_date(),300,4);

select * from pedido;


/* Procedimento 3: utilizado para inserir ou alterar dos dados do produto - Patricia*/

delimiter $
create procedure sp_insere_pedido(data_pedido date,
valor_total numeric(7,2), cod_cliente int)
begin
if (data_pedido is null) then
select 'Você deve informar uma data válida!' as msg;
else
if(valor_total is null) then
select 'Você deve informar o valor!' as msg;
else 
if(cod_cliente is null) then
select 'Você deve informar o código do cliente!' as msg;
else 
insert into pedido(data_pedido, valor_total, cod_cliente) values
(data_pedido, valor_total, cod_cliente);
end if;
end if;
end if;
end $
delimiter ;

call sp_insere_pedido('2022-05-04', 279.30, 6);

/* Procedimento 4: utilizado para inserir ou alterar dos dados do fornecedor - Solange*/
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
/* Procedimento 1: Arthur*/

delimiter $
create procedure calculaProjecaoProdutoAno(nomeProj varchar(50), anoProj date)
begin
declare qtdVendasRealizadas int;
declare qtdDiasTrabalhados int;
declare qtdDiasProjetados int;
declare projecaoVendas int;
declare projecaoVendasTotal int;
set qtdVendasRealizadas = (select sum(vi.qtd_pedido) from venda_item vi 
inner join produto p on p.cod_produto = vi.cod_produto
inner join pedido pe on pe.cod_pedido = vi.cod_pedido
where p.nome = nomeproj
group by nome);
set qtdDiasTrabalhados = timestampdiff(day, '2022-01-01', CURRENT_TIMESTAMP);
set qtdDiasProjetados = timestampdiff(day, anoProj, CURRENT_TIMESTAMP);
	if(nomeProj is null and anoProj is null) then
		select 'Informe o nome do produto e ano a ser projetado.' as msg;
    else
    set projecaoVendas = ((qtdVendasRealizadas/qtdDiasTrabalhados)*qtdDiasProjetados)*-1;
    set projecaoVendasTotal = projecaoVendas + qtdVendasRealizadas;
    
    select nomeProj NomeProduto, qtdVendasRealizadas Vendas_atuais,  projecaoVendasTotal
    from produto group by NomeProduto;
end if;
end $
delimiter ;


call calculaProjecaoProdutoAno("Witbier Baden", '2022-12-31');

/* Procedimento 2:  Relatório para verificar quantidade em estoque de determinado produto - Patricia*/

delimiter $
create procedure verificaQuantidadeEmEstoque(var_nome varchar(50))
begin
	declare estoque int;
    set estoque = (select qtd_estoque from Produto where nome = var_nome);
    if(estoque > 10 AND estoque < 50) then
		select concat('Estoque baixo: ', estoque) as msg;
	else if(estoque < 10) then
		select concat('Estoque crítico: ', estoque)as msg;
	else if(estoque = 0) then
		select 'Sem estoque!' as msg;
	else 
		select concat('Estoque OK: ', estoque) as msg;
end if;
end if;
end if;
end $
delimiter ;

call verificaQuantidadeEmEstoque("Capunga Pet Growler Ipa Cumade Florzinha");

/* Procedimento 3: Relatorio com dados dos fornecedores que realizaram vendas no ano de ???? superior a R$ ?? Solange*/
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

/* Procedimento 4: Relatório com quantidade de vendas por dia em um determinado mês - Leticia*/
delimiter $
create procedure relatorio_vendas_diarias(var_ano int, var_mes int)
begin
if(var_ano IS NULL or var_mes IS NULL) then
select 'Você precisa informar o ano e o mês do relatório a ser extraído!' as msg;
else
select data_pedido, sum(valor_total)
from pedido
where month(data_pedido) = var_mes
and year(data_pedido) = var_ano
group by data_pedido;
end if;
end $
delimiter ;


call relatorio_vendas_diarias('2022', '05');

/* C)*/
/* Procedimento 1: Arthur */

DELIMITER $
create procedure sp_consultaRelatorio_top3Produtos()
begin
select p.nome nome, count(vi.qtd_pedido) qtd_pedidos, sum(vi.qtd_pedido) qtd_vendida
from venda_item vi 
inner join produto p on p.cod_produto = vi.cod_produto
inner join pedido pe on pe.cod_pedido = vi.cod_pedido
group by qtd_vendida, qtd_pedidos
order by qtd_pedidos, qtd_vendida desc
limit 3;
end
$
Delimiter ;

call sp_consultaRelatorio_top3Produtos();

/* Procedimento 2: Descrição: Somatória de pedidos feitos pelo cliente x no ano x - Patricia*/

delimiter $
create procedure sp_consultaTotalPedidosDoClientePorAno(nome varchar(255), ano_pedido numeric(4))
begin
	select c.nome nome_cliente, count(p.cod_pedido) quantidade_pedidos
    from Cliente c
    inner join Pedido p on p.cod_cliente = c.cod_cliente
    where c.nome = nome
    and year(p.data_pedido) = ano_pedido;
end $
delimiter ;

call sp_consultaTotalPedidosDoClientePorAno('Sebastião Hugo Henry Pereira', 2022);

/* Procedimento 3: Somatoria das compras de produtos dos fornecedores no ano de ???? Solange*/

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


/* Procedimento 4: Relatório com quantidade de produtos vendidos por dia em um determinado mês - Leticia*/
delimiter $
create procedure relatorio_produtos_vendidos_diario(var_ano int, var_mes int)
begin
if(var_ano IS NULL or var_mes IS NULL) then
select 'Você precisa informar o ano e o mês do relatório a ser extraído!' as msg;
else
select p.data_pedido, sum(vi.qtd_pedido) 'quantidade vendida', pr.nome
from pedido p
inner join venda_item vi on vi.cod_pedido = p.cod_pedido
inner join produto pr on pr.cod_produto = vi.cod_produto
where month(p.data_pedido) = var_mes
and year(p.data_pedido) = var_ano
group by p.data_pedido;
end if;
end $
delimiter ;

call relatorio_produtos_vendidos_diario('2022', '05');

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

/* Função 5: Recebe a quantidade do produto e retorna o valor do pedido total*/
DELIMITER |
CREATE FUNCTION fn_valor_total(var_valor_item decimal(7,2), var_qtd_pedido int)
RETURNS decimal(7,2)
DETERMINISTIC
BEGIN
DECLARE valor_total varchar(12);
DECLARE erro CONDITION FOR SQLSTATE '45000';
if(var_valor_item is null or var_qtd_pedido is null)
then
	SIGNAL erro
	SET MESSAGE_TEXT = 'Valor e quantidade do item não pode ser nulo!';
else
	SET valor_total = (var_valor_item * var_qtd_pedido); 
end if;
RETURN valor_total;
END |
Delimiter ;

select fn_valor_total(2,10) AS ValorTotal;


/* 3 - Criação de triggers*/

/* Trigger 1: - Arthutr */
delimiter $
create trigger validaEstoque before update on produto
for each row
begin
declare estoqueAtual int;
declare nuevoEstoqueAtual int;
DECLARE erro CONDITION FOR SQLSTATE '45000';
set estoqueAtual = (select qtd_estoque from Produto where cod_produto = new.cod_produto);
	if(estoqueAtual >= 100) then
		SIGNAL erro
				SET MESSAGE_TEXT = 'Não é possivel adicionar mais produtos.';
			else
				set nuevoEstoqueAtual = new.qtd_estoque + estoqueAtual;
                set new.qtd_estoque = nuevoEstoqueAtual;
end if;
end $
delimiter ;

drop trigger validaEstoque;
drop function verificaQuantidadeEmEstoque1;

update produto set qtd_estoque = 10 where cod_produto = 2;

select * from produto;

/* Trigger 2: Não aplicar desconto em compras abaixo de valor R$ 5000,00*/
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

/* Trigger 3: Verifica se a quantidade de itens em estoque é menor do que a quantidade desejada no pedido - Patrícia */
delimiter $
CREATE TRIGGER tr_valida_estoque_pedido BEFORE insert on venda_item
FOR EACH ROW
BEGIN
DECLARE msg varchar(255);
DECLARE quantidadePedido int;
DECLARE quantidadeEstoque int;
DECLARE erro CONDITION FOR SQLSTATE '45000';

SET quantidadeEstoque = (SELECT qtd_estoque from produto p where p.cod_produto = new.cod_produto);
SET quantidadePedido = new.qtd_pedido;
	if (quantidadePedido > quantidadeEstoque) THEN
				SIGNAL erro
				SET MESSAGE_TEXT = 'Estoque insuficiente para realizar pedido.';
end if;
END $
delimiter ;

drop trigger tr_valida_estoque_pedido;

INSERT INTO venda_item (
    cod_produto,
    cod_pedido,
    qtd_pedido,
    valor_item)
 VALUES(1, 8, 100, 9.90);
    
SELECT * from produto;
SELECT * from venda_item;

/* Trigger 4: Aplicar desconto no mês de aniversário do cliente - Letícia*/
delimiter $
CREATE TRIGGER tr_desconto_aniversario BEFORE insert ON pedido
FOR EACH ROW
BEGIN
DECLARE aniversario date;
SET aniversario = (select c.data_nasc from cliente c where c.cod_cliente = new.cod_cliente);
if(month(aniversario) = month(new.data_pedido)) then 
	set new.valor_total = (new.valor_total*0.9);
end if;
END $
delimiter ;

insert into pedido(data_pedido, valor_total, cod_cliente) values ('2022-04-01',100,5);
select * from pedido;
