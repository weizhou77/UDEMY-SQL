-- select all columns from film table
select * from film;

-- select film_id and title from film table
select film_id, title from film;

-- Challenges:
-- situation: we want to send out a promotianal email to our existing customers!
-- we need to know the first and last name of the customer and then their actual emails
select * from customer;
select first_name, last_name, email from customer;


-- SELECT DISTINCT
-- only want to list the unique/distinct values
select * from film;

select distinct release_year from film;
--same as
select distinct(release_year) from film;

--how many unique rental rate do we have
select distinct rental_rate from film;

-- challenge:
-- situation: an Australian visitor is not familiar withthe movie ratings
-- we want to know the types of ratings we have in our database
-- what ratings do we have available
select distinct rating from film;

-- COUNT:
-- returns the number of input rows that match a specific condition of a query
select count(*) from film;
select count(rating) from film;

-- count how many unique ratings in the table.
select count(distinct(rating)) from film;

select * from payment;
select count(*) from payment;

-- show the amount column from payment table
select amount from payment;
-- shwo the unique value of amount from payment table
select distinct amount from payment;
-- count how many unique value of amount in payment table
select count(distinct(amount)) from payment;

-- SELECT WHERE:
-- WHERE statement allows us to specify conditions on columns for the rows to be returned
-- SELECT column1, column2 FROM table WHERE conditions;
select * from customer
where first_name = 'Jared';

select * from film;
select * from film 
where rental_rate > 4 and replacement_cost >= 19.99 
and rating = 'R';

select title from film 
where rental_rate > 4 and replacement_cost >= 19.99 and rating = 'R';

-- count how many rows that satisfis the conditions
select count(title) from film 
where rental_rate > 4 and replacement_cost >= 19.99 and rating = 'R';

-- OR operator
select count(*) from film 
where rating = 'R' or rating = 'PG-13';

-- != not equal operator
select * from film
where rating != 'R';

-- Challenge
-- #1 A customer forgot their wallet at out store, we need to track down their email to inform them
-- what is the email for the customer with the name Nancy Thomas
select * from customer;
select email from customer where first_name = 'Nancy' and last_name = 'Thomas';

-- #2 a customer wanrs to know what the movie 'Outlaw Hanky' is about
-- could you give them the description for the movie 'outlaw hanky'
select * from film;
select title,description from film where title ='Outlaw Hanky';

-- #3 a customer is late on their movie return and we have emailed them a letter to their address at '259 Ipoh Drive', we should also call them on the phone to let them know
-- can you get the phone number for the customer who lives at 259 Ipoh Drive
select * from address;
select phone from address where address = '259 Ipoh Drive';

-- ORDER BY
-- you can use ORDER BY to sort rows based on a column valuem in either ascending or descending order
-- SELECT column_1, column_2 FROM table ORDER BY column_1 ASC(orDEC);
-- we can also ORDER BY 2 columns, incase the first order column has duplicate rows.
select * from customer;
select * from customer 
order by first_name DESC;

select store_id, first_name, last_name from customer 
order by store_id DESC, first_name ASC;

-- LIMIT 
-- limit the number of rows returned for a query
-- useful for not wanting to return every single row in a table but only view the top few rows to get an idea of the table layout
-- also useful in combinaton with order by
-- always the last command to be executed
select * from payment limit 1;
select * from payment
where amount != 0.00
order by payment_date DESC
limit 5;

-- Challenge
-- we want to reward our first 10 paying customers
-- what customer ids of the first 10 customers who created a payment
select * from payment limit 1;
select customer_id from payment
order by payment_date ASC
limit 10;

--  a customer wants to quickly rent a video to watch over their short lunch break
-- what are the titles of the 5 shortest in length of runtime movies?
select * from film;
select title, length from film
order by length ASC
limit 5;

-- since all 5 movie lengths are 46, not sure if there are more movies that are 46 mins length so
select title, length from film
where length = 46
order by title;

-- if the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have?
select title, length from film
where length <= 50
order by length, title;

select count(*) from film
where length <= 50;

-- BETWEEN
-- use to match a value against a range of values: value BETWEEN low AND high = value >= low AND value <= high
-- can combine BETWEEN and NOT operator : value NOT BETWEEN low AND high = value < low or value > high
-- can be used with dates: date BETWEEN '2007-01-01' and '2007-02-01'
select * from payment limit 2;

-- payments between 8 and 9 dollars
select * from payment 
where amount between 8 and 9
order by amount;
select count(*) from payment where amount between 8 and 9;

