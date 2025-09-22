-- 142page ~ 178page DQL (SELECT�� => �˻�)
/*
	1) SQL : ���ڿ� ����
	    DQL : ����Ŭ���� ���� ���� ���Ǵ� ���
			SELECT
	    DML : INSERT / UPDATE / DELETE
	    DDL : ���̺� ���� , �� ���� ...
			CREATE / ALTER / DROP / RENAME
	    DCL : ���� ���
			GRANT / REVOKE
	    TCL : ���� / ���
			COMMIT / ROLLBACK
	2)  ������
		SELECT : ������ ��ȸ
		WHERE : ���� �˻�
		GROUP BY : �׷캰 ����
		JOIN : �ٸ� ���̺� ����
		SUBQUERY : SQL���� �������� ��Ƽ� �Ѱ�����
		DDL : ����
		DML : ����
		TCL : Ʈ����� ����
	3) ������ �˻�
		SELECT
		����) 
			���̺��� ���� : �÷��� / �������� => DESC table_name
			--------------------------------------------------
			SELECT (DISTINCT|ALL) * | ���� (column_list)
			FROM table_name | view_name | SELECT
			-------------------------------------------------- �ʼ�
			[
				WHERE ���ǹ� (������)
				GROUP BY => ��� / ���� => ���� ���� ������ �ִ� �÷�
								      => �Լ�
				HAVING => �׷쿡 ���� ����
				ORDER BY => ���� (�  �÷�) 
			]
			1. ������ 
				��������� : + , - , * , / => %(MOD)
						  / => ����/����=�Ǽ�
						 + => ���� ��ɸ� ������ �ִ�
						    => ���ڿ� ���� : ||
				�񱳿����� : =  , !=(<>) , < , > , <= , >=
						=> ������������ �ַ� ���
				�������� : AND : ���� ����                           
						  OR : ���߿� �Ѱ� �̻� true
				BETWEEN ~ AND : �Ⱓ , ������ ����
				IN : OR�� ���� ��쿡 ��ü
				NOT : ���� ������
				LIKE : �˻��ÿ� �ַ� ���
					���ڰ� ������ ��� : _
					���ڼ� ������ : %
				NULL : ���� ó���� �ȵȴ�
					IS NULL / IS NOT NULL

			2. ���� �Լ�
				������ �Լ�
					���� �Լ�
					  SUBSTR : ���� �ڸ���
					    =>SUBSTR(���ڿ�|�÷�,������ġ,����)
					    => ����Ŭ�� ���ڹ�ȣ : 1
					  INSER : ������ ��ġ Ȯ�� 
					    => INSTR(���ڿ�|�÷�,ã�¹���,������ġ,�� ��°)
					    => indexOf / lastIndexOf
					    => ��) ����� ���ʱ� ~��....
					  REPLACE : ����
					    => REPLACE(���ڿ�|�÷�,ã�¹���,���湮��)
					    => �̹��� (URL)=> &
					  LENGTH : ���� ����
					    => LENGTH(���ڿ�|�÷�)
					  RPAD : ���ڰ� ������ �������� ���� ���
							�ٸ� ���ڷ� ��ü (���̵� ã��)
					    => RPAD(����|�÷�,��±��ڼ�,��ü����)
					���� �Լ�
					  MOD : ������
					    => MOD(10,2) => 10%2		
					  ROUND : �ݿø�
					    => ROUND(�Ǽ�,�ڸ���)
					  CEIL : �ø�
					    => ��������
					    => CEIL(�Ǽ�) => �Ҽ����� 1�̻�
					��¥ �Լ�
					  SYSDATE : �ý��׹��� ���� ��¥/�ð�
					    => �Խ��� , ȸ�� , ���� , ���� ...
					  MONTHS_BETWEEN : ������ �Ⱓ�� ����  ��
					    => MONTHS_BETWEEN(����, ����)
					��ȯ �Լ�
					  TO_CHAR : ���ڿ� ��ȯ
					    => ��¥
						YYYY/RRRR �⵵
						MM ��
						DD ��
						HH : HH243 => �ð� => ��� / ��������
						MI : ��
						SS : ��
						DY : ����
					    => ����
						9,999,999,999
					��Ÿ 
					  NVL : NULL���� ��쿡 �ٸ� ������ ����
					    => NVL(�÷�,��ü��)
					    		----- NULL�� ��쿡�� ����
					    => �÷��� �������� , ��ü���� �������� ��ġ
				*** �����Լ� , ������ �Լ��� ���� ��� ����
				*** ���� ��� => GROUP BY 
				���� �Լ�
				  COUNT : ROW�� ����
				  COUNT(*) / COUNT(�÷�)
					|		|
				  NULL ����  NULL ����
				  => �α��� , ���̵�ã�� , ��ٱ��� ���� , �˻� �Ǽ�
				  MAX :  ROW��ü �ִ밪
						=> �ڵ� ������ȣ => CREATE SEQUENCE
				  SUM : ROW�� ����
				  AVG : ROW�� ��� 
					
			3. GROUP BY
				: ���� ���� ���� �÷��� �׷����� �����Ŀ�
				  �׷캰 ��� => ID / �μ��� / �Ի�⵵
			4. HAVING 
				GROUP�� ���� ������ ����
			5. ORDER BY : ����
			  = ORDER BY �÷�|�Լ� ASC|DESC
			  = ���� 
			    ORDER BY �÷� , �÷�
					    ----   -----> ���� ���� ������ �ִ� ���
				= ���� / ���� ���ϱ� ...
			-----------------------------------------------------------------
			6. JOIN : �Ѱ��̻��� ���̺� �����ؼ� ������ ����
		           =���̺��� ����ȭ�� ���� �������� ������ �۾�
			  INNER JOIN : ���� ���� ������ �ְų� �����ϴ� ���
					    ----------------------- =    ----- BETWEEN , ��������
				= ���� ���� ���Ǵ� JOIN
				1) ����Ŭ ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A,B
				  WHERE A.col=B.col
				2) ANSI ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A JOIN B
				  ON A.col=B.col
			-------------------------------------------
			  OUTER JOIN : ���� ����
				1) ����Ŭ ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A,B
				  WHERE A.col=B.col(+)
				2) ANSI ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A LEFT OUTER JOIN B
				  ON A.col=B.col
				1) ����Ŭ ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A,B
				  WHERE A.col(+)=B.col
				2) ANSI ����
				  SELECT �÷�(A),�÷�(B)
				  FROM A RIGHT OUTER JOIN B
				  ON A.col=B.col
			  SELF JOIN : �ڽ� ���̺� (���� ���̺��� ������ ����)
				
		---------------------------------------------------------------------
		�������� : �����ȿ� �ٸ� �������� �߰� => �������� SQL������ �Ѱ��� ����
		  MainQuery ������ (��������)
					     ----------- ���� => ����� MainQuery
		 => ����
		  => SQL������ ������ ���� ó��
		  => �������� ���� , ������ �ܰ躰�� ������ �ۼ�
		  => �ӵ��� ������ (����Ŭ ���� => �ð��� ���� �ɸ���) 
		  
		 => ����
		  => SQL������ ��� => �м��ϱ� ����� �� �ִ�
		  -------------------------------------------------------
		    1) ���� => ���� SELECT�� ����
			���� => SELECT
			�������� => SELECT , INSERT , UPDATE , DELETE
		       SELECT �ڿ�
			SELECT ename , (SELECT ~) => �÷� ��� ��� : ��Į�� ��������
		       FROM �ڿ� (SELECT~) => ���̺� ��� ��� : �ζ��� ��
					---------- ����
	               WHERE �ڿ� ���ǰ� => ��������
					------------------------
					1. ������ �������� => �÷� 1��
					  �񱳿����ڸ� �ַ� ��� 
					2. ������ �������� => �÷� 1��
					  IN / ANY / SOME / ALL
					  IN �˻��� ��� ���� ���� 
					  IN(SELECT DISTINCT deptno FROM emp)
					  IN(10,20,30)
					  > ANY(SOME)
					     ANY(SELECT DISTINCT deptno FROM emp) 
					  > ANY(10,20,30) => 10 ����
					  < ANY(SOME)
					  < ANY(10,20,30) => 30 ����
					  > ALL(10,20,30) => 30 ����
					  < ALL(10,20,30) => 10 ����
					  ---------------------------------
					    MIN / MAX
					------------------------
					3. �����÷� ��������
					4. ���� ��������
						  
			����)
				- �޿��� ���
				SELECT AVG(sal) FROM emp
				-- ��պ��� ���� ��� 
				SELECT * form emp
				WHERE sal<2073;
				------------------------------------
				SELECT * form emp
				WHERE sal<(SELECT AVG(sal) FROM emp);
								|
								2037
				=> MainQuery ����				
*/
-- 1. KING�� ���� �μ��� �ִ� ��� ����� ����
-- KING�� �μ� ã��
-- WHERE�� ����
/*
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename='KING');
*/
/*
	�÷��� 1�� / �÷��� ������ => ���� �÷� ��������
	1) �ڹٿ��� ����Ŭ ������ ���ٽÿ��� �ִ��� Ƚ���� ���δ�
	2) �ӵ��� ����ȭ
	** JOIN�� ���̺� �ִ� ������ ����
	** SubQuery�� SQL���� ����
*/
/*
set linesize250
set pagesize 25
-- SCOTT�� �޴� �޿��� ������ �޿��� �޴� ��� ���
SELECT *
FROM emp
WHERE sal=(SELECT sal FROM emp WHERE ename='SCOTT')
AND ename<>'SCOTT';

-- �޿��� ���� ���� ����� ���� �μ��� �ִ� ����� ��� ����
SELECT * 
FROM emp
WHERE deptno=(SELECT deptno FROM emp
			WHERE sal=(SELECT MIN(sal) FROM EMP));

-- ������ CLECK�� ����� �μ��� ��� ��� ���� ���
SELECT deptno FROM emp WHERE job='CLERK';
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE job='CLERK');
-- 10
SELECT *
FROM emp
WHERE deptno > ANY (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno < ANY (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno > ALL (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno < ALL (SELECT deptno FROM emp WHERE job='CLERK');

-- 10
SELECT *
FROM emp
WHERE deptno = (SELECT MAX(deptno) FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno = (SELECT MIN(deptno) FROM emp WHERE job='CLERK');
*/
-- �μ��� �ְ� �޿� ��� ��ȸ
SELECT deptno,MAX(sal)
FROM emp
GROUP BY deptno;

