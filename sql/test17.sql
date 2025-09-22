-- 179page => DDL / DML
/*
	SQL
	  |
	DQL : 데이터 검색
		SELECT 
	DDL : 데이터 정의 언어
		CREATE : 생성 => TABLE : 데이터 저장 공간 (FILE)
					  VIEW : 가상 테이블 => 기존 테이블을 제어
					  SEQUENCE : 자동 증가 번호
					  INDEX / 시노님
					  PS/SQL => 함수 , 트리거
		DROP : 삭제
		ALTER :  수정 => ADD , MODIFY , DROP
				   => 컬럼단위 , 제약조건
		TRUNCATE : 잘라내기
		RENAME : 테이블 이름 변경
	DML : 데이터 조작
		INSERT : 데이터 추가
		UPDATE : 데이터 수정
		DELETE : 데이터 삭제
	DCL : GRANT : 권한 부여 / REVOKE : 권한 해제
	TCL : 정상 수행 : COMMIT / 비정상 수행 : ROLLBACK
		*** 오라클 자체에서는 COMMIT이 되어야 저장
		     자바는 AutoCommit
		 	=> TRANSACTION
	1) 데이터 저장 공간
	    -------------------
		1. 데이터형 
		  문자열 
		  	CHAR(1~2000byte) 지정 => CHAR(10)
				=> 고정 바이트 (메모리가 항상 고정)
				=> CHAR(10) => 'A' ===>
				     -----------------------------
					'A' \0 \0 .... 10개
				     -----------------------------
				=> 글자수가 같은 경우 (남자/여자 , y/n)
			VARCHAR2(1~4000byte) => 오라클에서 한글 (한글자 3byte)
				=> 가변 바이트 (메모리 => 글자수에 따라 크기가 다르다)
				=> 가장 많이 사용되는 문자열 
				=> 오라클에만 존재하는 데이터형이다
			CLOB : 4기가 => 가변형
				=> 한글 1000자 넘는 경우에 사용
				=> 줄거리 / 회사소개 / 자기소개 / 글쓰기
			-------------------------------- 자바에서 String으로 처리 (10g)
		  숫자 : NUMBER => int , long , double
			  ----------- (38)
			  NUMBER : default => 8자리 사용이 가능
							--- 숫자가 8개 존재
					NUMBER(8,2) => 12345678.12 (X)
								 ---------- 6
			NUMBER(4) => 0~9999
			NUMBER(2,1) => 평점

		  날짜 : DATE / TIMESTAMP
			   ------ java.util.Date
		  기타 (사용 빈도가 적다)
			사진 / 동영상 , 로그
			BLOB : 2진파일
			BFILE : file형태로 저장 => 폴더에 저장 => 파일을 읽어서 출력
		  형식) 
			  컬럼명 데이터형
			  -------------------
		1-1. 테이블의 식별자
			= 같은 데이터베이스에서 같은 테이블은 사용 금지
			= XE 
			1. 문자로 시작한다 (알파벳 , 한글)
			 => 알파벳은 대소문자 구분이 없다 (단, 실제 저장은 대문자로 저장된다)
			 => WHERE table_name='emp' => 'EMP'
			 => 실제 저장 공간 
				테이블 확인 : user_tables
				user_views ... user_sequences ... , user_constraints
			2. 테이블명은 30bytes 사용이 가능(컬럼명도 동일)
			3. 숫자는 사용이 가능 => 앞에 사용 금지
			4. 특수문자 ( _ , $ ) => 단어 두개인 경우 file_name
			5. 키워드 사용 금지
			 	SELECT / FROM / GROUP BY / ORDER BY ... JOIN
		2. 정형화된 데이터 : 필요한 데이터 수집 => 제약조건
			= 제약조건 : 이상현상 방지
					  ----------
					 수정 ,삭제 => 원하지 않는 데이터가 제어
			= NOT NULL : 반드시 입력값이 있어야 된다
				*** 필요입력 / 입력메세지
			= UNIQUE : 중복이 없는 데이터 (NULL값을 허용)
				*** 후보키 (기본키를 대체) => 전화번호 / 이메일
			= PRIMARY KEY : 기본키 => 모든 테이블은 1개이상의 기본키를 가지고 있다
								=> NOT NULL + UNIQUE
								=> 숫자로 이용 (게시물 번호 , 영화 번호 , 맛집 번호...)
									=> 사람 : 아이디 (중복체크)
			= FOREIGN KEY : 참조키 , 다른 테이블과 연결
				맛집 = 댓글 (맛집번호)
				영화 = 리뷰 (영화번호)
				회원 = 예약 (회원ID) 
			= CHECK : 지정된 데이터만 저장
				=> 라디오버튼 / 체크박스 / 콤보박스
				=> 남자 / 여자 , 부서명 , 장르 ...
			= DEFAULT : 미리 기본값을 설정
				=> 등록일 : redate DATE DEFAULT SYSDATE
				=> HIT : hit NUMBER DEFAULT 0
		3. 어떤 데이터를 저장할 지 => 데이터베이스 설계
			=> 벤치마킹 => 페이지 분석
			=> 게시판 , 여행 ....

		4. 테이블 생성 => 자동 COMMIT
			1) 기존의 테이블을 복사 (전체 데이터까지)
				CREATE TABLE table명
				AS 
					SELECT * FROM emp
			2) 기존의 테이블형태만 복사(데이터 없이)
				CREATE TABLE table명
				AS
					SELECT * FROM emp
					WHERE 1=2;
						   ----- false일 조건
							'A'='BB '
			3) 사용자 정의 
*/
-- 테이블 복사
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
-- 테이블 삭제
/*
	형식) 
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
-- 컬럼 추가 
/*
	ALTER TABLE myEmp ADD mgr NUMBER(4);
				 -------
*/
/*
ALTER TABLE myEmp ADD mgr NUMBER(4);
*/
-- 컬럼 수정
/*
	ALTER TABLE myEmp MODIFY 컬럼명 변경할 데이터형
*/
--ALTER TABLE myEmp MODIFY ename VARCHAR(52);
-- 컬럼 삭제
/*
	ALTER TABLE table_name DROP COLUMN column명
*/
/*
ALTER TABLE myemp DROP COLUMN mgr;
*/
--ALTER TABLE myEmp ADD myDate DATE;
--					-------- regdate => 컬럼명 변경
--ALTER TABLE myEmp RENAME COLUMN mydate TO regdate;

-- 테이블명 변경
--RENAME myemp TO empDept;

-- 데이터 잘라내기 => 복구가 안된다
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
	테이블 생성 명령어 => AUTOCOMMIT => 한번 수행시에 복구할 수 없다
	1. CREATE : 생성
	2. ALTER : 컬럼 수정 / 제약 조건 수정
		ADD : 컬럼 추가  
		MODIFY : 컬럼 수정 => 크기 조절
		DROP COLUMN => 컬럼 삭제
	3. DROP : 테이블 삭제 
	4. RENAME : 테이블명 변경
	5. TRUNCATE : 테이블 데이터 삭제
*/


