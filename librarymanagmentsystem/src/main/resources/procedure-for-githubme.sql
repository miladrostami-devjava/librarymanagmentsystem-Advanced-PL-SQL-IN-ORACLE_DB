/*
Scenario: Calculation of the final cost of purchasing goods
In this scenario, we have the following:

The original price of the product:
the price of each product without considering taxes and discounts.
Number of goods:
 the number of goods purchased.
Discount percentage:
 The percentage that should be deducted from the total price as a discount.
Tax percentage:
The percentage that should be added to the total price as tax.
Calculation:
The final cost of the purchase is calculated as follows:

Calculation of the total price without discount:
 total price = original price of goods x number of goods.
Apply discount:
price after discount = total price - (total price x discount percentage).
Tax application:
 final cost = price after discount + (price after discount x tax percentage).
 */


-- proceduce :

create or replace procedure calculateFinalPriceProc(
base_price in number,
quantity in number,
discount_percent in  number,
tax_percent in number,
final_price  out number ) as
total_price number;
price_after_discount number;

begin
  total_price := quantity * base_price;
  price_after_discount := total_price - (total_price * discount_percent/100);
  final_price := price_after_discount + (price_after_discount * tax_percent/100);
end calculateFinalPriceProc;

-- test procedure

declare
base_price_product number := 1000;
quantity_product number := 200;
discount_percent number := 4;
tax_percent number := 9;
final_price_product number;
begin
 calculateFinalPriceProc(
 base_price => base_price_product,
 quantity => quantity_product,
 tax_percent => tax_percent,
 discount_percent => discount_percent
 final_price => final_price_product);

 dbms_output.put_line('the final price  for procedure is : ' || ' ' || final_price);

end;
/


-- function :

create or replace function calculateFinalPriceFunc(
base_price in number,
quantity in number,
discount_percent in  number,
tax_percent in number
) return number as
total_price number;
price_after_discount number;
final_price number;
begin
total_price := base_count * quantity ;
 price_after_discount := total_price - (total_price*discount_percent/100);
 final_price := price_after_discount + (price_after_discount* tax_percent/100);
return final_price;
end calculateFinalPriceFunc;
/

-- test function :
declare
base_price_product number := 1000;
quantity_product number := 200;
discount_percent number := 4;
tax_percent number := 9;
final_price number;

begin
  final_price := calculateFinalPriceFunc(
  base_price => base_price_product,
  quantity => quantity_product ,
  discount_percent => discount_percent,
  tax_percent => tax_percent
  );

 dbms_output.put_line('the final price for function is : ' || ' ' || final_price);

end;
/
