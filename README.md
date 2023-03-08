# SQL_Census_2011
a database schema for the government census data of India, consisting of four tables named Population, District, Literacy, and Literacy_Rate.

The Population table contains data on the population of each state in India, including the population in 2011, the estimated population in 2022, and the number of literate people. The District table contains data on the population of each district in India, along with the growth rate, sex ratio, and literacy rate. The Literacy table contains data on the literacy rates in each state of India, including the percentage of literate people, the percentage of male and female literates, and the difference between the male and female literate population. The Literacy_Rate table contains data on the literacy rates of districts in each state, including the highest and lowest literacy rates.

The schema includes primary keys and foreign keys to connect the tables. Specifically, the District, Literacy, and Literacy_Rate tables are connected to the Population table using the State column. The District table also has a primary key named Sr_no, while the Literacy and Literacy_Rate tables have primary keys named Sr_no and State.

The above information also includes various SQL queries that can be used to extract useful information from the database schema. These queries range from simple queries to advanced queries that involve subqueries and joins. Some examples of queries include retrieving districts with the highest or lowest sex ratio, calculating the average growth rate of districts in each state, and calculating the percentage of literate people in each state or district.

Overall, this information provides a comprehensive overview of the government census data of India and the database schema used to organize and store this data. This information can be used as a basis for a portfolio project involving data analysis and visualization of Indian census data, using SQL and other data analysis tools.
