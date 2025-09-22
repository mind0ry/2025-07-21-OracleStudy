-- 5�� (���α׷� : ����Ŭ ���α׷� , JDBC���α׷� , �����α׷�
/*
 	6�� : ER-MODEL : �����ͺ��̽� ���� => ������ ���� / ������ ����
		Ű�� ����
	7�� : ����ȭ
	8�� : Ʈ������
	------------------------
	���� : Ʃ��

	����Ŭ ���α׷� => PL/SQL (FUNCTION / PROCEDURE / TRIGGER)
	------------------
	  => SQLȮ�� / �������� / ������ / ���
	  => ���� ���� /����ó�� ���� / �������� ���� => ���� ���
	  => ���� �پ�� / �������� ���� (�����Լ�)
	�⺻ ����
	  DECLARE 
	    ���� ����
	 BEGIN
	    ������ => SQL�������� ����
	 EXCEPTOIN 
	    ����ó��
	 END;

	
*/
-- ��� 
/*
	���ν����� ����� ��ü
	1. FUNCTION : ���ϰ��� ������ �ִ� �Լ� = ���� �Լ�
	2. PROCEDURE : �������� ���� ��ɸ� �����ϴ� �Լ�
	3. TRIGGER : �ڵ� �̺�Ʈ ó��
*/
/*
	����
	  1. ����
	  	***= ��Į�� ����
			���� ��������
			no NUMBER
			name VARCHAR2(10)
	
		***= type����
			empno emp.empno%TYPE
				   ------------- ���� ���������� ÷��
		= rowtype ����
			��ü column�� �������� �б�
			emp emp%ROWTYPE
			       ----- emp�� ������ �ִ� ��� �÷� => VO
		= record
			���̺� ���������� ������ ���� : join
		--------------------------------------- row����
		***= cursor
			�������� row�� ���ÿ� ó��

	  2. ���
		���ǹ� : if , if~else , if~elsif ~ elsif ... / case
		�ݺ��� : �Ϲ� �ݺ��� , while / for
	  3. ����ó��
*/
/*
-- ����
-- System.out.println() => DBMS_OUTPUT_LINE()
-- Scanner => &
-- SELECT => ������ �ƴϴ� / ȭ�鿡 ���
SET SERVEROUTPUT ON;
-- ��Į�� ���� (������ ��������)
DECLARE
 pEmpno NUMBER(4);
 -- �ʱⰪ => pEmpno NUMBER(4)=100 (x)  pEmpno NUMBER(4):=100(O)
 pEname VARCHAR2(30);
 pJob VARCHAR2(20);
 pHiredate DATE;
 pSal NUMBER(7,2);
BEGIN
 SELECT empno,ename,job,hiredate,sal
 INTO pEmpno,pEname,pJob,pHiredate,pSal
 FROM emp
 WHERE empno=7900;
 -- ������ ���
 DBMS_OUTPUT.PUT_LINE('���''||pEmpno);
 DBMS_OUTPUT.PUT_LINE('�̸�''||pEname);
 DBMS_OUTPUT.PUT_LINE('����''||pJob);
 DBMS_OUTPUT.PUT_LINE('�Ի���''||pHiredate);
 DBMS_OUTPUT.PUT_LINE('�޿�'||pSal);
END;
*/

/*
DECLARE
 pEmpno NUMBER(4);
 -- �ʱⰪ => pEmpno NUMBER(4)=100 (x)  pEmpno NUMBER(4):=100(O)
 pEname VARCHAR2(30);
 pJob VARCHAR2(20);
 pHiredate DATE;
 pSal NUMBER(7,2);
BEGIN
 SELECT empno,ename,job,hiredate,sal
 INTO pEmpno,pEname,pJob,pHiredate,pSal
 FROM emp
 WHERE empno=&empno;
 -- ������ ���
 EXCEPTION
	WHEN NO_DATA_FOUND THEN
	  DBMS_OUTPUT.PUT_LINE('�ش� ����� �����ϴ�');
	WHEN TOO_MANY_ROWS THEN
	  DBMS_OUTPUT.PUT_LINE('2�� �̻��� ���� ��ȯ');
	WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�');

 DBMS_OUTPUT.PUT_LINE('���'||pEmpno);
 DBMS_OUTPUT.PUT_LINE('�̸�'||pEname);
 DBMS_OUTPUT.PUT_LINE('����'||pJob);
 DBMS_OUTPUT.PUT_LINE('�Ի���'||pHiredate);
 DBMS_OUTPUT.PUT_LINE('�޿�'||pSal);
END;
/
*/
/*
-- TYPE : ���� ���̺� ����� ���������� ������ �´�
-- ����) ������ ���̺��.�÷���%TYPE
DECLARE
  pEmpno emp.empno%TYPE;
  pEname emp.ename%TYPE;
  pJob emp.job%TYPE;
BEGIN
 -- ������ => DML�� �ַ� ���
  SELECT empno,ename,job INTO pEmpno,pEname,pJob
  FROM emp
  WHERE empno=7788;
   DBMS_OUTPUT.PUT_LINE('���'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('�̸�'||pEname);
   DBMS_OUTPUT.PUT_LINE('����'||pJob);

END;
/
*/
/*
SET SERVEROUTPUT ON;
-- ROWTYPE => VO : �Ѱ��� ���̺��� ������ �ִ� ��� ���������� �о�´�
-- ���̺��� ���̺��%ROWTYPE
DECLARE
	pEmp emp%ROWTYPE;
BEGIN
	SELECT * INTO pEmp
	FROM emp
	WHERE empno=7900;
	DBMS_OUTPUT.PUT_LINE('���:'||pEmp.empno);
	DBMS_OUTPUT.PUT_LINE('�̸�:'||pEmp.ename);
	DBMS_OUTPUT.PUT_LINE('����:'||pEmp.job);
	DBMS_OUTPUT.PUT_LINE('�Ի���:'||pEmp. hiredate);
	DBMS_OUTPUT.PUT_LINE('�޿�'||pEmp.sal);
END;
/
*/
-- JOIN => ���̺� ������ ���� => RECORD
-- IF / IF~ELSE / FOR
-- ���� => FUNCTION
/*
	TYPE empDept IS RECORD(
		empno emp.empno%TYPE,
		ename emp.ename%TYPE,
		job emp.job%TYPE,
		dname demp.dname%TYPE,
		loc dept.loc%TYPE
	
	);
	-- GROUP BY , JOIN , SUBQUERY
*/
/*
DECLARE
   -- class EmpDeptGradeVO
   -- ���������� ����� ���Ƿ� ����
   TYPE empDeptSalGrade IS RECORD(
	empno emp.empno%TYPE,
	ename emp.ename%TYPE,
	job emp.job%TYPE,
	dname dept.dname%TYPE,
	loc dept.loc%TYPE,
	grade salgrade.grade%TYPE
   );
   -- ���� ����
   edg EmpDeptSalGrade;
BEGIN
   SELECT empno,ename,job,dname,loc,grade
   	INTO edg
   FROM emp,dept,salgrade
   WHERE emp.deptno=dept.deptno
   AND sal BETWEEN losal AND hisal
   AND empno=7788;
   DBMS_OUTPUT.PUT_LINE('���:'||edg.empno);
   DBMS_OUTPUT.PUT_LINE('�̸�:'||edg.ename);
   DBMS_OUTPUT.PUT_LINE('����:'||edg.job);
   DBMS_OUTPUT.PUT_LINE('�μ���:'||edg.dname);
   DBMS_OUTPUT.PUT_LINE('�ٹ���:'||edg.loc);
   DBMS_OUTPUT.PUT_LINE('���:'||edg.grade);
END;
/
*/
-- ��Į�󺯼� (���� ��������), TYPE���� (���� �������� �б�)
/*
	����)
		------------- �͸�
		DECLARE
		   ��������
		------------- CREATE FUNCTION func_name(�Ű�����)
				 CREATE PROCEDURE pro_name(�Ű�����)
				 CREATE TRIGGER tri_name
		BEGIN
		   ����
			SELECT => ���� �޾Ƽ� ������ ���� INTO
			=> ���� ����
			=> ������ : SQL�� �ִ� ������ ����
			=> ��� 
		EXCEPTION
		   ����ó��
		ȭ�� ���
		END;
		/
		
		���
		  = ���ǹ�
		  	1) ���� ���ǹ�
			   IF ���ǹ� THEN => if(���ǹ�)
				���๮�� => ������ true�϶� ����
			   END IF;
			2) ���� ���ǹ�
			   IF ���ǹ� THEN => if(���ǹ�)
				���๮�� => ������ true
			   ELSE => else
				���๮�� => ������ false
			   END IF;
			3) ���� ���ǹ� => �Ѱ��� ���Ǹ� ����
			   IF ���ǹ� THEN
				���๮��
			   ELSIF ���ǹ� THEN
				���๮��	   
			   ELSIF ���ǹ� THEN
				���๮��	
			   ELSE => ������ ����
				���๮��	
			   END IF;
*/
/*
-- ���� ���ǹ� IF ���ǹ� THEN
DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;

   IF pDeptno=10 THEN
   	pDname:='���ߺ�'; -- ���� ���� :=
   END IF;
   IF pDeptno=20 THEN
   	pDname:='������'; -- ���� ���� :=
   END IF;
   IF pDeptno=30 THEN
   	pDname:='�����'; -- ���� ���� :=
   END IF;
   IF pDeptno=40 THEN
   	pDname:='ȸ���'; -- ���� ���� :=
   END IF;
   DBMS_OUTPUT.PUT_LINE('���:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('�̸�:'||pEname);
   DBMS_OUTPUT.PUT_LINE('����:'||pJob);
   DBMS_OUTPUT.PUT_LINE('�μ���ȣ:'||pDeptno);
END;
/
*/
/*
DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;

   IF pDeptno=10 THEN
   	pDname:='���ߺ�'; -- ���� ���� :=
   ELSIF pDeptno=20 THEN
   	pDname:='������'; -- ���� ���� :=

   ELSIF pDeptno=30 THEN
   	pDname:='�����'; -- ���� ���� :=

   ELSIF pDeptno=40 THEN
   	pDname:='ȸ���'; -- ���� ���� :=
   END IF;
   DBMS_OUTPUT.PUT_LINE('���:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('�̸�:'||pEname);
   DBMS_OUTPUT.PUT_LINE('����:'||pJob);
   DBMS_OUTPUT.PUT_LINE('�μ���ȣ:'||pDeptno);
END;
/
*/
/*
-- IF ~ ELSE
DECLARE
  pEname emp.ename%TYPE;
  pComm emp.comm%TYPE;
  pSal emp.sal%TYPE;
  pTotal NUMBER(7,2):=0;
BEGIN
  SELECT ename,comm,sal,sal+NVL(comm,0)
   INTO pEname,pComm,pSal,pTotal
  FROM emp
  WHERE empno=&empno;
  -- pComm = 0 , pComm = null => else���� ����
  --			���� ������ �ȵȴ�
  IF pComm>0 THEN
	DBMS_OUTPUT.PUT_LINE(pEname||'���� �޿��� '||pSal||'�̰� �������� '||pComm||'�̸� �ѱ޿��� '||pTotal||'�Դϴ�');
  ELSE 
	DBMS_OUTPUT.PUT_LINE(pEname||'���� �޿��� '||pSal||'�̰� �������� ���� �ѱ޿��� '||pTotal||'�Դϴ�');
  END IF;
END;
/
*/

DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;
	
   pDname:=CASE pDeptno -- switch(deptno)
		WHEN 10 THEN '���ߺ�' -- case 10
		WHEN 20 THEN '������' -- case 20
		WHEN 30 THEN '�����' -- case 30
		ELSE '����' -- default
		END;
DBMS_OUTPUT.PUT_LINE('���:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('�̸�:'||pEname);
   DBMS_OUTPUT.PUT_LINE('����:'||pJob);
   DBMS_OUTPUT.PUT_LINE('�μ�:'||pDname);
		
END;
/