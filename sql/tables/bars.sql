
DROP TABLE IF EXISTS bars;

CREATE TABLE bars (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name        VARCHAR(64)    NOT NULL,
	slug        VARCHAR(32)    NOT NULL UNIQUE,
	category_id BIGINT         NOT NULL,
	franchise_id BIGINT            NULL,
	description MEDIUMTEXT     NOT NULL,
	city_id     BIGINT		   NOT NULL,
	zone_id     BIGINT		       NULL,
	address     VARCHAR(255)   NOT NULL,
	phones      VARCHAR(64)    NOT NULL,
	lat         DECIMAL(17,14) NOT NULL,
	lng         DECIMAL(17,14) NOT NULL,
	price       DECIMAL(15,2)  NOT NULL DEFAULT 0,
	cover       DECIMAL(15,2)  NOT NULL DEFAULT 0,
	color		ENUM('RED','GREEN','PINK','PURPLE','PURPLE_B','BLUE','BLUE_C','CYAN','CYAN_B','ORANGE','DEEP_ORANGE','BROWN','GRAY') NOT NULL,
	genre		SET('Rock','Pop','Rap','Ska','Reggae','Blues','Jazz','Lounge','Clasica','Reggaeton','Salsa','Cumbia','Electronica','Crossover') NOT NULL DEFAULT '',
	hits        INTEGER        NOT NULL DEFAULT 0,
	likes       INTEGER        NOT NULL DEFAULT 0,
	enabled     ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	verified    ENUM('TRUE','FALSE') NOT NULL DEFAULT 'FALSE',
	ex_image_url VARCHAR(255) NOT NULL DEFAULT '',
	created     DATETIME       NOT NULL,
	updated     DATETIME           NULL
)CHARSET utf8 COLLATE utf8_general_ci;

