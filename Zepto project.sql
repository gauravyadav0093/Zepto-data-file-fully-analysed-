-- load data
select*from dbo.Zepto_SQL_Project

-- count of rows

select count(*)from dbo.Zepto_SQL_Project

--sample data 
 select top 10 * from dbo.Zepto_SQL_Project

 -- null values 

select * from dbo.Zepto_SQL_Project
where Category is null 
  or
 Name is null
 or
 mrp is null
 or
 discountpercent is null
 or 
 availableQuantity is null
 or
 discountedsellingprice is null
 or
  weightinGms is null
 or
 outOfstock is null
 or
 quantity is null

  
  -- different product category
  select distinct category
  from dbo.Zepto_SQL_Project
  order by category;


-- product in stock vs out of stock
select outofstock , count(category)
from dbo.Zepto_SQL_Project
group by outofstock

-- product names present multiple times 
select name , count (category) as 'number of category'
from dbo.Zepto_SQL_Project 
group by name
having count (category)>1
order by count (category) desc;

-- lets clean some data 

-- products with price=0
select * from dbo.Zepto_SQL_Project 
where mrp =0 or discountedsellingprice =0;

delete from dbo.Zepto_SQL_Project  
where mrp=0;

-- paise to rupees 
update dbo.Zepto_SQL_Project 
set 
    mrp= mrp/100.0,
    discountedsellingprice = discountedsellingprice / 100.0;
 
select mrp, discountedsellingprice from dbo.Zepto_SQL_Project

select * from dbo.Zepto_SQL_Project


--Questions 


--Q1 find the top 10 best value products based on the discount percentage

select  distinct top 10 name,mrp,discountpercent
from dbo.Zepto_SQL_Project
order by discountpercent desc

--Q2 what are the products with high MRP but out of stock
select distinct name ,mrp as outofstock , mrp from dbo.Zepto_SQL_Project
where outofstock = 1 and mrp >300
order by mrp desc;

--Q3 calculate estimate revenue for each category

select category ,
sum(discountedsellingprice*availablequantity) as total_revenue
from dbo.Zepto_SQL_Project
group by category
order by total_revenue

--Q4 find all products where MRP is greater than Rupees 500 and discount is less than 10%

select distinct name,mrp,discountpercent
from  dbo.Zepto_SQL_Project
where mrp > 500 and discountpercent<10
order by mrp desc, discountpercent desc;

-- Q5 identify the top 5 categories offering average discount percentage.
select top 5 category,
avg (discountpercent) as avg_dis
from  dbo.Zepto_SQL_Project
group by category 
order by avg_dis desc

--Q6 find the price per gram for products above 100g and sort best value.
--error
select distinct name,weightingms,discountedsellingprice,
discountedsellingprice/weightingms as price_per_grams
from  dbo.Zepto_SQL_Project
where weightingms >100
order by price_per_grams 

--Q7  group the products into categorys like low , medium , bulk

select distinct name, weightingms,
case when weightingms< 1000 then 'low'
when weightingms <5000 then 'medium'
else'bulk'
end as weight_category
from  dbo.Zepto_SQL_Project

--Q8 what is the total inventory weight per cetegory
select category,
sum(weightingms* availablequantity) as total_weight
from  dbo.Zepto_SQL_Project
group by category 
order by total_weight



