select * from portocovid.coviddeath;

select * from portocovid.covidvac;

-- New cases and death for each year
select location, date_format(date, '%Y'), sum(new_cases) as new_cases_total, sum(new_deaths) as death
from portocovid.coviddeath
where location = 'Indonesia'
group by location, date_format(date, '%Y');

-- Total cases and death precentage in year 2022
select location, date_format(date, '%Y') as year, sum(new_cases) as total_cases, sum(new_deaths) as death, (sum(new_deaths)/sum(new_cases)) * 100 as precentage_of_death
from portocovid.coviddeath
where date_format(date, '%Y') = '2022'
group by location, date_format(date, '%Y')
order by precentage_of_death desc;

-- Percentage of population infected each country from 2020 until 2022 --
select location, population, max(total_cases) as Highest_infection_count, max((total_cases/population))*100 as infection_percent
from portocovid.coviddeath
group by location, population
order by infection_percent desc;

-- New vaccination each year around the world
select d.location, date_format(d.date, '%Y') as year, population, sum(new_vaccinations) as vaccinated
from portocovid.coviddeath d join portocovid.covidvac v on d.location = v.location and d.date = v.date
where d.location != 'High income'
group by d.location, population, year
order by year, vaccinated desc;

-- New vaccination each year in Indonesia
select d.location, date_format(d.date, '%Y') as year, population, sum(new_vaccinations) as vaccinated
from portocovid.coviddeath d join portocovid.covidvac v on d.location = v.location and d.date = v.date
where d.location = 'Indonesia'
group by d.location, population, year
order by year, vaccinated desc;

select d.location, date_format(d.date, '%Y') as year, population, Max(people_fully_vaccinated) as fully_vaccinated, Max(people_fully_vaccinated)/population as percent_vaccinated
from portocovid.coviddeath d join portocovid.covidvac v on d.location = v.location and d.date = v.date
where d.location != 'High income' and d.location != 'Low income' and date_format(d.date, '%Y') = '2022'
group by d.location, population, year
order by year, percent_vaccinated desc;

