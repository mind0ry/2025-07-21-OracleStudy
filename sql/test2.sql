 -- 69page : �����̼� (���̺�) 
/*
	�����̼� : ���õ� �����͸� ����� �� (ȸ��, �Խ���, ����, ����, ����...)
			������ ����� ���� (����ȭ) = �ߺ��� �ּ�ȭ
	Ư¡
	  1) ���ϰ��� ������ �ִ� : ���� �����ͺ��̽� ������ ���� �̸��� ����� �Ұ���
	  2) �÷��� ������ ����
	      �÷� + ������ ��
	  3) ������ ������ ���� (����)
	  4) ������ ���� (�÷� , �÷��� �ش�Ǵ� �����Ͱ�)
	  5) ���̺�(�����̼�) ���� (�����̼� ���� => ���� record , ROW)
	      -------------------------------
		 id 	  name 	 sex       class Member{
							String id,name,sex			
						     }
		=> �÷� , �ڹ�(�������, �ν��Ͻ� ����)
 	      -------------------------------
		aaa	   ȫ�浿	���� 	    Member m=new Member()
						    m.id="aaa"
						    m.name="ȫ�浿"
						    m.sex="����"
		=> row / record , �ڹ�(��ü, �ν��Ͻ�)
							| ���� �޸𸮿� ����� ����
		=> �����ͺ��̽� ��� : Ʃ��
	      -------------------------------
		bbb	   �ڹ���	����
	      -------------------------------

		72page 
		    �Ӽ� : �÷� (� �����͸� ������ �� ����)
				=> �����ͺ��̽� ����
				=> ��ġ��ŷ => �ʿ��� �����͸� ����
		    ������ => �Ѱ��� �÷��� ������ �ִ� ������
 		    ����  => �÷��� ����
		    Ʃ�� => ���� => ��� ������ �����ϰ� �ִ� (�Ѱ� , �Ѹ�)
		    ī��θ�Ƽ : Ʃ���� ���� => COUNT(*)

			-----------------------------------------
			�����̼� : ���̺�				����
			-----------------------------------------
			�ν��Ͻ� : ���� ����� ������	������
			-----------------------------------------
			Ʃ�� : ��					���ڵ�
			-----------------------------------------
			�Ӽ� : ��(column)				�ʵ�
			-----------------------------------------
			
			-----------------------------------------

			74 page
				= �Ӽ����� ���� ���� ������ �ִ� (���ڰ�)
				    id hobby
				  aaa  �, ����, ��� => ���� , ���� => ���̺� �Ѱ� ����
				  -----------
				  aaa �
				  aaa ����
				  aaa ���	===> 1����ȭ
				  -----------
				= �Ӽ����� �ٸ� ��Ī�� ������ �ִ�
				= �Ӽ��� ������ ����
				= �Ѱ��� �����ͺ��̽� �ȿ� ���� ���̺���� �����ϸ� �ȵȴ�
				= Ʃ���� ������ ���� => ORDER BY 
			76 page
				Ű
				1. �ߺ��� �����Ͱ� ���� �����
				   --------------------------------- �̻� ���� ����
									    -----------
									   ����, �����ÿ� 
				=> ������ ���� ���� : ������ ���Ἲ
				=> �⺻Ű : PRIMARY KEY
				     -------- ID , ��ȣ (��ȭ��ȣ,������ȣ,�Խù���ȣ...)
				     -------- �ڵ� ���� ��ȣ
				2. ��üŰ (�ĺ�Ű) => email,phone => UNIQUE
				3. �ܷ�Ű (����Ű) => ���̺� ���� => FOREGIN KEY
				4. CHECK , NOT NULL , DEFAULT
				----------------------------------------------------- 6�� / 7��
	
				90 page ���� ���
					    ----------- ���� (������ �ǹ�)
					1. ��������
					   ----------- ���ϴ� �����͸� ���
					2. ������
					   ----------- ���ǿ� �´� ������ ���
					3. ������ / ������ / ������
								    MINUS
							INTERSECT
					   UNION ALL / UNION
					4. ����
					   ���� ���� / �� ����
					   --------------------------- INNSER JOIN
					   equals / non-equals (����)
					   NULL �� ���� => OUTER JOIN
						LEFT OUT JOIN
						RIGHT OUT JOIN
						FULL OUT JOIN
					�ڿ� ����
						NATURAL JOIN
					------------------------------------ SELECT
*/
-- ��������
/*
SELECT empno,ename,job,hiredate,sal
FROM emp;
*/
-- ������
/*
SELECT empno,ename,job,hiredate,sal
FROM emp
WHERE sal=3000;
*/
/*
CREATE TABLE test1(
	no number
);
CREATE TABLE test2(
	no number
);

INSERT INTO test1 VALUES(1);
INSERT INTO test1 VALUES(2);
INSERT INTO test1 VALUES(3);
INSERT INTO test1 VALUES(4);
INSERT INTO test1 VALUES(5);

INSERT INTO test2 VALUES(4);
INSERT INTO test2 VALUES(5);
INSERT INTO test2 VALUES(6);
INSERT INTO test2 VALUES(7);
INSERT INTO test2 VALUES(8);
COMMIT;
*/
/*
-- ������
SELECT no FROM test1
INTERSECT
SELECT no FROM test2;

-- ������
SELECT no FROM test1
UNION
SELECT no FROM test2;

SELECT no FROM test1
UNION ALL
SELECT no FROM test2;

-- ������
SELECT no FROM test1
MINUS
SELECT no FROM test2;

SELECT no FROM test2
MINUS
SELECT no FROM test1;
*/
/*
--����
--EQUI_JOIN => INNER JOIN
-- ����Ŭ ����
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- ANSI ����
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
-- �ڿ� ����
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp NATURAL JOIN dept;
-- JOIN~USING
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept USING(deptno);
*/
SELECT e1.ename "����",e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno(+);

SELECT e1.ename "����",e2.ename "���"
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

SELECT empno,ename,job,dname,loc,dept.deptno
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT empno,ename,job,dname,loc,dept.deptno
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;