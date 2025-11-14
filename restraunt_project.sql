create database rest_proj;
use rest_proj;
-- Consumers Table
CREATE TABLE Consumers (
    Consumer_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Smoker BOOLEAN,
    Drink_Level VARCHAR(20),
    Transportation_Method VARCHAR(50),
    Marital_Status VARCHAR(20),
    Children BOOLEAN,
    Age INT,
    Occupation VARCHAR(50),
    Budget VARCHAR(20)
);

-- Consumer Preferences Table
CREATE TABLE Consumer_Preferences (
    Consumer_ID VARCHAR(10),
    Preferred_Cuisine VARCHAR(50),
    PRIMARY KEY (Consumer_ID, Preferred_Cuisine),
    FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID)
);

-- Restaurants Table
CREATE TABLE Restaurants (
    Restaurant_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Zip_Code VARCHAR(10),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Alcohol_Service VARCHAR(50),
    Smoking_Allowed BOOLEAN,
    Price VARCHAR(20),
    Franchise BOOLEAN,
    Area VARCHAR(50),
    Parking BOOLEAN
);

-- Restaurant Cuisines Table
CREATE TABLE Restaurant_Cuisines (
    Restaurant_ID VARCHAR(10),
    Cuisine VARCHAR(50),
    PRIMARY KEY (Restaurant_ID, Cuisine),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurants(Restaurant_ID)
);

-- Ratings Table
CREATE TABLE Ratings (
    Consumer_ID VARCHAR(10),
    Restaurant_ID VARCHAR(10),
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT,
    PRIMARY KEY (Consumer_ID, Restaurant_ID),
    FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurants(Restaurant_ID)
);
INSERT INTO Consumers VALUES
('C001', 'Alice Johnson', 'Cuernavaca', 'Morelos', 'Mexico', 18.9200, -99.2350, TRUE, 'High', 'Car', 'Single', TRUE, 28, 'Student', 'Medium'),
('C002', 'Bob Smith', 'Cuernavaca', 'Morelos', 'Mexico', 18.9210, -99.2360, FALSE, 'Low', 'Bicycle', 'Married', FALSE, 35, 'Engineer', 'High'),
('C003', 'Carlos Diaz', 'San Luis Potosi', 'SLP', 'Mexico', 22.1565, -100.9855, FALSE, 'Social', 'Public', 'Single', FALSE, 23, 'Student', 'Low'),
('C004', 'Diana Lopez', 'Ciudad Victoria', 'Tamaulipas', 'Mexico', 23.7369, -99.1411, TRUE, 'Medium', 'Car', 'Married', TRUE, 40, 'Employed', 'Medium'),
('C005', 'Elena Rivera', 'Cuernavaca', 'Morelos', 'Mexico', 18.9220, -99.2370, FALSE, 'Social', 'Bus', 'Single', FALSE, 32, 'Teacher',
 'Medium');
 INSERT INTO Consumer_Preferences VALUES
