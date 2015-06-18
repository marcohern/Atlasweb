DROP TABLE IF EXISTS bars_categories;

CREATE TABLE bars_categories (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	slug		VARCHAR(32)    NOT NULL,
	name        VARCHAR(64)    NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;

