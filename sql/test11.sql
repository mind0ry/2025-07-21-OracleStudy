-- 2025-09-04 GROUP BY / JOIN / SUBQUERY
/*
	GROUP BY : ������ �׷캰�� ��� ���� = ������ ���
	JOIN : �������� ���̺��� ���� �ʿ��� �����͸� ����
		 ------------------ ����ȭ => ���̺��� ���� ��������
	=> ������ ����
	SUBQUERY : �������� SQL�� �Ѱ��� SQL�������� ����
			  SELECT �ڿ� => ��Į�� �������� (�÷� ���)
			  FROM �ڿ� => �ζ��� �� (���̺� ���)
			  WHERE �ڿ� => �������� (���ǰ��� ���)

	1. GROUP BY =159page
	   ------------
	  	���� ���� ���� �÷��� ��� ���� ���
								------
								�����Լ��� �̿��Ѵ�
		=> COUNT / MAX / MIN / SUM / AVG
		1) ������
			WHERE / HAVING�� ȥ���ϸ�  => ������ �߻��� �� �ִ�
			������ �Լ��� ����� �� ���� , �׷����� ������ �÷��ܴ�
			�ٸ� �÷��� ����� �� ����
		2) ���� ����
			SELECT ----4
			FROM ------1
			GROUP BY ----2
			HAVING -------3
			ORDER BY ---5

		=> �÷����߿� ���� ���� ������ �ִ� ã�Ƽ� �׷�
			��) emp
				deptno (�μ���ȣ) / job(����) / �Ի�⵵�� (hiredate)
		=> SQL ����
			GROUP BY �÷� / �Լ�
			SELECT �÷���|�Լ��� , �����Լ� ....
			FROM table_name
			GROUP BY �÷���|�Լ���
			HAVING ���� (�׷쿡 ���� ����) => GROUP BY�ִ� ��� ����� ����
			--------------- �ʿ�ÿ��� ���
			ORDER BY �÷���|�Լ���
*/
-- �μ�(deptno)�� �޿� ����� ���Ѵ�
set linesize 250
set pagesize25
/*
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
ORDER BY deptno;
*/
/*
-- �μ��� �ο��� , �޿����� , �޿� ��� , �ִ밪 , �ּҰ�
SELECT deptno,
	   COUNT(*) "�ο���",
	   SUM(sal) "�޿�����",
	   AVG(sal) "�޿� ���",
	   MAX(sal) "�ִ밪",
  	   MIN(sal) "�ּҰ�"
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
-- ������ (job)
SELECT job,
	   COUNT(*) "�ο���",
	   SUM(sal) "�޿�����",
	   AVG(sal) "�޿� ���",
	   MAX(sal) "�ִ밪",
  	   MIN(sal) "�ּҰ�"
FROM emp
GROUP BY job
ORDER BY job ASC;
--�Ի翬����
SELECT
	  TO_CHAR(hiredate,'yyyy'),
	   COUNT(*) "�ο���",
	   SUM(sal) "�޿�����",
	   AVG(sal) "�޿� ���",
	   MAX(sal) "�ִ밪",
  	   MIN(sal) "�ּҰ�"
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy')
ORDER BY TO_CHAR(hiredate,'yyyy') ASC;

--�Ի� ���� -- MyBatis => ��Ī
-- 1�� => DataBase : MyBatis (XML , Annotation)
SELECT
	  TO_CHAR(hiredate,'dy"����"') "����",
	   COUNT(*) "�ο���",
	   SUM(sal) "�޿�����",
	   AVG(sal) "�޿� ���",
	   MAX(sal) "�ִ밪",
  	   MIN(sal) "�ּҰ�"
FROM emp
GROUP BY TO_CHAR(hiredate,'dy"����"')
ORDER BY TO_CHAR(hiredate,'dy"����"') ASC;

-- �׷� ���� : HAVING
-- ��� �޿��� 2000�̻��� �μ��� ���
SELECT deptno,COUNT(*),AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

-- �μ��� �ο��� 4���̻��� �μ��� �ο���, �޿��� ����
SELECT deptno , COUNT(*) , SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*) >= 4;
*/
/*
	159page
	-----------
	GROUP BY ���� ����ϴ� �Լ�(�����Լ�) => CUBE / ROLLUP
	------------ MIN/MAX/COUNT/AVG/SUM
	| ���� ���� ������ �ִ� �÷� / �Լ�
	161page ������ / �������
	=> ���������� / ������ ������
	=> ������ �Լ� : ROW����
	=> ���� �Լ� : COLUMN����
	=> ������ �Լ��� �����Լ��� ȥ���� �Ұ���
		=> ����) �׷����� ����ϴ� �Լ�
			SELECT ename,UPPER(ename),COUNT(*) => ����
	=> ���� �׷� / ���� �׷�
	�μ��� => ������ , �Ի��� => ����
*/
/*
SELECT deptno,job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY deptno,job
ORDER BY deptno ASC;

SELECT TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'dy'),COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'dy')
ORDER BY TO_CHAR(hiredate,'YYYY') DESC;
*/
/*
	���翡�� ����ϴ� ���̺�
	orders : ���ų��� book : å���� , customer : ȸ������
	-------
		ORDERID => ���Ź�ȣ => �ߺ����� ������ (PRIMARY KEY)
		CUSTID => ȸ�� ID
		BOOKID => å ID
		SALEPRICE => ����
		ORDERDATE => ������
*/
/*
SELECT orderid,name,bookname,saleprice,orderdate
FROM orders,customer,book
WHERE orders.custid=customer.custid
AND orders.bookid=book.bookid;
*/
--1. ���� ��� å�� ���
/*
SELECT MAX(saleprice)
FROM orders;

SELECT bookname
FROM book
WHERE  price=(SELECT MAX(saleprice)
FROM orders);
*/
-- 160page => ���� ����
-- ������ 8000���̻� ������ ������ ���� �ֹ������� �� ����
SELECT custid,COUNT(*) as "��������" --5
FROM orders --1
WHERE saleprice >= 8000 --2
GROUP BY custid --3
HAVING COUNT(*)>=2 --4
ORDER BY custid;
-- ������  �������� , �Ѿ��� ���
SELECT custid "�� ���̵�" , COUNT(*) "��������", SUM(saleprice) "�Ѿ�"
FROM orders
GROUP BY custid
ORDER BY custid;

