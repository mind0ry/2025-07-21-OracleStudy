-- JOIN
/*
	���α׷� (�ڹ� => ���õ� �ҽ��� ��� ��� ���)
			���� ������ ������ => �迭
			�ٸ� ������ ������ => Ŭ����
			��ɾ ���� => �޼ҵ�
			--------------------------------- Ŭ����
	����Ŭ
			���� ���
			-----------
				���� �÷����� ��� ��� : GROUP BY
				���� �����͸� ������ �ִ� ���̺� : JOIN
				�ٸ� �����͸� ��� �����Ѵ� : SUBQUERY
			*** �������� ���̺��� �ʿ��� ������ ���� : JOIN
			*** SQL������ �������� ���� SQL�� �Ѱ��� ��� ���
			=> SQL => 5�� => ������ ���� => 1�� 
	1. ������ �ʿ伺
			�����������ͺ��̽� (RDBMS) => ����Ŭ
			=> ��� �����͸� �ϳ��� ���̺� ���� �ִ� ���� �ƴ϶�
				�������� ���̺� ����ȭ�Ǿ� �л�Ǿ� �ִ�
				=> �� ���̺��� Ư���� ��Ģ�� ���踦 ������ �ְ� ����
			=> ������ ���̺��� ���õ� ������ �о�´�
			��)
				�л�
				 => �й�
				 => �̸�
				 ****����=> ����(����)
				-------------------------
				�й� 	   �̸�      ����
				-------------------------
			  	  1	 ȫ�浿      ����
				  2      ȫ�浿     ���� ,����
				  3 	  �ڹ���	����,����,���� ==> ���ڼ� 
				
				�л� : �й� , �̸�
				���� : �й� , ����
				--------------------
				�й�		����
				--------------------
				  1		����
				  2		����
				  2		����
				  3  		����
				  3		����
				  3		����          
			=> JOIN
				=> ���� ���� ���Ǵ� ��� (INNER JOIN)
				1) EQUI JOIN => ���� ���� ������ �ִ� ��� , NULL�� ��� ó���� �Ұ���
				2) NON-EQUI JOIN => ���� ���� ������ �ִ� ���� �ƴϴ�
								���Ե� ���
								----------------------------------------
			
*/
/*
CREATE TABLE salgrade(
	grade NUMBER,
	losal NUMBER,
	hisal NUMBER
);
INSERT INTO salgrade VALUES(1,700,1200);
INSERT INTO salgrade VALUES(2,1201,1400);
INSERT INTO salgrade VALUES(3,1401,2000);
INSERT INTO salgrade VALUES(4,2001,3000);
INSERT INTO salgrade VALUES(5,3001,5000);
COMMIT;
*/
/*
	1) INNER JOIN
		���� ���� ��� , ���� ���
		----------------- �������� ���
		EQUI-JOIN : = ������ ���
		NON-EQUI-JOIN : = �� �ƴ� ������ ��� (BETWEEN , ��������)
		--------------------------------------------------------------------------
		������)
			  ������ ���̺��� ���� �÷��� ������ �ִ� ���
			  �ݵ�� ���� �� ���
			  emp => deptno => emp.deptno
			  dept => deptno => dept.deptno
			  FROM emp e(��Ī) => e.deptno
				   --------------
				   ���̺�� �� ��쵵 �ִ�
			  	   ���� ���̺��� ���� 
				   ------------- SELF JOIN
				   FROM emp e1, emp e2
				   => �̸� , �����ȣ
				   *** JOIN�� �׻� ���� �÷��� ���ϴ� ���� �ƴϴ�
					=> �÷��� ���� ���� ������ �־�� �Ѵ�
				   ��)
					�Խ��� : no
					��� : no , bno
					���� : no
					��� : no , fno
				   1) emp : ��� ����
					empno , ename , job , mgr , hiredate , sal , comm , deptno
					dept : �μ�����
					deptno , dname(�μ���) , loc(�ٹ���)

			JOIN�� ����
			--------------
			1) ����Ŭ JOIN
				SELECT �÷���(A),�÷���(B)
				FROM A,B
				WHERE A.col=B.col
				=> �ٸ� ������ �ִ� ��쿡�� �ݵ�� AND
			2) ANSI JOIN
				SELECT �÷���(A),�÷���(B)
				FROM A (INNER) JOIN B
					     ------- ���� ����
				ON A.col=B.col
					     | ���� ���� ��� => �������� ��� 
			---------------------
			3) NATURAL JOIN
				SELECT �÷�(A),�÷�(B)
				FOM A NATURAL JOIN B
			4) JOIN USING
				SELECT �÷�(A),�÷�(B)
				FOM A JOIN B USING(�÷�)
			--------------------- ���� : ���� �÷���
*/
-- ��� , �̸� , ���� , �Ի��� , �޿� , �μ��� , �ٹ��� , �μ���ȣ
/*
	��� , �̸� , ���� , �Ի��� , �޿� : emp
	�μ��� , �ٹ��� , �μ���ȣ : dept
	�μ���ȣ : emp , dept => ��� ���̺��� ������ ���� ����
			emp.deptno , dept.detpno : �ָ��� ���� ���� �߻�
*/
/*
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp JOIN dept
ON emp.deptno=dept.deptno;

SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp NATURAL JOIN dept;

SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp JOIN dept USING(deptno);


SELECT empno,ename,job,hiredate,sal,dname,loc,e.deptno
FROM emp e, dept d
WHERE e.deptno=d.deptno;

SELECT empno,ename,job,hiredate,sal,dname,loc,e.deptno
FROM emp e JOIN dept d
ON e.deptno=d.deptno;
*/
-- SELF JOIN
/*
SELECT e1.ename "����" , e2.ename "�����"
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno(+);
*/
/*
SELECT empno,ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;
*/
-- empno,ename,job,hiredate,sal,dname,loc,grade
/*
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
WHERE sal BETWEEN losal AND hisal;

SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;
*/
-- 30�� �μ��� �ִ� ��� : �̸� , ���� , �Ի��� , �޿� , �μ��� , �ٹ���
SELECT ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND emp.deptno=30;

-- emp , dept�� �ִ� ��� �������� ��� (����)
SELECT *
FROM emp,dept
WHERE emp.deptno=dept.deptno;
/*
	book : å ����
		bookid : ������ => ��ȣ
		bookname : å�̸�
		publisher : ���ǻ�
		price : ����
	customer : ȸ�� ����
		custid : ID
		name
		address
		phone
	orders : ���ų���
		orderid : ���� ��ȣ
		custid : ȸ�� ���̵�
		bookid : å ���̵�
		saleprice : ���� �ݾ�
		orderdate : ������
*/
-- ���ų��� => orderid , ȸ���̸� , å�̸� , ������
SELECT orderid , name , bookname , orderdate
FROM orders , customer , book
WHERE orders.custid=customer.custid
AND orders.bookid=book.bookid;

SELECT *
FROM orders;