('C001', 'Mexican'),
('C001', 'Italian'),
('C002', 'Japanese'),
('C003', 'American'),
('C003', 'Mexican'),
('C004', 'Italian'),
('C005', 'Mexican'),
('C005', 'American');
INSERT INTO Restaurants VALUES
('R001', 'El Camino Real', 'Cuernavaca', 'Morelos', 'Mexico', '62210', 18.9200, -99.2350, 'Wine & Beer', TRUE, 'Medium', TRUE, 'Urban', TRUE),
('R002', 'La Trattoria', 'Cuernavaca', 'Morelos', 'Mexico', '62220', 18.9210, -99.2360, 'None', FALSE, 'High', FALSE, 'Suburban', FALSE),
('R003', 'Taco Loco', 'San Luis Potosi', 'SLP', 'Mexico', '78200', 22.1565, -100.9855, 'Wine & Beer', TRUE, 'Low', FALSE, 'Urban', TRUE),
('R004', 'Burger Hub', 'Cuernavaca', 'Morelos', 'Mexico', '62230', 18.9230, -99.2380, 'Beer', FALSE, 'Medium', TRUE, 'Urban', TRUE),
('R005', 'Pizza Plaza', 'Ciudad Victoria', 'Tamaulipas', 'Mexico', '87000', 23.7370, -99.1420, 'Wine & Beer', FALSE, 'Medium', FALSE, 
'Suburban', FALSE);
INSERT INTO Restaurant_Cuisines VALUES
('R001', 'Mexican'),
('R002', 'Italian'),
('R003', 'Mexican'),
('R004', 'American'),
('R005', 'Pizzeria');
INSERT INTO Ratings VALUES
('C001', 'R001', 2, 2, 2),  -- Highly Satisfactory
('C001', 'R002', 1, 1, 0),
('C002', 'R002', 2, 2, 1),
('C002', 'R004', 0, 0, 1),
('C003', 'R003', 2, 1, 2),
('C004', 'R005', 1, 1, 1),
('C005', 'R001', 2, 2, 2),
('C005', 'R004', 1, 0, 1);
INSERT INTO Ratings VALUES
('C001', 'R001', 2, 2, 2),  -- Highly Satisfactory
('C001', 'R002', 1, 1, 0),
('C002', 'R002', 2, 2, 1),
('C002', 'R004', 0, 0, 1),
('C003', 'R003', 2, 1, 2),
('C004', 'R005', 1, 1, 1),
('C005', 'R001', 2, 2, 2),
('C005', 'R004', 1, 0, 1);

-- Using the WHERE clause to filter data based on specific criteria. --
	-- 1. List all details of consumers who live in the city of 'Cuernavaca' --
SELECT * 
FROM Consumers
WHERE City = 'Cuernavaca';
	-- 2. Find the Consumer_ID, Age, and Occupation of all consumers who are 'Students' AND are 'Smokers' -- 
SELECT Consumer_ID, Age, Occupation
FROM Consumers
WHERE Occupation = 'Student' AND Smoker = TRUE;
	-- 3. List the Name, City, Alcohol_Service, and Price of all restaurants that serve 'Wine & Beer' and have a 'Medium' price level--
SELECT Name, City, Alcohol_Service, Price
FROM Restaurants
WHERE Alcohol_Service = 'Wine & Beer' AND Price = 'Medium';
	 -- 4. Find the names and cities of all restaurants that are part of a 'Franchise'--
SELECT Name, City
FROM Restaurants
WHERE Franchise = TRUE;
	-- 5. Show the Consumer_ID, Restaurant_ID, and Overall_Rating for all ratings where the Overall_Rating was 'Highly Satisfactory' (value = 2)--
SELECT Consumer_ID, Restaurant_ID, Overall_Rating
FROM Ratings
WHERE Overall_Rating = 2;

-- Questions JOINs with Subqueries --
	-- 1. List the names and cities of all restaurants that have an Overall_Rating of 2 (Highly Satisfactory) from at least one consumer--
SELECT DISTINCT r.Name, r.City
FROM Restaurants r
JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
WHERE ra.Overall_Rating = 2;
	-- 2. Find the Consumer_ID and Age of consumers who have rated restaurants located in 'San Luis Potosi'--
SELECT DISTINCT c.Consumer_ID, c.Age
FROM Consumers c
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
JOIN Restaurants res ON r.Restaurant_ID = res.Restaurant_ID
WHERE res.City = 'San Luis Potosi';
	-- 3. List the names of restaurants that serve 'Mexican' cuisine and have been rated by consumer 'U1001'-- 
SELECT DISTINCT res.Name
FROM Restaurants res
JOIN Restaurant_Cuisines rc ON res.Restaurant_ID = rc.Restaurant_ID
JOIN Ratings r ON res.Restaurant_ID = r.Restaurant_ID
WHERE rc.Cuisine = 'Mexican' AND r.Consumer_ID = 'C001';
	-- 4. Find all details of consumers who prefer 'American' cuisine AND have a 'Medium' budget--
SELECT c.*
FROM Consumers c
JOIN Consumer_Preferences cp ON c.Consumer_ID = cp.Consumer_ID
WHERE cp.Preferred_Cuisine = 'American' AND c.Budget = 'Medium';
	-- 5. List restaurants (Name, City) that have received a Food_Rating lower than the average Food_Rating across all rated restaurants--
