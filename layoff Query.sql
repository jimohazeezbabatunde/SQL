--- Exploratory analysis
select * from layoffs2;

describe layoffs2;

select count(not null)
from layoffs2;

select count( null)
from layoffs2;

select count(" ")
from layoffs2;


--- looking at the start and the end of layoff
select min(date), max(date)
from layoffs2;

--- LAYOFFS INSIGHT

--- top 5 maximum laid off in one day by company, location, and country.
select company, location, country,  max(total_laid_off) 
from layoffs2
group by company, location, country
order by max(total_laid_off) desc limit 5; 

--- top 5 maximium % laid off in one day by company, location, and country.
select company, location, country,  max(percentage_laid_off) 
from layoffs2
group by company, location, country
order by  max(percentage_laid_off) desc limit 5;

---  total laid off by company
select company,  sum(total_laid_off)
from layoffs2
group by company
order by  sum(total_laid_off) desc ;

---  total laid off by industry
select company,  sum(total_laid_off)
from layoffs2
group by industry
order by  sum(total_laid_off) desc ;


--- which country got the most during layoffs
select country,  sum(total_laid_off)
from layoffs2
group by country
order by  sum(total_laid_off) desc;

--- total layoffs by year
select year(date),  sum(total_laid_off)
from layoffs2
group by year(date)
order by  1  desc;

--- total layoffs by month
select monthname(date),  month(date),   sum(total_laid_off)
from layoffs2
where month(date) is not null
group by month(date), monthname(date)
order by month(date) asc, sum(total_laid_off) desc;

--- average % laid off by industry
select  industry , ceiling( avg(percentage_laid_off))
from layoffs2
group by industry
order by  avg(percentage_laid_off) desc;

--- which stage got the most during layoffs
select stage,  sum(total_laid_off)
from layoffs2
group by stage
order by  sum(total_laid_off) desc;

--- companies in Nigeria with layoffs
select company, industry, sum(total_laid_off)
from layoffs2
where country = 'nigeria' 
group by company, industry
order by sum(total_laid_off) desc;

--- Total layoff by year in Nigeria
Select YEAR(date) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs2
Where country = 'nigeria'
and total_laid_off IS NOT NULL
group by YEAR(date)
order by year ASC;

--- total layoff by month and year
select substring(date, 1,7)  month, sum(total_laid_off)
from layoffs2
where substring(date, 1,7) is not null
group by month
order by 1 asc;

--- rolling total by month and year
with rolling_total  as
(select substring(date, 1,7)  month, sum(total_laid_off) laid_off
from layoffs2
where substring(date, 1,7) is not null
group by month
order by 1 asc)
select  month,  laid_off,
sum(laid_off) over (order by month) rolling_total
from rolling_total;


--- looking at the start and the end of layoff
select min(date), max(date)
from layoffs2;