--payment not between 8 and 9 dollars
select * from payment 
where amount not between 8 and 9
order by amount;
select count(*) from payment 
where amount not between 8 and 9;

select * from payment
where payment_date between '2007-02-01' and '2007-02-15' --will not show 02-15 date, will only show til 02-14
order by payment_date;

-- IN
-- value IN(option1,option2,...,option_n)
-- ex: SELECT color FROM table WHERE color IN('red','blue');
select * from payment limit 2;
select distinct(amount) from payment
order by amount;

-- show all the orders that are 0.99,1.98,1.99
select * from payment
where amount in(0.99,1.98,1.99)
order by amount;

--show all the orders that are not
select * from payment 
where amount not in (0.99,1.98,1.99)
order by amount;

select * from customer;
select * from customer
where first_name in('John','Jake','Julie');

--LIKE
-- allows us to perform pattern matching against string data with the use of wildcard characters:
-- percent % : mathces any sequence of characters. EX: WHERE name LIKE 'A%' = all names that begin with an 'A' or WHERE name LIKE '%a' = all name ends with an 'a'
-- underscore _ : matches any single character EX: imagine we had version string codes in the format 'Version#A4', Version#B7... WHERE value LIKE 'Version#A_' to find all the A version. 
-- combine %_ example: WHERE name LIKE '_her%' : Cheryl, Theresa, Sherri..., One character before her and any characters after it. 
select * from customer
where first_name like 'J%' and last_name like 'S%';
-- LIKE is case sensitive J!=j, ILIKE is not case sensitive J=j
select * from customer
where first_name ilike 'j%' and last_name ilike 's%';

select * from customer
where first_name like '%er%';

select * from customer
where first_name like '_her%';

select * from customer
where first_name not like 'A%' and last_name not like 'B%'
order by last_name;

-- General Challenge
-- how many payment transactions were greater than $5.00
select * from payment;
select count(*) from payment
where amount > 5.00;

-- how many actors have a first name that starts with the letter P
select * from actor;
select count(*) from actor
where first_name like 'P%';

-- how many unique dirtricts are our customer from?
select * from address;
select count(distinct district) from address;

-- retrieve the list of names for those distinct districts from the previous question
select distinct district from address;

-- how many films have a rating of R and a replacement cost between $5 and $15
select * from film;
select count(*) from film
where rating = 'R' and replacement_cost between 5 and 15;

-- how many films have the word Truman somewhere in the the title
select * from film;
select count(*) from film
where title like '%Truman%';

-- GROUP BY
-- allow us to aggregate data and applu functions to better understand how data is distributed per caregory
-- AVG()-returns average value, floating point value, can use ROUND() to specify precision after the decimal.
-- COUNT()-returns number of values
-- MAX()-returns maximum value
-- MIN()-returns minimum value
-- SUM()-returns the sum of all values

select * from film;
select min(replacement_cost) from film;
select max(replacement_cost) from film;
select max(replacement_cost), min(replacement_cost) from film;
select avg(replacement_cost) from film;
select round(avg(replacement_cost),2) from film;
select sum(replacement_cost) from film;

-- GROUP BY
-- choose categorical column(non continuous) to do GROUP BY
-- SELECT category_col, min/max/avg/sum...(data_col) FROM table GROUP BY category_col
-- the columns that are not data_col, they must appear after GROUP BY 
-- EX: SELECT company, division, sum(sales) FROM finance_table GROUP BY company, division
-- EX: SELECT company, division, sum(sales) FROM finance_table WHERE division IN('marketing','transport') GROUP BY company, division
-- EX: SELECT company, sum(sales) FROM finance_table GROUP BY company ORDER BY sum(sales)

select * from payment;
-- group the custimer id
select customer_id from payment
group by customer_id
order by customer_id;

-- what customer is spending the most
select customer_id, sum(amount) from payment
group by customer_id
order by sum(amount) DESC;

select customer_id, count(amount) from payment
group by customer_id
order by count(amount) DESC;

select customer_id, staff_id, sum(amount) from payment
group by staff_id, customer_id
order by customer_id, staff_id;

-- group by the payment_date
select date(payment_date) from payment;
select date(payment_date), sum(amount) from payment
group by date(payment_date)
order by sum(amount) DESC;

-- Challenge
-- #1 we have two staff members id 1 and 2. we want to give a bonus to the staff member that handled the most payments. how many payments did each staff member handle and who gets the bonus
select * from payment;
select staff_id, count(payment_id) from payment
group by staff_id
order by count(payment_id) DESC;

