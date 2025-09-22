-- 프로젝트 => 회원
/*
	아이디	==> VARCHAR2 PK
	비밀번호    ==> VARCHAR2 NN
	이름 		==> VARCHAR2 NN
	성별		==> VARCHAR2 CK
	우편번호	==> VARCHAR2 NN
	주소 1	==> VARCHAR2 NN
	주소 2	==> VARCHAR2 
	전화번호 	==> VARCHAR2 UK
	소개		==> CLOB
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
	CONSTRAINT pm_sex_ck CHECK(sex IN('남자','여자')),	
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
	CONSTRAINT pm_sex_ck CHECK(sex IN('남자','여자')),	
	CONSTRAINT pm_phone_uk UNIQUE(phone)
);