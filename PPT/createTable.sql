-- 创建数据库`xscj1`

CREATE DATABASE `xscj1`;

USE `xscj1`;


-- 创建表 `xsqk`

CREATE TABLE `xsqk` (
  `学号` char(10) NOT NULL,
  `姓名` varchar(10) NOT NULL,
  `性别` char(2) DEFAULT '男',
  `出生日期` date NOT NULL,
  `专业名` varchar(20) NOT NULL,
  `所在学院` varchar(20) NOT NULL,
  `联系电话` char(11) DEFAULT NULL,
  `总学分` tinyint DEFAULT NULL,
  `备注` varchar(50) DEFAULT NULL,
  `社团团长` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`学号`),
  UNIQUE KEY `姓名` (`姓名`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 创建表 `kc`

CREATE TABLE `kc` (
  `课程号` CHAR(3) NOT NULL,
  `课程名` VARCHAR(30) NOT NULL,
  `授课教师` VARCHAR(8) DEFAULT NULL,
  `开课学期` TINYINT NOT NULL,
  `学时` SMALLINT NOT NULL,
  PRIMARY KEY (`课程号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;


-- 创建表 `xs_kc`

CREATE TABLE `xs_kc` ( 
  `学号` CHAR(10) NOT NULL,
  `课程号` CHAR(3) NOT NULL,
  `成绩` TINYINT DEFAULT NULL, 
  `学分` TINYINT DEFAULT NULL,
  PRIMARY KEY (`学号`,`课程号`), 
  CONSTRAINT `FK_xsqk_xh` FOREIGN KEY (`学号`) REFERENCES `xsqk` (`学号`), 
  CONSTRAINT `FK_kc_kch` FOREIGN KEY (`课程号`) REFERENCES `kc` (`课程号`), 
  CONSTRAINT `xs_kc_chk_1` CHECK ((`成绩` >= 0) AND (`成绩` <= 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;

CREATE TABLE number (SELECT 课程号, COUNT(课程号) 选课人数 FROM xs_kc GROUP BY 课程号);

SET @@global.sql_mode ='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

