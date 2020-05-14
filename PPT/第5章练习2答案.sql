1、SELECT COUNT(备注) AS 班干部人数 FROM xsqk
2、SELECT 课程号,SUM(成绩) AS 总成绩,AVG(成绩) AS 平均分,MAX(成绩) AS 最高分,MIN(成绩) AS 最低分 FROM xs_kc GROUP BY 课程号
3、SELECT 课程号,COUNT(*) AS 人数 FROM xs_kc GROUP BY 课程号
4、SELECT COUNT(*) FROM xsqk WHERE 出生日期>=19990101
5、SELECT 课程号, AVG(成绩) AS  平均成绩 FROM xs_kc WHERE 课程号='101'
6、SELECT COUNT(*) AS 学生人数 FROM xs_kc WHERE 成绩>70 AND 成绩<80
7、SELECT 备注 职务,GROUP_CONCAT(姓名) AS 人员 FROM xsqk GROUP BY 备注 HAVING 备注 IS NOT NULL
     或	SELECT 备注 职务,GROUP_CONCAT(姓名) AS 人员 FROM xsqk GROUP BY 备注 HAVING COUNT(备注)>0
8、SELECT 专业名,性别,COUNT(性别) AS 总人数 FROM xsqk GROUP BY 专业名,性别
9、SELECT 开课学期, GROUP_CONCAT(课程名) 课程名,SUM(学时) 总学时 FROM kc GROUP BY 开课学期