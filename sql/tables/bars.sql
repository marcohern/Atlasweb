DROP TABLE IF EXISTS bars;

CREATE TABLE bars (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name        VARCHAR(64)    NOT NULL,
	slug        VARCHAR(32)    NOT NULL UNIQUE,
	category    VARCHAR(32)    NOT NULL,
	description MEDIUMTEXT     NOT NULL,
	city        VARCHAR(32)    NOT NULL,
	province    VARCHAR(32)    NOT NULL,
	address     VARCHAR(255)   NOT NULL,
	phones      VARCHAR(64)    NOT NULL,
	lng         DECIMAL(17,14) NOT NULL,
	lat         DECIMAL(17,14) NOT NULL,
	hits        INTEGER        NOT NULL DEFAULT 0,
	likes       INTEGER        NOT NULL DEFAULT 0,
	enabled     ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	created     DATETIME       NOT NULL,
	updated     DATETIME           NULL
)CHARSET utf8 COLLATE utf8_general_ci;

