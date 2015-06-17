DROP TABLE IF EXISTS bars_week_schedules;

CREATE TABLE bars_week_schedules(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	bar_id BIGINT NOT NULL,
	start_week_day ENUM('MON','TUE','WED','THU','FRI','SAT','SUN','*HOL') NOT NULL DEFAULT 'MON',
	end_week_day   ENUM('MON','TUE','WED','THU','FRI','SAT','SUN','*HOL') NULL DEFAULT 'MON',
	start_day_time TIME NOT NULL,
	end_day_time TIME NOT NULL,
	enabled     ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	created     DATETIME       NOT NULL,
	updated     DATETIME           NULL
)CHARSET utf8 COLLATE utf8_general_ci;

