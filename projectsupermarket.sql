
CREATE TABLE supermarket_3 (
    invoice_id VARCHAR(15),
    branch VARCHAR(2),
    city VARCHAR(20),
    customer_type VARCHAR(15),
    gender VARCHAR(10),
    product_line VARCHAR(80),
    unit_price NUMERIC(10,2),
    quantity INT,
    tax NUMERIC(10,2),
    total NUMERIC(10,2),
    date_ varchar(20),
    time_ varchar(20),
    payment VARCHAR(30),
    cogs NUMERIC(10,2),
    gross_margin_percentage NUMERIC(5,2),
    gross_income NUMERIC(10,2),
    rating NUMERIC(3,1)
);


select * from supermarket_3;


---total no of entries
select count(*) from supermarket_3;

---total quantity of product sold
select sum(quantity)from supermarket_3;


---average rating of product
select avg(rating) from supermarket_3;


---total number of male and female customer
select  gender ,count(*) from supermarket_3 as total_gender
group by gender;

---product ranking lines based on the total revenue generated (window function)
select product_line,sum(total_amount) AS total_revenue,
    rank() over (order by sum(total_amount) desc) as revenue_rank
from supermarket_3
group by product_line;


---How many customers belong to each customer type (Member and Normal)
select customer_type,count(*)from supermarket_3 as total_customers
group by customer_type;


---which branch has generated the maximum revenue
select  branch ,sum(total_amount) as total_revenue from supermarket_3
group by branch
order by total_revenue desc
limit 1;

---total number of branches prensent in each city
select city,branch,count(*) from supermarket_3
group by city,branch;
select * from supermarket_3;


---Maximum sale per city(window function)
select*,
max(total_amount) over(partition by City) AS max_city_sale
from supermarket_3;


---the avg product rating of each branch
select city,branch,avg(rating) from supermarket_3
group by city, branch;


---branches ranking based on tax(window function)
select branch,city,tax,
row_number()  OVER(PARTITION BY branch order by tax desc) AS rating_
FROM supermarket_3;


---total revenue of each branch
select branch,sum(total_amount)as total_revenue from supermarket_3
group by branch;

---which payment method genrates the highest revenue
select payment,count(*) as highest_revenue_method from supermarket_3
group by payment
order by highest_revenue_method desc
limit 1;

---date on which the highest sales were recorded
select date_,sum(total_amount) as highest_sale from supermarket_3
group by date_
order by highest_sale desc
limit 1;




---most preferred payment method in each city

select city,
       payment,
       payment_count
from (select city,payment,count(*) AS payment_count,
           rank() over(partition by city order by count(*) desc)AS payment_rank from supermarket_3
 group by city, payment) 
 ranked_payments
where payment_rank = 1;


---Best Performing Branch on the basis of total revenue and rating
select 
    branch,
    sum(total_amount) as total_revenue,
    avg(rating) as avg_rating
from  supermarket_3
group by branch
order by total_revenue desc, avg_rating desc
limit 1;








