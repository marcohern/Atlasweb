DROP TABLE IF EXISTS apps;

CREATE TABLE apps (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(32) NOT NULL UNIQUE,
	sender_id VARCHAR(32) NOT NULL,
	sender_secret VARCHAR(32) NOT NULL,
	permissions SET('users','places','events','routes') NOT NULL DEFAULT '',
	created DATETIME NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;
