-- ��(view)

/*
	TABLE / sequence / view / synonym / ps / sql

	| select / update / delete / insert
		

	VIEW
		= ������ ���̺�κ��� �����͸� �����ϴ� �������̺�
		= ���� �پ�� / SQL ������ �ܼ�ȭ 
		= ���� �����Ͱ� ����Ǵ� ���� �ƴ϶� SELECT ������ �����ϰ� �ִ�
		1. �ܼ��� : ���̺� �Ѱ� ����
		2. ���պ� : ���̺� ������ ���� (JOIN / SUBQuery)
		3. �ζ��κ� : FROM �ڿ� SELECT
		** ���� : DML�� ���� 
			    --------------
			    => �����ϴ� ���̺� ��ü�� ����
		=> WITH CHECK OPTION / READONLY OPTION (View => �б� ����)
*/
-- ���պ�
/*
conn system/happy
GRANT CREATE VIEW TO hr;
conn hr/happy
/*
CREATE VIEW emp_dept
AS
	SELECT empno,ename,sal,job,hiredate,dname,loc
	FROM emp,dept
	WHERE emp.deptno=dept.deptno;
*/
/*
2. ���̺� 1���̻��� �����ؼ� ���Ӱ� ������� ���� ���̺�
3. ���� ����
	�ܼ��� (���̺� �Ѱ� ����) => ���󵵰� ���� ���� (���̺� ���)
			=> DML���� 
4. ����
	=���� => ���� ���̺��̶� ������ �ȵȴ�
		=> VIEW�� ���� �����͸� �����ϴ� ���� �ƴϴ� (SQL���常 ����)
	= ���� : SQL������ �����ϰ� �ֱ� ������ ����
	= ���������� ����� ����
5. ���� ���� (����)
	WITH CHECK OPTION = DML ���� (DEFAULT)
	WITH READ ONLY = �б� ����  (SELECT)
6. �� ����
	CREATE VIEW view_name
	AS 
		SELECT ~~
7. ���� ���� (****)
	CREATE OR REPLACE VIEW view_name
	AS
		SELECT ~~
8. ���� ����
	DROP VIEW view_name
9. �� Ȯ��
	SELECT text 
	FROM user_views
	WHERE view_name='�빮��'

	*** ������ SQL�� ��� => ��� ����� �Ǹ� VIEW�� ���
	*** ������ �ʿ��� �κ�
	    ----------------------- 
*/
/*
SELECT text
FROM user_views
WHERE view_name='EMP_DEPT';
*/
-- �ܼ��� : ���̺� �Ѱ��� ���� => DML�� ����
-- ���̺� ����
/*
CREATE TABLE myDept
AS
	SELECT * FROM dept;
*/
/*
CREATE VIEW myView
AS
	SELECT * FROM myDept;
*/
/*
INSERT INTO myView VALUES(50,'���ߺ�','����');
COMMIT;
*/
-- �ܼ��� => �б� ����
--DROP VIEW myView;
/*
CREATE VIEW myView
AS
	SELECT * FROM myDept WITH READ ONLY;
*/
/*
INSERT INTO myView VALUES(50,'���ߺ�','����');
COMMIT;
*/
--DROP VIEW myView;
--DROP TABLE myDept;
--����
/*
CREATE OR REPLACE VIEW emp_dept
AS
	SELECT empno,ename,job,hiredate,sal,dname,loc,grade
	FROM emp,dept,salgrade
	WHERE emp.deptno=dept.deptno
	AND sal BETWEEN losal AND hisal;
*/
-- �Ϲ� ���̺�� �����ϰ� ����� ����
-- ������ �ִ� ��
/*
CREATE OR REPLACE VIEW emp_view1
AS 
    SELECT empno,ename,job,hiredate,sal,
    	(SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	(SELECT loc FROM dept WHERE deptno=emp.deptno) "loc"
    FROM emp
    WHERE MOD(empno,2)=0;
*/
--SELECT ename,dname FROM emp_view1;
-- ���� ��
/*
CREATE OR REPLACE VIEW emp_view2
AS
   SELECT empno,ename,job,sal,hiredate,dname,loc,grade
   FROM emp JOIN dept
   ON emp.deptno=dept.deptno
   JOIN salgrade
   ON sal BETWEEN losal AND hisal;
*/

-- ���� / �׷�
CREATE OR REPLACE VIEW emp_view3
AS
	SELECT deptno,TO_CHAR(hiredate,'YYYY') "regdate",COUNT(*) "count",
	MAX(sal) "max_sal",MIN(sal) "min_sal",
	SUM(sal) "sum_sal",ROUND(AVG(sal)) "avg_sal"
FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
HAVING AVG(sal) > 2073
ORDER BY deptno;



