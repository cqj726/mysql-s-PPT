/* 
	云数据库应用(Mysql)教材
	范例
*/

USE `xscj1`;

################################  例7.1
DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    TRIGGER `xscj1`.`insert_xskc` AFTER INSERT
    ON `xscj1`.`xs_kc`
    FOR EACH ROW BEGIN
	UPDATE number SET `选课人数`=`选课人数`+1 WHERE `课程号`=new.`课程号`;
    END$$

DELIMITER ;

## 测试 例7.1
INSERT INTO xs_kc VALUES ('2016110406','110','82',NULL);

################################ 例7.2
DELIMITER $$

CREATE
    TRIGGER `xscj1`.`delete_xsqk` BEFORE DELETE
    ON `xscj1`.`xsqk`
    FOR EACH ROW BEGIN
	DELETE FROM xs_kc WHERE 学号 = OLD.学号;
    END$$

DELIMITER ;

-- 测试 例7.2
DELETE FROM xsqk WHERE 学号='2016110407';

################################  例7.3
DELIMITER $$

CREATE
    TRIGGER `update_xsqk` AFTER UPDATE ON `xsqk` 
    FOR EACH ROW BEGIN
	IF new.`学号` != old.`学号` THEN
	    UPDATE xs_kc SET `学号`=new.`学号` WHERE `学号`=old.`学号`;
	END IF;
    END$$

DELIMITER ;

################################ 查看触发器
USE `information_schema`;
SELECT * FROM `TRIGGERS`;

USE `xscj1`;
SHOW TRIGGERS;

################################ 全局变量
SHOW GLOBAL VARIABLES;

SHOW GLOBAL VARIABLES LIKE 'autocommit';
SELECT @@global.autocommit;

SET GLOBAL autocommit =0;

SET @@global.autocommit =1;

SELECT @@global.range_alloc_block_size;    ##最低4096，每次加1024

SET GLOBAL range_alloc_block_size = 3000;
SET GLOBAL range_alloc_block_size = 6000;
SET GLOBAL range_alloc_block_size = 8192;
SET @@global.range_alloc_block_size = 4096;

################################ 会话变量

SHOW VARIABLES;
SHOW VARIABLES LIKE 'default_storage_engine';
SHOW VARIABLES LIKE 'autocommit';

SELECT @@session.autocommit;

SET SESSION autocommit =0;

SET @@session.autocommit =1;

SELECT @@session.range_alloc_block_size;    ##最低4096，每次加1024

SET SESSION range_alloc_block_size = 8192;

################################ 用户变量
SET @user1='关系数据库', @user2='MySQL', @user3='MySQL';
SET @user1='关系数据库', @user2='MySQL', @user3:='MySQL';


SELECT @user3='MySQL数据库';

SELECT @user3:='MySQL数据库';

SELECT @user2=@user3;

SELECT @user3;

SELECT @user2:=@user3;

################################ 局部变量
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`sum_add`(IN X INT, IN Y INT)
	BEGIN
		DECLARE z INT DEFAULT 0;
		SET z = X + Y;
		SELECT z  SUM;
	END$$

DELIMITER ;

CALL sum_add(3,4);

################################ 例9.7
DELIMITER $$

CREATE
    PROCEDURE proc1(IN xh CHAR(10))
    READS SQL DATA
    BEGIN
	IF (SELECT 学号 FROM xsqk WHERE xsqk.学号 = xh) IS NULL THEN
		SELECT '无此学生信息' AS 学生信息;
	ELSE
		SELECT 学号,姓名,性别,专业名 FROM xsqk WHERE xsqk.学号 = xh;
	END IF;
    END$$

DELIMITER ;

CALL proc1('2016110101');

################################ 例9.8
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`proc2`(IN xh CHAR(10), IN kch CHAR(3))
	BEGIN
		DECLARE cj TINYINT;
		IF(SELECT 学号 FROM xs_kc WHERE `学号`= xh AND `课程号`=kch) IS NULL THEN
			SELECT '无此学生成绩' AS '学生成绩';
		ELSE
			SELECT 成绩 INTO cj FROM xs_kc WHERE `学号`= xh AND `课程号`=kch;
			SELECT cj AS 成绩;
			SET cj=FLOOR(cj/10);
			CASE cj
				WHEN 0||1||2||3||4||5 THEN SELECT '不及格' AS 成绩等级;
				WHEN 6 THEN SELECT '及格' AS 成绩等级;
				WHEN 7 THEN SELECT '中等' AS 成绩等级;
				WHEN 8 THEN SELECT '良好' AS 成绩等级;
			ELSE SELECT '优秀' AS 成绩等级;
			END CASE;
		END IF;
	END$$

DELIMITER ;

CALL proc2('2016110102','102');

