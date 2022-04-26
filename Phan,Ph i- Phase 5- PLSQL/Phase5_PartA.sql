DECLARE
    MaxPrice NUMBER;
    MinPrice NUMBER;
    AvgPrice NUMBER;
    
    housePrice HOUSE.Price%type;
    houseStreetName HOUSE.StreetName%type;
    
    priceRow House%rowtype;
    

    CURSOR PricePerSqft IS (SELECT round(Price/Sqft) as roundedPrice, StreetName FROM House);
    
    
BEGIN
    
    SELECT MAX(cast(round(Price/Sqft,2) as numeric(36,2))) INTO MaxPrice from House;
    SELECT MIN(cast(round(Price/Sqft,2) as numeric(36,2))) INTO MinPrice from House;
    SELECT AVG(SUM(cast(round(Price/Sqft,2) as numeric(36,2))))  INTO AvgPrice from House GROUP BY StreetName;
    
    
    DBMS_OUTPUT.PUT_LINE('Price per square feet aggregates are $' || TO_CHAR(AvgPrice) || ', $' || TO_CHAR(MinPrice) || ', and $' || TO_CHAR(MaxPrice));
    
    
    FOR priceRow IN PricePerSqft 
    LOOP
    IF(priceRow.roundedPrice > AvgPrice) THEN
        DBMS_OUTPUT.PUT_LINE(priceRow.StreetName || ' ' || priceRow.roundedPrice || ' Above Average');
    ELSIF (priceRow.roundedPrice < AvgPrice)
    THEN
        DBMS_OUTPUT.PUT_LINE(priceRow.StreetName || ' ' || priceRow.roundedPrice || ' Below Average');
        ELSE
        DBMS_OUTPUT.PUT_LINE(priceRow.StreetName || ' ' || priceRow.roundedPrice || ' Average');
        EXIT;
    END IF;
    END LOOP;

END;
    