-- #2 HQ company is conducting a study on the relationship between replacement cost and a movie MPAA rating
-- what is the average replacement cost per MPAA rating
select * from film;
select rating, round(avg(replacement_cost), 2) from film
group by rating
order by round(avg(replacement_cost), 2);

-- #3 we are running a promotion to reward our top 5 customers with coupons
-- what are the customer ids of the top five customers by total spend
select * from payment;
select customer_id, sum(amount) from payment
group by customer_id
order by sum(amount) DESC
limit 5;

-------------------------
--HAVING
-- allows us to filter after an aggregation has already taken place
-- EX: SELECT company, SUM(sales) FROM finance_table WHERE company != 'Google' GROUP BY company HAVING SUM(sales)>1000

select * from payment;
select customer_id, sum(amount) from payment
where customer_id not in (184,84,477)
group by customer_id
having sum(amount) >100
order by sum(amount) DESC;


select store_id, count(*) from customer
group by store_id
having count(*) > 300;

-- Challenge
-- #1 we are launching a platnum service for our most loyal customer. we will assign platinum status to customers that have had 40 or more transaction payments
-- what customer_ids are eligible for platinum status
select * from payment;
select customer_id, count(payment_id) from payment
group by customer_id
having count(payment_id) >= 40
order by count(payment_id) DESC;

-- #2 what are the customer ids of customers who have spent more than $100 in payment transactions with our staff_id member 2
select * from payment;
select staff_id, customer_id, sum(amount) from payment
where staff_id = 2
group by staff_id, customer_id
having sum(amount) >= 100
order by sum(amount) DESC;

select customer_id, sum(amount) from payment
where staff_id = 2
group by customer_id
having sum(amount) >= 100
order by sum(amount) DESC;

--- Assessment test 1
-- #1 return the customer ids of customer who have at least $110 with staff member who has an id of 2
select customer_id, sum(amount) from payment
where staff_id = 2
group by customer_id
having sum(amount) > 110
order by sum(amount) DESC;

-- #2 how many films begin with the letter J
select count(*) from film 
where title like 'J%';

-- #3 what customer has the highest customer ID number whose name starts with an E and has an address ID lower than 500
select * from customer;
select first_name, last_name from customer
where first_name like 'E%' and address_id < 500
order by customer_id DESC
limit 1;

-------------------------
--JOINS
-- INNER JOINS, OUTER JOINS, FULL JOINS, UNIONS

--- AS 
-- lets us to create an alias for a column or result
-- EX: select column AS new_name from table
-- EX: select sum(column) as new_name from table
-- the new_name is only for the output column name
select count(amount) from payment;
select count(amount) as num_transactions from payment;

select customer_id, sum(amount) as total_spent from payment
group by customer_id
having sum(amount) > 100
order by sum(amount);--still need to use sum(amount) instead of total_spent

--------------
-- INNER JOINS
-- will result with the set of records that match in both tables
select * from payment;
select * from customer;

select * from payment
inner join customer
on payment.customer_id = customer.customer_id;

select payment_id, payment.customer_id, first_name from payment --inner join, the order of payment and customer do not matter.
inner join customer
on payment.customer_id = customer.customer_id;

----------------
-- full outer join
-- allows us to specify how to deal with values only present in one of the tavles being joined.

-- everything from customer table and everything from payment table
select * from customer
full outer join payment
on customer.customer_id = payment.customer_id;

-- we fully join the customer and payment table, then filter it for rows that are only unique to the customer table or only unique to the payment table.
-- the result is 0 rows which means we dont have any customer information who has never mad a payment and we dont have a customer that has made payments and we dont have his or her information
select * from customer
full outer join payment
on customer.customer_id = payment.customer_id
where customer.customer_id is null or payment.payment_id is null;

select count(distinct customer_id) from payment;
select count(distinct customer_id) from customer;


-----------------
-- LEFT OUTER JOIN same as left join
-- results in the set of records that are in the left table, if there is no match with the right table, the results are null
-- table order matters
select * from film;
select * from inventory;
--movies that are not inventory, out of stock;
select film.film_id, title, inventory_id, store_id from film
left join inventory 
on inventory.film_id = film.film_id
where inventory.film_id is null;

-------------------
-- right join, same as left join, just different table order

-----------------------
-- unions 
-- used to combine the result-set of two or more select statements
-- basically serves to directly concatenate two results together, essentially pasting them together
-- SELECT column_name(s) FROM table1 UNION SELECT column_name(s) FROM table2;

-- Challenge
-- #1 California sales tax laws have changed and we need to alert our customers to this through email
-- what are the emails of the customers who live in california
select * from customer;
select * from address;
select district, email from customer
inner join address on
customer.address_id = address.address_id
where district = 'California';

