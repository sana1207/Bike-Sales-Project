-----------------------------------------------------------------------------------------------------------

---- 1) Making Gender values Consistant

Select *
from BIKE..CustomerDemographic


Update BIKE..CustomerDemographic
Set gender = 'Female'
where gender = 'Femal'


Update BIKE..CustomerDemographic
Set gender = 'Male'
where gender = 'M'


------ Checking Gender

Select count(gender),gender
from BIKE..CustomerDemographic
group by gender

----------------------------------------------------------------------------------------------------------------------

---- 2) Making state consistant

Update demo_addr
Set state = 'NSW'
where state = 'New South Wales'


Update demo_addr
Set state = 'VIC'
where state = 'Victoria'

-------------------------------------------------------------------------------------------------------------------------

Select state, postcode
from  demo_addr
group by  state, postcode
order by state desc

--------------------------------------------------------------------------------------------------------------------------

---- 3) Make Full name

Select*
FROM BIKE..Transactions


ALTER TABLE BIKE..CustomerDemographic
ADD full_name varchar(255);

Select customer_id,  
    CONCAT(first_name,' ',last_name) as full_name
FROM BIKE..CustomerDemographic

UPDATE BIKE..CustomerDemographic 
SET full_name = CONCAT(first_name,' ',last_name) 

----------------------------------------------------------------------------------------------

---- 4) Total number of customer [visual]

SELECT
COUNT(DISTINCT customer_id) as Total_customers
FROM BIKE..Transactions;

--------------------------------------------------------------------------------------------------

---- 5) Total Spend [visual]

Select SUM(list_price) as Total_Spend
FROM BIKE..Transactions

--------------------------------------------------------------------------------------------------

---- 6) Target Customer[visual]


Select TOP 200 full_name as Name,
    job_title as Job_Title,
	address as Address,
	postcode as PostCode,
	state as State,
	Rank 
FROM BIKE..NewCustomerList
Order by Rank

------------------------------------------------------------------------------------------------------

---- 7) Combing CustomerDemographic and address 


SELECT *
FROM BIKE..CustomerAddress



CREATE VIEW demo_addr
AS SELECT demo.customer_id, demo.full_name, demo.gender, demo.age,
          demo.job_title, demo.job_industry_category, demo.wealth_segment, demo.deceased_indicator,
		  demo.owns_car, demo.tenure, addr.address, addr.postcode, 
		  addr.state, addr.country, addr.property_valuation

FROM BIKE..CustomerDemographic as demo, BIKE..CustomerAddress as addr
WHERE demo.customer_id= addr.customer_id

Select full_name as Name,
    job_title as Job_Title,
	address as Address,
	postcode as PostCode,
	state as State
FROM demo_addr

 



-------------------------------------------------------------------------------

---- 8) Combing to make goods [visual]

Select *
from BIKE..Transactions

Select transaction_id,  
    CONCAT(brand,': ','(class:',product_class,')') as Good
FROM BIKE..Transactions

ALTER TABLE BIKE..Transactions
ADD Goods varchar(255);

UPDATE BIKE..Transactions 
SET Goods =  CONCAT(brand,': ','(class:',product_class,')') 


-------------------------------------------------------------------------------------------------------

---- 9) Top 10  Goods

Select TOP 10 count(Goods) as No_of_Sold , Goods
FROM BIKE..Transactions
Group by Goods 
Order by No_of_Sold desc




----------------------------------------------------------------------------------------------------------


---- 10) Age grouping Female [Visual]

Select SUM(CASE WHEN AGE < 20 THEN 1 ELSE 0 END) AS [< 20],
       SUM(CASE WHEN AGE > 19 AND AGE < 30  THEN 1 ELSE 0 END) AS [20-29],
	   SUM(CASE WHEN AGE > 29 AND AGE < 40  THEN 1 ELSE 0 END) AS [30-39],
	   SUM(CASE WHEN AGE > 39 AND AGE < 50  THEN 1 ELSE 0 END) AS [40-49],
	   SUM(CASE WHEN AGE > 49 AND AGE < 60  THEN 1 ELSE 0 END) AS [50-59],
	   SUM(CASE WHEN AGE > 59 AND AGE < 70  THEN 1 ELSE 0 END) AS [60-69],
	   SUM(CASE WHEN AGE > 69 AND AGE < 80  THEN 1 ELSE 0 END) AS [70-79]
FROM BIKE..CustomerDemographic
where gender =  'Female'


----Age grouping Male [Visual]
 
Select SUM(CASE WHEN AGE < 20 THEN 1 ELSE 0 END) AS [< 20],
       SUM(CASE WHEN AGE > 19 AND AGE < 30  THEN 1 ELSE 0 END) AS [20-29],
	   SUM(CASE WHEN AGE > 29 AND AGE < 40  THEN 1 ELSE 0 END) AS [30-39],
	   SUM(CASE WHEN AGE > 39 AND AGE < 50  THEN 1 ELSE 0 END) AS [40-49],
	   SUM(CASE WHEN AGE > 49 AND AGE < 60  THEN 1 ELSE 0 END) AS [50-59],
	   SUM(CASE WHEN AGE > 59 AND AGE < 70  THEN 1 ELSE 0 END) AS [60-69],
	   SUM(CASE WHEN AGE > 69 AND AGE < 80  THEN 1 ELSE 0 END) AS [70-79]
FROM BIKE..CustomerDemographic
where gender =  'Male'
