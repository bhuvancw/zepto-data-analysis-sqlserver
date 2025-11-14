-- Dataset URL -> --https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv

create database zepto_db

use [zepto_db]

create schema zp

select * from zp.zepto

alter table zp.zepto add id int identity primary key

create table zp.zpto(
		id int identity primary key,
		category varchar(150),
		name varchar(150) not null,
		mrp float,
		discPercent float,
		availableQuantity int,
		discSellingPrice float,
		weightInGms float,
		outOfStock int,
		quantity int
		)

insert into zp.zpto (
    category,
    name,
    mrp,
    discPercent,
    availableQuantity,
    discSellingPrice,
    weightInGms,
    outOfStock,
    quantity
)
select 
    category,
    name,
    mrp,
    discountPercent,
    availableQuantity,
    discountedSellingPrice,
    weightInGms,
    outOfStock,
    quantity
from zp.zepto;

drop table zp.zepto

select top 10 * from zp.zpto

alter table zp.zpto 
alter column mrp numeric(20,2)
alter table zp.zpto 
alter column discPercent numeric(5,2)
alter table zp.zpto 
alter column discSellingPrice numeric(20,2)
alter table zp.zpto 
alter column weightingms numeric(10,2)
alter table zp.zpto 
alter column outofstock varchar(10)

zepto_db.zp.zpto

exec sp_help 'zp.zpto';

select
    *
from zp.zpto
where
    id is null
    or
    category is null
    or
    name is null
    or
    mrp is null
    or
    discPercent is null
    or
    availableQuantity is null
    or
    discSellingPrice is null
    or
    weightInGms is null
    or
    outOfStock is null
    or
    quantity is null

-- different product categories
select
    distinct category
from zp.zpto
order by category

-- Products in Stock vs Out of Stock
update zp.zpto set outofstock= case
                                    when outofstock=1 then 'True'
                                    else 'False'
                                end;
select
    outofstock,
    count(id) as [Total Number]
from zp.zpto
group by outofstock

--Product names present multiple times
select
    name,
    count(name) as [Total Count]
from zp.zpto
group by name
having count(name)>1
order by [Total Count] desc

-- Data Cleaning

exec sp_rename 'zp.zpto.discSellingPrice', 'discSP'
exec sp_rename 'zp.zpto.availableQuantity', 'avlQuantity'

-- Product with price 0
select
    *
from zp.zpto
where
    mrp = 0
or
    discSP=0

delete from zp.zpto
where mrp=0 or discSP=0

-- convert paise to rupees
update zp.zpto
set discSP = discSP/100.00,
    mrp = mrp/100.00

-- Q1. Find the top 10 best value products based on the discount %
select
    distinct top 10 name,
    mrp,
    discPercent,
    discSp
from zp.zpto
order by discPercent desc

-- Q2.  What are the products with high MRP and out of stock
select
    distinct name,
    mrp
from zp.zpto
where outofstock='True'
and mrp>300
order by mrp desc

-- Q3. Calculate estimated revenue for each category
select
    category,
    sum(discSP*avlQuantity) as Revenue
from zp.zpto
group by category
order by revenue desc

-- Q4. Find all products where MRP>500 and discount less than <10%
select
        *
from zp.zpto
where mrp>500 and discPercent<10
order by mrp desc, discPercent desc

-- Q5. Identify the top categories offering the highest average discount percentage
select
    category,
    round(avg(discPercent),2) as [Average Discount]
from zp.zpto
group by category
order by 'Average Discount' desc

-- Q6. Find price per gram for products above 100mg and sort by best value
select
    distinct name,
    mrp,
    weightingms,
    cast(round(mrp/weightingms,2) as numeric(10,2)) as [Price per gram]
from zp.zpto
where weightingms>=100
order by [Price per gram] desc

-- Q7. group the products into categories like Low, Medium, Bulk
select
    distinct name,
    weightingms,
    case
        when weightingms<1000 then 'Low'
        when weightingms<5000 then 'Medium'
        else 'Bulk'
    end as 'Weight Category'
from zp.zpto

-- Q8. What is Total Inventory Weight Per Category
select
    category,
    sum(weightingms*avlQuantity) as [Total Inventory Weight]
from zp.zpto
group by category
order by [Total Inventory Weight] desc
     
    


