-- 3장(SQL 기본) - 4장(SQL 고급)
/*
	179page ~
	-------------
	1. DDL : 정의 언어 => 단위 컬럼단위 => 자동 COMMIT
		생성 , 수정 , 삭제 , 이름변경 , 데이터 잘라내기
		= 생성 :  CREATE TABLE
		   ***TABLE : 데이터 저장 메모리 => 파일과 유사한 역할 
		   VIEW : 가상 테이블 (보안, 단순한 SQL)
		   CREATE VIEW
		   ***SEQUENCE : 자동 증가 번호
		   CREATE SEQUENCE
		   INDEX : 검색의 최적화 => 정렬
		   CREATE INDEX
		   FUNCTION : 리턴형을 가지고 있는 함수 (내장함수)
				=> 사용자 정의
		   CREATE FUNCTION
		   PROCEDURE : 기능만 수행
		   CREATE PROCEDURE
		   TRIGGER : 자동 이벤트 처리
		   CREATE TRIGGER
		=> 수정 : ALTER
			=> 추가(컬럼) , 제약조건 ==> ADD
				ALTER TABLE table_name ADD 컬럼명 데이터형 [제약조건]
			=> 수정(컬럼) , 제약조건 ==> MODIFY
				ALTER TABLE table_name MODIFY 컬럼명 데이터형
								   ---------- 데이터의 크기 변경
			=> 삭제(컬럼) , 제약조건 ==> DROP
				ALTER TABLE table_name DROP COLUMN 컬럼명
		=> 삭제 : DROP
			DROP TABLE table_name
			DROP SEQUENCE seq_name
		=> 이름 변경 : RENAME
			RENAME old_name TO new_name
			--------------------------------------- 테이블 변경
			ALTER TABLE table_name RENAME COLUMN old_name TO new_name
		=> 테이블은 유지 => 데이터만 지우는 방법
			TRUNCATE
			TRUNCATE TABLE table_name
		=> DDL은 ROLLBACK이 없다 => 복구가 어렵다

		1. table 제작
		  1) 데이터형
			문자형 : CHAR(1~2000byte) , VARCHAR2(1~4000byte) , CLOB (4기가) 
				    ---------------------   ----------------------------   ---------------
												      글자수가 많은 경우 : 댓글 , 내용 , 줄거리
								가변 바이트 : 일반적으로 가장 많이 사용되는 문자
				    고정 바이트 (글자수가 동일한 경우)
				*** 오리클은 한글 한글자당 3byte
				*** 글자수를 지정 => 범위를 벗어나면 데이터 추가가 안된다
			숫자형 : NUMBER => 38자리
				    => int / long / double
				    => default 주로 사용 : NUMBER => NUMBER(8,2) 
			날짜형 : DATE , TIMESTAMP
				    ------ 시간 , 분 , 초 , 날짜
			매칭
				오라클	 	자바
				CHAR
				VARCHAR2
				CLOB			String
				NUMBER		int / double
				DATE 		java.util.Date
				BFILE/BLOB		java.io.In putStream
				------------ 폴더 (이미지,동영상...)
		  2) 테이블,컬럼명의 식별자
			= 문자로 시작한다 (알파벳 , 한글)
							       ----- 운영체제마다 한글 처리가 다르다
							       ----- 소프트웨어 이행
			*** 알파벳은 대소문자 구분을 하지 않는다
			     실제로 오라클에 저장될때 => 대문자 저장
		  	# TABLE 저장 => user_tables
			# 제약조건 	   => user_constraints
			# View	   => user_views
			---------------------------------------- 확인
		    	= table , column의 글자수 => 30byte => 5~10
			   ** 컬럼명과 테이블명은 동일 할 수 있다
			= 같은 데이터베이스(XE)에서는 table은 유일값이다
			= 키워드는 사용이 불가능
				SELECT, INSERT , UPDATE, JOIN , ORDER BY ...
			= 숫자를 사용할 수 있다 (앞에 사용 할 수 없다)
			= 특수문자 사용 (_)
				=> 단어가 두개이상일 경우
				=> goods_info => goodsInfo
		  3) 제약조건 : 이상현상을 방지 (수정 , 삭제할때 원하지 않는 데이터에 영향이 있다)
			1 홍길동 서울
			2 홍길동 경기
			3 홍길동 부산
			= NOT NULL : 반드시 입력값이 필요한 경우
			  * 필수 입력 , 메세지 창 
			  * ''(null) , ' '(space)
			= UNIQUE : 중복이 없는 데이터 (null값을 허용)
			  * 후보키 : 전화번호,이메일...
			= NOT NULL + UNIQUE : 기본키 => PRIAMRY KEY
			  * 데이터의 무결성
			  * 자동 증가 번호 , 아이디 (중복 체크)
			   ------------------- SEQUENCE
			= FOREIGN KEY : 다른 테이블을 연결 
				=> JOIN / 외래키(참조키)
			= CHECK : 지정 데이터만 사용
				=> 장르 , 구분 , 직위 , 근무지 ...
			= DEFAULT : 데이터가 입력이 안된 경우 처리하는 데이터
				=> SYSDATE , 0 , 사용자/관리자

			형식)
				CREATE TABLE table_name (
					컬럼명 데이터형 [제약조건], => DEFAULT / NOT NULL
					컬럼명 데이터형 [제약조건],
					컬럼명 데이터형 [제약조건],
					[제약조건], => CHECK , FK , PK , UK
					[제약조건]
				);
	2. DML => ROW단위 처리
	  데이터 조작언어
		= INSERT : 추가 
		  1) 전체 데이터 추가 , DEFAULT 포함
			INSERT INTO table_name VALUES(값,값...)
					  -------------- 테이블의 컬럼순서로
					  -------------- 문자 , 날짜 => ''
		  2) 지정된 데이터만 추가 : DEFAULT , NULL 허용
			INSERT INTO table_name(컬럼,컬럼...)
			VALUES(값,값...)
		= UPDATE : 수정 => 형식이 1개
			UPDATE table_name SET
			컬럼=값 , 컬럼=값 , 컬럼=값
			[조건] WHERE 조건
				=> 글수정 , 회원가입 , 예약변경
		= DELETE : 삭제 => 형식이 1개
		   DELETE FROM table_name
		   [WHERE 조건]
			=> 글삭제 , 회원탈퇴 , 예약 취소 , 결제 취소 ...
*/
--DROP TABLE student;

