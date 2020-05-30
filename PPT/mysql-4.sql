-- 创建数据库XSCJ1
CREATE DATABASE XSCJ1;

-- 切换数据库XSCJ1为当前数据库
USE XSCJ1;

-- 创建学生表XS
CREATE TABLE XS (
	学号 CHAR(10) PRIMARY KEY,
	姓名 VARCHAR(10) NOT NULL UNIQUE,
	性别 CHAR(2) DEFAULT '男',
	出生日期 DATE NOT NULL,
	专业名 VARCHAR(20) NOT NULL,
	所在学院 VARCHAR(20) NOT NULL,
	联系电话 CHAR(11) NULL,
	总学分 TINYINT(1) NULL,
	备注 VARCHAR(50) NULL
);

-- 创建成绩表CJ
CREATE TABLE CJ (
	学号 CHAR(10) NOT NULL,
	课程号 CHAR(3) NOT NULL,
	成绩 TINYINT(4) NULL CHECK (成绩 >= 0
	AND 成绩 <= 100),
	学分 TINYINT NULL,
	PRIMARY KEY (学号, 课程号)
);

-- 向学生表XS中输入数据
INSERT INTO XS (学号, 姓名, 性别, 出生日期, 专业名
	, 所在学院, 联系电话, 备注)
VALUES  ('2016110102', '龙婷秀', '女', '1998-11-05', '云计算'
		, '计算机学院', '13512456254', NULL),
	('2016110103', '张庆国', '男', '1999-01-09', '云计算'
		, '计算机学院', '13710425255', NULL),
	('2016110104', '张小博', '男', '1998-04-06', '云计算'
		, '计算机学院', '13501056042', NULL),
	('2016110105', '钟鹏香', '女', '1998-05-03', '云计算'
		, '计算机学院', '13605126565', NULL),
	('2016110106', '李家琪', '男', '1998-04-07', '云计算'
		, '计算机学院', '13605078782', NULL),
	('2016110201', '曹科梅', '女', '1998-06-09', '信息安全'
		, '计算机学院', '13465215623', NULL),
	('2016110202', '江杰', '男', '1998-02-06', '信息安全'
		, '计算机学院', '13520556252', NULL),
	('2016110203', '肖勇', '男', '1998-04-12', '信息安全'
		, '计算机学院', '13756156524', NULL),
	('2016110204', '周明悦', '女', '1998-05-18', '信息安全'
		, '计算机学院', '15846662514', NULL),
	('2016110205', '蒋亚男', '女', '1998-04-06', '信息安全'
		, '计算机学院', '13801201304', NULL),
	('2016110301', '李娟', '女', '1998-08-24', '网络工程'
		, '计算机学院', '13305047552', '学习委员'),
	('2016110302', '成兰', '女', '1999-01-06', '网络工程'
		, '计算机学院', '13815463563', NULL);

-- 向成绩表CJ中输入数据
INSERT INTO CJ (学号, 课程号, 成绩, 学分)
VALUES  ('2016110101', '101', '83', '2'),
	('2016110101', '102', '64', '5'),
	('2016110101', '104', '58', '0'),
	('2016110102', '102', '67', '5'),
	('2016110102', '103', '65', '4'),
	('2016110103', '101', '78', '2'),
	('2016110104', '103', '54', '0'),
	('2016110105', '101', '65', '2'),
	('2016110105', '105', '67', '4'),
	('2016110106', '102', '57', '0'),
	('2016110201', '106', '78', '4'),
	('2016110202', '106', '81', '4'),
	('2016110202', '107', '85', '4'),
	('2016110203', '108', '61', '2');

-- 将成绩表CJ中课程号为102的记录的成绩更新为73分
UPDATE CJ
SET 成绩 = 73
WHERE 课程号 = '102';

-- 删除成绩表CJ中成绩小于60分的记录
DELETE FROM CJ
WHERE 成绩 < 60;

-- 删除学生表XS中学号为2016110205的记录
DELETE FROM XS
WHERE 学号 = '2016110205';