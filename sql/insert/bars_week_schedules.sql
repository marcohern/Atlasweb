INSERT INTO bars_week_schedules(id, bar_id, start_week_day, end_week_day, start_day_time, end_day_time, sep, created) VALUES
( 1,1,'MON','SAT' ,'12:00:00','18:30:00','-',NOW()),
( 2,1,'SUN','*HOL','13:00:00','16:30:00','/',NOW()),
( 3,2,'MON','SAT' ,'12:00:00','18:30:00','-',NOW()),
( 4,2,'SUN','*HOL','13:00:00','16:30:00','/',NOW()),
( 5,3,'MON','SAT' ,'12:00:00','18:30:00','-',NOW()),
( 6,3,'SUN','*HOL','13:00:00','16:30:00','/',NOW()),
( 7,4,'MON','SAT' ,'12:00:00','18:30:00','-',NOW()),
( 8,4,'SUN','*HOL','13:00:00','16:30:00','/',NOW()),
( 9,5,'MON','SAT' ,'12:00:00','18:30:00','-',NOW()),
(10,5,'SUN','*HOL','13:00:00','16:30:00','/',NOW());

