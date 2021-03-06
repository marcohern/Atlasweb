
DROP TABLE IF EXISTS apps;

CREATE TABLE apps (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(32) NOT NULL UNIQUE,
	sender_id VARCHAR(32) NOT NULL,
	sender_secret VARCHAR(32) NOT NULL,
	permissions SET('users','places','events','routes') NOT NULL DEFAULT '',
	created DATETIME NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;

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
	genre		SET('Rock','Pop','Rap','Ska','Reggae','Blues','Jazz','Lounge','Clasica','Reggaeton','Salsa','Cumbia','Electronica','Crossover','Bailables') NOT NULL DEFAULT '',
	hits        INTEGER        NOT NULL DEFAULT 0,
	likes       INTEGER        NOT NULL DEFAULT 0,
	enabled     ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	verified    ENUM('TRUE','FALSE') NOT NULL DEFAULT 'FALSE',
	ex_image_url VARCHAR(255) NOT NULL DEFAULT '',
	created     DATETIME       NOT NULL,
	updated     DATETIME           NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_categories;

CREATE TABLE bars_categories (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	slug		VARCHAR(32)    NOT NULL,
	name        VARCHAR(64)    NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_cities;

CREATE TABLE bars_cities (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	slug VARCHAR(32) NOT NULL UNIQUE,
	province_id BIGINT NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_countries;

CREATE TABLE bars_countries (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	slug VARCHAR(32) NOT NULL UNIQUE,
	iso2 CHAR(2) NOT NULL UNIQUE,
	iso3 CHAR(3) NOT NULL UNIQUE
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_franchises;

CREATE TABLE bars_franchises (
	id          BIGINT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
	slug		VARCHAR(32)    NOT NULL,
	name        VARCHAR(64)    NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_genres;

CREATE TABLE bars_genres(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(32) NOT NULL,
	slug VARCHAR(32) NOT NULL UNIQUE
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_provinces;

CREATE TABLE bars_provinces (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	slug VARCHAR(32) NOT NULL UNIQUE,
	country_id BIGINT NOT NULL,
	iso2 CHAR(6) NOT NULL UNIQUE
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_week_schedules;

CREATE TABLE bars_week_schedules(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	bar_id BIGINT NOT NULL,
	start_week_day ENUM('MON','TUE','WED','THU','FRI','SAT','SUN','*HOL') NOT NULL DEFAULT 'MON',
	end_week_day   ENUM('MON','TUE','WED','THU','FRI','SAT','SUN','*HOL') NULL DEFAULT 'MON',
	start_day_time TIME NOT NULL,
	end_day_time TIME NOT NULL,
	sep CHAR(1) NOT NULL DEFAULT '-',
	enabled     ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	created     DATETIME       NOT NULL,
	updated     DATETIME           NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS bars_zones;

CREATE TABLE bars_zones (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	slug VARCHAR(32) NOT NULL UNIQUE,
	city_id BIGINT NOT NULL,
	lat         DECIMAL(17,14) NOT NULL,
	lng         DECIMAL(17,14) NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS places;

CREATE TABLE places (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	description MEDIUMTEXT NOT NULL,
	lng DECIMAL(17,14) NOT NULL,
	lat DECIMAL(17,14) NOT NULL,
	enabled ENUM('TRUE','FALSE') NOT NULL DEFAULT 'TRUE',
	created DATETIME
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS tokens;

CREATE TABLE tokens (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	user_id BIGINT NOT NULL,
	token CHAR(32) NOT NULL UNIQUE,
	created DATETIME NOT NULL,
	expires DATETIME NOT NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(32) NOT NULL UNIQUE,
	email VARCHAR(128) NOT NULL UNIQUE,
	password CHAR(64) NOT NULL,
	salt  CHAR(40) NOT NULL,
	fname VARCHAR(64) NOT NULL,
	lname VARCHAR(64) NOT NULL,
	role ENUM('ADMIN','USER') NOT NULL DEFAULT 'USER',
	created DATETIME NOT NULL,
	updated DATETIME NULL
)CHARSET utf8 COLLATE utf8_general_ci;


DELIMITER $$

DROP PROCEDURE IF EXISTS  TokensDeleteExpired$$

CREATE PROCEDURE TokensDeleteExpired()
BEGIN
	DELETE FROM tokens WHERE expires > NOW();
END$$

DELIMITER ;


-- Bars
INSERT INTO bars(id,name,slug,category_id,franchise_id,city_id,zone_id,address,phones,ex_image_url,lat,lng,cover,price,color,genre,description,created) VALUES
(1,'BBC Andino','bbc-andino',1,1,1,2,'Cra. 12 No. 83-33','(1)7429292 ext. 311','http://media-cdn.tripadvisor.com/media/photo-s/05/e1/76/20/bogota-beer-company.jpg',4.667483,-74.053242,0,22000,'CYAN','Pop,Rock,Crossover','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu laoreet neque. Vestibulum scelerisque mi a quam faucibus consequat. Duis egestas hendrerit odio, vel scelerisque neque accumsan in. Ut sed metus nisl. Sed ipsum risus, finibus in urna quis, porttitor imperdiet mi. Praesent mattis nunc luctus aliquam aliquam. Cras fermentum sagittis nunc ac dapibus. Vivamus et felis ipsum. Nunc eget quam neque. In ut diam ut felis bibendum luctus eget sit amet risus. Donec eu urna eu metus efficitur gravida. Vivamus non massa eros. Nulla facilisi. Quisque pulvinar auctor nisi eleifend sollicitudin. Integer feugiat tempus metus in tempus. Nullam tempor lorem a justo elementum tincidunt.',NOW()),
(2,'BBC Cedritos','bbc-cedritos',1,1,1,1,'Av. 19 No. 139 – 07','(1)7429292 ext. 315','http://bogotabeercompany.com/wp-content/uploads/2014/06/3.jpg',4.723106,-74.046335,0,22000,'CYAN','Pop,Rock,Crossover','Phasellus tempus venenatis sem, vitae congue ex vehicula vitae. Aliquam eget rutrum ligula. Sed pharetra magna eget lectus bibendum tincidunt. Donec tempus ut eros nec luctus. Ut et eros placerat, pharetra arcu vel, sollicitudin eros. Vivamus tincidunt, neque sit amet pulvinar porttitor, purus ante lacinia sem, vel hendrerit lacus ante nec nisi. Pellentesque tincidunt nisl lectus, in sollicitudin libero maximus ac. Vestibulum laoreet convallis hendrerit. Donec nunc felis, convallis eu imperdiet non, rhoncus et nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',NOW()),
(3,'BBC Salitre','bbc-salitre',1,1,1,16,'Av. Cll. 26 No. 68B – 85','(1)7429292 ext. 318','http://photos.wikimapia.org/p/00/01/43/34/17_big.jpg',4.655589,-74.106444,0,22000,'CYAN','Pop,Rock,Crossover','In interdum a metus at elementum. Donec quis tincidunt elit. Vivamus non velit consectetur magna fermentum aliquam. Aenean pulvinar purus in metus vestibulum, nec scelerisque ipsum sollicitudin. Aenean placerat dui non eros lacinia, a suscipit nisl fringilla. Proin quis elit tellus. Mauris sit amet euismod tortor, non hendrerit purus. Quisque aliquam tempus magna, eget sollicitudin metus porttitor et. Phasellus suscipit vel sem ut maximus. Sed felis mauris, finibus sed tempus sit amet, sollicitudin in sapien. Quisque tortor orci, porta posuere maximus et, condimentum ut nibh. Praesent eu lacinia dolor.',NOW()),
(4,'Joshua Suramericana Salitre','joshua-salitre',1,2,1,16,'Calle 25B #68B-26 Torre Suramericana Local 108','4272944','https://www.google.com.co/search?q=Joshua+Salitre&espv=2&biw=1616&bih=874&source=lnms&tbm=isch&sa=X&ei=FZ-UVbyQDobusAW61ICgAQ&ved=0CAYQ_AUoAQ#tbs=isz:m&tbm=isch&q=Joshua+Salitre&imgrc=t4qsvb5I7jBKTM%3A',4.655441,-74.10641,0,25000,'BROWN','Pop,Rock,Crossover','Phasellus ultrices pulvinar tortor, quis pretium sapien volutpat ac. Mauris in facilisis tellus. Donec accumsan dolor a ligula congue sodales. Nam luctus faucibus erat in dictum. Sed imperdiet posuere ligula nec congue. Quisque aliquet ante sed tincidunt iaculis. Sed quis lobortis magna, nec tempus arcu. Proin lacinia justo vestibulum molestie iaculis. Maecenas urna nisi, aliquet nec vulputate eu, rhoncus quis tortor. Ut sollicitudin sodales magna et finibus. Sed id lacinia enim, ac aliquam diam.',NOW()),
(5,'Joshua Centro Mayor','joshua-cmayor',1,2,1,12,'Centro Mayor Centro Comercial Local 3055','7383072','http://0.kekantoimg.com/7KxEZC43EQ3siJq8UyhzRmXspYo=/fit-in/600x600/s3.amazonaws.com/kekanto_pics/pics/32/785032.jpg',4.593426,-74.124627,0,25000,'BROWN','Pop,Rock,Crossover','Nam vel dui ut risus fringilla molestie at id turpis. Pellentesque id diam vel justo feugiat semper in vitae orci. Aliquam vitae ex tincidunt, commodo lacus ac, euismod est. Etiam gravida blandit tincidunt. Mauris vitae scelerisque ex, sed finibus metus. Integer massa lorem, iaculis id nisl nec, blandit imperdiet eros. Ut mattis risus placerat, tempor turpis eget, vehicula diam. Nunc malesuada aliquet ligula, eget blandit leo pulvinar et. In viverra pellentesque nunc quis euismod. Proin a quam eleifend, imperdiet elit ut, pharetra nunc. Cras augue est, sollicitudin sit amet elementum non, euismod ac justo. Nulla volutpat dolor at turpis pretium, ut efficitur urna rutrum. Cras nec viverra leo, eu eleifend nisl.',NOW()),
(6,'Shamua','shamua',3,NULL,1,2,'Av 19 # 114 - 70','2142691 - 2158530','http://cdn0.matrimonio.com.co/emp/fotos/8/2/4/3/Imagen%2047.jpg',4.697388,-74.050008,0,26000,'BLUE','Pop,Rock,Crossover','Sed velit eros, egestas at lobortis sit amet, euismod eu lorem. Donec id est fermentum augue ultrices laoreet eu non purus. Ut rhoncus tristique justo non dictum. Curabitur ac enim faucibus, fringilla arcu ac, suscipit arcu. Aliquam auctor consequat rhoncus. Sed feugiat dictum bibendum. Cras vulputate luctus sapien. Duis molestie turpis orci, non fermentum nibh ornare et. Proin auctor, turpis ut placerat tempus, sapien lectus lacinia mi, eu egestas diam velit ut nulla. Maecenas molestie nec mi ac scelerisque. Pellentesque pellentesque lectus ut eros tempus bibendum. Nullam facilisis convallis dictum. Duis in pellentesque elit.',NOW()),
(7,'BBC Parque 93','bbc-prq93',1,1,1,2,'Cra. 11A No. 93A – 94 (Parque 93)','(1)7429292 ext. 313','http://photos.wikimapia.org/p/00/01/43/34/13_big.jpg',4.675916,-74.047699,0,22000,'CYAN','Pop,Rock,Crossover','Donec maximus, ex sagittis interdum rhoncus, sem tortor iaculis ligula, vitae eleifend ex enim at orci. Proin dolor eros, sollicitudin sit amet laoreet ut, condimentum non nisl. Mauris eleifend augue velit, sit amet cursus orci tincidunt non. Donec mattis malesuada ante quis pellentesque. Quisque mollis porttitor velit bibendum tristique. Phasellus facilisis dui sit amet leo tempus, sed efficitur enim finibus. Praesent non varius odio. Fusce aliquam velit et auctor vehicula. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NOW()),
(8,'BBC Calle 85','bbc-c85',1,1,1,2,'Cll. 85 No. 13 – 06','(1)7429292 ext. 316','http://res.cloudinary.com/civico/image/upload/c_fill,h_500,w_500/v1/entity/image/file/057/000/52e694ea31e93c1b96000057.jpg',4.669196,-74.053702,0,22000,'CYAN','Pop,Rock,Crossover','Nulla enim dolor, vulputate ut elit id, suscipit porttitor diam. Mauris ut consectetur ante. Cras vitae erat urna. Cras tincidunt viverra vestibulum. Aenean id nulla nec odio egestas fringilla. Donec eget velit libero. Suspendisse accumsan laoreet neque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam bibendum molestie justo ut scelerisque.',NOW()),
(9,'BBC Usaquén','bbc-usaquen',1,1,1,1,'Cra. 6 No. 119 – 24','(1)7429292 ext. 314','http://thecitypaperbogota.com/wp-content/uploads/2012/12/bbc-front-AndresRueda.jpg',4.69575,-74.031067,0,22000,'CYAN','Pop,Rock,Crossover','Morbi a semper odio, ut luctus tellus. Cras vitae aliquam sapien. Duis nec lorem sed odio tristique accumsan porttitor ut neque. Vivamus blandit, enim a commodo tempus, lectus nisl varius mi, eu porta augue magna in magna. Aliquam non ultricies ligula, sed accumsan quam. Integer rutrum odio vitae ex vestibulum, ultricies condimentum risus consectetur. Nam congue enim purus, quis auctor elit imperdiet quis. Duis quis tincidunt massa, at eleifend purus. Mauris a pellentesque mi. Nullam congue diam vitae nisi pharetra fringilla. Nulla porttitor urna a urna bibendum, dignissim scelerisque turpis congue. Curabitur turpis ligula, ultricies aliquam massa ut, euismod volutpat nibh. Sed accumsan nisi quis neque pretium, sit amet tempus tellus vulputate.',NOW()),
(10,'BBC Avenida 19','bbc-av19',1,1,1,1,'Av. 19 No. 120 – 76 ','(1)7429292 ext. 312','http://res.cloudinary.com/civico/image/upload/c_fill,h_628,w_1200/v1/entity/image/file/10f/000/5310ec59820c65cb4300010f.jpg',4.700994,-74.04935,0,22000,'CYAN','Pop,Rock,Crossover','Donec condimentum convallis hendrerit. Vestibulum dapibus leo at dolor feugiat, sed vehicula nibh vulputate. Proin nec iaculis massa. Integer non massa quis purus vehicula lobortis blandit a nunc. Duis fringilla sapien a bibendum varius. Integer luctus volutpat dapibus. Aliquam odio turpis, pretium in auctor vel, pharetra id urna. Mauris non nulla id massa mollis tristique nec at sapien. Nulla eleifend tortor et ultricies volutpat. Nam quis tristique velit, quis vehicula mauris. Morbi tristique augue in auctor tincidunt. Fusce ultricies sodales purus eget mattis. Aenean rhoncus neque egestas molestie tempor. Ut non tempus magna. Proin sed enim tortor. Fusce sem neque, maximus sit amet lacus id, vehicula efficitur nisi.',NOW()),
(11,'BBC San Martín','bbc-san-martin',1,1,1,3,'Cr 7 # 32-48','(1)3509093','http://res.cloudinary.com/civico/image/upload/v1408724011/entity/image/file/017/000/53f76c2ab9dd5d3361000017.jpg',4.618726,-74.068065,0,22000,'CYAN','Pop,Rock,Crossover','Cras quam ipsum, volutpat id imperdiet ut, tincidunt id arcu. Sed ligula nisl, rutrum vel elementum in, interdum vel orci. Duis iaculis nibh eget auctor congue. Quisque ac nulla quis ex aliquet efficitur. Nam ut magna ut diam faucibus maximus. Duis rutrum nec urna eu tincidunt. Aenean porta diam vel mi aliquam, eu eleifend ligula sollicitudin. Nullam non posuere sapien. Pellentesque imperdiet enim vitae consequat placerat. Aliquam malesuada, urna id aliquam imperdiet, nulla dolor feugiat velit, sed accumsan nibh libero sit amet ipsum. Sed bibendum dolor molestie purus rutrum, lobortis ultrices dui cursus.',NOW()),
(12,'BBC La Macarena','bbc-la-macarena',1,1,1,3,'Cra. 4A No. 27 – 04','(1)7429292 ext. 311','http://static.theculturetrip.com/images/56-262915-bbc1.jpg',4.613988,-74.066372,0,22000,'CYAN','Pop,Rock,Crossover','Vivamus feugiat eros sodales bibendum lobortis. Etiam congue risus quam, ut vehicula enim consectetur sit amet. Cras fermentum metus non odio luctus lacinia. Ut tempor eleifend lorem vitae lobortis. In consectetur tristique tempor. Vivamus eleifend hendrerit lorem. Fusce sit amet sodales sapien. Donec tempus diam ut magna laoreet pellentesque. Maecenas facilisis nisi sit amet eros mattis mollis. Donec placerat, risus ut lobortis mattis, tellus sapien tempor nunc, tristique egestas lacus massa ac orci. Vivamus sed augue non felis semper finibus et eu nibh. Quisque rutrum massa et sem pharetra pellentesque. Praesent elit lectus, efficitur sed aliquet vitae, finibus et felis. Proin eu risus vehicula nulla suscipit tincidunt ac eget mauris. In at egestas enim.',NOW()),
(13,'BBC Titan','bbc-titan',1,1,1,15,'Av Calle 80 # 80-94 Centro Comercial Titán Plaza Local 3-58','(1)7422733','http://www.ospinas.com.co/wp-content/uploads/2013/03/bbc.jpg',4.694834,-74.086766,0,22000,'CYAN','Pop,Rock,Crossover','Nam dolor urna, hendrerit id nisi non, volutpat porttitor mauris. Suspendisse fermentum erat sed finibus vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eros sapien, tristique a ultrices quis, congue a libero. Nullam nec pharetra justo, ut semper nunc. Vivamus ut pulvinar felis. Duis sem arcu, feugiat at quam fringilla, viverra condimentum orci. Vivamus ut odio orci. Vestibulum et elementum lacus, et aliquet lorem.',NOW()),
(14,'BBC Pepe Sierra','bbc-pepe-sierra',1,1,1,1,'Cll. 116 No. 16 – 78','(1)7429292 ext. 310','http://bogotabeercompany.com/wp-content/uploads/2014/06/10.jpg',4.697595,-74.046083,0,22000,'CYAN','Pop,Rock,Crossover','Donec mauris augue, vestibulum at aliquet non, facilisis eget neque. Etiam iaculis, nunc non ultrices scelerisque, eros elit vehicula libero, quis consequat justo ipsum non urna. Duis lacus neque, fringilla ac nisi vitae, dignissim hendrerit erat. Maecenas sed diam sit amet nisi semper sagittis id sed orci. Etiam tempor sem quis aliquet commodo. Aliquam sit amet enim fringilla, pretium augue ut, sagittis justo. Fusce tristique ullamcorper tincidunt. Curabitur non elementum est, quis interdum tortor. Aenean vulputate maximus finibus. Donec dolor odio, convallis ac ligula id, commodo facilisis diam. Sed porta id sapien id placerat.',NOW()),
(15,'BBC Galerias','bbc-galerias',1,1,1,2,'Cr 24 # 53-66','(1)3002729','http://www.citybog.com/images/est_photo2_1671bbcusaquentwo.jpg',4.642533,-74.073827,0,22000,'CYAN','Pop,Rock,Crossover','Aenean at libero molestie, tempor lectus ut, pretium mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere nulla sed laoreet efficitur. Donec sagittis finibus felis, et facilisis lectus pretium vel. Etiam id augue id diam blandit pulvinar at vitae est. Vestibulum gravida luctus eros, vitae aliquet libero vestibulum quis. Nunc sollicitudin, justo bibendum ornare accumsan, augue mauris lacinia eros, ut sodales quam velit quis nisi. Nunc a tincidunt tellus. Cras mattis vel lorem vel ultricies.',NOW()),
(16,'BBC Centro Mayor','bbc-cmayor',1,1,1,12,'Av NQS – 38A Sur Centro Comercial Centro Mayor Local 351-352','(1)3002729','http://bogotabeercompany.com/wp-content/uploads/2014/07/26.jpg',4.592084,-74.123785,0,22000,'CYAN','Pop,Rock,Crossover','Vestibulum vitae ullamcorper felis. Aliquam vulputate sit amet metus non finibus. Curabitur hendrerit leo quis fringilla dignissim. Aliquam ut turpis malesuada, hendrerit diam eu, luctus dui. Ut eget cursus nulla. Cras sed viverra ligula. Vestibulum et ornare massa, non consectetur magna. Sed tincidunt neque cursus justo pretium, eu tincidunt ipsum interdum. Integer posuere tristique odio et tristique. Nullam non turpis varius purus congue efficitur nec vitae nisi. Nam mattis mi a arcu porttitor tincidunt. Maecenas aliquam congue porttitor. Donec fringilla, orci nec dictum egestas, purus justo tincidunt nunc, sit amet aliquet ipsum metus auctor dui.',NOW()),
(17,'BBC Rosales','bbc-rosales',1,1,1,5,'Cra. 5 No. 71A – 75','(1)7429292 ext. 317','http://bogotabeercompany.com/wp-content/uploads/2014/06/20.jpg',4.654109,-74.053742,0,22000,'CYAN','Pop,Rock,Crossover','Cras sollicitudin vel ligula non aliquam. Donec ullamcorper facilisis vehicula. Suspendisse placerat libero eget neque tristique facilisis. Fusce quis enim mauris. Proin elementum risus ornare, mollis est non, fermentum erat. Pellentesque eget malesuada ex. Morbi tincidunt vulputate iaculis. Pellentesque mi magna, laoreet eu erat sed, bibendum vestibulum nibh. Nam id metus est. Mauris auctor volutpat bibendum. Fusce sollicitudin blandit quam a vehicula. Aenean tincidunt massa a tincidunt posuere. Fusce vitae purus tempor odio egestas dapibus ut ut tellus. Cras et urna hendrerit, placerat leo id, rhoncus elit. Phasellus purus tortor, porttitor vitae euismod nec, lacinia eu quam. Sed fringilla, mauris volutpat dapibus venenatis, ex felis volutpat enim, nec aliquet felis eros ac quam.',NOW()),
(18,'BBC La Candelaria','bbc-candelaria',1,1,1,4,'Calle 12D No. 4-02','(1)7429292 ext. 312','http://bogotabeercompany.com/wp-content/uploads/2014/06/30.jpg',4.600257,-74.070481,0,22000,'CYAN','Pop,Rock,Crossover','Proin rutrum nisi sit amet pulvinar mattis. Maecenas volutpat, nisl in iaculis facilisis, neque risus tempor leo, in gravida lacus libero vitae ex. Nulla quis ornare mauris. Proin dapibus, ipsum eu tempus pulvinar, erat massa tincidunt metus, sed cursus metus lectus in enim. Aenean aliquet elit sollicitudin dolor varius, a vestibulum diam fringilla. Phasellus suscipit interdum ornare. Suspendisse vulputate justo lectus, sed sodales urna dignissim ac. Aliquam suscipit imperdiet tellus, quis lobortis quam dignissim id. Aliquam erat volutpat. Vestibulum ultricies, sem eget tempus iaculis, leo nisl eleifend tortor, id sagittis orci ante ac risus. Praesent mi lectus, mattis eget tempus ut, tristique sed sapien. Quisque sit amet auctor leo, ac tempor tellus.',NOW()),
(19,'BBC Plaza de las Americas','bbc-plz-americas',1,1,1,18,'C.C. Plaza de las Américas Local 17-23','(1)7429292 Ext. 319','http://photos.wikimapia.org/p/00/01/43/34/21_big.jpg',4.618512,-74.134443,0,22000,'CYAN','Pop,Rock,Crossover','Aenean velit nisi, aliquet ac convallis vitae, sagittis nec diam. Aliquam ultrices mauris id magna fringilla, nec elementum dolor luctus. Nullam dictum euismod dolor eget tincidunt. Sed pellentesque scelerisque imperdiet. Pellentesque tincidunt condimentum congue. Donec posuere dolor ac lacinia accumsan. Fusce vel consectetur mauris. In fringilla lacinia elementum. Maecenas consectetur urna a malesuada malesuada. In viverra, enim ac maximus tempor, ligula odio fringilla enim, et bibendum quam velit eu erat. Mauris non mi a ex viverra sodales. Morbi efficitur at ex ac pellentesque. Phasellus convallis pellentesque nisi, non feugiat sapien pharetra non. Donec nec sollicitudin nunc, nec hendrerit nibh.',NOW()),
(20,'BBC Belaire','bbc-belaire',1,1,1,1,'Calle 153 #6-65. Locales 5a-5b','(1) 7429292 Ext: 323','http://res.cloudinary.com/civico/image/upload/v1403899200/entity/image/file/009/000/53adcd33b9dd5d084e000009.jpg',4.727324,-74.024496,0,22000,'CYAN','Pop,Rock,Crossover','Proin nec quam eu leo condimentum maximus et ut augue. Sed varius sit amet turpis sed aliquet. Aliquam erat volutpat. Sed ultrices, ex eget dignissim vulputate, erat velit sollicitudin quam, eu ornare nunc nulla sit amet ipsum. In id enim aliquet, imperdiet quam vel, facilisis ipsum. Sed molestie lectus eu nunc interdum, sed condimentum neque mattis. Vestibulum consectetur mi ut ante feugiat commodo. Ut et nibh sodales, rutrum arcu vitae, tempor lacus. Phasellus rutrum massa non ante auctor posuere. Fusce nec velit eget mi ultricies porttitor non ac purus. Quisque justo ante, fringilla quis vestibulum ut, sagittis in nulla. Donec sed dapibus libero. Morbi cursus mi nibh, sit amet convallis ante cursus ut. Etiam ultrices viverra ipsum. Pellentesque urna ligula, accumsan ut gravida vel, scelerisque et ipsum.',NOW()),
(21,'BBC Chia','bbc-chia',1,1,2,1,'Avenida Pradilla # 5-31. Local1-39 C.C Plaza Mayor Chía','(1) 7429292 Ext: 321','http://photos.wikimapia.org/p/00/01/43/34/23_big.jpg',4.865091,-74.040017,0,22000,'CYAN','Pop,Rock,Crossover','Suspendisse ex sem, ornare lobortis tempus et, interdum quis orci. Aliquam erat volutpat. Praesent dignissim eget ipsum id imperdiet. Nunc aliquam vulputate orci, pharetra blandit neque lacinia id. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras nulla urna, sagittis eget tellus faucibus, pharetra imperdiet nulla. Nunc ligula dui, venenatis a porttitor sit amet, blandit non velit. Aenean ullamcorper, est porttitor fermentum venenatis, erat velit tincidunt nibh, eu mattis lorem magna eu augue. Aliquam turpis enim, ultricies imperdiet leo ac, viverra tempor urna. Sed convallis, tortor sed convallis suscipit, velit ipsum ornare sapien, quis lobortis justo risus ultricies neque. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc efficitur, quam ac tincidunt fermentum, odio nulla ultricies diam, vel ultrices turpis quam nec tellus. Mauris pulvinar enim mattis arcu ornare, facilisis vulputate ligula maximus. Aenean vel fermentum eros. Ut fringilla ac enim sed tempor. Aenean hendrerit tincidunt pretium.',NOW()),
(22,'Joshua Portal 80','joshua-portal80',1,2,1,15,'Centro Comercial Portal 80 Local N2 005','4911172','http://res.cloudinary.com/civico/image/upload/v1/entity/image/file/764/000/52dd2cc031e93cbe82000764.jpg',4.711345,-74.112951,0,25000,'BROWN','Pop,Rock,Crossover','Cras sagittis interdum turpis, quis sagittis diam fringilla quis. Fusce semper nibh dui, sit amet ullamcorper ex finibus nec. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras est eros, vulputate id lacinia finibus, interdum vel erat. Donec venenatis erat sed est aliquet maximus. Curabitur laoreet, leo sit amet lobortis consectetur, lectus nulla varius velit, id ultricies nisi nibh varius nisi. Vivamus eu mauris eu dolor ullamcorper feugiat.',NOW()),
(23,'Joshua Gran Estación','joshua-gran-estacion',1,2,1,16,'Centro Comercial Gran Estación Local 10-59','2213574','http://res.cloudinary.com/civico/image/upload/c_fill,h_500,w_500/v1/entity/image/file/764/000/52dd2cc031e93cbe82000764.jpg',4.64723,-74.101956,0,25000,'BROWN','Pop,Rock,Crossover','Morbi sit amet nulla velit. Fusce ac turpis quis tortor mattis mattis quis quis ipsum. Integer tincidunt pharetra ante, vel vehicula quam eleifend vel. Vivamus sollicitudin libero quis ex pharetra, porttitor venenatis enim commodo. Phasellus sit amet odio vel justo pulvinar scelerisque in quis sapien. Donec et dictum ante. Nullam et augue eu risus dictum dictum. Praesent vel ipsum at turpis bibendum tempor mollis vitae ligula. Donec luctus, nisi nec cursus viverra, lorem elit posuere sem, vitae lacinia neque velit cursus nulla. Nam finibus eu neque ut efficitur. Etiam elementum odio tellus, id tincidunt nisl lacinia vitae. Vivamus mollis at ante sed viverra. Cras malesuada diam eget facilisis suscipit.',NOW()),
(24,'Joshua Calima','joshua-calima',1,2,1,10,'Calima Centro Comercial Local C-01 Tercer Piso','3786145','https://s-media-cache-ak0.pinimg.com/736x/57/3d/80/573d8075ba935ee3474340146ee38704.jpg',4.617798,-74.08634,0,25000,'BROWN','Pop,Rock,Crossover','Vivamus et turpis sagittis, congue mi non, facilisis ante. Nullam quis tempus turpis, at feugiat ex. Fusce sed feugiat mauris, blandit pretium diam. Donec sed diam justo. Fusce ac justo sollicitudin, mattis mauris et, maximus nisl. Sed viverra arcu sed ultrices blandit. Morbi vulputate cursus purus, nec imperdiet augue. Sed ultrices dolor a mattis molestie.',NOW()),
(25,'Joshua Titan Plaza','joshua-titan',1,2,1,15,'Titán Plaza Centro Comercial Local 4-19 - 4-20 Terraza','7362119','https://s-media-cache-ak0.pinimg.com/736x/57/3d/80/573d8075ba935ee3474340146ee38704.jpg',4.69518,-74.086625,0,25000,'BROWN','Pop,Rock,Crossover','Sed egestas congue nisl eget luctus. Fusce vitae convallis metus. In accumsan feugiat tortor, sit amet ultrices tortor hendrerit sit amet. Phasellus ac dolor et tellus interdum tempus. Proin ullamcorper est et est malesuada congue. Duis vehicula quis purus sit amet varius. Suspendisse ut augue a libero venenatis pretium et mattis est. Nam interdum et dolor in rutrum. Proin auctor erat lectus, eu venenatis velit gravida lobortis. Vivamus ornare sollicitudin urna vitae aliquam. Suspendisse odio lorem, volutpat non facilisis ut, aliquam in diam. Praesent placerat congue augue et lobortis. Donec mattis neque hendrerit, facilisis tellus tristique, commodo massa. Praesent nunc eros, eleifend et rhoncus eget, euismod eget nibh. Praesent auctor tortor vel leo malesuada, quis tristique risus cursus. Morbi suscipit dapibus sapien eu maximus.',NOW()),
(26,'Chamois - Calle 85','chamois-c85',1,2,1,2,'Calle 85 No. 11 - 69','2183071','http://goguiadelocio.com.co/wordpress/wp-content/uploads/2014/03/KUKARAMAKARA-RUMBA.jpg',4.66815,-74.05218,0,30000,'RED','Reggae,Ska,Rap,Reggaeton','Quisque aliquet scelerisque lacus, sit amet efficitur purus accumsan ac. Morbi pharetra cursus aliquet. Praesent sed metus fermentum, viverra arcu at, hendrerit sem. Donec eu finibus ante. Nam mollis fermentum mattis. Duis suscipit sed lorem non vulputate. Curabitur semper, lacus in porta ullamcorper, dui dolor euismod dolor, vitae cursus lorem nulla eget urna. Aliquam a tincidunt eros. Etiam tempor mattis diam, non venenatis massa pretium tincidunt. Maecenas euismod ligula ipsum, a fringilla odio sodales id. Ut nulla nulla, scelerisque sodales ultricies sit amet, gravida ac orci. Fusce eu congue quam. Sed gravida tortor eu urna pulvinar congue eu vitae sem. Integer a congue nisl.',NOW()),
(27,'Irish Pub - La Candelaria','irish-pub-candelaria',1,5,1,4,'Carrera 3 # 12-37','284-9351','http://media-cdn.tripadvisor.com/media/photo-s/05/c3/48/85/en-la-zona-rosa.jpg',4.597251,-74.071113,0,24000,'RED','Pop,Rock,Crossover','Sed ut consectetur risus. Nam enim nibh, sodales id sagittis non, posuere ac quam. Cras ultricies eros felis, non volutpat ex blandit sodales. Sed pulvinar ipsum enim, ut scelerisque tellus aliquet et. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras ac dolor et tellus imperdiet blandit vitae ut felis. Proin ac ante felis. Phasellus eget lectus dignissim, fermentum mauris et, vulputate tellus. In in mi eros. Integer at fringilla velit, nec convallis dui. Sed eget ullamcorper metus, vitae aliquam diam. Fusce congue leo justo, sit amet convallis tellus sollicitudin congue. Nam aliquet turpis facilisis neque viverra, quis convallis sem porta.',NOW()),
(28,'Irish Pub - Zona T','irish-pub-zona-t',1,5,1,2,'Carrera 12A No. 83-48','691-8711','http://res.cloudinary.com/civico/image/upload/v1/entity/image/file/06d/000/52e699ad31e93c1b9600006d.jpg',4.667704,-74.053757,0,24000,'RED','Pop,Rock,Crossover','Duis tempus nulla eu vestibulum fringilla. Praesent tempus placerat nulla, ut consectetur nulla euismod sit amet. Cras ac tempus mi. Suspendisse potenti. Morbi et tempor eros, et porta nisl. Nunc nec justo non sem laoreet ullamcorper. Curabitur neque ligula, dapibus sit amet ex in, scelerisque congue odio. Suspendisse porta mi massa, a pharetra nisl imperdiet sit amet.',NOW()),
(29,'Irish Pub - Usaquén','irish-pub-usaquen',1,5,1,1,'Carrera 6A No. 117-45','213-4157','http://res.cloudinary.com/civico/image/upload/v1/entity/image/file/183/000/53179ae0820c659a84000183.jpg',4.694697,-74.031654,0,24000,'RED','Pop,Rock,Crossover','Cras lectus libero, condimentum imperdiet orci at, vehicula faucibus lacus. Curabitur ut tortor at lacus dictum accumsan in sed sem. Cras ut cursus urna. Aenean tempus rutrum velit, vitae sollicitudin eros mollis sit amet. Vestibulum id sapien erat. Integer dictum ipsum in nulla interdum semper. Quisque in tincidunt nisl, id pretium ex. Aliquam non vestibulum lectus. Pellentesque sagittis sodales purus, ut vestibulum nibh porta nec. Donec vel mattis odio.',NOW()),
(30,'Irish Pub - Avenida 19','irish-pub-av19',1,5,1,1,'Av 19 #120-50','-','http://www.dublin-pub.co/wp-content/uploads/2013/12/av19-2.jpg',4.700904,-74.049406,0,24000,'RED','Pop,Rock,Crossover','Mauris neque nunc, tempus in commodo at, fermentum id nisl. Nunc blandit sapien ac vehicula elementum. Nunc sodales rhoncus nunc. Sed feugiat, augue placerat accumsan eleifend, est velit viverra nunc, sed maximus arcu est a ipsum. Pellentesque ut vulputate ligula. Pellentesque mi tellus, consequat eu varius vitae, cursus quis nisl. Mauris non mi euismod, fringilla lorem et, viverra ex. Maecenas in tristique nunc. Aliquam lacus elit, dictum ut dolor quis, accumsan cursus tortor. Nam tristique mollis malesuada. Vestibulum tempor fringilla tellus nec venenatis. Cras mattis consequat velit, vitae aliquet libero volutpat a. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',NOW()),
(31,'Gaira Café Cumbia House','gaira',3,NULL,1,2,'Cra 13 #96 - 11','746 2696','http://www.elnuevosiglo.com.co/sites/default/files/imagecache/400xY/fOTOGAIRA.png',4.680583,-74.047543,0,35000,'ORANGE','Reggae,Ska,Rap,Reggaeton,Salsa,Cumbia','Aliquam consequat ex dui, at hendrerit diam consectetur ut. Mauris arcu libero, rutrum id odio et, laoreet lacinia neque. Duis placerat nibh sed diam tempor aliquam. Nulla vestibulum aliquam est, scelerisque eleifend sapien auctor id. Curabitur magna mi, tincidunt nec iaculis pretium, malesuada vel nisi. Nunc pretium sodales fermentum. Sed condimentum mi vel luctus pretium. Pellentesque vulputate lacus eget ipsum lobortis semper. Nulla malesuada sed ipsum quis consequat.',NOW()),
(32,'Milú Disco','milu',2,NULL,1,2,'Carrera 27 No. 52-61','3007433431-3013306289','http://res.cloudinary.com/civico/image/upload/c_fill,h_628,w_1200/v1421855007/entity/image/file/067/003/5240520731e93c9b60003067.jpg',4.64189,-74.075979,10000,30000,'GREEN','Rap,Reggaeton,Salsa,Cumbia','Morbi id nisl justo. Phasellus vestibulum convallis tellus, eu mattis massa ullamcorper ut. Nulla convallis massa in dignissim finibus. Donec bibendum luctus dolor, vel pharetra lectus aliquam porta. Aliquam a mi mauris. Nam eu imperdiet augue. Ut pellentesque velit efficitur, rhoncus erat vel, luctus urna. Praesent eget est dolor. Etiam tempor a metus quis cursus. Quisque quis lorem magna. Etiam massa metus, mollis sed nulla eu, tincidunt elementum enim. Phasellus interdum metus id mi commodo dictum. Sed interdum augue vitae diam varius pretium. Nam eget risus a lorem eleifend tempor sit amet et lectus.',NOW()),
(33,'Casino Caribe Centro','casino-caribe-centro',6,6,1,4,'Cra. 7 No. 21-70','3346869','http://res.cloudinary.com/civico/image/upload/v1422027195/entity/image/file/5e9/000/51cdf00531e93c9ce90005e9.jpg',4.607701,-74.070793,0,45000,'RED','Lounge','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu laoreet neque. Vestibulum scelerisque mi a quam faucibus consequat. Duis egestas hendrerit odio, vel scelerisque neque accumsan in. Ut sed metus nisl. Sed ipsum risus, finibus in urna quis, porttitor imperdiet mi. Praesent mattis nunc luctus aliquam aliquam. Cras fermentum sagittis nunc ac dapibus. Vivamus et felis ipsum. Nunc eget quam neque. In ut diam ut felis bibendum luctus eget sit amet risus. Donec eu urna eu metus efficitur gravida. Vivamus non massa eros. Nulla facilisi. Quisque pulvinar auctor nisi eleifend sollicitudin. Integer feugiat tempus metus in tempus. Nullam tempor lorem a justo elementum tincidunt.',NOW()),
(34,'Casino Caribe Plaza','casino-caribe-plaza',6,6,1,18,'CC Plaza de las Americas- Local 2925 y 2729 Entrada 2','4478224','http://www.travelers.com.co/images/made/images/uploads/alianzas/casino_caribe_650_250_c1.jpg',4.620052,-74.135297,0,45000,'RED','Lounge','Phasellus tempus venenatis sem, vitae congue ex vehicula vitae. Aliquam eget rutrum ligula. Sed pharetra magna eget lectus bibendum tincidunt. Donec tempus ut eros nec luctus. Ut et eros placerat, pharetra arcu vel, sollicitudin eros. Vivamus tincidunt, neque sit amet pulvinar porttitor, purus ante lacinia sem, vel hendrerit lacus ante nec nisi. Pellentesque tincidunt nisl lectus, in sollicitudin libero maximus ac. Vestibulum laoreet convallis hendrerit. Donec nunc felis, convallis eu imperdiet non, rhoncus et nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',NOW()),
(35,'Casino Caribe Unicentro','casino-caribe-unicentro',6,6,1,1,'CC Unicentro Local 2241','2138300','http://www.unicentrobogota.com/wp-content/uploads/Casino_Caribe_Local_2-241_Unicentro_Bogota1.jpg',4.703253,-74.041476,0,45000,'RED','Lounge','In interdum a metus at elementum. Donec quis tincidunt elit. Vivamus non velit consectetur magna fermentum aliquam. Aenean pulvinar purus in metus vestibulum, nec scelerisque ipsum sollicitudin. Aenean placerat dui non eros lacinia, a suscipit nisl fringilla. Proin quis elit tellus. Mauris sit amet euismod tortor, non hendrerit purus. Quisque aliquam tempus magna, eget sollicitudin metus porttitor et. Phasellus suscipit vel sem ut maximus. Sed felis mauris, finibus sed tempus sit amet, sollicitudin in sapien. Quisque tortor orci, porta posuere maximus et, condimentum ut nibh. Praesent eu lacinia dolor.',NOW()),
(36,'Casino Broadway Centro','casino-broadway-centro',6,7,1,4,'Cra.9 No.17-25','3419157','http://www.winnergroup.com/images/casinos/casinos_3_1334277373.png',4.604949,-74.073946,0,42000,'BLUE','Lounge','Phasellus ultrices pulvinar tortor, quis pretium sapien volutpat ac. Mauris in facilisis tellus. Donec accumsan dolor a ligula congue sodales. Nam luctus faucibus erat in dictum. Sed imperdiet posuere ligula nec congue. Quisque aliquet ante sed tincidunt iaculis. Sed quis lobortis magna, nec tempus arcu. Proin lacinia justo vestibulum molestie iaculis. Maecenas urna nisi, aliquet nec vulputate eu, rhoncus quis tortor. Ut sollicitudin sodales magna et finibus. Sed id lacinia enim, ac aliquam diam.',NOW()),
(37,'Casino Broadway Jiménez','casino-broadway-jimenez',6,7,1,4,'Av. Jiménez No.8 -71','2822109','http://www.winnergroup.com/images/casinos/casinos_3_1334277373.png',4.602208,-74.075216,0,42000,'BLUE','Lounge','Nam vel dui ut risus fringilla molestie at id turpis. Pellentesque id diam vel justo feugiat semper in vitae orci. Aliquam vitae ex tincidunt, commodo lacus ac, euismod est. Etiam gravida blandit tincidunt. Mauris vitae scelerisque ex, sed finibus metus. Integer massa lorem, iaculis id nisl nec, blandit imperdiet eros. Ut mattis risus placerat, tempor turpis eget, vehicula diam. Nunc malesuada aliquet ligula, eget blandit leo pulvinar et. In viverra pellentesque nunc quis euismod. Proin a quam eleifend, imperdiet elit ut, pharetra nunc. Cras augue est, sollicitudin sit amet elementum non, euismod ac justo. Nulla volutpat dolor at turpis pretium, ut efficitur urna rutrum. Cras nec viverra leo, eu eleifend nisl.',NOW()),
(38,'Casino Broadway Kennedy','casino-broadway-kennedy',6,7,1,18,'Cra. 76 No. 35c-18 sur','2736339','http://www.winnergroup.com/images/casinos/casinos_3_1334277373.png',4.618111,-74.133974,0,42000,'BLUE','Lounge','Sed velit eros, egestas at lobortis sit amet, euismod eu lorem. Donec id est fermentum augue ultrices laoreet eu non purus. Ut rhoncus tristique justo non dictum. Curabitur ac enim faucibus, fringilla arcu ac, suscipit arcu. Aliquam auctor consequat rhoncus. Sed feugiat dictum bibendum. Cras vulputate luctus sapien. Duis molestie turpis orci, non fermentum nibh ornare et. Proin auctor, turpis ut placerat tempus, sapien lectus lacinia mi, eu egestas diam velit ut nulla. Maecenas molestie nec mi ac scelerisque. Pellentesque pellentesque lectus ut eros tempus bibendum. Nullam facilisis convallis dictum. Duis in pellentesque elit.',NOW()),
(39,'Casino Broadway Andino','casino-broadway-andino',6,7,1,2,'Centro Comercial Andino- Local 301','6169012','http://esphoto980x880.mnstatic.com/centro-comercial-andino_7367658.jpg',4.666671,-74.053525,0,42000,'BLUE','Lounge','Donec maximus, ex sagittis interdum rhoncus, sem tortor iaculis ligula, vitae eleifend ex enim at orci. Proin dolor eros, sollicitudin sit amet laoreet ut, condimentum non nisl. Mauris eleifend augue velit, sit amet cursus orci tincidunt non. Donec mattis malesuada ante quis pellentesque. Quisque mollis porttitor velit bibendum tristique. Phasellus facilisis dui sit amet leo tempus, sed efficitur enim finibus. Praesent non varius odio. Fusce aliquam velit et auctor vehicula. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NOW()),
(40,'Casino Broadway Unicentro','casino-broadway-unicentro',6,7,1,1,'Centro Comercial Unicentro-Local 207','2146859','http://www.winnergroup.com/images/casinos/casinos_3_1334277373.png',4.702847,-74.041751,0,42000,'BLUE','Lounge','Nulla enim dolor, vulputate ut elit id, suscipit porttitor diam. Mauris ut consectetur ante. Cras vitae erat urna. Cras tincidunt viverra vestibulum. Aenean id nulla nec odio egestas fringilla. Donec eget velit libero. Suspendisse accumsan laoreet neque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam bibendum molestie justo ut scelerisque.',NOW()),
(41,'Casino Broadway Metropolis','casino-broadway-metropolis',6,7,1,15,'Centro Comercial Metropolis-Local 177','2259365','http://res.cloudinary.com/civico/image/upload/v1401927818/entity/image/file/02c/000/538fb889b9dd5dc34900002c.jpg',4.680585,-74.082262,0,42000,'BLUE','Lounge','Morbi a semper odio, ut luctus tellus. Cras vitae aliquam sapien. Duis nec lorem sed odio tristique accumsan porttitor ut neque. Vivamus blandit, enim a commodo tempus, lectus nisl varius mi, eu porta augue magna in magna. Aliquam non ultricies ligula, sed accumsan quam. Integer rutrum odio vitae ex vestibulum, ultricies condimentum risus consectetur. Nam congue enim purus, quis auctor elit imperdiet quis. Duis quis tincidunt massa, at eleifend purus. Mauris a pellentesque mi. Nullam congue diam vitae nisi pharetra fringilla. Nulla porttitor urna a urna bibendum, dignissim scelerisque turpis congue. Curabitur turpis ligula, ultricies aliquam massa ut, euismod volutpat nibh. Sed accumsan nisi quis neque pretium, sit amet tempus tellus vulputate.',NOW()),
(42,'Casino Rio','casino-rio',6,NULL,1,1,'Av.19 No.122-64','2131014','http://bingueros.com/image.php/images/articulos/5735/1323964014.png?width=422&cropratio=1.2:1&image=/images/articulos/5735/1323964014.png',4.70221,-74.049221,0,45000,'GREEN','Lounge','Donec condimentum convallis hendrerit. Vestibulum dapibus leo at dolor feugiat, sed vehicula nibh vulputate. Proin nec iaculis massa. Integer non massa quis purus vehicula lobortis blandit a nunc. Duis fringilla sapien a bibendum varius. Integer luctus volutpat dapibus. Aliquam odio turpis, pretium in auctor vel, pharetra id urna. Mauris non nulla id massa mollis tristique nec at sapien. Nulla eleifend tortor et ultricies volutpat. Nam quis tristique velit, quis vehicula mauris. Morbi tristique augue in auctor tincidunt. Fusce ultricies sodales purus eget mattis. Aenean rhoncus neque egestas molestie tempor. Ut non tempus magna. Proin sed enim tortor. Fusce sem neque, maximus sit amet lacus id, vehicula efficitur nisi.',NOW()),
(43,'Hollywood Casino','hollywood-casino',6,NULL,1,15,'Centro Comercial Bulevar Niza – Local 181','2265613','http://res.cloudinary.com/civico/image/upload/v1421793837/entity/image/file/5e5/000/51ce0c6c31e93c40670005e5.jpg',4.712027,-74.07166,0,43000,'GREEN','Lounge','Cras quam ipsum, volutpat id imperdiet ut, tincidunt id arcu. Sed ligula nisl, rutrum vel elementum in, interdum vel orci. Duis iaculis nibh eget auctor congue. Quisque ac nulla quis ex aliquet efficitur. Nam ut magna ut diam faucibus maximus. Duis rutrum nec urna eu tincidunt. Aenean porta diam vel mi aliquam, eu eleifend ligula sollicitudin. Nullam non posuere sapien. Pellentesque imperdiet enim vitae consequat placerat. Aliquam malesuada, urna id aliquam imperdiet, nulla dolor feugiat velit, sed accumsan nibh libero sit amet ipsum. Sed bibendum dolor molestie purus rutrum, lobortis ultrices dui cursus.',NOW()),
(44,'La Villa','la-villa',2,NULL,1,2,'Cra. 14a #83-56','313 236 4413','http://static.wixstatic.com/media/01b297_99c833ab1ece455c87e668306dc2bd1b.jpg_srb_p_1197_798_75_22_0.50_1.20_0.00_jpg_srb',4.668928,-74.055085,15000,22000,'RED','Rock,Crossover,Pop,Reggae,Ska,Rap,Reggaeton,Salsa,Electronica','Vivamus feugiat eros sodales bibendum lobortis. Etiam congue risus quam, ut vehicula enim consectetur sit amet. Cras fermentum metus non odio luctus lacinia. Ut tempor eleifend lorem vitae lobortis. In consectetur tristique tempor. Vivamus eleifend hendrerit lorem. Fusce sit amet sodales sapien. Donec tempus diam ut magna laoreet pellentesque. Maecenas facilisis nisi sit amet eros mattis mollis. Donec placerat, risus ut lobortis mattis, tellus sapien tempor nunc, tristique egestas lacus massa ac orci. Vivamus sed augue non felis semper finibus et eu nibh. Quisque rutrum massa et sem pharetra pellentesque. Praesent elit lectus, efficitur sed aliquet vitae, finibus et felis. Proin eu risus vehicula nulla suscipit tincidunt ac eget mauris. In at egestas enim.',NOW()),
(45,'Simona','simona',2,NULL,1,2,'Cll 84 No 14 - 60','301 3717552','https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xta1/v/t1.0-9/10929159_830172950362478_5542276870089899145_n.jpg?oh=77fecdf4bfd0c86b1d58950f42dff495&oe=5622A727&__gda__=1444003502_0eb0951549b99f3692997202de02122f',4.669257,-74.055166,8000,26000,'CYAN','Reggae,Reggaeton,Pop,Salsa,Cumbia','Nam dolor urna, hendrerit id nisi non, volutpat porttitor mauris. Suspendisse fermentum erat sed finibus vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eros sapien, tristique a ultrices quis, congue a libero. Nullam nec pharetra justo, ut semper nunc. Vivamus ut pulvinar felis. Duis sem arcu, feugiat at quam fringilla, viverra condimentum orci. Vivamus ut odio orci. Vestibulum et elementum lacus, et aliquet lorem.',NOW());

INSERT INTO bars_categories(id, slug, name) VALUES
(1, 'bar','Bar'),
(2, 'disco','Discoteca'),
(3, 'restaurant','Restaurante'),
-- (4, 'xxx','Xxx'),
-- (5, 'disco-gay','Discoteca Gay'),
(6, 'casino','Casino');


INSERT INTO bars_cities (id, name, slug, province_id) VALUES
(1,'Bogotá','bogota',1);


INSERT INTO bars_countries(id, name, slug, iso2, iso3) VALUES
(1, 'Colombia','colombia','CO','COL');


-- BarFranchises
INSERT INTO bars_franchises(id, name, slug) VALUES
(1,'Bogotá Beer Company','bbc'),
(2,'Joshua','joshua'),
(5,'The Irish Pub','irish-pub'),
(6,'Casino Caribe','casino-caribe'),
(7,'Casino Broadway','casino-broadway');
INSERT INTO bars_genres(id, name, slug) VALUES
(1,'Rock','rock'),
(2,'Pop','pop'),
(3,'Rap','rap'),
(4,'Ska','ska'),
(5,'Reggae','reggae'),
(6,'Blues','blues'),
(7,'Jazz','jazz'),
(8,'Lounge','lounge'),
(9,'Clasica','clasica'),
(10,'Reggaeton','reggaeton'),
(11,'Salsa','salsa'),
(12,'Cumbia','cumbia'),
(13,'Electronica','electronica'),
(14,'Crossover','crossover'),
(15,'Bailables','bailables');


INSERT INTO bars_provinces (id, name, slug, country_id, iso2) VALUES
(1,'Cundinamarca','cundinamarca',1,'CO-CUN');

INSERT INTO bars_week_schedules(id, bar_id, start_week_day, end_week_day, start_day_time, end_day_time, sep, created) VALUES
( 1,1,'MON','SAT' ,'17:00:00','23:30:00','-',NOW()),
( 2,1,'SUN','*HOL','18:00:00','21:30:00','/',NOW()),
( 3,2,'MON','SAT' ,'17:00:00','23:30:00','-',NOW()),
( 4,2,'SUN','*HOL','18:00:00','21:30:00','/',NOW()),
( 5,3,'MON','SAT' ,'17:00:00','23:30:00','-',NOW()),
( 6,3,'SUN','*HOL','18:00:00','21:30:00','/',NOW()),
( 7,4,'MON','SAT' ,'17:00:00','23:30:00','-',NOW()),
( 8,4,'SUN','*HOL','18:00:00','21:30:00','/',NOW()),
( 9,5,'MON','SAT' ,'17:00:00','23:30:00','-',NOW()),
(10,5,'SUN','*HOL','18:00:00','21:30:00','/',NOW());


-- BarZones
INSERT INTO bars_zones(id, name, slug, city_id, lat, lng) VALUES
(1,'Usaquén','usaquen',1,4.705027,-74.041023),
(2,'Chapinero','chapinero',1,4.647541,-74.061965),
(3,'Santafé','santafe',1,4.609704,-74.070785),
(4,'Candelaria','candelaria',1,4.595789,-74.073308),
(5,'San Cristobal','san-cristobal',1,4.560488,-74.090732),
(6,'Usme','usme',1,4.505131,-74.109213),
(7,'Suba','suba',1,4.73723,-74.081963),
(8,'Barrios Unidos','barrios-unidos',1,4.665674,-74.076545),
(9,'Teusaquillo','teusaquillo',1,4.63956,-74.082428),
(10,'Mártires','martires',1,4.606901,-74.087174),
(11,'Antonio Nariño','antonio-narino',1,4.590452,-74.10348),
(12,'Rafael Uribe','rafael-uribe',1,4.565505,-74.114191),
(13,'Tunjuelito','tunjuelito',1,4.567682,-74.132271),
(14,'Ciudad Bolivar','ciudad-bolivar',1,4.569991,-74.158924),
(15,'Engativá','engativa',1,4.705794,-74.112824),
(16,'Fontibón','fontibon',1,4.674542,-74.143316),
(17,'Puente Aranda','puente-aranda',1,4.613611,-74.113973),
(18,'Kennedy','kennedy',1,4.629304,-74.150161),
(19,'Bosa','bosa',1,4.609429,-74.18856);


INSERT INTO users(id,username,email,password,salt,fname,lname,role,created) VALUES
(1, 'marcohern', 'marcohern@gmail.com', 'ea049c8ad4d6a10bf271c74dcaee59edaaf0bbc78a452ebad4a0a3bf2b39d7e9', '3W0svqRVLqZG9ouYxhYtfAvr9gIzzNG5m6IRILF', 'Marco', 'Hernandez', 'ADMIN', NOW());

