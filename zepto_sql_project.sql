drop table if exists zepto;

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);

SELECT COUNT (*) FROM ZEPTO

--sample data
SELECT * FROM zepto
limit 10;

--null values
SELECT * FROM zepto
Where 
	name is null or
	category is null or
	mrp is null or
	discountpercent is null or
	availablequantity is null or 
	discountedsellingprice is null or 
	weightingms is null or 
	outofstocks is null or 
	quantity is null 
--different product cateories
SELECT DISTINCT category 
FROM zepto
order by category

--products in stock vs out of stock
Select outofstocks, COUNT(sku_id)
from zepto
group by outofstocks;

--product names present multiple times
SELECT name,count(sku_id) as "number of SKUs"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc
--data cleaning
 --price with zero
SELECT *
from zepto
where mrp = 0 or
	discountedsellingprice = 0;

--deleting products with mrp of 0rs
SELECT *
from zepto
where mrp = 0 or
	discountedSellingprice = 0

DELETE from zepto
where mrp = 0

--converting mrp paise into rupees
UPDATE zepto 
set mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

select mrp,discountedsellingprice from zepto 
--01. find the top 10 best value products based on the discount percentage
SELECT DISTINCT 
	name, 
	discountpercent
from
	zepto
order by 
	discountpercent DESC
limit 10

--02. what are the products with high mrp but out of stock
select distinct 
	name,	
	mrp
from 
	zepto
where 
	outofstocks = TRUE
order by mrp DESC
limit 10 
--or we can also do the query as follows
select distinct 
	name,
	mrp
from 
	zepto
where 
	outofstocks = true and mrp > 300
order by 
	mrp desc

--03. calculate estimated revenue for each category
select 
	category,
	sum(discountedsellingprice*availablequantity) AS totalrevenue
from zepto
group by category
order by totalrevenue
--04. find all the products where mrp is greater than 500rs and disciunt is less than 10%
select distinct name, mrp,discountpercent
from zepto
where mrp >500 and discountpercent <10
order by mrp desc, discountpercent desc
--05. identify the top 5 categories offering the highest average discount percentage
select
	category,
	ROUnd(avg(discountpercent),2) as avg_discount
from 
	zepto
group by
	category
order by 
	avg_discount DESC
limit 5
--06. find the price per grams that weigh over 100 gms and sort by best value
select distinct
	name,
	weightingms,
	discountedsellingprice, 
	round((discountedsellingprice/weightingms),2) as price_per_gram
from zepto
where weightingms>=100
order by price_per_gram ASC, weightingms
--07. group the products into categories like low medium and bulk
SELECT DISTINCT 
	name, weightingms,
case when weightingms <1000 then 'low'
	when weightingms <5000 then 'medium'
	else 'bulk'
	end as weight_category
from zepto

--08. what is the total inventory weight per category
SELECT 
	category,
	sum(weightingms*availablequantity) as total_weight
from 
	zepto
group by 
	category
order by 
	total_weight 