/*
	제약조건 : 한개의 테이블에 동시에 저장 => 중복이 되면 오류 발생
		       ---------------- user_constraints
	=> 이름  부여 => 쉽게 제어하기 위해서 ...
	      ----------- 테이블명_컬럼_약자
		NOT NULL => nn
		PRIMARY KEY => pk
		FOREIGN KEY => fk
		CHECK => ck
		UNIQUE => uk

		1) 테이블 제작
		  => 데이터 추출 : 어떤 데이터를 저장할 지
		  => 데이터형 확인 
		  => 제약조건
		  	: NOT NULL => 컬럼뒤에서
			: DEFAULT => 컬럼뒤
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
	제약조건명
		C(NN,CK),P(PK),R(FK)
*/
-- INSERT => hakbun은 자동 증가
-- MAX 
/*
INSERT INTO student VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'홍길동',90,90,80,SYSDATE);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'심청이',80,90,70);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'이순신',82,92,72);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'강감찬',83,93,73);
INSERT INTO student(hakbun,name,kor,eng,math)
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),'박문수',85,95,75);

COMMIT;
*/
/*
SELECT hakbun,name,kor,eng,math,kor+eng+math "total",
	ROUND((kor+eng+math)/3.0,2) "avg",
	RANK() OVER(ORDER BY (kor+eng+math) DESC) "rank"
FROM student;
*/
-- 점수 수정
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
	UPDATE : 수정
	DELETE : 삭제
	--------------------------- COMMIT 
	=> executeQuery() => SELECT
	=> excuteUpdate() => commit() => INSERT / UPDATE / DELETE

	형식) 
		UPDATE table_name
		SET 컬럼=값 , 컬럼=값 .... : 컬럼 데이터형=> 문자,날짜 => '값'
		[WHERE 조건문]

		DELETE FROM table_name
		[WHERE 조건문]
*/

