DELIMITER ++
CREATE PROCEDURE createMonthlyWinners()
BEGIN
DECLARE numMonths INT;
DECLARE loopNum INT;
DECLARE storeName TEXT;
DECLARE monthNum INT;
DECLARE yearNum INT;
DECLARE storedDate DATE;
DECLARE purchases INT;

CREATE TABLE MonthlyWinners (
month TEXT, 
store TEXT, 
numPurchases INT
);

SELECT COUNT(DISTINCT DATE_FORMAT(buyDate, "%Y%m")) INTO numMonths FROM purchase;
SET loopNum = 0;
SELECT(DATE_FORMAT(buyDate, "%c")), DATE_FORMAT(buyDate, "%Y") INTO monthNum, yearNum FROM purchase limit 1;

WHILE loopNum < numMonths DO
	SELECT store, buyDate, COUNT(*) INTO storeName, storedDate, purchases FROM purchase 
    WHERE DATE_FORMAT(buyDate, "%Y %c") = CONCAT(yearNum, " ", monthNum)
    GROUP BY store ORDER BY COUNT(*) DESC LIMIT 1;
    
    INSERT INTO MonthlyWinners VALUES(DATE_FORMAT(storedDate, "%M %Y"), storeName, purchases);
    IF (monthNum = 12) THEN SET yearNum = yearNum + 1;
    END IF;
    SET monthNum = (monthNum + 1)%12;
    IF monthNum = 0 THEN SET monthNum = 1;
    END IF;
    SET loopNum = loopNum + 1;
END WHILE;
END ++
DELIMITER ;