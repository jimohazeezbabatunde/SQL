--- Removing duplicates
--- Standardizing the data
--- Null values or blank values
--- removing any column and row

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_number` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs2
 select *,
row_number() over( partition by company, location, industry, total_laid_off, percentage_laid_off,  date, stage,country, funds_raised_millions) as row_num
from layoffs;

select * 
from layoffs2
where `row_number` >1;

delete
from layoffs2
where `row_number` >1;

--- standardizing the data

select trim(company)
from layoffs2;

update layoffs2
set company = trim(company);

select trim(location)
from layoffs2;

update layoffs2
set location = trim(location);

select *
from layoffs2;

select trim(industry)
from layoffs2;

update layoffs2
set industry = trim(industry);

alter table layoffs2
modify percentage_laid_off int;

alter table layoffs2
change percentage_laid_off percentage_laid_off int;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs2;

update layoffs2
set date = str_to_date(`date`, '%m/%d/%Y');

select *
from layoffs2;

alter table layoffs2
modify `date` date;

select stage, trim(stage)
from layoffs2;

update layoffs2
set stage = trim(stage);

select country, trim(trailing '.' from country)
from layoffs2;

update layoffs2
set country = trim(trailing '.' from country) 
where country = 'states.';

--- removing null values and blank values
select * from layoffs2
where total_laid_off is null
and percentage_laid_off is null;

delete from layoffs2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs2
where industry is null
and total_laid_off is null;

delete from layoffs2
where industry is null
and total_laid_off is null;

----  altering of where crypto currency to crypto

update  layoffs2
set industry = 'crypto'
where industry like 'crypto%';

--- replacing values

select * from layoffs2
where company = 'airbnb';

UPDATE layoffs2
 set industry = null
where industry = '';

select 1L.industry, 2L.industry
from layoffs2 1L
join layoffs2 2L
on 1L.company = 2L.company
where 1L.industry is null
and 2L.industry is not null;

update layoffs2 1L
join layoffs2 2L
on 1L.company = 2L.company
SET  1L.industry = 2L.industry
WHERE 1L.industry is null
and 2L.industry is not null;

select * from layoffs2;

alter table layoffs2
drop column `row_number`;

select * from layoffs2
where country = null
