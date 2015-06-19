DROP TABLE IF EXISTS bars_franchises;

CREATE TABLE bars_franchises (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	slug		VARCHAR(32)    NOT NULL,
	name        VARCHAR(64)    NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;