--#2 A customer walks in and is a huge fan of the actor "Nick Wahlberg" and wants to know which mivies he is in
-- get a list of all the movies 'Nick Wahlberg' has been in
select * from actor;
select * from film_actor;
select * from film;
select title, first_name, last_name from film
inner join film_actor 
on film.film_id = film_actor.film_id
inner join actor 
on actor.actor_id = film_actor.actor_id
where actor.first_name = 'Nick' and actor.last_name = 'Wahlberg';

------------------
-- Advance SQL Commands:
-- Timestamps and EXTRACT
-- Math Functions
-- String Functions
-- Sub-query
-- Self-Join

-----------------
-- Timestamps and EXTRACT
-- more useful when creating our own tables and databases
-- Time - Contains only time
-- DATE - contains only date
-- TIMESTAMP - contains date and time
-- TIMESTAMPTZ - contains date, time and timezone

-- current timezone
show timezone;
select now();
select timeofday();
select current_time;
select current_date;

-- EXTRACT
-- EXTRACT():
-- allow you to extract or obtain a sub-component of a date value : YEAR,MONTH,DAY,WEEK,QUARTER
-- EXTRACT(YEAR FROM date_col)

-- AGE():
-- calculates and returns the current age given a timestamp
-- AGE(date_col)
-- returns: 13 years 1 mon 5 days 01:34:13.003423

-- TO_CHAR():
-- convert data types to text
-- useful for timestamp formatting
-- TO_CHAR(date_col,'mm-dd-yyyy')

select * from payment;

select extract(year from payment_date) as pay_year from payment;
select extract(quarter from payment_date) as pay_quarter from payment;
select extract(dow from payment_date) as day_of_week from payment;

select age(payment_date) from payment;

select to_char(payment_date, 'month-yyyy') from payment;-- check sql data format type
select to_char(payment_date, 'day - mm dd yyyy') from payment;

-- Challenge
-- #1 during which months did payments occur
-- format your answer to return back the full month name
select distinct to_char(payment_date, 'Month') from payment;

-- #2 how many payments occured on a monday?
select to_char(payment_date, 'day') from payment;
select count(*) from payment
where extract(dow from payment_date) = 1;

---------------
-- Mathmatical Functions
-- check the mathematical functions and operators document page on website on sql
select * from film;

-- % for rental rate to replacement cost
select round(rental_rate/replacement_cost,4)*100 as percent_cost from film;

select 0.1 * replacement_cost as deposit from film;

----------------
-- String Functions and Operations
-- allow us to edit combine and alter text data columns
-- check for string functions and operations document page on sql website
select * from customer;
select length(first_name) from customer;

-- concatenation
select upper(first_name) || ' ' || upper(last_name) as full_name from customer;
select * from customer;

select lower(left(first_name,1))||lower(last_name)||'@gmail.com' as customer_email from customer;
-- left('abcd',2) = ab

---------------
--Subquery
-- allows you to construct complex queries, essentially performing a query on the results of another query
-- the syntax is straightforward and involves two select statements
-- EX: SELECT student, grade FROM test_scores WHERE grade > (SELECT AVG(grade) FROM test_scores)
-- sql will run subquery which is (SELECT AVG(grade) FROM test_scores) first because its inside ()

-- subquery can operate on a separate table
-- SELECT student, grade FROM test_scores WHERE student IN (SELECT student FROM honor_roll_table);

---------------
--EXISTS()
-- used to test for existence of rows in a subquery
-- typically a subquert is passed in the EXISTS() function to check if any rows are returned with the subquery
-- SELECT col_name FROM table_name WHERE EXISTS (SELECT col_name FROM table_name WHERE condition);

select * from film;

-- film that has rental rate that is higher than the average rental rate
select title, rental_rate from film
where rental_rate > (select avg(rental_rate) from film);

-- use join and subquery
select * from rental;
select * from inventory;

select * from rental
where return_date between '2005-05-29' and '2005-05-30';

-- film id and title of the movie that are return between 05-28 and 05-29
-- we do the subquery first
select film_id, title from film
where film_id in
(select inventory.film_id from rental
inner join inventory 
on inventory.inventory_id = rental.inventory_id
where return_date between '2005-05-29' and '2005-05-30')
order by title;


-- find customer who has at least one payment that is not greater than $11
select first_name, last_name from customer as c
where not EXISTS(select * from payment as p 
			where p.customer_id = c.customer_id
			and amount > 11);
			
