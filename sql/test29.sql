-- 데이터 수집
/*
	1. 데이터형
	   = 문자 : CHAR(1~2000byte) , VARCHAR2(1~4000byte) , CLOB
	   = 숫자 : NUMBER = int / double NUMBER(2,1)
	   = DATE
	2. 생성
	   CREATE TABLE table_name(
		컬럼명 데이터명 [제약조건],
	 	컬럼명 데이터명 [제약조건],
		컬럼명 데이터명 [제약조건], => DEFAULT / NOT NULL
		[제약조건].. // PK , UK , CK , FK
	   );
	3. 컬럼 추출 = 데이터형 확인 = 테이블 제작
						    ------------- 중복제거 / 단일값 설정
	4. 추출
	   이미지 (Main) / 이미지 여러개
	   업체명 / 업종 / 전화 / 주소 / 평점 / 테마 / 영업시간 / 주차 / 소개 / 가격대
*/
--DROP TABLE menupan_food;
CREATE TABLE menupan_food(
	fno NUMBER,
	name VARCHAR2(200) CONSTRAINT menuf_name_nn NOT NULL,
	type VARCHAR2(100) CONSTRAINT menuf_type_nn NOT NULL,
	phone VARCHAR2(20),
	address VARCHAR2(500) CONSTRAINT menuf_address_nn NOT NULL,
	score NUMBER(2,1),
	theme CLOB,
	price VARCHAR2(50),
	time VARCHAR2(100),
	parking VARCHAR2(100),
	poster VARCHAR2(260) CONSTRAINT menuf_poster_nn NOT NULL,
	images CLOB,
	content CLOB,
	hit NUMBER DEFAULT 0,
	CONSTRAINT menuf_fno_pk PRIMARY KEY(fno)
);
--DROP SEQUENCE mf_fno_seq;
CREATE SEQUENCE mf_fno_seq
	START WITH 1
	INCREMENT BY 1
	NOCACHE
	NOCYCLE;
-- 이름 검색 최적화 
/*
DROP INDEX idx_mf_name;
DROP INDEX idx_mf_type;
DROP INDEX idx_mf_address;
DROP INDEX idx_mf_score;
DROP INDEX idx_mf_hit;
*/
CREATE INDEX idx_mf_name ON menupan_food(name);
-- 음식 종류 최적화
CREATE INDEX idx_mf_type ON menupan_food(type);
-- 주소 검색
CREATE INDEX idx_mf_address ON menupan_food(address);
-- 평점 정렬
CREATE INDEX idx_mf_score ON menupan_food(score);
-- 조회수 (인기순위 검색)
CREATE INDEX idx_mf_hit ON menupan_food(hit);