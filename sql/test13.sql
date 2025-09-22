-- JOIN
set linesize 250
set pagesize 25
-- ����̸��� SCOTT�� ����� ��� , �̸� , �μ��� , �ٹ��� ���
/*
SELECT empno,ename,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename='SCOTT';

-- �ٹ����� DALLAS�� ����� ��� , �̸� , ���� �μ��� , �ٹ��� , �Ի���
SELECT empno , ename , job , dname , loc , hiredate
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND loc='DALLAS';

-- �̸� �߿� A�� ���Ե� ����� �̸�, ���� , �μ���, �ٹ��� ���
SELECT ename,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
*/
/*
	INNER������ ���� => ������ (=) : NULL�� ����
	------------------------------------------------------
	| ���� => null���� �ִ� ���̺� Ȯ��
	INNER JOIN + ���� => OUTER JOIN
	OUTER JOIN (�����ڸ��)

	 1) LEFT OUTER JOIN 
		SELECT �÷�(A),�÷�(B)
		FROM A,B
		WHERE A.col=B.col(+)
		
		SELECT �÷�(A),�÷�(B)
		FROM A LEFT OUTER JOIN B
		ON A.col=B.col

	 2) RIGHT OUTER JOIN
		SELECT �÷�(A),�÷�(B)
		FROM A,B
		WHERE A.col(+)=B.col
		
		SELECT �÷�(A),�÷�(B)
		FROM A RIGHT OUTER JOIN B
		ON A.col=B.col

	 3) FULL OUTER JOIN (���󵵰� ���� ����)
		SELECT �÷�(A),�÷�(B)
		FROM A FULL OUTER JOIN B
		ON A.col=B.col
	INNER JOIN (= , ����) : ���ǿ� �´� ROW�� ����
	LEFT OUTER JOIN : ���� ���̺��� ��� ������ , �������� �����Ͱ� ���� ��� NULL

	��� ����
	1. ������ ���� ����
	2. NULL ó�� => �м�
	3. ��� ���� 
	----------------------------
	
*/
/*
-- RIGHT OUTER JOIN
SELECT ename,dname,loc
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT ename,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

SELECT ename,dname,loc
FROM emp FULL OUTER JOIN dept
ON emp.deptno=dept.deptno;
*/
-- ������ : �ݵ�� ������ ���̺� => �ߺ����� �� : ���� 
-- LEFT OUTER JOIN
-- ��� ��� ��� + �Ŵ��� ������ ������ ǥ��

SELECT e1.empno,e1.ename,e2.empno,e2.ename
FROM emp e1 , emp e2
ON e1.mgr=e2.empno(+);
/*
	WHERE emp.deptno=dept.deptno
		    -------------  --------------
			
	------------------------------------
LEFT	 : ���� ���̺�        ���
	------------------------------------
RIGHT : ������ ���̺�    �μ�
	------------------------------------
*/
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid(+);