SELECT r.Name, r.City
FROM Restaurants r
JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(ra.Food_Rating) < (SELECT AVG(Food_Rating) FROM Ratings);
	-- 6. Find consumers (Consumer_ID, Age, Occupation) who have rated at least one restaurant but have NOT rated any restaurant that serves 'Italian' cuisine
    SELECT DISTINCT c.Consumer_ID, c.Age, c.Occupation
FROM Consumers c
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Consumer_ID NOT IN (
    SELECT ra.Consumer_ID
    FROM Ratings ra
    JOIN Restaurant_Cuisines rc ON ra.Restaurant_ID = rc.Restaurant_ID
    WHERE rc.Cuisine = 'Italian'
);
	-- 7. List restaurants (Name) that have received ratings from consumers older than 30
SELECT DISTINCT r.Name
FROM Restaurants r
JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
JOIN Consumers c ON ra.Consumer_ID = c.Consumer_ID
WHERE c.Age > 30;
	-- 8. Find the Consumer_ID and Occupation of consumers whose preferred cuisine is 'Mexican' and who have given an Overall_Rating of 0 to at least one restaurant
SELECT DISTINCT c.Consumer_ID, c.Occupation
FROM Consumers c
JOIN Consumer_Preferences cp ON c.Consumer_ID = cp.Consumer_ID
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE cp.Preferred_Cuisine = 'Mexican' AND r.Overall_Rating = 0;
	-- 9. List the names and cities of restaurants that serve 'Pizzeria' cuisine and are located in a city where at least one 'Student' consumer lives
SELECT DISTINCT r.Name, r.City
FROM Restaurants r
JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Pizzeria'
  AND r.City IN (SELECT DISTINCT City FROM Consumers WHERE Occupation = 'Student');
	-- 10. Find consumers (Consumer_ID, Age) who are 'Social Drinkers' and have rated a restaurant that has 'No' parking--
SELECT DISTINCT c.Consumer_ID, c.Age
FROM Consumers c
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
JOIN Restaurants res ON r.Restaurant_ID = res.Restaurant_ID
WHERE c.Drink_Level = 'Social' AND res.Parking = FALSE;
-- Questions Emphasizing WHERE Clause and Order of Execution --
	-- 1. List Consumer_IDs and the count of restaurants they've rated, but only for consumers who are 'Students'. Show only students who have rated more than 2 restaurants
    SELECT c.Consumer_ID, COUNT(r.Restaurant_ID) AS Rated_Count
FROM Consumers c
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Occupation = 'Student'
GROUP BY c.Consumer_ID
HAVING COUNT(r.Restaurant_ID) > 2;
	-- 2. Categorize consumers by 'Engagement_Score' = Age / 10 (integer division). List Consumer_ID, Age, Engagement_Score for consumers whose score = 2 and who use 'Public' transportation
    SELECT Consumer_ID, Age, FLOOR(Age/10) AS Engagement_Score
FROM Consumers
WHERE FLOOR(Age/10) = 2 AND Transportation_Method = 'Public';
	-- 3. For each restaurant, calculate average Overall_Rating. List Name, City, and average Overall_Rating for restaurants in 'Cuernavaca' AND average > 1.0
    SELECT r.Name, r.City, AVG(ra.Overall_Rating) AS Avg_Overall_Rating
FROM Restaurants r
JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
WHERE r.City = 'Cuernavaca'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(ra.Overall_Rating) > 1.0;
	-- 4. Find consumers (Consumer_ID, Age) who are 'Married' and whose Food_Rating = Service_Rating, only consider ratings where Overall_Rating = 2
SELECT DISTINCT c.Consumer_ID, c.Age
FROM Consumers c
JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Marital_Status = 'Married' 
  AND r.Overall_Rating = 2 
  AND r.Food_Rating = r.Service_Rating;
	-- 5. List Consumer_ID, Age, and Name of any restaurant they rated, but only for consumers who are 'Employed' and have given Food_Rating = 0 to at least one restaurant located in 'Ciudad Victoria'
    SELECT DISTINCT c.Consumer_ID, c.Age, r2.Name
