 -- ����� ���� ���̺� ���� 
/*
	������ ���� => ������ ���� (�䱸���� , ������ �м�)
		|		����
				���� , �뷡�� , ������ , �ٹ��� , ���� , ���� , ������ Ű
	���� ����
		|		����(NUMBER) , �뷡��(VARCHAR2) ,
				 ������(VARCHAR2) , �ٹ���(VARCHAR2) , 
				����(NUMBER) , ����(VARCHAR2) , ������ Ű(VARCHAR2)
	������ ����
				���� NUMBER(3) ....

	����)
		CREATE TABLE table_name(
			�÷��� �������� [��������],
			�÷��� �������� [��������],
			�÷��� �������� [��������],
			-------------------------------- �÷�����
				=> �÷� ������ ���ÿ� �������� ����
				=> �ݵ�� ��� : NOT NULL , DEFAULT
			[��������],
			[��������],
			[��������]
			-------------------------------- ���̺���
				=> ���̺��� ������� �Ŀ� ���߿� ��������  ����
				=> PRIMARY KEY , FOREIGN KEY , CHECK , UNIQUE
		)

		�������� ���� : �������� �̸� �ο�
				      ---------
					user_constaints : �Ѱ��� ����
					���̺��_�÷���_�������Ǿ���
					----- ����
					nn : NOT NULL
					pk : PRIMARY KEY 
					fk : FOREIGN KEY
					ck : CHECK
					uk : UNIQUE
*/
/*
	emp / dept
	��� : empno = PRIMARY KEY
	�̸� : ename = NOT NULL
	���� : job 	   = NOT NULL / CHECK
	��� : mgr	   = NULL ���
	�Ի��� : hiredate = DATE => DEFAULT
	�޿� : sal	= NOT NULL
	������ : comm = NULL ���
	�μ���ȣ : deptno = FOREIGN KEY
--------------------------------------
	�μ���ȣ : deptno = PRIMARY KEY
	�μ��� : dname (CHECK) = NOT NULL
	�ٹ��� : loc (CHECK) = NOT NULL

	ȸ�� => ���� (ID) ���� , ��� , ���� ....
	
	1. ���̺�
	2. ��������
	3. ���̺� ����

	 => �Ǹ���ǥ / ��ǰ / ��ǥ��

	�Ǹ���ǥ
	---------------------------------------------------
	�÷���    ��ǥ��ȣ   �Ǹ�����   ����   �Ѿ�
	---------------------------------------------------
	��������     PK		NN         NN  CHECK
				    DEFAULT
	---------------------------------------------------
	�������̺�
	---------------------------------------------------
	���� �÷�
	---------------------------------------------------
	üũ							>0
	---------------------------------------------------
	��������  VARCHAR2 DATE	VARCHAR2 NUMBER
	---------------------------------------------------
	ũ�� 	       13			     51	8,2
	-----------------------------------------------------------

	��ǰ
	---------------------------------------------------
	�÷���    ��ǰ��ȣ   ��ǰ��   ��ǰ�ܰ�  
	---------------------------------------------------
	��������     PK		NN         CK
	---------------------------------------------------
	�������̺�
	---------------------------------------------------
	���� �÷�
	---------------------------------------------------
	üũ							>0
	---------------------------------------------------
	��������  VARCHAR2 VARCHAR2 NUMBER
	---------------------------------------------------
	ũ�� 	       13		  51		8,2
	-----------------------------------------------------------

	��ǥ��
	--------------------------------------------------------
	�÷���    ��ǥ��ȣ   ��ǰ��ȣ   ����   �ܰ�   �ݾ�  
	--------------------------------------------------------
	��������   PK/FK		FK         NN     NN    CK
	--------------------------------------------------------
	�������̺�	�Ǹ���ǥ  ��ǰ
	--------------------------------------------------------
	���� �÷�  ��ǥ��ȣ    ��ǰ��ȣ
	--------------------------------------------------------
	üũ							      >0
	--------------------------------------------------------
	��������  VARCHAR2 VARCHAR2 NUMBER NUMBER NUMBER
	--------------------------------------------------------
	ũ�� 	       13		  51		8,2		8,2		8,2
	-----------------------------------------------------------

*/
/*
DROP TABLE �Ǹ���ǥ;
DROP TABLE ��ǰ;
DROP TABLE ��ǥ��;
CREATE TABLE �Ǹ���ǥ (
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE DEFAULT SYSDATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL,
    ����   VARCHAR2(51) CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL,
    �Ѿ�     NUMBER CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ� > 0), 
    CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ)
);

CREATE TABLE ��ǰ (
    ��ǰ��ȣ VARCHAR2(13),
    ��ǰ��   VARCHAR2(51) CONSTRAINT ��ǰ_��ǰ��_nn NOT NULL,
    ��ǰ�ܰ� NUMBER CONSTRAINT ��ǰ_��ǰ�ܰ�_ck CHECK(��ǰ�ܰ� > 0), 
    CONSTRAINT ��ǰ_��ǰ��ȣ_pk PRIMARY KEY(��ǰ��ȣ)
);

CREATE TABLE ��ǥ�� (
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(13),
    ����     NUMBER CONSTRAINT ��ǥ��_����_nn NOT NULL,
    �ܰ�     NUMBER CONSTRAINT ��ǥ��_�ܰ�_nn NOT NULL,
    �ݾ�     NUMBER CONSTRAINT ��ǥ��_�ݾ�_ck CHECK(�ݾ� > 0),
    -- ��ǥ��ȣ�� ��ǰ��ȣ�� �Բ� PK�� ��� �� �Ϲ����Դϴ� (�� ��ǥ�� ���� ��ǰ ����)
    CONSTRAINT ��ǥ��_pk PRIMARY KEY(��ǥ��ȣ, ��ǰ��ȣ),
    CONSTRAINT ��ǥ��_��ǥ��ȣ_fk FOREIGN KEY(��ǥ��ȣ)
        REFERENCES �Ǹ���ǥ(��ǥ��ȣ),
    CONSTRAINT ��ǥ��_��ǰ��ȣ_fk FOREIGN KEY(��ǰ��ȣ)
        REFERENCES ��ǰ(��ǰ��ȣ)
);
*/
-- ALTER�� �̿��� �������� ����
DROP TABLE �Ǹ���ǥ;
DROP TABLE ��ǰ;
DROP TABLE ��ǥ��;
-- ��Ÿ/��ȣ/Ÿ�� ����ġ�� ����
CREATE TABLE �Ǹ���ǥ (
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE,
    ����   VARCHAR2(51),
    �Ѿ�     NUMBER
);
/*
	1. NOT NULL => MODIFY �÷��� �������� ��������
	2. CHECK , PRIMARY KEY , FOREIGN KEY , UNIQUE => ADD CONSTRAINT ��������
	3. �������� ����
	    ALTER TABLE table_name DROP CONSTRAINT �̸� ;
									    ------
									�Ǹ���ǥ_��ǥ��ȣ_pk 
	=> �ѹ��� �ϼ��� �ȵȴ�
		�÷� �߰� , �÷� ũ�� ���� , �÷� ������ ���� => 184~815
		ALTER TABLE table_name ADD �÷��� �������� [��������]
		ALTER TABLE table_name MODIFY �÷��� ��������
									  ----------
		ALTER TABLE table_name DROP COLUMN col_name
		=> COLUMN ����
		=> �������� ���� => �����Ͱ� �ִ� ���
		�������� �߰� , �������� ���� , ���� ���� ���� ����
		ALTER TABLE table_name ADD CONSTRAINT ~
						   ------ PK,FK,CK,UK
		ALTER TABLE table_name MODIFY �÷��� �������� CONSTRAINT ~
						   ---------- NN
		** DEFAULT ���ÿ��� CONSTRAINT�տ� ����
		ALTER TABLE table_name DROP CONSTRAINT constraint_name
*/
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ);
ALTER TABLE �Ǹ���ǥ MODIFY �Ǹ����� DATE DEFAULT SYSDATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ MODIFY ���� VARCHAR2(51) CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ� > 0);
CREATE TABLE ��ǰ (
    ��ǰ��ȣ VARCHAR2(13),
    ��ǰ��   VARCHAR2(51) ,
    ��ǰ�ܰ� NUMBER
);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ��ȣ_pk PRIMARY KEY(��ǰ��ȣ);
ALTER TABLE ��ǰ ADD NUMBER CONSTRAINT ��ǰ_��ǰ�ܰ�_ck CHECK(��ǰ�ܰ� > 0);
ALTER TABLE ��ǰ MODIFY ��ǰ�� VARCHAR2(51) CONSTRAINT ��ǰ_��ǰ��_nn NOT NULL;
CREATE TABLE ��ǥ�� (
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(13),  -- ����(��ǰ.��ǰ��ȣ)�� ���� ��ġ
    ����     NUMBER,
    �ܰ�     NUMBER,
    �ݾ�     NUMBER
);