SELECT ename,deptno,sal
FROM emp
WHERE (deptno,sal) IN(SELECT deptno,MAX(sal)
				FROM emp
				GROUP BY deptno);
-- ��� �̸� , �Ի��� , �޿�(emp) , �μ��� , �ٹ���(dept)
-- ���� ���Ǵ� SQL => FUNCTION
-- ���� �� �޴� �÷� 1�� , �÷� ������
SELECT ename,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- ��Į�� ���� ����
SELECT ename,hiredate,sal,
	(SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	(SELECT loc FROM dept WHERE deptno=emp.deptno) "loc"
FROM emp;
-- ���̺� ��� ���
SELECT ename,hiredate,sal
FROM (SELECT * FROM emp);

-- ���ϴ� ������ŭ ���
-- emp���� ���������� 5�� ����
SELECT empno,ename,hiredate,job,rownum                                                                           
FROM emp
WHERE rownum<=5;

SELECT ename,sal
FROM emp
ORDER BY sal DESC;

SELECT empno,ename,hiredate,job,sal,rownum
FROM (SELECT *
		FROM emp
		ORDER BY sal DESC)
WHERE rownum<=5;

--rownum�� ���� => TOP-N

SELECT empno,ename,hiredate,job,sal,rownum
FROM (SELECT *
		FROM emp
		ORDER BY sal DESC)
WHERE rownum BETWEEN 1 AND 5;

-- �ζ��κ� => (���� , ����¡) =>
SELECT empno,ename,hiredate,job,num
FROM (SELECT empno,ename,hiredate,job,rownum as num
FROM (SELECT empno,ename,hiredate,job
FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 6 AND 10;

/*
	***������ ��������
	***������ �������� =>IN , MAX / MIN
	�����÷� �������� => GROUP BY
	���� ��������
	 EXISTS => ���翩�� (true => ���� , false => ���� x)
*/
-- �μ� ���̺�(DEPT)�� �����ϴ� �μ��� ���� ����� �̸� / �μ���ȣ ���
/*
SELECT ename,deptno
FROM emp e
WHERE EXISTS(SELECT 1
		     FROM dept d
		     WHERE d.deptno=e.deptno);
*/

-- ��� ��������
/*
	���� ��������
	 => ���������� ���������� ���� ����
	��� ��������
	 => ������������ ROW���� �ݺ�����
*/
SELECT e1.ename,e1.sal,e1.deptno
FROM emp e1 
WHERE e1.sal > (SELECT AVG(e2.sal)
			FROM emp e2
			WHERE e2.deptno=e1.deptno);
-- �� �μ��� ��� �޿����� ���� ��� ��ȸ
/*
	������ / ������ (IN)
	��Į�� �������� / �ζ��κ�

	=> �������� ����
	 1. �������� ���� => ����� ��ȯ
	 2. ������������ ������� �޾Ƽ� ����/���̺� Ȱ��
	 3. ���ο��� ���� �����
*/
