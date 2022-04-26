-- 1. Retrieve the street address for houses with an agent in the New Orleans office.--

SELECT StreetName
FROM House
LEFT OUTER JOIN Agent
    ON H_AgentID = A_ID
WHERE Office LIKE 'New Orleans%';

-- 2. Retrieve the street address for house which have a seller name that is the same as the listing agent’s name.--

SELECT StreetName
FROM House
LEFT OUTER JOIN Agent
    ON H_AgentID = A_ID
LEFT OUTER JOIN Seller
    ON H_SellerSSN = S_SSN
WHERE S_Name LIKE A_Name;


--3. Find names of all agents who represent a buyer with a minimum price range greater than $80K and a maximum price range less than $225K. --

SELECT A_Name
FROM Agent LEFT OUTER JOIN Buyers
ON A_ID = B_AgentID
WHERE MinPrice > 80000 AND MaxPrice < 225000;

-- 4. For each agent, list their name, office, and the total number of buyers they represent. --

SELECT A_Name, Office, COUNT(B_AgentID)
FROM Agent, Buyers
WHERE A_ID = B_AgentID
GROUP BY A_Name,Office;

-- 5. Retrieve the street address for all houses that have an agent who is representing at least one buyer. --

SELECT StreetName
FROM House LEFT OUTER JOIN Agent
    ON H_AgentID = A_ID
    LEFT OUTER JOIN Buyers
    ON A_ID = B_AgentID
HAVING COUNT(B_AgentID) >= 1
GROUP BY StreetName
ORDER BY StreetName;

-- 6.  Retrieve the street address for all houses that have an agent who is not representing any buyers. --
SELECT StreetName
FROM House LEFT OUTER JOIN Agent
    ON H_AgentID = A_ID
    LEFT OUTER JOIN Buyers
    ON A_ID = B_AgentID
WHERE B_AgentID IS NULL
GROUP BY StreetName;
    
-- 7. For each agent, retrieve the agent’s name and the average commission of all houses they are listing. --
SELECT A_Name, AVG(Commission)
FROM Agent, House
WHERE A_ID = H_AgentID
GROUP BY A_Name


-- 8. Retrieve the average price for all houses in the state of Louisiana. --

SELECT AVG(Price)
FROM House
WHERE UPPER(State) Like 'LA';

-- 9. List the names of all agents and the number of phone numbers they have.-- 

SELECT A_Name, COUNT(A_PhoneNum)
FROM Agent, AgentPhone
WHERE A_ID = A_AgentID
GROUP BY A_Name
ORDER BY A_Name DESC;

-- 10. Find the names of all agents who represent exactly two buyers.  --
SELECT A_Name, COUNT(B_AgentID)
FROM Agent LEFT OUTER JOIN Buyers
ON A_ID = B_AgentID
GROUP BY A_Name
HAVING COUNT(B_AgentID)= 2;

-- 11. For each agent whose average commission is greater than $10K, retrieve the agent’s name and the number houses they represent. --

SELECT A_Name, AVG(Commission), COUNT(HouseID)AS numHouseRep
FROM Agent, House
WHERE A_ID = H_AgentID
HAVING AVG(Commission) > 10000
GROUP BY A_Name;


--12. Retrieve the names of all buyers who are represented by the agent who is listing the lowest priced house. --
SELECT BuyerName
FROM Buyers LEFT OUTER JOIN Agent
    ON B_AgentID = A_ID
    LEFT OUTER JOIN House
    ON A_ID = H_AgentID
WHERE Price IN (SELECT MIN(Price) FROM House);

-- 13. Retrieve the agent’s name and the buyer’s name for all agents who are listing a house within the buyer’s price range (i.e., house price is between minimum and maximum price range).  --

SELECT A_Name, BuyerName
FROM Agent LEFT OUTER JOIN Buyers
    ON A_ID = B_AgentID
    LEFT OUTER JOIN House
    ON A_ID = H_AgentID
WHERE Price BETWEEN MinPrice AND MaxPrice
GROUP BY A_Name, BuyerName;


--14. Find sellers whose SSN number has a pattern 321 repeated twice (sequentially). For example, the query should return sellers with the SSN’s ‘321-32-145’ and ‘983-21-3219’, but not ‘321-99-3218’. --
SELECT *
FROM Seller
WHERE REGEXP_LIKE(S_SSN,'(321)\1{1}');

--15. Find agents whose office consists of exactly 2 words. For example, the query should return records for “Metairie Office” and “Downtown Office”, but not “University of New Orleans Office”.  --

SELECT *
FROM Agent
WHERE REGEXP_LIKE(Office, '^[a-zA-Z]+\s[a-zA-Z]+$');

--16. Find all houses that include a street number in the street address. For example, the query should return records for “2000 Lakeshore Drive” and “1500 Sugar Bowl Drive” but not “Canal Street”. --
SELECT *
FROM House
WHERE REGEXP_LIKE(StreetName,'^[[:digit:]]');
