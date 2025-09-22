-- ������ ���۾�� (DML => INSERT / UPDATE / DELETE) = 187page
/*
	INSERT : ������ �߰�
	 = INSERT ALL : �̹� �����ϴ� ���̺��� ��ü �����͸� ������ ����
	 ***= ��ü ������ ���
		INSERT INTO table_name VALUES(��,�� ....) => DEFAULT�� ������ �ȵȴ�
				   ------------
				   �÷��� ��Ī => DEFAULT�� �������
	 = ���ϴ� ������ ��� (NULL��� , DEFAULT�� �ִ� ���)
	INSERT INTO table_name(�÷�,�÷�...) VALUES(��....)
*/
/*
-- INSERT ALL
CREATE TABLE emp_10
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_20
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_30
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;
*/
-- ��Ƽ�� ���̺� => �б⺰ ��� => ������ ��� (GROUP BY)
/*
DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;

CREATE TABLE emp_10
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_20
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_30
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

INSERT ALL
	WHEN deptno=10 THEN
	  INTO emp_10 VALUES(empno,ename,job,hiredate,sal)
	WHEN deptno=20 THEN
	  INTO emp_20 VALUES(empno,ename,job,hiredate,sal)
	WHEN deptno=30 THEN
	  INTO emp_30 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;
*/
--�Ի�⵵��
/*
CREATE TABLE emp_1980
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1981
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1982
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1983
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;
drop table emp_ 1980;
drop table emp_ 1981;
drop table emp_ 1982;
drop table emp_ 1983;
INSERT ALL
	WHEN TO_CHAR(hiredate,'YYYY')=1980 THEN
	  INTO emp_1980 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1981 THEN
	  INTO emp_1981 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1982 THEN
	  INTO emp_1982 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1983 THEN
	  INTO emp_1983 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;
*/
/*
DROP TABLE ��ǥ��;
DROP TABLE �Ǹ���ǥ;
DROP TABLE ��ǰ;

DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;
DROP TABLE emp_1980;
DROP TABLE emp_1981;
DROP TABLE emp_1982;
DROP TABLE emp_1983;
*/
/*
CREATE TABLE student(
	hakbun NUMBER,
	name VARCHAR2(52) CONSTRAINT student_name_nn NOT NULL,
	kor NUMBER(3) CONSTRAINT student_kor_nn NOT NULL,
	eng NUMBER(3) CONSTRAINT student_eng_nn NOT NULL,
	math NUMBER(3) CONSTRAINT student_math_nn NOT NULL,
	regdate DATE DEFAULT SYSDATE,
	CONSTRAINT student_hakbun_pk PRIMARY KEY(hakbun)
);
*/
--INSERT INTO table_name VALUES(��...)
-- ���ڿ� => '' , ��¥ => '' (SYSDATE)
-- DEFAULT�� �ִ� ��� => �÷��� ����
-- INSERT INTO table_name(�÷�.....) VALUES(��....)
-- 								      SYSDATE
--INSERT INTO student VALUES(100,'ȫ�浿',90,80,95,'25/08/01');
--INSERT INTO student VALUES(101,'��û��',80,75,90,SYSDATE);
/*
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(102,'�ڹ���',78,89,90);
COMMIT;
*/
-- subquery => insert,update,delete ���� ����� ����
-- insert => �ڵ� ������ȣ ����� SELECT NVL(MAX(hakbun)+1,100
/*
INSERT INTO student(hakbun,name,kor,eng,math) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
'�̼���',89,90,98);
COMMIT;
*/
/*
INSERT INTO student(hakbun,name,kor,eng,math) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
'������',80,95,90);
COMMIT;
*/
-- COMMIT�� ���� ��� => ����Ŭ������ ���������� ����� ����
-- �ڹٿ����� �ν����� ���Ѵ� (���� ����� �޸𸮿��� �б�)
/*
INSERT INTO student(hakbun,name,kor,eng) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
	'�����',90,90);
*/
/*
CREATE TABLE student2
AS
	SELECT * FROM student
	WHERE 1=2;
*/
=> SELECT ������ �̿��ؼ� ������ ������ ����
=> ���� ���Ǵ� ������ �ƴϴ� (�����͸� ����)
/*
INSERT INTO student2(hakbun,name,kor,eng,math,regdate)
	SELECT * FROM student;
*/