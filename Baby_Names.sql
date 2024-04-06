-- The project was on American Baby Name Trends for over 100 years
-- The primary objective was to understand the shifts in preferences for baby names in America by examining the patterns of popularity over the years.
-- RANK(), SET, HAVING, LIMIT, among other clauses were utilized.

-- American names for over 100 years:
create view Top_100 AS 
SELECT first_name
FROM usa_baby_names
Group by first_name
HAVING COUNT(DISTINCT year) > 100;
-- It was noted that Charles, David, Elizabeth, James, John, Joseph, Thomas, William appeared frequently over the years.

-- The type of popularity for each name: timeless vs. trendy
 SELECT first_name,
       CASE
           WHEN COUNT(DISTINCT year) >= 100 THEN 'timeless'
           ELSE 'trendy'
       END AS popularity_type
FROM usa_baby_names
GROUP BY first_name;
-- Charles, David, Elizabeth, James, John, Joseph appeared to be timeless while the other names were trendy.

-- The top 10 female names
SELECT first_name, count(*) AS Appearances
FROM usa_baby_names
WHERE sex = 'F'
Group by first_name
ORDER BY Appearances DESC
LIMIT 10;
-- It was observed that Elizabeth had appeared 101 times and least on top 10 was Jennifer and Margaret that had occured 50 times.

-- The most popular female name ending in "a" since 2015
SELECT first_name
FROM usa_baby_names
WHERE sex = 'F' and first_name like '%a' AND year >= 2015
Group by first_name
ORDER BY count(*) DESC
LIMIT 1;
-- It was discovered that Emma was popular female name since 2015.

-- The most popular male names by year
SELECT year, first_name
FROM usa_baby_names
WHERE sex = 'M'
Group by year
ORDER BY year, count(*) DESC;
-- It was seen that from 1920-1923 John was the popular name, Robert 1924-1939; ..... Jacob 1999-2012, Noah 2013-2016 and Liam 2017-2020.

-- The most popular male name for the largest number of years
-- @prev_year and @rank: @prev_year is used to keep track of the year in the previous row, and @rank is used to assign ranks to names within each year.
SET @prev_year = NULL, @rank = 0; 
SELECT first_name, COUNT(*) AS years
FROM (
  SELECT year, first_name,
    @rank := IF(@prev_year = year, @rank + 1, 1) AS `rank`,
    @prev_year := year
  FROM usa_baby_names
  WHERE sex = 'M'
  GROUP BY year, first_name
  ORDER BY year, COUNT(*) DESC
) AS yearly_popular_names
WHERE `rank` = 1
GROUP BY first_name
ORDER BY years DESC
LIMIT 1;
-- Michael was the most popular male name for 44 years.