FROM Consumers c
JOIN Ratings ra ON c.Consumer_ID = ra.Consumer_ID
JOIN Restaurants r2 ON ra.Restaurant_ID = r2.Restaurant_ID
WHERE c.Occupation = 'Employed' 
  AND ra.Food_Rating = 0 
  AND r2.City = 'Ciudad Victoria';
  --
  -- Advanced SQL Concepts: Derived Tables, CTEs, Window Functions, Views, Stored Procedures --
	-- 1. Using a CTE, find consumers in 'San Luis Potosi', and list Consumer_ID, Age, and Name of any Mexican restaurant they rated with Overall_Rating = 2
    WITH SLP_Consumers AS (
    SELECT Consumer_ID, Age
    FROM Consumers
    WHERE City = 'San Luis Potosi'
)
SELECT sc.Consumer_ID, sc.Age, r.Name AS Restaurant_Name
FROM SLP_Consumers sc
JOIN Ratings ra ON sc.Consumer_ID = ra.Consumer_ID
JOIN Restaurants r ON ra.Restaurant_ID = r.Restaurant_ID
JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Mexican' AND ra.Overall_Rating = 2;
	-- 2. For each Occupation, find the average age of consumers who have made at least one rating (using a derived table)
SELECT dt.Occupation, AVG(dt.Age) AS Avg_Age
FROM (
    SELECT DISTINCT c.Consumer_ID, c.Age, c.Occupation
    FROM Consumers c
    JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
) dt
GROUP BY dt.Occupation;
	-- 3. Rank all ratings for restaurants in 'Cuernavaca' by Overall_Rating, and show Consumer_ID, Restaurant_ID, Overall_Rating, RatingRank; also show avg rating given by that consumer
    WITH Cuernavaca_Ratings AS (
    SELECT ra.Consumer_ID, ra.Restaurant_ID, ra.Overall_Rating
    FROM Ratings ra
    JOIN Restaurants r ON ra.Restaurant_ID = r.Restaurant_ID
    WHERE r.City = 'Cuernavaca'
)
SELECT cr.Consumer_ID, cr.Restaurant_ID, cr.Overall_Rating,
       RANK() OVER (PARTITION BY cr.Restaurant_ID ORDER BY cr.Overall_Rating DESC) AS RatingRank,
       AVG(cr2.Overall_Rating) OVER (PARTITION BY cr.Consumer_ID) AS Avg_Consumer_Rating
FROM Cuernavaca_Ratings cr
JOIN Ratings cr2 ON cr.Consumer_ID = cr2.Consumer_ID;
	-- 4. Using a CTE, identify students with 'Low' budget, and list top 3 preferred cuisines using ROW_NUMBER()
WITH LowBudgetStudents AS (
    SELECT Consumer_ID
    FROM Consumers
    WHERE Occupation = 'Student' AND Budget = 'Low'
)
SELECT t.Consumer_ID, t.Preferred_Cuisine
FROM (
    SELECT lb.Consumer_ID, cp.Preferred_Cuisine,
           ROW_NUMBER() OVER (PARTITION BY lb.Consumer_ID ORDER BY cp.Preferred_Cuisine) AS rn
    FROM LowBudgetStudents lb
    JOIN Consumer_Preferences cp ON lb.Consumer_ID = cp.Consumer_ID
) AS t
WHERE t.rn <= 3;

	-- 5. For ratings by 'Consumer_ID' = 'U1008', show Restaurant_ID, Overall_Rating, and next restaurant rating using LEAD()
    WITH ConsumerRatings AS (
    SELECT Restaurant_ID, Overall_Rating
    FROM Ratings
    WHERE Consumer_ID = 'C005'
)
SELECT Restaurant_ID, Overall_Rating,
       LEAD(Overall_Rating) OVER (ORDER BY Restaurant_ID) AS Next_Restaurant_Rating
