use sakila;
show tables;
select * from payment;

-- multi row and subquery ke aanader kabhi bhi = operator ka use nhi kar sakte h 

select * from payment where amount =
 (select amount from payment where payment_id = 3 or payment_id = 2);
 
select * from payment where amount not in 
(select amount from payment where payment_id = 3 or payment_id=2);


select * from payment where amount >= any
 (select amount from payment where payment_id = 3 or payment_id=2);
 
 select * from payment where amount <  any
 (select amount from payment where payment_id = 3 or payment_id=2);
 -- 
 select * from payment where amount > all
 (select amount from payment where payment_id = 3 or payment_id=2);
 -- 0.99 se bhi chota 
 select * from payment where amount < all
 (select amount from payment where payment_id = 3 or payment_id=2);
 -- 0.99 and usse bhi chota 
  select * from payment where amount <= all
 (select amount from payment where payment_id = 3 or payment_id=2);
 
 -- get all tha payment info where the month of payment should be same as of the month id paymenet 2 or 3
 -- get all the paymnet info whose amount is larger then amount all the amount from the payment id 2 to 8
 
select * from payment where month(payment_date) in
(select month(payment_date) from payment where payment_id = 3 or payment_id=2);

select * from payment where amount >= all 
(select amount from payment where payment_id between 2 and  8);

-- co realed subquery :- a co realed sub. is a subquery its depends on outer subquery
-- it is execute repeatativly based on the value on the outerquery
select dept ,avg(salary) from employee group by dept; 

-- function
-- block of code => code reusable and readable
-- pre-defined and user defined
-- pre-defined => scaler function --> applied for each row and result will be given for each row
-- string(character) ,number,data related function

-- string related function 

select * from actor;
select first_name , lower(first_name) ,last_name from actor; -- lower function
select first_name , upper(first_name) ,last_name from actor; -- upperfunction

select first_name , last_name ,concat(first_name ,last_name) from actor; -- concat function 
select * from actor where concat(first_name,last_name) = 'EDCHASE'; -- concat with whare caluse

select * from actor where concat(first_name,last_name) like '%a'; -- with like operator
select * from actor where concat(first_name,last_name) like '%a%a%'; 

select first_name , last_name ,concat_ws('-','MR',first_name,last_name) from actor; -- concat_ws(join with Separator)

-- substring=> extract kuch protion ko(extract data basic of position)
select first_name , last_name, substr(last_name,2) from actor;  -- starting(positive)
select first_name , last_name, substr(last_name,-4) from actor;  -- sebstring(negative)
select first_name , last_name, substr(last_name,2,4) from actor;  
select first_name , last_name, substr(last_name,-3,2) from actor; 

-- practice-Question 
select first_name from actor where first_name like 'A%' or first_name like 'E%';
select *,substr(first_name,1,1) from actor where substr(first_name,1,1)='A' or substr(first_name,1,1)='E';

-- replace function 
select first_name ,replace(first_name , 'A' , '@') from actor;

-- trim(select value) => only for testing purpose
select char_length('abhi   ');
select char_length(trim('abhi  '));
select char_length(trim('    abhi'));

select char_length(trim('ab    hi'));

-- naman (here trim will remove character a from the values
select trim(both 'a' from 'aaaaanaman');

-- apply on a column
select first_name ,trim(both 'E' from first_name) from actor;


-- lpad /rpad(left padding / right padding)
select lpad('10234','6','0');

 -- number function => round
 select 14.68 ,round(89.2,-2);
 select 157.89,round(157.89,-2);
 
 -- truncate function 
 select round(14.685,2) , truncate(14.685,2);
 
 -- floor function / ceil function 
 select floor(5.9999999),ceil(6.0000000001);
 
 
 
 













