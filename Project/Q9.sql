CREATE FUNCTION numScoops(coneNumber INT)
RETURNS INT DETERMINISTIC
RETURN (SELECT COUNT(*) FROM scoopsincone
WHERE coneID = coneNumber);

DELIMITER ++
CREATE PROCEDURE purchaseSummary(purchaseNum INT,
OUT oneScoop INT,
OUT twoScoop INT,
OUT threeScoop INT)
BEGIN
	DECLARE rowNum INT;
    DECLARE numCones INT;
    DECLARE coneNum INT;
    DECLARE numScoop INT;
    SET rowNum = 0;
    SELECT COUNT(*) INTO numCones FROM conesinpurchase 
    WHERE purchaseID = purchaseNum;
    SET oneScoop = 0; 
    SET twoScoop = 0;
    SET threeScoop = 0;
    
	WHILE rowNum < numCones DO
		SELECT coneID INTO coneNum FROM conesinpurchase 
        WHERE purchaseID = purchaseNum LIMIT rowNum, 1;
        SET rowNum = rowNum + 1;
        SET numScoop = numScoops(coneNum);
        IF (numScoop = 1) THEN SET oneScoop = oneScoop + 1;
        ELSEIF (numScoop = 2) THEN SET twoScoop = twoScoop + 1;
        ELSE SET threeScoop = threeScoop + 1;
        END IF;
	END WHILE;
END ++
DELIMITER ;

USE ScoopsAhoy;
CALL purchaseSummary(8, @what, @no, @ok);
SELECT @what, @no, @ok;