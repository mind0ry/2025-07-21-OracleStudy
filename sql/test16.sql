-- 179page ������ ���� ���
/*
	1. table : ������ ���� ����
		= ��������
		= ����ȭ : ��¿� �ʿ��� �����͸� ����
	2. view : ���� ���̺�
	3. sequence : �ڵ� ���� ��ȣ
	4. �ó�� ; ���̺��� ��Ī
	5. INDEX : �ӵ� ����ȭ = �˻� , ���� ****** ���� *******
	6. PL/SQL
		=> FUNCTION , PROCEUDE , TRIGGER
							���� ���� = �ڵ�ȭ ó��
							�Խù� = ��� 
							�԰�,��� = ���
					�޼ҵ�� ���� (�������� ����)
			�������� �ִ� �Լ� (���� �Լ�) => SELECT

	---------------------------------------------------------------------
	�����ͺ��̽� ���� (����ȭ = 1,2,3����ȭ)

	=> DML (INSERT,UPDATE,DELETE) => ���� 
	
	1. DDL => ������ ���� (COMMIT / ROLLBACK)
	   -----
		��ɾ� : CREATE , ALTER , DROP , TRUNCATE , RENAME
		  ����
			CREATE TABLE
			CREATE VIEW
			CREATE SEQUENCE
			CREATE FUNCTION ...

		  ����
			DROP TABLE
			DROP VIEW
			DROP SEQUENCE ...
		
		  ����
			ALTER TABLE table�� ADD => �÷� �߰�
						      MODIFY => �÷� ����
						      DROP => �÷� ����
		  �߶󳻱�
			TRUNCATE TABLE table_name

		  �̸� ����
			RENAME old_name TO new_name

		  table��
			=> XE������ ���� => ���ϰ��� �ʿ��ϴ� (�ߺ� �� �� ����)
			=> ���ڼ� : 30�� ����
			=> Ư������ : _ 
			=> ���� ����� ���� : �տ� ��� ����
			=> ���ĺ��̳� �ѱ� ��� (���ĺ� ����)
			      ------- ��ҹ��� ������ ����
			      ------- ���� �޸𸮿� ���� (�빮�ڷ� ����)

		����)
			CREATE TABLE table_name(
				�÷��� �������� [��������],
				�÷��� �������� [��������],
				�÷��� �������� [��������]
			)
			1) �÷� ���� : � �����͸� ������ �� �м� = �䱸����
			2) ��������
			     ���� ����
				CHAR(1~2000byte) => ���� ����Ʈ
					=> ���� ũ���� �����Ͱ� �ִ� ���
				VARCHAR2(1~4000byte) => ���� ����Ʈ
					=> �Ϲ������� ���Ǵ� ����
				CLOB 4�Ⱑ => ����
					=> ���� / �ٰŸ� ...
			     ���� ����
				NUMBER : 8�ڸ�
				NUMBER(4)
				NUMBER(2,1)
			     ��¥ ����
				DATE / TIMESTAMP
			3) ��������
			    ----------
			    NOT NULL => �ݵ�� �Է°�
			    UNIQUE => �ߺ��� ���� �� => NULL���� ���
			    ---------- ��ȭ��ȣ / �̸��� ... 
			    NOT NULL + UNIQUE : PRIMARY KEY (�⺻Ű)
			    => ���� / ���̵� (��� ������ ã��)
			   --------------------- �ڵ����� INDEX
			    �ܷ�Ű : FOREIGN KEY (����Ű)
			    member 	reserve 
				id		�����ȣ
						   id => ���� ����
			    CHECK : ������ ���ڸ� ����� ����
					����/���� ���� / ���� / �帣 
			    DEFAULT : �̸� ���� ����
			    ----------------------------------------------
			    * �Ѱ��� ����ϴ� ���� �ƴ϶� ������ ����� ����

			    ���� ���̺�
			    -------------- �������ǿ� ���� ����
			    �߿� : ���̺� �Ѹ� / ũ�Ѹ�

				=> �÷����� : �÷� ������ ���ÿ� ���������� ����
							=> NOT NULL , DEFAULT 
				=> ���̺� ���� : ���̺��� �����Ŀ� �������� ����
							=> PK , FK , CK , UK
				*** ��� ���������� user_constaints�ȿ� ����

				CREATE TABLE table_name(
					�÷��� �������� CONSTRAINT table��_�÷���_nn NOT NULL,
					�÷��� �������� DEFAULT ��,
					...... , 
					CONSTRAINT table��_�÷���_pk PRIMARY KEY(�÷�),
					CONSTRAINT table��_�÷���_uk UNIQUE(�÷�),
					CONSTRAINT table��_�÷���_ck CHECK(�÷� IN(....)),
					CONSTRAINT table��_�÷���_fk FOREIGN KEY(�÷�),
					REFERENCES ������ ���̺� (�÷�)
				)
*/
/*
CREATE TABLE A(
	name VARCHAR2(10) CONSTRAINT a_name_nn NOT NULL
);
CREATE TABLE B(
	name VARCHAR2(10) CONSTRAINT b_name_nn NOT NULL
);
*/
/*
DROP TABLE A;
DROP TABLE B;
*/
/*
CREATE TABLE A(
	name VARCHAR2(20) CONSTRAINT a_name_nn NOT NULL,
	sex VARCHAR2(20)
);

ALTER TABLE A DROP CONSTRAINT a_name_nn;

INSERT INTO A VALUES ('ȫ�浿','����');
INSERT INTO A VALUES ('','����');
INSERT INTO A VALUES ('','����');
INSERT INTO A VALUES ('','����');
INSERT INTO A VALUES ('�ڹ���','����');
*/
/*
	a , 1
	b , 2
	a , 2
	b , 1
*/
DROP TABLE A;

CREATE TABLE A(
	id VARCHAR2(10),
	phone VARCHAR2(20),
	PRIMARY KEY(id,phone)
);
