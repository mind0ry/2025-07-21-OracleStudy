-- 179page => DDL / DML
/*
	SQL
	  |
	DQL : ������ �˻�
		SELECT 
	DDL : ������ ���� ���
		CREATE : ���� => TABLE : ������ ���� ���� (FILE)
					  VIEW : ���� ���̺� => ���� ���̺��� ����
					  SEQUENCE : �ڵ� ���� ��ȣ
					  INDEX / �ó��
					  PS/SQL => �Լ� , Ʈ����
		DROP : ����
		ALTER :  ���� => ADD , MODIFY , DROP
				   => �÷����� , ��������
		TRUNCATE : �߶󳻱�
		RENAME : ���̺� �̸� ����
	DML : ������ ����
		INSERT : ������ �߰�
		UPDATE : ������ ����
		DELETE : ������ ����
	DCL : GRANT : ���� �ο� / REVOKE : ���� ����
	TCL : ���� ���� : COMMIT / ������ ���� : ROLLBACK
		*** ����Ŭ ��ü������ COMMIT�� �Ǿ�� ����
		     �ڹٴ� AutoCommit
		 	=> TRANSACTION
	1) ������ ���� ����
	    -------------------
		1. �������� 
		  ���ڿ� 
		  	CHAR(1~2000byte) ���� => CHAR(10)
				=> ���� ����Ʈ (�޸𸮰� �׻� ����)
				=> CHAR(10) => 'A' ===>
				     -----------------------------
					'A' \0 \0 .... 10��
				     -----------------------------
				=> ���ڼ��� ���� ��� (����/���� , y/n)
			VARCHAR2(1~4000byte) => ����Ŭ���� �ѱ� (�ѱ��� 3byte)
				=> ���� ����Ʈ (�޸� => ���ڼ��� ���� ũ�Ⱑ �ٸ���)
				=> ���� ���� ���Ǵ� ���ڿ� 
				=> ����Ŭ���� �����ϴ� ���������̴�
			CLOB : 4�Ⱑ => ������
				=> �ѱ� 1000�� �Ѵ� ��쿡 ���
				=> �ٰŸ� / ȸ��Ұ� / �ڱ�Ұ� / �۾���
			-------------------------------- �ڹٿ��� String���� ó�� (10g)
		  ���� : NUMBER => int , long , double
			  ----------- (38)
			  NUMBER : default => 8�ڸ� ����� ����
							--- ���ڰ� 8�� ����
					NUMBER(8,2) => 12345678.12 (X)
								 ---------- 6
			NUMBER(4) => 0~9999
			NUMBER(2,1) => ����

		  ��¥ : DATE / TIMESTAMP
			   ------ java.util.Date
		  ��Ÿ (��� �󵵰� ����)
			���� / ������ , �α�
			BLOB : 2������
			BFILE : file���·� ���� => ������ ���� => ������ �о ���
		  ����) 
			  �÷��� ��������
			  -------------------
		1-1. ���̺��� �ĺ���
			= ���� �����ͺ��̽����� ���� ���̺��� ��� ����
			= XE 
			1. ���ڷ� �����Ѵ� (���ĺ� , �ѱ�)
			 => ���ĺ��� ��ҹ��� ������ ���� (��, ���� ������ �빮�ڷ� ����ȴ�)
			 => WHERE table_name='emp' => 'EMP'
			 => ���� ���� ���� 
				���̺� Ȯ�� : user_tables
				user_views ... user_sequences ... , user_constraints
			2. ���̺���� 30bytes ����� ����(�÷��� ����)
			3. ���ڴ� ����� ���� => �տ� ��� ����
			4. Ư������ ( _ , $ ) => �ܾ� �ΰ��� ��� file_name
			5. Ű���� ��� ����
			 	SELECT / FROM / GROUP BY / ORDER BY ... JOIN
		2. ����ȭ�� ������ : �ʿ��� ������ ���� => ��������
			= �������� : �̻����� ����
					  ----------
					 ���� ,���� => ������ �ʴ� �����Ͱ� ����
			= NOT NULL : �ݵ�� �Է°��� �־�� �ȴ�
				*** �ʿ��Է� / �Է¸޼���
			= UNIQUE : �ߺ��� ���� ������ (NULL���� ���)
				*** �ĺ�Ű (�⺻Ű�� ��ü) => ��ȭ��ȣ / �̸���
			= PRIMARY KEY : �⺻Ű => ��� ���̺��� 1���̻��� �⺻Ű�� ������ �ִ�
								=> NOT NULL + UNIQUE
								=> ���ڷ� �̿� (�Խù� ��ȣ , ��ȭ ��ȣ , ���� ��ȣ...)
									=> ��� : ���̵� (�ߺ�üũ)
			= FOREIGN KEY : ����Ű , �ٸ� ���̺�� ����
				���� = ��� (������ȣ)
				��ȭ = ���� (��ȭ��ȣ)
				ȸ�� = ���� (ȸ��ID) 
			= CHECK : ������ �����͸� ����
				=> ������ư / üũ�ڽ� / �޺��ڽ�
				=> ���� / ���� , �μ��� , �帣 ...
			= DEFAULT : �̸� �⺻���� ����
				=> ����� : redate DATE DEFAULT SYSDATE
				=> HIT : hit NUMBER DEFAULT 0
		3. � �����͸� ������ �� => �����ͺ��̽� ����
			=> ��ġ��ŷ => ������ �м�
			=> �Խ��� , ���� ....

		4. ���̺� ���� => �ڵ� COMMIT
			1) ������ ���̺��� ���� (��ü �����ͱ���)
				CREATE TABLE table��
				AS 
					SELECT * FROM emp
			2) ������ ���̺����¸� ����(������ ����)
				CREATE TABLE table��
				AS
					SELECT * FROM emp
					WHERE 1=2;
						   ----- false�� ����
							'A'='BB '
			3) ����� ���� 
*/
-- ���̺� ����
/*
CREATE TABLE myEmp2
AS 
 SELECT * FROM emp;
*/
/*
CREATE TABLE myEmp3
AS
 SELECT * FROM emp
 WHERE 1=2;
*/
-- ���̺� ����
/*
	����) 
		DROP TABLE table_name;
*/
/*
DROP TABLE myEmp;
DROP TABLE myEmp2;
DROP TABLE myEmp3;
*/
/*
CREATE TABLE myEmp
AS 
	SELECT empno,ename,job,hiredate,sal,dname,loc
	FROM emp,dept
	WHERE emp.deptno=dept.deptno;
*/
-- �÷� �߰� 
/*
	ALTER TABLE myEmp ADD mgr NUMBER(4);
				 -------
*/
/*
ALTER TABLE myEmp ADD mgr NUMBER(4);
*/
-- �÷� ����
/*
	ALTER TABLE myEmp MODIFY �÷��� ������ ��������
*/
--ALTER TABLE myEmp MODIFY ename VARCHAR(52);
-- �÷� ����
/*
	ALTER TABLE table_name DROP COLUMN column��
*/
/*
ALTER TABLE myemp DROP COLUMN mgr;
*/
--ALTER TABLE myEmp ADD myDate DATE;
--					-------- regdate => �÷��� ����
--ALTER TABLE myEmp RENAME COLUMN mydate TO regdate;

-- ���̺�� ����
--RENAME myemp TO empDept;

-- ������ �߶󳻱� => ������ �ȵȴ�
-- TRUNCATE TABLE empdept;
/*
DROP TABLE empDept;
CREATE TABLE empDept
AS 
	SELECT empno,ename,job,hiredate,sal,dname,loc
	FROM emp,dept
	WHERE emp.deptno=dept.deptno;
*/
--ALTER TABLE empdept ADD mgr NUMBER(4) DEFAULT 7788 NOT NULL;

/*
	���̺� ���� ��ɾ� => AUTOCOMMIT => �ѹ� ����ÿ� ������ �� ����
	1. CREATE : ����
	2. ALTER : �÷� ���� / ���� ���� ����
		ADD : �÷� �߰�  
		MODIFY : �÷� ���� => ũ�� ����
		DROP COLUMN => �÷� ����
	3. DROP : ���̺� ���� 
	4. RENAME : ���̺�� ����
	5. TRUNCATE : ���̺� ������ ����
*/


