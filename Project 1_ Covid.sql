Select Count(*)
From coviddeaths;

-- Select *
-- From covidvaccinations
-- order by 3,4;

Select *
From coviddeaths
Where continent is not null
Order by 3,4;

-- SELECT DATA WE ARE GOING TO BE USING --
Select Location, date, total_cases, new_cases, total_deaths, population
From coviddeaths
Where continent is not null
order by 1,2 AND total_cases ASC;

-- LOOKING AT TOTAL CASES VS TOTAL DEATHS --
--What percentage of people who had COVID died?
-- In total as a percentage of deaths
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From coviddeaths
Where continent is not null
order by 1,2 AND total_cases ASC
LIMIT 1000;

-- In the U.S, total percentage
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From coviddeaths
Where continent is not null
Where location LIKE '%states%'
LIMIT 1000;

-- In Brazil
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From coviddeaths
Where continent is not null
Where location LIKE 'Bra%'
LIMIT 1000;

-- LOOKING AT TOTAL CASES VS POPULATION -- 
-- Shows what percentage of population got Covid in the U.S 
Select location, date, total_cases, population, (total_cases/population)*100 AS DeathPercentage 
From coviddeaths
Where continent is not null
Where location like '%states%'
Order By 3,4
LIMIT 1000;

-- LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION --
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
From coviddeaths
Where continent is not null
Group By population, location
Order By PercentPopulationInfected DESC;

-- SHOWING COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION --
Select location, MAX(total_deaths) AS TotalDeathCount
From coviddeaths
Where continent is not null
Group By location
Order By TotalDeathCount DESC
LIMIT 5000;

-- BREAKING IT DOWN BY CONTINENT --
-- Showing continents with the highest death count per population
Select continent, MAX(total_deaths) AS TotalDeathCount
From coviddeaths
Where continent is not null
Group By continent
Order By TotalDeathCount DESC;

-- GLOBAL NUMBERS --
-- By day -- 
Select date, SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage 
From coviddeaths
Where continent is not null 
Group By date
LIMIT 2000;
--Overall--
Select SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage 
From coviddeaths
Where continent is not null 
LIMIT 2000;

-- COVID VACCINATIONS --
Select * 
From coviddeaths dea
Join covidvaccinations vac
On dea.location = vac.location
and dea.date = vac.date;

-- Looking at Total Population vs. Vaccinations --
-- What is the total amount of people in the world who have been vaccinated? --
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From coviddeaths dea 
Join covidvaccinations vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null 
LIMIT 3000;