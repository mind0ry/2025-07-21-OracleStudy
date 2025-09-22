-- 3��(SQL �⺻) - 4��(SQL ���)
/*
	179page ~
	-------------
	1. DDL : ���� ��� => ���� �÷����� => �ڵ� COMMIT
		���� , ���� , ���� , �̸����� , ������ �߶󳻱�
		= ���� :  CREATE TABLE
		   ***TABLE : ������ ���� �޸� => ���ϰ� ������ ���� 
		   VIEW : ���� ���̺� (����, �ܼ��� SQL)
		   CREATE VIEW
		   ***SEQUENCE : �ڵ� ���� ��ȣ
		   CREATE SEQUENCE
		   INDEX : �˻��� ����ȭ => ����
		   CREATE INDEX
		   FUNCTION : �������� ������ �ִ� �Լ� (�����Լ�)
				=> ����� ����
		   CREATE FUNCTION
		   PROCEDURE : ��ɸ� ����
		   CREATE PROCEDURE
		   TRIGGER : �ڵ� �̺�Ʈ ó��
		   CREATE TRIGGER
		=> ���� : ALTER
			=> �߰�(�÷�) , �������� ==> ADD
				ALTER TABLE table_name ADD �÷��� �������� [��������]
			=> ����(�÷�) , �������� ==> MODIFY
				ALTER TABLE table_name MODIFY �÷��� ��������
								   ---------- �������� ũ�� ����
			=> ����(�÷�) , �������� ==> DROP
				ALTER TABLE table_name DROP COLUMN �÷���
		=> ���� : DROP
			DROP TABLE table_name
			DROP SEQUENCE seq_name
		=> �̸� ���� : RENAME
			RENAME old_name TO new_name
			--------------------------------------- ���̺� ����
			ALTER TABLE table_name RENAME COLUMN old_name TO new_name
		=> ���̺��� ���� => �����͸� ����� ���
			TRUNCATE
			TRUNCATE TABLE table_name
		=> DDL�� ROLLBACK�� ���� => ������ ��ƴ�

		1. table ����
		  1) ��������
			������ : CHAR(1~2000byte) , VARCHAR2(1~4000byte) , CLOB (4�Ⱑ) 
				    ---------------------   ----------------------------   ---------------
												      ���ڼ��� ���� ��� : ��� , ���� , �ٰŸ�
								���� ����Ʈ : �Ϲ������� ���� ���� ���Ǵ� ����
				    ���� ����Ʈ (���ڼ��� ������ ���)
				*** ����Ŭ�� �ѱ� �ѱ��ڴ� 3byte
				*** ���ڼ��� ���� => ������ ����� ������ �߰��� �ȵȴ�
			������ : NUMBER => 38�ڸ�
				    => int / long / double
				    => default �ַ� ��� : NUMBER => NUMBER(8,2) 
			��¥�� : DATE , TIMESTAMP
				    ------ �ð� , �� , �� , ��¥
			��Ī
				����Ŭ	 	�ڹ�
				CHAR
				VARCHAR2
				CLOB			String
				NUMBER		int / double
				DATE 		java.util.Date
				BFILE/BLOB		java.io.In putStream
				------------ ���� (�̹���,������...)
		  2) ���̺�,�÷����� �ĺ���
			= ���ڷ� �����Ѵ� (���ĺ� , �ѱ�)
							       ----- �ü������ �ѱ� ó���� �ٸ���
							       ----- ����Ʈ���� ����
			*** ���ĺ��� ��ҹ��� ������ ���� �ʴ´�
			     ������ ����Ŭ�� ����ɶ� => �빮�� ����
		  	# TABLE ���� => user_tables
			# �������� 	   => user_constraints
			# View	   => user_views
			---------------------------------------- Ȯ��
		    	= table , column�� ���ڼ� => 30byte => 5~10
			   ** �÷���� ���̺���� ���� �� �� �ִ�
			= ���� �����ͺ��̽�(XE)������ table�� ���ϰ��̴�
			= Ű����� ����� �Ұ���
				SELECT, INSERT , UPDATE, JOIN , ORDER BY ...
			= ���ڸ� ����� �� �ִ� (�տ� ��� �� �� ����)
			= Ư������ ��� (_)
				=> �ܾ �ΰ��̻��� ���
				=> goods_info => goodsInfo
		  3) �������� : �̻������� ���� (���� , �����Ҷ� ������ �ʴ� �����Ϳ� ������ �ִ�)
			1 ȫ�浿 ����
			2 ȫ�浿 ���
			3 ȫ�浿 �λ�
			= NOT NULL : �ݵ�� �Է°��� �ʿ��� ���
			  * �ʼ� �Է� , �޼��� â 
			  * ''(null) , ' '(space)
			= UNIQUE : �ߺ��� ���� ������ (null���� ���)
			  * �ĺ�Ű : ��ȭ��ȣ,�̸���...
			= NOT NULL + UNIQUE : �⺻Ű => PRIAMRY KEY
			  * �������� ���Ἲ
			  * �ڵ� ���� ��ȣ , ���̵� (�ߺ� üũ)
			   ------------------- SEQUENCE
			= FOREIGN KEY : �ٸ� ���̺��� ���� 
				=> JOIN / �ܷ�Ű(����Ű)
			= CHECK : ���� �����͸� ���
				=> �帣 , ���� , ���� , �ٹ��� ...
			= DEFAULT : �����Ͱ� �Է��� �ȵ� ��� ó���ϴ� ������
				=> SYSDATE , 0 , �����/������

			����)
				CREATE TABLE table_name (
					�÷��� �������� [��������], => DEFAULT / NOT NULL
					�÷��� �������� [��������],
					�÷��� �������� [��������],
					[��������], => CHECK , FK , PK , UK
					[��������]
				);
	2. DML => ROW���� ó��
	  ������ ���۾��
		= INSERT : �߰� 
		  1) ��ü ������ �߰� , DEFAULT ����
			INSERT INTO table_name VALUES(��,��...)
					  -------------- ���̺��� �÷�������
					  -------------- ���� , ��¥ => ''
		  2) ������ �����͸� �߰� : DEFAULT , NULL ���
			INSERT INTO table_name(�÷�,�÷�...)
			VALUES(��,��...)
		= UPDATE : ���� => ������ 1��
			UPDATE table_name SET
			�÷�=�� , �÷�=�� , �÷�=��
			[����] WHERE ����
				=> �ۼ��� , ȸ������ , ���ຯ��
		= DELETE : ���� => ������ 1��
		   DELETE FROM table_name
		   [WHERE ����]
			=> �ۻ��� , ȸ��Ż�� , ���� ��� , ���� ��� ...
*/
--DROP TABLE student;

