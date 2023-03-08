-- ** Project On Indian Census of 2011 **
-- Files and database are available in the repository.

-- ** Topics Covered **
-- Adding Constraint, Aggregation functions, Union, Joins, Subquery, Temp table 

-- Creating new database name 'Census'

Create database Census;

Use Census;

Select * From Population;
Select * From District;
Select * From Literacy_rate;
Select * From literacy;

-- ** ADD PRIMARY KEY **

ALTER TABLE Population
ADD CONSTRAINT PRIMARY KEY (State);

ALTER TABLE District
ADD CONSTRAINT PRIMARY KEY (Sr_no);

ALTER TABLE Literacy_rate
ADD CONSTRAINT PRIMARY KEY (State);

ALTER TABLE literacy
ADD CONSTRAINT PRIMARY KEY (State);

-- ** ADD FOREIGN KEY **
-- Create Relationship Between district and population table

Alter table district 
add constraint
Foreign Key (State) references population (state);

Alter table literacy 
add constraint
Foreign Key (State) references population (state);

Alter table Literacy_rate 
add constraint
Foreign Key (State) references population (state);

----------------------------------------------------------------------------------------------------------------

-- Total population of India in 2011. (Aggregation functions)

Select Sum(Population_in_2011) as Total_population 
From population;

-- the population of all the districts in a particular state, along with their growth rates and sex ratios, sorted in descending order of population. 

SELECT District, Population, Growth, Sex_Ratio
FROM District
WHERE State = 'Maharashtra'
ORDER BY Population DESC;

-- Percentage Growth of population in 10 years. 

Select Sr_no, State, (Estimated_population_in_2022 / population_in_2011) as Percent_growth 
From Population
Group by Sr_no, State, Estimated_population_in_2022, Population_in_2011
Order By Percent_Growth Desc;


-- State Having Lowest Literacy Rate

Select Sr_No, state, Min(literacy) as Lowest_Literacy 
From literacy
Group By Sr_No,state, Literacy
order By literacy 
limit 1;

-- Calculate the total population of each state, along with the total number of literates and estimated population in 2022.

SELECT State, SUM(Population_in_2011) AS Total_Population, SUM(Literates) AS Total_Literates, SUM(Estimated_population_in_2022) AS Estimated_Population
FROM Population
GROUP BY State;

-- Calculate the average growth rate of each state.

SELECT State, round(AVG(Growth),2) AS Avg_Growth_Rate
FROM District
GROUP BY State;

-- Retrieve the top 5 districts with the highest literacy rates, along with their respective states.

SELECT District, State, Literacy
FROM District
WHERE District IN (
    SELECT Highest_Literacy_Districts
    FROM literacy_rate
    ORDER BY H_Rate DESC)
LIMIT 5;

-- Retrieve the state names, their estimated populations in 2022, and the percentage increase in population from 2011 to 2022.

SELECT State, Estimated_population_in_2022, 
((Estimated_population_in_2022 - Population_in_2011) / Population_in_2011) * 100 AS Population_Increase_Percentage
FROM Population;

-- Average Literacy Rate In 
Select Avg(literacy)
From district
where State = 'Maharashtra';

-- Average Literacy Rate of females of each state.

Select State, Round(AVG(female),2) AVG_Female_Literacy 
From Literacy
Group By state 
order By AVG_Female_Literacy Desc;

-- Average Growth Rate Per State.

Select Sr_no, State, Avg(Sex_Ratio) as Avg_Sex_ratio
From District
Group By Sr_No, State
Order By Sr_no;

-- Average growth and literacy of 'Pradesh' states where state name have 'Pradesh' in it and also the literacy is between 70 percent and 90 percent

Select District, State, round((AVG(Growth)*100),2) as Avg_Growth , Literacy 
from District
where state Like '%Pradesh%' 
And Literacy Between '70.00' and '95.00'
Group by District,state,Literacy
order BY State, Literacy asc;

-- Top 5 state with high literacy and 5 states with lowest literacy 
(Select Highest_Literacy_Districts as Litercy_rate, H_rate 
From Literacy_Rate
order by H_rate
Limit 5)
union
(Select Lowest_Literacy_Rate_Districts, L_rate 
From Literacy_Rate
order by L_rate
limit 5);

-- Comparing literacy of state with highest rate of the district. 

Select r.state, r.Highest_Literacy_Districts, r.H_rate, l.literacy
From Literacy_rate r
left join
Literacy l on r.state = l.state
Group by r.state, r.Highest_Literacy_Districts,r.H_Rate,l.Literacy;

-- Calculate literate population

 SELECT District, State, Population,
  ROUND(Population * (Literacy / 100), 0) AS Literate_Population
FROM
  District;

-- Calculating the population of literate males and female from total population

SELECT 
    p.State,
    SUM(p.Population_in_2011) AS Total_Population,
    SUM(p.Literates) AS Total_Literates,
    SUM(p.Population_in_2011) - SUM(p.Literates) AS Total_Illiterates,
    ROUND((SUM(l.Male) * SUM(p.Literates) / 100), 0) AS Male_Literates,
    ROUND((SUM(l.Female) * SUM(p.Literates) / 100), 0) AS Female_Literates
FROM Population p 
JOIN Literacy l ON p.State = l.State
GROUP BY p.State;

----------------------------------------------------------------------------------------------------------------

-- ** Creating Temp Table **

Drop table if exists Population_Literacy;

Create Table Population_literacy (
Sr_no INT,
State Varchar(200),
Population INT,
Literacy Float);

Insert Into Population_literacy
Select p.Sr_no, p.State, Avg(p.population_in_2011) As AvG_population, Round(l.literacy,2) 
From Population p
join Literacy l 
on p.State = l.State
Group By p.State, p.Sr_No, l.literacy;

Select * From Population_literacy;
