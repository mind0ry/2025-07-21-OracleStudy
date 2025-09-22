-- PL/SQL => �ݺ��� , CURSOR (*****�ٽ� ���*****)
-- FUNCTION (��Į�� �������� , ��� ������ ����� ���� : PROCEDURE)
/*
	�ݺ��� : BASIC => do ~ while
		    WHILE
		    FOR
	�ݺ���
		1) �⺻ �ݸ�
		    ����)
			LOOP
			   �ݺ� ó������
			   EXIT ���� ===> ���� ����
			END LOOP;
			
			 do
			 {
				�ݺ� ���ǹ�
			 } while(���ǹ�);
		2) WHILE
		    ����)
			WHILE ���� LOOP
				�ݺ� ó�� ����
			END LOOP;
		
			while(����)
			{
				�ݺ� ó�� ����
			}
		3) FOR (******)
		    ����)
			FOR ���� IN low..hi LOOP
			  ó������
			END LOOP;

			��)
				1~9
				FOR i IN 1..9 LOOP
				   ��¹���
				END LOOP;

				9~1
				FOR i IN RESERVE 1..9 LOOP
				    ��¹���
				END LOOP;
*/
/*
-- LOOP (basic = do~while)
DECLARE
   sno NUMBER:=1;
   eno NUMBER:=10;
BEGIN
   LOOP
	DBMS_OUTPUT.PUT_LINE(sno);
	sno:=sno+1; -- sno++
	EXIT WHEN sno>eno;
   END LOOP;
END;
/
-- WHILE (while = while)
DECLARE
   no NUMBER:=1; -- C��� ���� : ������ �ݵ�� ���� ����
BEGIN
   WHILE no<=10 LOOP
	DBMS_OUTPUT.PUT_LINE(no);
	no:=no+1; --no++
   END LOOP;
END;
/
-- FOR
DECLARE 
BEGIN
   FOR i IN 1..10 LOOP
	DBMS_OUTPUT.PUT_LINE(i);
   END LOOP;
END;
/

-- ���� ���
DECLARE 
BEGIN
   FOR i IN REVERSE 1..10 LOOP
	DBMS_OUTPUT.PUT_LINE(i);
   END LOOP;
END;
/
*/
/*
-- FOR + IF
-- 1~10 => ¦��
DECLARE
BEGIN
   FOR i IN 1..10 LOOP
	IF MOD(i,2)=0 THEN
	   DBMS_OUTPUT.PUT_LINE(i);
	END IF;
   END LOOP;
END;
/
-- 1~100 => ¦���� �� , Ȧ���� �� , ��ü ��
DECLARE
   even NUMBER:=0;
   odd NUMBER:=0;
   total NUMBER:=0;
BEGIN
   FOR i IN 1..100 LOOP
   	total:=total+i;
	IF MOD(i,2)=0 THEN
	   even:=even+i;
	ELSE
	   odd:=odd+i;
	END IF;
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('1~100���� ��ü ��:'||total);
   DBMS_OUTPUT.PUT_LINE('1~100���� Ȧ�� ��:'||odd);
   DBMS_OUTPUT.PUT_LINE('1~100���� ¦�� ��:'||even);
END;
/
*/
-- CURSOR : ResultSet => ArrayList => ���
/*
	����)
		CURSOR Ŀ���� IS 
		   SELECT ~
*/
/*
-- ��� ���
DECLARE
   vemp emp%ROWTYPE;
   -- CURSOR ����
   CURSOR cur IS
	SELECT * FROM emp;
BEGIN 
   FOR vemp IN cur LOOP -- for(EmpVO vo:list)
	DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
   END LOOP;
END;
/
*/
/*
	����)
		����� DECLARE
		������ BEGIN ~ END
 		����ó�� EXCEPTION => �����ο� ����

		DECLARE
		   ���� ���� : ��Į�� ���� (�Ϲ� = ������ ��������)
				   %TYPE : ���� ���̺��� �÷� ���������� ������ �´�
				   CURSOR : ��� => ResultSet
		BEGIN
		   ������ : �����ڴ� �״�� ���
	           ��� : IF ~ , IF ~ ELSE , FOR
		   => PL/SQL => SQL�������� ����
			SELECT���� ���� �޴� ��� => INTO
		   END;
*/
-- ����� ���� �Լ� => 270page
-- subquery ���ÿ� �ַ� ��� => �ݺ� ���� : �����Լ�
/*
	����)
		CREATE [OR REPLACE] FUNCTION func_name(�Ű�����....)
		RETURN ��������
		IS
		   ��������
		BEGIN
			����
			RETURN ��
		END;
		/
		=> SELECT / WHERE / GROUP BY / ORDER BY ...
		*** �ݵ�� ������� 1���� ����
*/
/*
-- SELECT * FROM student; => ������ �Լ� (row������ ó��)
-- JOIN�� �ִ� ���
-- DROP FUNCTION func_name
CREATE OR REPLACE FUNCTION stdSum(pHakbun student.hakbun%TYPE)
RETURN NUMBER
IS
   vTotal NUMBER:=0;
BEGIN
   SELECT kor+eng+math INTO vTotal
   FROM student
   WHERE hakbun=pHakbun;
   RETURN vTotal;
END;
/

CREATE OR REPLACE FUNCTION stdAvg(pHakbun student.hakbun%TYPE)
RETURN NUMBER
IS
   vAvg NUMBER:=0;
BEGIN
   SELECT ROUND((kor+eng+math)/3.0,2) INTO vAvg
   FROM student
   WHERE hakbun=pHakbun;
   RETURN vAvg;
END;
/
*/
/*
SELECT hakbun,name,kor,eng,math,(kor+eng+math) "sum",
	   ROUND((kor+eng+math)/3.0,2) "avg"
FROM student;

SELECT hakbun,name,kor,eng,math,stdSum(hakbun) "sum",
	   stdAvg(hakbun) "avg"
FROM student;
*/
/*
	FUNCTION : �޿� / ���� ���
			  ������ ��ȯ (��¥ => ���ڿ�)
			  ������ ���� ���� ��� => ��ǰ ���� , �� ��� ����
			  JOIN / SUBQUERY�� ���� ���
*/ 
-- �μ���
CREATE OR REPLACE FUNCTION getDname(pDeptno dept.deptno%TYPE)
RETURN VARCHAR2
IS 
  -- �������� ����
  pDname dept.dname%TYPE;
