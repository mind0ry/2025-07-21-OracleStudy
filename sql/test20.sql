-- ������Ʈ => ȸ��
/*
	���̵�	==> VARCHAR2 PK
	��й�ȣ    ==> VARCHAR2 NN
	�̸� 		==> VARCHAR2 NN
	����		==> VARCHAR2 CK
	�����ȣ	==> VARCHAR2 NN
	�ּ� 1	==> VARCHAR2 NN
	�ּ� 2	==> VARCHAR2 
	��ȭ��ȣ 	==> VARCHAR2 UK
	�Ұ�		==> CLOB
*/
CREATE TABLE project_member(
	id VARCHAR2(20),
	pwd VARCHAR2(10) CONSTRAINT pm_pwd_nn NOT NULL,
	name VARCHAR2(52) CONSTRAINT pm_name_nn NOT NULL,
	sex CHAR(6),
	post VARCHAR2(7) CONSTRAINT pm_post_nn NOT NULL,
	addr1 VARCHAR2(500) CONSTRAINT pm_addr1_nn NOT NULL,
	addr2 VARCHAR2(100),
	phone VARCHAR2(13),
	content CLOB,
	regdate DATE DEFAULT SYSDATE,
	CONSTRAINT pm_id_pk PRIMARY KEY(id),
	CONSTRAINT pm_sex_ck CHECK(sex IN('����','����')),	
	CONSTRAINT pm_phone_uk UNIQUE(phone)
);

CREATE TABLE project_member(
	id VARCHAR2(20),
	pwd VARCHAR2(10) CONSTRAINT pm_pwd_nn NOT NULL,
	name VARCHAR2(52) CONSTRAINT pm_name_nn NOT NULL,
	sex CHAR(6),
	post VARCHAR2(7) CONSTRAINT pm_post_nn NOT NULL,
	addr1 VARCHAR2(500) CONSTRAINT pm_addr1_nn NOT NULL,
	addr2 VARCHAR2(100),
	phone VARCHAR2(13),
	regdate DATE DEFAULT SYSDATE,
	CONSTRAINT pm_id_pk PRIMARY KEY(id),
	CONSTRAINT pm_sex_ck CHECK(sex IN('����','����')),	
	CONSTRAINT pm_phone_uk UNIQUE(phone)
);