/*
	�������� : �Ѱ��� ���̺� ���ÿ� ���� => �ߺ��� �Ǹ� ���� �߻�
		       ---------------- user_constraints
	=> �̸�  �ο� => ���� �����ϱ� ���ؼ� ...
	      ----------- ���̺��_�÷�_����
		NOT NULL => nn
		PRIMARY KEY => pk
		FOREIGN KEY => fk
		CHECK => ck
		UNIQUE => uk

		1) ���̺� ����
		  => ������ ���� : � �����͸� ������ ��
		  => �������� Ȯ�� 
		  => ��������
		  	: NOT NULL => �÷��ڿ���
			: DEFAULT => �÷���
			: PK,FK,CK,UK
*/
/*
CREATE TABLE student(
	hakbun NUMBER,
	name VARCHAR2(51) CONSTRAINT std_name_nn NOT NULL,
	kor NUMBER(3),
	eng NUMBER(3),
	math NUMBER(3),
	regdate DATE DEFAULT SYSDATE,
	CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun),
	CONSTRAINT std_kor_ck CHECK(kor>=0 AND kor<=100),
	CONSTRAINT std_eng_ck CHECK(eng>=0 AND eng<=100),
	CONSTRAINT std_math_ck CHECK(math>=0 AND math<=100)
);
*/
/*
SELECT * FROM user_constraints
WHERE table_name='STUDENT';
	�������Ǹ�
		C(NN,CK),P(PK),R(FK)
*/
-- INSERT => hakbun�� �ڵ� ����
-- MAX 
/*
INSERT INTO student VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'ȫ�浿',90,90,80,SYSDATE);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'��û��',80,90,70);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'�̼���',82,92,72);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'������',83,93,73);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'�ڹ���',85,95,75);

COMMIT;
*/
/*
SELECT hakbun,name,kor,eng,math,kor+eng+math "total",
	ROUND((kor+eng+math)/3.0,2) "avg",
	RANK() OVER(ORDER BY (kor+eng+math) DESC) "rank"
FROM student;
*/
-- ���� ����
/*
UPDATE student 
SET kor=95,eng=90,math=89;
ROLLBACK;
SELECT * FROM student;
*/
/*
UPDATE student 
SET kor=95,eng=90,math=89
WHERE hakbun=103;
ROLLBACK;
SELECT * FROM student;
*/
/*
DELETE FROM student
WHERE MOD(hakbun,2)=1
ROLLBACK;
SELECT * FROM student;
*/
/*
	UPDATE : ����
	DELETE : ����
	--------------------------- COMMIT 
	=> executeQuery() => SELECT
	=> excuteUpdate() => commit() => INSERT / UPDATE / DELETE

	����) 
		UPDATE table_name
		SET �÷�=�� , �÷�=�� .... : �÷� ��������=> ����,��¥ => '��'
		[WHERE ���ǹ�]

		DELETE FROM table_name
		[WHERE ���ǹ�]
*/