BEGIN
  -- ������
  SELECT dname INTO pDname
  FROM dept
  WHERE deptno=pDeptno;
  RETURN pDname;
END;
/
-- �ٹ���
CREATE OR REPLACE FUNCTION getLoc(pDeptno dept.deptno%TYPE)
RETURN VARCHAR2
IS 
  -- �������� ����
  pLoc dept.loc%TYPE;
BEGIN
  -- ������
  SELECT pLoc INTO pLoc
  FROM dept
  WHERE deptno=pDeptno;
  RETURN pLoc;
END;
/
-- �޿� ��� -- error : show error
CREATE OR REPLACE FUNCTION getGrade(pSal emp.sal%TYPE)
RETURN NUMBER
IS
  vGrade salgrade.grade%TYPE; 
BEGIN
  SELECT grade INTO vGrade 
  FROM salgrade
  WHERE pSal BETWEEN losal AND hisal;
  RETURN vGrade;
END;
/

SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

SELECT empno,ename,job,hiredate,sal,
	   (SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	   (SELECT loc FROM dept WHERE deptno=emp.deptno) "loc",
	   (SELECT dname FROM salgrade WHERE emp.sal BETWEEN losal AND hisal) "grade"
FROM emp;
-- FUNCTION => ���� ����ϴ� �κп��� : ROW ���� ����
SELECT empno,ename,job,hiredate,sal,
	   getDname(deptno) "dname",
	   getLoc(deptno) "loc",
	   getGrade(sal) "grade"
FROM emp;