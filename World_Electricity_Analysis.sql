----retriving the all the tables
select * from Final_oil
select * from [dbo].[Final_rural (1)]
select * from Final_total1
select * from Final_urban
select * from Final_losses
select * from Final_nuclear
select * from Final_renewable
---import metadata
select * from metadata

--Comparison of access to electricity post 2000s in different countries
--for Rural

select Country_Name,Country_Code, avg(value_Column) as 'Access_of_Electricity_Rural' from [dbo].[Final_rural (1)]
where Year_Column>2000 
group by Country_Name,Country_Code 


---income group wise comparision post 2000s
select * from metadata
select m.IncomeGroup, avg(f.Value_Column) as 'Access_of_Electricity_Rural' from [dbo].[Final_rural (1)] as f
inner join metadata as m on f.Country_Code=m.Country_Code
where f.Year_Column>2000 and f.Value_Column!=0 AND m.IncomeGroup IS NOT NULL
group by m.IncomeGroup
order by Access_of_Electricity_Rural desc


---region wise comparision of access_of_electricity post 2000s
select m.Region, avg(f.Value_Column) as 'Access_of_Electricity_Rural' from [dbo].[Final_rural (1)] as f
inner join metadata as m on f.Country_Code=m.Country_Code
where f.Year_Column>2000 and f.Value_Column!=0 and m.Region is not null
group by m.Region
order by Access_of_Electricity_Rural desc

---Q3-Present a way to compare every country’s performance with respect to world average for 
---every year. As in, if someone wants to check how is the accessibility of electricity in India in
---2006 as compared to average access of the world to electricity 


with avg_electricity_access_world as (
select Year_Column,AVG(Value_column) as 'avg_electricity_access_world' 
from Final_total1 
group by Year_Column)

select a.Country_Name,a.Country_Code,a.Year_Column,a.Value_Column as 'Country_electricity_access',b.avg_electricity_access_world from 
Final_Total1 as a inner join avg_electricity_access_world as b 
on a.Year_Column=b.Year_Column

--Q4-A chart to depict the increase in count of country with greater than 75% 
--electricity access in rural areas across different year. For example, what was the 
--count of countries having ≥75% rural electricity access in 2000 as compared to 2010. 

select Year_Column,COUNT(Country_Name) as Number_of_countries from [Final_rural (1)]
where Value_column >=75
group by Year_Column
order by Year_Column

--Q5--Define a way/KPI to present the evolution of nuclear  power presence grouped by Region 
---and IncomeGroup. How was the nuclear power generation in the region of Europe & Central 
---Asia as compared to Sub-Saharan Africa.
select * from Final_nuclear

--evolution of nuclear power in different regions

select n.Year_Column, m.Region,AVG(n.Value_Column) as 'avg_access_of_nuclear_electricity' from Final_nuclear as n
join metadata as m on n.Country_Code=m.Country_Code
where m.Region is not null
group by m.Region,n.Year_Column
order by n.Year_Column



---evolution of nuclear power IncomeGroup -Wise comparison

select n.Year_Column, m.IncomeGroup,AVG(n.Value_Column) as 'avg_of_access_of_nuclear_electricity' from Final_nuclear as n
join metadata as m on n.Country_Code=m.Country_Code
where m.IncomeGroup is not null
group by m.IncomeGroup,n.Year_Column
order by n.Year_Column

---A chart to present the production of electricity across different sources (nuclear, oil, etc.) as
---a function of time

select n.Year_Column,avg(n.Value_Column) as 'avg_Electricity_Production _throught_Nuclear',
avg(o.Value_Column) as 'avg_Electricity_Production _throught_oil',avg(l.Value_Column) as 'avg_of_ power transmission and distribution losses '  from  Final_nuclear as n
join Final_oil as o on n.Country_Code=o.Country_Code and n.Year_Column=o.Year_Column
join Final_losses as l on o.Country_Code=l.Country_Code and l.Year_Column=o.Year_Column
group by n.Year_Column
order by n.Year_Column asc