--------------
-- self-join
-- a quert in which a table is joined to itself
-- self-joins are useful for comparing values in a column of rows within same table
-- SELECT tableA.col, tableB.col FROM table AS tableA JOIN table as tableB ON tableA.some_col = tableB.other_col

-- find all the pairs of films that has the same length
select * from film;
select title, length from film
where length = 117;

select f1.title, f2.title, f1.length from film as f1
inner join film as f2
on f1.film_id != f2.film_id and f1.length = f2.length;

-----------------
-- Exercise
select * from cd.facilities;
select * from cd.bookings;
select * from cd.members;

-- you want to print out a list of all of the facilities and their cost to members. how would you retrieve a list of only facility names and costcs
select * from cd.facilities;
select name, membercost from cd.facilities;

-- how can you produce a list of facilities that charge a fee to members?
select * from cd.facilities
where membercost > 0;

-- how can you produce a list of facilities that charge a fee to members and that fee is less than 1/50th of the monthly maintainance cost?
-- return the facid, facility name, member cost and monthly maintenance of the facilities in question
select facid, name, membercost, monthlymaintenance from cd. facilities
where membercost > 0 and membercost < (monthlymaintenance/50.0);

-- how can you produce a list of all facilities with the word 'Tennis' in their name
select * from cd.facilities
where name like '%Tennis%';

-- how can you retrieve the details of facilities with ID 1 and 5, try to do it without using OR operator
select * from cd.facilities 
where facid in (1,5);

-- how can you produce a list of members who joined after the start of september 2012; return the memid, surname,firstname, and joindate
select * from cd.members;

select memid,surname,firstname,joindate from cd.members
where joindate >= '2012-09-01';

-- how can you produce an ordered list of the first surname in the members table? this list must not contain duplicates
select distinct surname from cd.members
order by surname
limit 10;

-- you'd like to get the signup date of your last member 
select joindate from cd.members
order by joindate DESC
limit 1;

select max(joindate) from cd.members;

-- produce a count of the number of facilities that have a cost to guests of 10 or more
select * from cd.members;
select * from cd.bookings;
select * from cd.facilities;
select count(*) from cd.facilities
where guestcost >= 10;

-- produce a list of the total number of slots booked per facility in the month of september 2012. produce an output able consisting of facility od and slots, sorted by the number of slots
select facid, sum(slots) from cd.bookings
where starttime between '2012-09-01' and '2012-10-01'
group by facid
order by sum(slots);

-- produce a list of facilities with more than 1000 slots booked, Produce an output table consisting of facilities id and total slots, sorter by facility id
select facid, sum(slots) from cd.bookings
group by facid
having sum(slots) > 1000
order by facid;

-- how can you produce a list of the start times for bookings for tennis courts for the date '2012-09-21'. return a list of start time and facility name pairing order by the time
select * from cd.bookings;
select * from cd.facilities;
select starttime as start,name from cd.bookings as b 
inner join cd.facilities as f
on b.facid = f.facid
where starttime >= '2012-09-21' and starttime < '2012-09-22' and name ilike '%tennis court%'
order by starttime;

-- how can you produce a list of the start times for bookings by members named 'Davis Farrell'
select * from cd.bookings;
select * from cd.members;
select starttime, firstname, surname from cd.bookings as b
inner join cd.members as m
on b.memid = m.memid
where firstname = 'David' and surname = 'Farrell';

-----------------
-- Introducting to sections

------------------
-- Data Types:
-- SERIAL - CHECK this one, create 1,2,3,4,5,6......
-- Boolean - True or False
-- Character - char, varchar, and text
-- Numerica - integer and floating-point number
-- Temporal - date, time, timestamp and interval
-- UUID - universally unique identifiers
-- Array - stores an array of strings, numbers etc
-- JSON 
-- Hstore key - value pair
-- special types such as network address and geometric data
-- check postgresql.org/docs.current/datatype.html or check online for examples

-----------------------
-- Primary Keys and Foreign Keys
-- Primary Keys: a column or a group of columns used to identify a row uniquely in a table. EX in dvdrental database we saw customers had a unique non-null customer_id column as their primary key
-- primary keys are important since they allow us to easily discern what columns should be used for joining tables together
select * from customer; -- PK in customer_id column means primary key

