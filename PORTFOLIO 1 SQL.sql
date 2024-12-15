SELECT * FROM COVIDDEATH 
ORDER BY 3,4


SELECT LOCATION , DATE , TOTAL_CASES , NEW_CASES , TOTAL_DEATHS , POPULATION
FROM COVIDDEATH
ORDER BY 1,2

SELECT 
    LOCATION,  DATE, TOTAL_CASES, TOTAL_DEATHS, (TOTAL_DEATHS / TOTAL_CASES) * 100 AS DEATH_RATE
FROM  COVIDDEATH
WHERE LOCATION LIKE '%INDIA'


ORDER BY  1,2






SELECT 
    LOCATION,  POPULATION,MAX(TOTAL_CASES), (MAX(TOTAL_CASES / POPULATION)) * 100 AS CASE_RATE
FROM  COVIDDEATH
--WHERE LOCATION LIKE '%INDIA'

GROUP BY POPULATION,LOCATION


ORDER BY  4 DESC




SELECT 
 

   LOCATION,  POPULATION,MAX(TOTAL_DEATHS), (MAX(TOTAL_DEATHS / POPULATION)) * 100 AS DEATH_CASE
FROM  COVIDDEATH
--WHERE LOCATION LIKE '%INDIA'

GROUP BY LOCATION,population


ORDER BY  4 DESC








 
 SELECT
   LOCATION, MAX( CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATH 
   FROM COVIDDEATH
   WHERE CONTINENT IS NOT NULL
   GROUP BY LOCATION

   ORDER BY TOTALDEATH  DESC




   SELECT
   
   LOCATION, MAX( CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATH 
   FROM COVIDDEATH
   WHERE CONTINENT IS NOT NULL
   GROUP BY LOCATION

   ORDER BY TOTALDEATH  DESC





  SELECT
   
   CONTINENT, MAX( CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATH 
   FROM COVIDDEATH
   WHERE CONTINENT IS NOT NULL
   GROUP BY CONTINENT

   ORDER BY TOTALDEATH  DESC



    
SELECT 
     DATE , SUM(NEW_CASES) AS NEWCASES,SUM(CAST(NEW_DEATHS AS INT)) AS NEWDEATHS, SUM(CAST(new_deaths AS INT))/ SUM(NEW_CASES)*100 AS DEATHPERCENTAGE
FROM  COVIDDEATH
 WHERE CONTINENT IS NOT  NULL
 GROUP BY DATE


SELECT *
FROM COVIDVACCINATION VAC
JOIN COVIDDEATH DEA
ON VAC.LOCATION = DEA.location




SELECT DEA.CONTINENT , DEA.LOCATION , DEA.DATE , DEA.POPULATION , VAC.NEW_VACCINATIONS,
SUM(CAST(VAC.NEW_VACCINATIONS AS INT)) OVER (PARTITION BY DEA.LOCATION  )AS RPLLINGPEOPLEVACCINATEDROLLINGPEOPLEVACCINATED
FROM COVIDVACCINATION VAC
JOIN COVIDDEATH DEA

ON VAC.LOCATION = DEA.location
WHERE DEA.CONTINENT IS NOT NULL
ORDER BY 2,3




WITH POPVSVAC
(CONTINENT , LOCATION , POPULATION , NEW_VACCINATIONS , ROLLINGPEOPLEVACCINATED)
AS
(


SELECT DEA.CONTINENT , DEA.LOCATION ,  DEA.POPULATION , VAC.NEW_VACCINATIONS,
SUM(CAST(VAC.NEW_VACCINATIONS AS INT)) OVER (PARTITION BY DEA.LOCATION  )AS RPLLINGPEOPLEVACCINATEDROLLINGPEOPLEVACCINATED
FROM COVIDVACCINATION VAC
JOIN COVIDDEATH DEA

ON VAC.LOCATION = DEA.location
WHERE DEA.CONTINENT IS NOT NULL


)

SELECT * 
FROM POPVSVAC



CREATE TABLE #PERCENTAGEPOPULATIONVACCINATED(

CONTINENT NVARCHAR(200),
LOCATION NVARCHAR(200),
POPULATION INT,
NEW_VACCINATION INT,
ROLLINGPEOPLEVACCINATED INT,

)


INSERT INTO #PERCENTAGEPOPULATIONVACCINATED

SELECT DEA.CONTINENT , DEA.LOCATION ,  DEA.POPULATION , VAC.NEW_VACCINATIONS,
SUM(CAST(VAC.NEW_VACCINATIONS AS INT)) OVER (PARTITION BY DEA.LOCATION  )AS RPLLINGPEOPLEVACCINATEDROLLINGPEOPLEVACCINATED
FROM COVIDVACCINATION VAC
JOIN COVIDDEATH DEA

ON VAC.LOCATION = DEA.location
WHERE DEA.CONTINENT IS NOT NULL


SELECT * 
FROM #PERCENTAGEPOPULATIONVACCINATED







CREATE VIEW  PERCENTAGEPOPULATION AS

SELECT DEA.CONTINENT , DEA.LOCATION ,  DEA.POPULATION , VAC.NEW_VACCINATIONS,
SUM(CAST(VAC.NEW_VACCINATIONS AS INT)) OVER (PARTITION BY DEA.LOCATION  )AS RPLLINGPEOPLEVACCINATEDROLLINGPEOPLEVACCINATED
FROM COVIDVACCINATION VAC
JOIN COVIDDEATH DEA

ON VAC.LOCATION = DEA.location
WHERE DEA.CONTINENT IS NOT NULL








