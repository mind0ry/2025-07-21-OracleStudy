-- 179page 데이터 정의 언어
/*
	1. table : 데이터 저장 공간
		= 데이터형
		= 정형화 : 출력에 필요한 데이터만 수집
	2. view : 가상 테이블
	3. sequence : 자동 증가 번호
	4. 시노님 ; 테이블의 별칭
	5. INDEX : 속도 최적화 = 검색 , 정렬 ****** 면접 *******
	6. PL/SQL
		=> FUNCTION , PROCEUDE , TRIGGER
							연쇄 반응 = 자동화 처리
							게시물 = 댓글 
							입고,출고 = 재고
					메소드와 동일 (리턴형이 없다)
			리턴형이 있는 함수 (내장 함수) => SELECT

	---------------------------------------------------------------------
	데이터베이스 설계 (정규화 = 1,2,3정규화)

	=> DML (INSERT,UPDATE,DELETE) => 복구 
	
	1. DDL => 복구가 없다 (COMMIT / ROLLBACK)
	   -----
		명령어 : CREATE , ALTER , DROP , TRUNCATE , RENAME
		  생성
			CREATE TABLE
			CREATE VIEW
			CREATE SEQUENCE
			CREATE FUNCTION ...

		  삭제
			DROP TABLE
			DROP VIEW
			DROP SEQUENCE ...
		
		  수정
			ALTER TABLE table명 ADD => 컬럼 추가
						      MODIFY => 컬럼 변경
						      DROP => 컬럼 제거
		  잘라내기
			TRUNCATE TABLE table_name

		  이름 변경
			RENAME old_name TO new_name

		  table명
			=> XE폴더에 저장 => 유일값이 필요하다 (중복 할 수 없다)
			=> 글자수 : 30자 내외
			=> 특수문자 : _ 
			=> 숫자 사용이 가능 : 앞에 사용 금지
			=> 알파벳이나 한글 사용 (알파벳 권장)
			      ------- 대소문자 구분이 없다
			      ------- 실제 메모리에 저장 (대문자로 저장)

		형식)
			CREATE TABLE table_name(
				컬럼명 데이터형 [제약조건],
				컬럼명 데이터형 [제약조건],
				컬럼명 데이터형 [제약조건]
			)
			1) 컬럼 설정 : 어떤 데이터를 저장할 지 분석 = 요구사항
			2) 데이터형
			     문자 저장
				CHAR(1~2000byte) => 고정 바이트
					=> 같은 크기의 데이터가 있는 경우
				VARCHAR2(1~4000byte) => 가변 바이트
					=> 일반적으로 사용되는 문자
				CLOB 4기가 => 가변
					=> 내용 / 줄거리 ...
			     숫자 저장
				NUMBER : 8자리
				NUMBER(4)
				NUMBER(2,1)
			     날짜 저장
				DATE / TIMESTAMP
			3) 제약조건
			    ----------
			    NOT NULL => 반드시 입력값
			    UNIQUE => 중복이 없는 값 => NULL값을 허용
			    ---------- 전화번호 / 이메일 ... 
			    NOT NULL + UNIQUE : PRIMARY KEY (기본키)
			    => 숫자 / 아이디 (모든 데이터 찾기)
			   --------------------- 자동으로 INDEX
			    외래키 : FOREIGN KEY (참조키)
			    member 	reserve 
				id		예약번호
						   id => 값이 존재
			    CHECK : 지정된 문자만 사용이 가능
					남자/여자 직위 / 지역 / 장르 
			    DEFAULT : 미리 값을 지정
			    ----------------------------------------------
			    * 한개나 사용하는 것이 아니라 여러개 사용이 가능

			    실제 테이블
			    -------------- 제약조건에 대한 수정
			    중요 : 테이블 한명 / 크롤링

				=> 컬럼레벨 : 컬럼 생성과 동시에 제약조건이 저장
							=> NOT NULL , DEFAULT 
				=> 테이블 레벨 : 테이블이 생성후에 제약조건 저장
							=> PK , FK , CK , UK
				*** 모든 제약조건은 user_constaints안에 저장

				CREATE TABLE table_name(
					컬럼명 데이터형 CONSTRAINT table명_컬럼명_nn NOT NULL,
					컬럼명 데이터형 DEFAULT 값,
					...... , 
					CONSTRAINT table명_컬럼명_pk PRIMARY KEY(컬럼),
					CONSTRAINT table명_컬럼명_uk UNIQUE(컬럼),
					CONSTRAINT table명_컬럼명_ck CHECK(컬럼 IN(....)),
					CONSTRAINT table명_컬럼명_fk FOREIGN KEY(컬럼),
					REFERENCES 참조할 테이블 (컬럼)
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

INSERT INTO A VALUES ('홍길동','남자');
INSERT INTO A VALUES ('','여자');
INSERT INTO A VALUES ('','남자');
INSERT INTO A VALUES ('','여자');
INSERT INTO A VALUES ('박문수','남자');
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
