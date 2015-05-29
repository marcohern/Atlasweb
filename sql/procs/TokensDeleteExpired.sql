
DELIMITER $$

DROP PROCEDURE IF EXISTS  TokensDeleteExpired$$

CREATE PROCEDURE TokensDeleteExpired()
BEGIN
	DELETE FROM tokens WHERE expires > NOW();
END$$

DELIMITER ;

