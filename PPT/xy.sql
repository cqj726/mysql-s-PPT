USE `xscj1`;

DROP TABLE IF EXISTS `x`;

CREATE TABLE `x` (
  `a` char(10) DEFAULT NULL,
  `b` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert  into `x`(`a`,`b`) values 
('1','asd'),
('2','sdf');

DROP TABLE IF EXISTS `y`;

CREATE TABLE `y` (
  `c` char(10) DEFAULT NULL,
  `d` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert  into `y`(`c`,`d`) values 
('1','qw'),
('2','jh'),
('3','ewrw');