-- Foreign keys: a field or group of fields in a table that uniquely identifies a row in another table
-- defined in a table that references to the primary key of the other table
-- the table that contains the foreign key is called referencing table or child table
-- the table to which the foreign key references is called referenced table or parent table.
-- a table can have multiple foreign keys depending on its relationships with other tables.
-- EX :  the payment table, each payment row had its unique payment_id(a primary key) and identified the customer that made the payment through the customer_id(a foreign key since it references the customer table's primary key)
select * from payment;

------------
--Constraints
-- rules enforced on data columns on table
-- used to prevent invalid data from beiung entered into the database
-- ensures the accuracy and reliability of the data in the database
-- Column Constraints : constraints the data in a column to adhere to certain conditions
-- Table Constraints : applied to the entire table rather than to an individual column

-- For Columns:
-- NOT NULL constraints - ensures that a column cannot have Null value
-- UNIQUE constraints - ensures that all values in a column are different
-- PRIMARY KEY - uniquely identifies each row/record in a database table
-- FOREIGN KEY - constrains data based on columns in other tables
-- CHECK - ensures that all values in a column satisfy certain conditions
-- EXCLUSION - ensures that if any two rows are compared on the specified column or expression using the specified operator, not all of these comparisons will return TRUE.

-- For Tables: 
-- CHECK(condition) - to check a condition when inserting or updating data
-- REFERENCES - to constrain the value stored in the column that must exist in a column in another table
-- UNIQUE(col_list) - forces the values stored in the columns listed inside the parentheses to be unique
-- PRIMARY KEY(col_list) - allows you to define the primary key that consists of multiple columns

------------------
-- Create Table 
-- CREATE TABLE table_name (
--	col_name TYPE col_constraint,
--	col_name TYPE col_constraint,
--	table_constraint table_constraint
--	) INHERITS existing_table_name;

--EX:
create table account(
	user_id serial primary key,
	username varchar(50) unique not null,
	password varchar(50) not null,
	email varchar(250) unique not null,
	created_on timestamp not null,
	last_login timestamp
);

create table job(
	job_id serial primary key,
	job_name varchar(200) unique not null
);

create table account_job(
	user_id integer references account(user_id),
	job_id integer references job(job_id),
	hire_date timestamp
);

--------------
-- INSERT
-- allows you to add in rows to a table
-- INSERT INTO table(col1, col2,...) VALUES (value1, value2,...),(value1, valu2,...),...;

-- INSERT values from another table
-- INSERT INTO table(col1,col2,...) SELECT col1, col2,... FROM another_table WHERE condition;
-- the inserted row values must match up for the table including constraints
-- serial columns do not need to be provided a value

select * from account;
insert into account(username, password, email, created_on)
values
('Jose','password','jose@mail.com',current_timestamp)

select * from job;
insert into job(job_name)
values
('Astronaut2'),
('President');

insert into account_job(user_id,job_id,hire_date)
values
(1,1,current_timestamp);
select * from account_job;

-- because the user_id and job_id on account_job table is foreign key to the account and job table
-- if we want to enter the id that the parent table(account and job tables) does not have, it will show error
insert into account_job(user_id,job_id,hire_date)
values
(10,10,current_timestamp);

-------------------
-- UPDATE
-- allows for the changing of values of the columns in a table
-- UPDATE table SET col1 = value1, col2 = values2 WHERE condition;

update account
set last_login = current_timestamp
where last_login is null;

select * from account;

update account 
set last_login = created_on;

-- Using another tables's values (UPDATE join)
--update tableA
--set original_col = tableB.new_col
--from tableB
--where tableA.id = tableB.id;

-- Return affected rows
update account
set last_login = created_on
returning user_id, last_login;

select * from account;
update account
set last_login = current_timestamp;

select * from job;
select * from account_job;

-- UPDATE join
update account_job
set hire_date = account.created_on
from account
where account_job.user_id = account.user_id;

update account
set last_login = current_timestamp
returning email, created_on,last_login;

-----------------
-- DELETE
-- remove rows from table
-- DELETE FROM table WHERE row_id = 1;

-- we can delete rows based on their presence in other tables
-- DELETE FROM tableA USING tableB WHERE tableA.id=tableB.id; DELETE join

-- delete all rows from a table
-- DELETE FROM table

select * from job;
insert into job(job_name)
values
('cowboy')
returning job_name;

delete from job
where job_name = 'cowboy' 
returning job_id, job_name; -- will show the row that we deleted;

-- ALTER table;
-- allows for changes to an existing table structure such as
-- adding, dropping or renaming columns
-- changing a column's data type
-- set DEFAULT values for a column
-- Add CHECK constraints
-- Rename table

-- adding : ALTER TABLE table_name ADD COLUMN new_col TYPE
-- removing : ALTER TABLE table_name DROP COLUMN col_name
-- alter constraints : ALTER TABLE table_name ALTER COLUMN col_name SET DEFAULT value
-- alter constraints : ALTER TABLE table_name ALTER COLUMN col_name DROP DEFAULT 
-- alter constraints : ALTER TABLE table_name ALTER COLUMN col_name SET NOT NULL ...

create table information(
	info_id serial primary key,
	title varchar(500) not null,
	person varchar(50) not null unique
);

alter table information
rename to new_info;

select * from new_info;
alter table new_info
rename column person to people;

-- alter table CompanyID_ChannelIDCount
-- alter column company_id1 set data type text;


-- since people column is not null, it will show error
insert into new_info(title)
values
('some new title');

-- alter constraints
alter table new_info
alter column people drop not null;
--now we can just add the title without adding people info
insert into new_info(title)
values
('some new title');

select * from new_info;

-----------------
-- drop table
-- allows for the complete removal of a column in a table
-- ALTER TABLE table_name DROP COLUMN col_name1, DROP COLUMN col_name2;
-- remove the dependencies as well
-- ALTER TABLE table_name DROP COLUMN col_name CASCADE;
-- check for existence to avoid error
-- ALTER TABLE table_name DROP COLUMN IF EXISTS col_name;

select * from new_info;
alter table new_info 
drop column people;

------------- CHECK Constraints
-- allows us to create more customized constraints that adhere to a certain condition
-- such as making sure all inserted integer valyes fall below a certain threshold

--CREATE TABLE example(
--	ex_id SERIAL PRIMARY KEY,
--	age SMALLINT CHECK(age>21),
--	parent_age SMALLINT CHECK (parent_age > age)
--);

create table employees(
	emp_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birthdate date check(birthdate > '1900-01-01'),
	hire_date date check(hire_date > birthdate),
	salary integer check(salary > 0)
);
-- error because it violates the birthdate check
insert into employees(
first_name,last_name,birthdate,hire_date,salary)
values
('Jose','Portilla','1899-11-03','2010-01-01',100);

insert into employees(
first_name,last_name,birthdate,hire_date,salary)
values
('Jose','Portilla','1999-11-03','2010-01-01',100);

-- violates the salary check
insert into employees(
first_name,last_name,birthdate,hire_date,salary)
values
('Sammy','Portilla','1999-11-03','2010-01-01',-100);


insert into employees(
first_name,last_name,birthdate,hire_date,salary)
values
('Sammy','Portilla','1999-11-03','2010-01-01',1100);

select * from employees;

-----------
-- Assessment Test 3

-- #1 create two new tables teachers and students
-- The students table should have columns for student_id, first_name,last_name, homeroom_number, phone,email, and graduation year.
-- The teachers table should have columns for teacher_id, first_name, last_name, homeroom_number, department, email, and phone.

create table students(
	student_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	homeroom_number integer,
	phone varchar(50) not null unique,
	email varchar(200) unique,
	graduation_year integer
);

create table teachers(
	teacher_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	homeroom_number integer,
	department varchar(100),
	email varchar(200) unique,
	phone varchar(20) unique
);


-- Once you've made the tables, insert a student named Mark Watney (student_id=1) who has a phone number of 777-555-1234 
-- and doesn't have an email. He graduates in 2035 and has 5 as a homeroom number.
insert into students(first_name, last_name, phone, graduation_year, homeroom_number)
values
('Mark','Watney','777-555-1234',2035,5);

select * from students;

-- Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number of 5 and is from the Biology department. 
-- His contact info is: jsalk@school.org and a phone number of 777-555-4321.
insert into teachers(first_name, last_name,homeroom_number, department, email, phone)
values
('Jonas', 'Salk', 5, 'Biology', 'jaslk@school.org', '777-555-4321');
select * from teachers;

-----------------
-- Conditional Expression and Procedures Introduction
-- CASE;COALESCE;NILLIF;CAST;VIEWS;IMPORT AND EXPORT FUNCTIONALITY

--------------------
-- CASE
-- we can use CASE statment to only execute SQL code when certain conditions are met
-- similar if/else statements in other programming languages
-- two mian ways: general CASE or a CASE expression
-- Both methods can lead to the same results
-- general CASE : 

--CASE 
--	WHEN condition1 THEN result1 
--	WHEN condition2 THEN result2 
--	ELSE some_other_result 
--END

create table test(a integer);
insert into test(a)
values (1),(2);


SELECT a,
CASE 
WHEN a = 1 THEN 'one'
WHEN a = 2 THEN 'two'
ELSE 'other'
END as label
FROM test;

-- CASE expression
--case expression
--	when value1 then result1
--	when value2 then result2
--	else some_other_result
--end

select a,
case a
when 1 then 'one'
when 2 then 'two'
else 'other'
end as label
from test;

-- EX
select * from customer;
select customer_id,
case 
	when (customer_id <= 100) then 'Premium'
	when (customer_id between 100 and 200) then 'Plus'
	else 'Normal'
end as customer_class
from customer;

-- raffle that customer_id 2 is the winner and 5 is the second place.
select customer_id,
case customer_id
	when 2 then 'Winner'
	when 5 then 'Second Place'
	else 'Normal'
end as raffle_results
from customer;

-- count how many 0.99 movies i have
select rental_rate from film;
select 
sum(case rental_rate
	when 0.99 then 1
	else 0
end) as bargains,
sum(case rental_rate
   		when 2.99 then 1
   		else 0
   end) as regular,
sum(case rental_rate
   		when 4.99 then 1
   		else 0
   end) as premium
from film;

select count(rental_rate) as number_of_bargins from film
where rental_rate = 0.99;

-- Challenge
-- we want to know and compare the various amounts of films we have per movie rating
-- use case and the dvdrental database to recreate
select * from film;
select 
sum(case rating
   		when 'R' then 1
   		else 0
  	end) as r,
sum(case rating
   		when 'PG' then 1
   		else 0
  	end) as pg,
sum(case rating
   		when 'PG-13' then 1
   		else 0
  	end) as pg13
from film;

---------------------
-- COALESCE
-- accepts an unlimited number of arguments. it returns the first argument that is not null. if all arguments are null, the coalesce function will return null
-- useful when querying a table that contains null values and substituting it with another value
-- EX: SELECT COALESCE(1,2) : 1; SELECT COALESCE(NULL,2,3) : 2;
-- useful example: SELECT item,(price-COALESCE(discount,0)) AS final FROM table;
-- explaination: select the item column and (price column - discount column), when discount is null, substitute it with 0.
-- keep in mind use COALESCE when you encounter a table with null values that you want to perform operations on.

---------------------
-- CAST
-- CAST operator lets you convert from one data type into another
-- SELECT CAST('5' AS INTEGER)
-- PostgreSQL CAST operator: SELECT '5'::INTEGER;
-- SELECT CAST(data AS TIMESTAMP) FROM table;

select cast('5' as integer) as new_int;
select '5'::integer;
select cast('five' as integer) as new_int;--error

select * from rental;
-- want to count the digits in inventoy id column
select char_length(cast(inventory_id as varchar)) from rental;

----------------------
-- NULLIF
-- takes in 2 inputs and returns NULL if both are equal, otherwise it returns the first argument passed
-- EX: NULLIF(10,10) : returns NULL;
-- very useful in cases where a NULL value would cause an error or unwanted result
drop table if exists depts;
create table depts(
	first_name varchar(50), 
	department varchar(50));

INSERT INTO depts(first_name,department)
values('Vinton','A'),('Laren','A'),('Claire','B');

select * from depts;
-- calculate the ratio between two departments
select (
sum(case when department = 'A' then 1 else 0 end) / 
sum(case when department ='B' then 1 else 0 end)
) as department_ratio from depts;

delete from depts
where department = 'B';

select * from depts;
select (
sum(case when department = 'A' then 1 else 0 end) / 
sum(case when department ='B' then 1 else 0 end)
) as department_ratio from depts; -- error, division by 0;

-- so we need to use the NULLIF function
select (
sum(case when department = 'A' then 1 else 0 end) /
nullif(sum(case when department = 'B' then 1 else 0 end),0) -- return null if the sum for 'B' is same as 0;
) as department_ratio from depts;

------------
-- VIEWS
-- there are specific combinations of tables and conditons that you find yourself using quite often for a peoject
-- instead of having to perform the same query over and over again as a starting point, you can create a VIEW to quickly see this query with a simple call
-- is a database object that is of a stored query
-- a view can be accessed as a virtual table in PostgreSQL
-- but the view does not store data physically, it simply stores the query.
-- you can UPDATE or ALTER existing views also

select * from customer;
select * from address;
select first_name, last_name, address from customer 
inner join address
on customer.address_id = address.address_id;

-- create a view
create view customer_info as 
select first_name, last_name, address from customer 
inner join address
on customer.address_id = address.address_id;

select * from customer_info;

create or replace view customer_info as 
select first_name, last_name, address, district from customer 
inner join address
on customer.address_id = address.address_id;

drop view if exists customer_info;
alter view customer_info rename to c_info;

-------------------
-- import and export





