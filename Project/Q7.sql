DELIMITER ++
CREATE FUNCTION isNutFree(coneNumber INT)
RETURNS BOOLEAN DETERMINISTIC 
BEGIN
    DECLARE texture TEXT;
	SELECT cone.conetype INTO texture FROM cone
    WHERE cone.ID = coneNumber;
    
    IF (texture = "Waffle") THEN RETURN FALSE;
    ELSEIF EXISTS(SELECT * FROM scoopsincone JOIN scoop ON scoopsincone.scoopID= scoop.ID
    WHERE coneID = coneNumber AND (name = "Macadamia" OR name = "Coconut")) THEN RETURN FALSE;
    ELSE RETURN TRUE;
    END IF;
END ++
DELIMITER ;