FROM ConsumerRatings;
-- 6.Consider all ratings made by 'Consumer_ID' = 'U1008'. For each rating, show the Restaurant_ID, Overall_Rating, and the Overall_Rating of the next restaurant they rated (if any), ordered by Restaurant_ID (as a proxy for time if rating time isn't available). Use a derived table to filter for the consumer's ratings first.
-- Derived table to filter the consumer's ratings first
SELECT dr.Restaurant_ID, dr.Overall_Rating,
       LEAD(dr.Overall_Rating) OVER (ORDER BY dr.Restaurant_ID) AS Next_Restaurant_Rating
FROM (
    SELECT Restaurant_ID, Overall_Rating
    FROM Ratings
    WHERE Consumer_ID = 'C005'
) AS dr
ORDER BY dr.Restaurant_ID;
-- 7.Create a VIEW named HighlyRatedMexicanRestaurants
CREATE OR REPLACE VIEW HighlyRatedMexicanRestaurants AS
SELECT r.Restaurant_ID, r.Name, r.City
FROM Restaurants r
JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(ra.Overall_Rating) > 1.5;
-- 8. 3. Using CTE, find consumers who prefer 'Mexican' but have NOT rated any restaurant in HighlyRatedMexicanRestaurants
WITH MexicanConsumers AS (
    SELECT Consumer_ID
    FROM Consumer_Preferences
    WHERE Preferred_Cuisine = 'Mexican'
)
SELECT mc.Consumer_ID
FROM MexicanConsumers mc
WHERE mc.Consumer_ID NOT IN (
    SELECT DISTINCT ra.Consumer_ID
    FROM Ratings ra
    JOIN HighlyRatedMexicanRestaurants hr ON ra.Restaurant_ID = hr.Restaurant_ID
);
-- 9. 4. Create a stored procedure GetRestaurantRatingsAboveThreshold
DELIMITER $$

CREATE PROCEDURE GetRestaurantRatingsAboveThreshold(
    IN p_Restaurant_ID VARCHAR(10),
    IN p_MinOverallRating INT
)
BEGIN
    SELECT Consumer_ID, Overall_Rating, Food_Rating, Service_Rating
    FROM Ratings
    WHERE Restaurant_ID = p_Restaurant_ID
      AND Overall_Rating >= p_MinOverallRating;
END$$

DELIMITER ;
-- usage example 
CALL GetRestaurantRatingsAboveThreshold('R001', 2);
-- 10. 5. Identify top 2 highest-rated restaurants per cuisine, including ties
WITH CuisineRatings AS (
    SELECT rc.Cuisine, r.Name AS Restaurant_Name, r.City, AVG(ra.Overall_Rating) AS Avg_Rating
    FROM Restaurants r
    JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
    JOIN Ratings ra ON r.Restaurant_ID = ra.Restaurant_ID
    GROUP BY rc.Cuisine, r.Restaurant_ID, r.Name, r.City
)
SELECT Cuisine, Restaurant_Name, City, Avg_Rating
FROM (
    SELECT cr.*,
           DENSE_RANK() OVER (PARTITION BY Cuisine ORDER BY Avg_Rating DESC) AS RatingRank
    FROM CuisineRatings cr
) t
WHERE RatingRank <= 2
ORDER BY Cuisine, Avg_Rating DESC;
-- 11. 6. Create VIEW ConsumerAverageRatings and find top 5 consumers
	-- Step 1: Create the view
    CREATE OR REPLACE VIEW ConsumerAverageRatings AS
SELECT Consumer_ID, AVG(Overall_Rating) AS Avg_Overall_Rating
FROM Ratings
GROUP BY Consumer_ID;
	-- Step 2: Find top 5 consumers and count of Mexican restaurants rated
    WITH TopConsumers AS (
    SELECT Consumer_ID, Avg_Overall_Rating
    FROM ConsumerAverageRatings
    ORDER BY Avg_Overall_Rating DESC
    LIMIT 5
)
SELECT tc.Consumer_ID, tc.Avg_Overall_Rating,
       COUNT(DISTINCT rc.Restaurant_ID) AS Mexican_Restaurants_Rated
FROM TopConsumers tc
LEFT JOIN Ratings ra ON tc.Consumer_ID = ra.Consumer_ID
LEFT JOIN Restaurant_Cuisines rc ON ra.Restaurant_ID = rc.Restaurant_ID AND rc.Cuisine = 'Mexican'
GROUP BY tc.Consumer_ID, tc.Avg_Overall_Rating
ORDER BY tc.Avg_Overall_Rating DESC;
/* 12. Create a stored procedure named GetConsumerSegmentAndRestaurantPerformance that accepts a Consumer_ID as input.

The procedure should:
Determine the consumer's "Spending Segment" based on their Budget:
'Low' -> 'Budget Conscious'
'Medium' -> 'Moderate Spender'
'High' -> 'Premium Spender'
NULL or other -> 'Unknown Budget'


For all restaurants rated by this consumer:
List the Restaurant_Name.
The Overall_Rating given by this consumer.
The average Overall_Rating this restaurant has received from all consumers (not just the input consumer).
A "Performance_Flag" indicating if the input consumer's rating for that restaurant is 'Above Average', 'At Average', or 'Below Average' compared to the restaurant's overall average rating.
Rank these restaurants for the input consumer based on the Overall_Rating they gave (highest rating = rank 1).
*/
DELIMITER $$

CREATE PROCEDURE GetConsumerSegmentAndRestaurantPerformance(
    IN p_Consumer_ID VARCHAR(10)
)
BEGIN
    -- 1. Get the consumer's budget
    DECLARE v_Budget VARCHAR(20);
    DECLARE v_SpendingSegment VARCHAR(50);

    SELECT Budget INTO v_Budget
    FROM Consumers
    WHERE Consumer_ID = p_Consumer_ID;

    -- 2. Determine Spending Segment
    SET v_SpendingSegment = CASE
        WHEN v_Budget = 'Low' THEN 'Budget Conscious'
        WHEN v_Budget = 'Medium' THEN 'Moderate Spender'
        WHEN v_Budget = 'High' THEN 'Premium Spender'
        ELSE 'Unknown Budget'
    END;

    -- 3. Show consumer info
    SELECT p_Consumer_ID AS Consumer_ID, v_Budget AS Budget, v_SpendingSegment AS Spending_Segment;

    -- 4. Show restaurants rated by this consumer with performance flag and ranking
    WITH ConsumerRatings AS (
        -- Get restaurants this consumer rated
        SELECT r.Restaurant_ID, r.Name AS Restaurant_Name, ra.Overall_Rating AS Consumer_Rating
        FROM Ratings ra
        JOIN Restaurants r ON ra.Restaurant_ID = r.Restaurant_ID
        WHERE ra.Consumer_ID = p_Consumer_ID
    ),
    RestaurantAvg AS (
        -- Calculate average rating for each restaurant
        SELECT r.Restaurant_ID, AVG(ra.Overall_Rating) AS Avg_Rating
        FROM Ratings ra
        JOIN Restaurants r ON ra.Restaurant_ID = r.Restaurant_ID
        GROUP BY r.Restaurant_ID
    ),
    PerformanceCTE AS (
        -- Compare consumer rating with restaurant average
        SELECT cr.Restaurant_Name, cr.Consumer_Rating, ra.Avg_Rating,
               CASE
                   WHEN cr.Consumer_Rating > ra.Avg_Rating THEN 'Above Average'
                   WHEN cr.Consumer_Rating = ra.Avg_Rating THEN 'At Average'
                   ELSE 'Below Average'
               END AS Performance_Flag,
               RANK() OVER (ORDER BY cr.Consumer_Rating DESC) AS RatingRank
        FROM ConsumerRatings cr
        JOIN RestaurantAvg ra ON cr.Restaurant_ID = ra.Restaurant_ID
    )
    -- Final output: Restaurant info with performance and ranking
    SELECT *
    FROM PerformanceCTE
    ORDER BY RatingRank;

END$$

DELIMITER ;
-- usage example 
CALL GetConsumerSegmentAndRestaurantPerformance('C002');
























    

