################################ 例9.9
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`proc3`(IN xh CHAR(10), IN kch CHAR(3))
	BEGIN
		DECLARE cj TINYINT;
		IF(SELECT 学号 FROM xs_kc WHERE `学号`= xh AND `课程号`=kch) IS NULL THEN
			SELECT '无此学生成绩' AS '学生成绩';
		ELSE
			SELECT 成绩 INTO cj FROM xs_kc WHERE `学号`= xh AND `课程号`=kch;
			SELECT cj AS 成绩;
			SET cj=FLOOR(cj/10);
			CASE
				WHEN cj IN(0,1,2,3,4,5) THEN SELECT '不及格' AS 成绩等级;
				WHEN cj=6 THEN SELECT '及格' AS 成绩等级;
				WHEN cj=7 THEN SELECT '中等' AS 成绩等级;
				WHEN cj=8 THEN SELECT '良好' AS 成绩等级;
			ELSE SELECT '优秀' AS 成绩等级;
			END CASE;
		END IF;
	END$$

DELIMITER ;

CALL proc3('2016110102','102');

################################ 例9.10
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`addsum`(IN X INT)
    BEGIN
	SET @i = 1, @sum = 0;
	add_sum:LOOP
	BEGIN
		SET @sum = @sum + @i;
		SET @i = @i + 1;
	END;
	IF @i > X THEN
		LEAVE add_sum;
	END IF;
	END LOOP add_sum;
	SELECT @sum;
    END$$

DELIMITER ;

CALL addsum(100);

################################ 例9.11
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`addsum1`()
    BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE SUM INT DEFAULT 0;
	WHILE i<=100
	DO
		SET SUM = SUM + i;
		SET i = i + 1;
	END WHILE;
	SELECT SUM;
    END$$

DELIMITER ;

CALL addsum1();

################################ 例9.13
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`xsqk_proc`()
    BEGIN
	DECLARE flag INT DEFAULT 0; ##定义结束标志，1：结束
	-- 定义四个变量
	DECLARE xh CHAR(10);
	DECLARE xm VARCHAR(10);
	DECLARE xb CHAR(2);
	DECLARE zym VARCHAR(20);
	
	-- 定义游标
	DECLARE xsqk_cursor1 CURSOR FOR SELECT `学号`,`姓名`,`性别`,`专业名` FROM xsqk;
	
	-- 定义错误处理程序
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	
	SET flag = 0;
	OPEN xsqk_cursor1;   ## 打开游标
	
	f_loop:LOOP
	FETCH xsqk_cursor1 INTO xh,xm,xb,zym;
	IF flag = 1 THEN
		LEAVE f_loop;
	ELSE
		SELECT xh,xm,xb,zym;
	END IF;
	END LOOP f_loop;
    END$$

DELIMITER ;

CALL xsqk_proc();

################################ 例9.14
DELIMITER $$

CREATE
    PROCEDURE `xscj1`.`cj_count`(OUT num INT)
	BEGIN
		DECLARE flag INT DEFAULT 0;
		DECLARE cj TINYINT;
		DECLARE cj_cursor CURSOR FOR SELECT 成绩 FROM xs_kc WHERE 成绩 < 60;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
		SET flag = 0;
		SET num = 0;
		OPEN cj_cursor;
		FETCH cj_cursor INTO cj;
		WHILE flag = 0 DO
			SET num = num + 1;
			FETCH cj_cursor INTO cj;
		END WHILE;
		CLOSE cj_cursor;
	END$$

DELIMITER ;

CALL cj_count(@num);

SELECT @num AS 不及格人数;

################################ 例9.15

USE xscj1;

SHOW VARIABLES LIKE 'default_storage_engine';

SELECT @@autocommit;

SELECT * FROM xsqk;

BEGIN;
/* start transaction;*/
INSERT INTO xsqk VALUES('2016110407','曾佳','男','1998-04-06','云计算','计算机学院','13585452547',NULL,NULL);
COMMIT;

BEGIN;
INSERT INTO xsqk VALUES('2016110408','王天','男','1997-12-06','云计算','计算机学院','13585452548',NULL,NULL);
ROLLBACK;

################################ 事务隔离级别和锁 9.16，9.17

SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT @@transaction_isolation;

# 一个客户端开启事务1：
BEGIN;

SELECT * FROM xsqk LOCK IN SHARE MODE;
SELECT * FROM xsqk WHERE 学号='2016110104' LOCK IN SHARE MODE;

SELECT * FROM xsqk WHERE 学号='2016110104' FOR UPDATE;
SELECT * FROM xsqk WHERE 学号='2016110104' LOCK IN SHARE MODE;

-- rollback;
COMMIT;

UPDATE xsqk SET 联系电话='13905126565' WHERE 学号='2016110105';

# 另一个客户端开启事务2：
BEGIN;

SELECT * FROM xsqk LOCK IN SHARE MODE;
SELECT * FROM xsqk WHERE 学号='2016110105' LOCK IN SHARE MODE;

SELECT * FROM xsqk WHERE 学号='2016110105' FOR UPDATE;
SELECT * FROM xsqk WHERE 学号='2016110105' LOCK IN SHARE MODE;

-- rollback;
COMMIT;

UPDATE xsqk SET 联系电话='13805126565' WHERE 学号='2016110104';

SELECT * FROM xs_kc WHERE 学号 IN('2016110101','2016110102') FOR UPDATE;