-- 1. Find all the buyers (their names) within a minimum price range of $150,000. --
SELECT BuyerName
FROM Buyers
WHERE MinPrice >= 150000;

--2. Find all buyers with agent ID 1 and sort the query output by their max price (any direction). --
SELECT BuyerName, MaxPrice
FROM Buyers
WHERE B_AgentID = 1
ORDER BY MaxPrice ASC;

--3. 3. Find the names of all buyers who have a phone number with a 504 area code (hint: remember the LIKE operator).--

SELECT BuyerName
FROM Buyers
WHERE B_PhoneNum LIKE '504%';

--4. Return the house addresses that do not have a listing price. --
SELECT Address, StreetName
FROM HOUSE
WHERE Price IS NULL;


--5. Find the square feet of all houses with a price between $100,000 and $200,000. --
SELECT Sqft
FROM House
WHERE Price BETWEEN 100000 AND 200000;

--6. Find all buyers who have a phone number with a 312 area code and do not have agent ID 1. --

SELECT BuyerName
FROM Buyers
WHERE B_PhoneNum LIKE '312%' AND B_AgentID != 1;

--7. Find the minimum and maximum square feet for all houses. Use only one query. --

SELECT MIN(Sqft) AS MinSqft,MAX(Sqft) AS MaxSqft
FROM House;

--8. Find the average max price for all buyers with agent ID 1.  --
SELECT AVG(MaxPrice)
FROM Buyers
WHERE B_AgentID = 1;

--9. Find the house with the highest price. Do not hardcode any salaries or other values.--
SELECT * 
FROM House
WHERE Price IN 
    (
        SELECT MAX(Price)
        FROM House
    );


--10. Find the houses that cost less than the average overall price for all houses + 20% (i.e., less than 1.2 * average price). Do not hardcode any prices or other values. --

SELECT * 
FROM House
WHERE Price <(SELECT AVG(Price) FROM House)*1.2;
