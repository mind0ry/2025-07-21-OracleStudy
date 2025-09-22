-- 3장 ~ 4장 => 형식 / 순서
/*
	PL/SQL/정규식 (REGEXP_LIKE , REGEXP_COUNT , REGEXP_REPLACE , 
	REGEXP_STRSUB , REGEXP_INSTR)
	=> 그룹함수 : GROUPING / CUBE / ROLLUP)
	=> 데이터베이스 설계 (정규화) / 트랜잭션 사용법
	1. 3장 
		=> SELECT => 데이터 검색 => 프로젝트 (80%)
		   형식,순서)
			SELECT (DISTINCT|*) *| column_list(연산자(산술),함수)
			FROM table_name|view_name|SELECT
		--------------------------------------------------------------------
		WHERE 조건문 (비교연산자 , 논리연산자 , BETWEEN ~ AND
					IN , LIKE , NOT , NULL(IS NULL , IS NOT NULL)
		GROUP BY 그룹컬럼|함수 => 그룹별 집계
				--------------- 컬럼값이 동일
		HAVING 그룹 조건 => GROUP BY가 있는 경우에만 사용이 가능
		ORDER BY 정렬할 컬럼 | 함수 (ASC|DESC)
							  ----- 생략
		=> 데이터가 많은 경우는 정렬시에 INDEX
			INDEX_ASC() , INDEX_DESC()

		1) 연산자
			산술 연산자 : + , - , * , / => MOD() : %
				=> ROW단위 통계 => 제공하는 함수가 없다
			비교연산자 : = , <> , < , > , <= , >=
			논리연산자 : AND (범위,기간 포함) , OR (범위 , 기간을 벗어난 경우)
									   | 다중검색
			BETWEEN ~ AND : AND 대신 사용
				=> 페이징 기법 , 체크인 , 예약 기간 ..
			IN : OR여러개인 경우 => MyBatis => forEach
				=> 동적쿼리
			NOT : 부정 => NOT IN , NOT LIKE , NOT BETWEEN
				=> !는 사용하지 않는다
			NULL : 값이 없는 상태
				=> NullPointerException : 오류 발생
				=> null로 연산 처리 => 결과값 (null)
				=> IS NULL , IS NOT NULL
			LIKE : % => 문자 제한이 없음
				_ => 문자 한글자
				startsWith : 문자% ====> index 적용 => ^문자
				endsWith : %문자 =====> 문자$
				contains : %문자% ========> 문자
					정규식
						범위 : [가-힣] , [A-Za-z] , [0-9]
				=> REGEXP_LIKE(컬럼,정규식)
		2) 내장함수
			= 단일행 함수 : ROW단위 처리 (한줄씩 처리)
			= 집계함수 : COLUMN단위 처리 
			LENGTH => 문자의 개수
			REPLACE : 문자 변경 => & , | , "
				=> 웹에서 채팅 (채팅문자 저장)
				=> URL => &는 요청값 구분
				=> GET : SELECT
				=> POST : INSERT
				=> DELETE : DELETE
					LENGTH(컬럼명) : 비밀번호
			RPAD => RPAD(컬럼명,문자개수,'*')
					=> 아이디 찾기

			숫자함수
				=> MOD : 나머지 => %
					MOD(숫자1,숫자2) => 숫자1%숫자2
				=> ROUND : 반올림 = 평균
					ROUND(123.567,2)
							    -
				=> CEIL : 올림 = 총페이지 구하기
					** TRUNC : 버림
			날짜함수
				=> SYSDATE : 시스템 시간 , 날짜
					산술연산자를 이용해서 전날 ...
					SYSDDATE - 1
				=> MONTHS_BETWEEN: 기간의 개월수
					MONTHS_BETWEEN(현재날짜 , 이전날짜)

			기타함수
				=> NVL : null일 경우 다른 값으로 변경
					NVL(컬럼 , 대체값)
						  |	    |	
						  --------- 데이터형이 동일

			변환함수 => 날짜 , 숫자 => 문자열 변환
				=> TO_CHAR(숫자, '패턴')
				      TO_CHAR(1234567,'9,999,999') 1,234,567
				     TO_CHAR(날짜 , '패턴') 
						YYYY / RRRR => 년도
						MM
						DD
						HH / HH24
						MI
						SS
						DY
					=> 날짜 + 시간 = 공지사항 / 댓글 

				=> COUNT : row의 개수
					=> 로그인 / 아이디 체크 / 전화번호 체크
					  COUNT(*) / COUNT(컬럼)
					  -----------    -------------- NULL값 제외
					  NULL값 포함
				MAX / MIN
				----- 자동 증가 번호 이용 => SEQUENCE
				SUM / AVG
				----- 총합 / 평균 
				=> GROUPING / CUBE / ROLLUP
			*** GROUP BY가 없는 경우 => 단일행 , 집계함수는 같이 사용할 수 없다
		3) 조인 / 서브쿼리 => 프로젝트 (반드시 SQLDeveloper)
			
		    자바 => "" (LIKE문장만 변경) '%A%'
				=> 오라클 : '%'||?||'%'
				=> MYSQL : CONCAT('%',?,'%')
		
		테이블이 2개 이상에서 데이터 추출 : 조인 => SELECT에서 사용 가능
			= INNER JOIN (교집합)
			   = EQUI_JOIN (=)
			   = NON_EQUI_JOIN (=외에 다른 연산자 : 논리연산자 , BETWEEN)
			   형식)
				오라클 조인
					SELECT A.col , B.col
					FROM A,B
					WHERE A.col=B.col
				표준 조인 (ANSI JOIN)
					SELECT A.col , B.col
					FROM A (INNER) JOIN B
					ON A.col=B.col
			= OUTER JOIN (교집합외 다른 데이터)
				= LEFT OUTER JOIN
				= RIGHT OUTER JOIN
				오라클 조인
					SELECT A.col , B.col
					FROM A,B
					WHERE A.col=B.col
				
				표준 조인 (ANSI JOIN)
					SELECT A.col , B.col
					FROM A (INNER) JOIN B
					ON A.col=B.col
				=> INTERSECT 
				*** UNION / UNION ALL / INTERSECT / MINUS		
				집합연산자
				A 1,2,3,4,5
				B 4,5,6,7,8
				A UNION B ==> 1,2,3,4,5,6,7,8
				A UNION ALL B ==> 1,2,3,4,5,4,5,6,7,8
				A INTERSECT B ==> 4,5
				A MINUS B ===> 1,2,3
				B MINUS A ===> 6,7,8
		SQL문장 2개 이상 통합하는 과정 : 서브쿼리
				서브쿼리
					= 단일행 서브쿼리 (컬럼 1개 , 결과값 1개)
						주로 사용하는 연산자 : 비교 연산자
						SELECT * FROM table_name
						WHERE 컬럼 연산자 (SELECT ~)
									     ----------- 결과값 1개 , 테이블 다른 경우도 있다
									|
								     비교연산자
   					= 다중행 서브쿼리 (컬럼 1개 , 결과값 여러개)
					= 다중컬럼 서브쿼리 (컬럼 여러개 , 결과값 1개)
						IN : 전체 대입
						ANY , ALL => MAX , MIN
						SELECT * FROM table_name
						WHERE 컬럼 연산자 (SELECT ~)
									    ------------ 결과값 여러줄
									| IN , ANY(SOME) , ALL
				스칼라 서브쿼리 : 컬럼 대신 사용
					SELECT 컬럼 (SELECT ~)
							  ------------ 결과값 1개 , 다른 테이블에서 추출
					FROM table_name
					=> 조인 대신 사용 / 문장이 많이 긴 경우
					=> 이미 SQL문장이 제작이 된 경우 = 다른 테이블에서 추가적으로 데이터 추출
							= 유지보수
					=> FUNCTION을 만들어서 처리 할 경우도 있다
		
				인라인뷰 : 테이블 대신 사용(보안)
					SELECT *
					FROM (SELECT ~)
					=>TOP-N
	   4장
		=> CREATE / DROP / TRUNCATE / RENAME / ALTER
		=> DML(INSERT , UPDATE , DELETE)
		DML : 데이터 조작 => 웹 개발자 => CRUD
			1) 데이터 저장 : INSERT
				= 전체 데이터 저장
				   INSERT INTO table_name VALUES(값,값...)
										  -------
									모든 컬럼값 설정
									순서
									문자 => "
									날짜 => 오늘 날짜가 아닌 경우
										'YY/MM/DD'
										SYSDATE
					*** ps.setString(1,vo.getName()) => 자동으로 '홍길동'	
					*** 오라클에서는 저장 : COMMIT
					*** 자바에서는 자동으로 COMMIT이 된다 (autocommit())	
					=> INSERT / INSERT/ INSERT / INSERT ....
					=> conn.setAitoCommit(false)
						INSERT / INSERT/ INSERT / INSERT ....
						conn.commit()
				= 원하는 데이터만 저장 = NULL허용 , DEFAULT 설정
				   INSERT INTO table_name(컬럼,컬럼,컬럼...)
				   VALUES(값,값,값...)
			2) 데이터 수정 : UPDATE
				UPDATE table_name
				SET 컬럼=값 , 컬럼=값...
					컬럼=SYSDATE
				[WHERE 조건] => 없는 경우에는 전체 변경
			3) 데이터 삭제 : DELETE
			-------------------------------------------------
			*** COMMIT을 수행 => ROLLBACK이 안된다
		
		---------------------------------------------------------------
	DDL : 정의 언어
		TABLE : 저장 공간
		VIEW : 가상 테이블
		SEQUENCE : 자동 증가 번호
		SYNONYM : 테이블 별칭
		FUNCTION / PROCEDURE / TRIGGER
		-------------------------------------------- 오라클 : OBJECT
		TABLE
		  1. 데이터형
			= 문자 => 한글 (한글자당 3byte)
				CHAR(1~2000byte) : 고정 바이트 (글자수가 같을 경우)
				VARCHAR2(1~4000byte) : 가변 바이트 (글자수에 따라 메모리가 달라진다)
				CLOB
			= 숫자 => NUMBER : 정수/실수 NUMBER (8,2)
				 	NUMBER(2,1)
		  2. 정형화된 데이터 => 필요한 데이터만 첨부
			=> NOSQL
			=> 제약조건
			   = 이상현상 방지 (수정 , 삭제)
				= 중복이 없는 데이터 저장 = 기본키
				  : 무결성 => PRIMARY KEY
				= 외부 데이터 참조 = 외래키 , 참조키
				  : 참조 무결성 => FOREIGN KEY
				= NOT NULL : 값이 반드시 존재
				= UNIQUE : 중복이 없는 값 (NULL 허용)
					=> PRIAMRY KEY 대체값
				= CHECK : 지정된 값만 저장
				= PRIMARY KEY : NOT NULL + UNIQUE
					=> 테이블에 반드시 한개 이상을 설정 = 기본키
			테이블 
			  1) 데이터 추출
			  2) 데이터형 설정
			  3) 제약조건 
			------------------------
			형식) 
				테이블명
				  1) 한글 / 알파벳 => 대소문자 구분이 없다
					실제로 오라클에 저장(대문자로 저장)
					user_table : PRIMARY KEY (중복이 되면 안된다)
				  2) 글자수 30글자(byte) 
				  3) 키워드는 사용 금지 (SELECT , INSERT...)
				  4) 숫자 사용이 가능 (단 뒤에 사용)
				  5) 특수문자 (_) => 5~10자 사이
				CREATE TABLE table_name(
					컬럼명 데이터형 [제약조건],
								---------- 여러개 적용이 가능
								--- DEFAULT / NOT NULL
								     ----------   ------------
									1		2
					컬럼명 데이터형 [제약조건],
					컬럼명 데이터형 [제약조건],
					[제약조건], => PK , CK , FK , UK
					[제약조건]
				);
				제약조건은 약식 / 정식
				CREATE TABLE table_name(
					id VARCHAR2(20) PRIMARY KEY,
					name VARCHAR2(50) NOT NULL
				);
				=> 제약조건을 제어하기 어렵다
				=> 제약조건의 이름 부여
					한개의 테이블에 저장
					---------------- user_constraints : 중복없이 설정
					table명_컬럼_nn , _pk...
				=> CONSTRAINT table명_컬럼_nn NOT NULL
				     CONSTRAINT table명_컬럼_pk PRIMARY KEY(컬럼)
				     CONSTRAINT table명_컬럼_ck CHECK(컬럼 IN(","))
				     CONSTRAINT table명_컬럼_uk UNIQUE(컬럼)
				     CONSTRAINT table명_컬럼_fk FOREIGN KEY(컬럼)
				     REFERENCES 참조테이블(컬럼)
				=> FOREIGN KEY
					먼저 참조테이블 생성 => 나중에 참조하고 있는 테이블
					삭제시에는 반대로

			-------------------------------------------------------------------------------------
			= 제어 : ALTER = 변경
				= 컬럼 추가
				ALTER TABLE table_name ADD likecount NUMBER DEFAULT 0
					컬럼명 데이터형 [제약조건|DEFAULT]
				= 컬럼 삭제
				ALTER TABLE table_name DROP COLUMN 컬럼명
				= 컬럼 수정 
				ALTER TABLE table_name MODIFY 컬럼명 데이터형
											  ----------
				= 컬럼명 변경
				ALTER TABLE table_name 
					RENAME COLUMN old_name TO new_name
				= ALTER 주로 데이터가 입력이 있는 경우에 주로 사용
				= 유지 보수  
			= 테이블 삭제
				DROP TABLE table_name : 완전삭제
			= 데이터만 삭제
				TRUNCATE TABLE table_name : 테이블은 유지 , 데이터만 삭제
			= RENAME
				RENAME old_name TO new_name
			------------------------------------------------------------------------------------
			3) SEQUENCE : 자동 증가 번호
				CREATE SEQUENCE table명_컬럼명_seq
					START WITH => 시작번호
					INCREMENT BY => 증가값
					NOCACHE => 미리 저장하는 것이 없이 사용 
					NOCYCLE => 마지막이면 다시 처음부터 
				*** 초기화 => DROP후 사용
				삭제 : DROP SEQUENCE seq명
			4) VIEW : 보안이 필요 , SQL문장이 긴 경우
					재사용
					= 기존의 테이블을 참조해서 만든 가상 테이블
				1. 종류
					단순뷰 : 테이블 한개 참조
					  *** DML이 가능
					       ------------- 뷰만 변경되는 것이 아니라
								참조하는 테이블 변경
						=> WITH READ ONLY : 읽기 전용
					복합뷰 : 테이블 여러개 참조 (JOIN,SUBQUERY)
						*** SQL문장을 단순화 => 저장후에 재사용
					인라인뷰 : 테이블 대신 SELECT사용
					=> user_views에 저장 : SQL문장만 저장된다
				2. 형식
					CREATE VIEW view_name
					AS
						SELECT ~~ (저장할 문장)
						------------- JOIN / SUBQUERY / GROUP BY....
				3. 수정
					CREATE OR REPLACE VIEW view_name
					AS
						SELECT ~~
				4. 삭제
					DROP VIEW view_name
				5. 많은 VIEW를 생성하면 비용이 많이 들어간다
			5) INDEX : 검색과 관련 (최적화)
				형식)
					CREATE INDEX index명 ON table명(컬럼명 (asc|desc))
					CREATE INDEX index명 ON table명(컬럼명 , 컬럼명)
					=> 검색 / 정렬
				 		INDEX_ASC() / INDEX_DESC()
					* 자주 사용하는 검색어가 있는 경우
						=> 데이터 적은 경우에는 사용하지 않는다
							데이터가 많은 경우 
					* JOIN에서 사용하는 컬럼이 있는 경우
					* NULL값이 많이 포함하는 컬럼을 이용
					* INSERT / UPDATE / DELETE 가 많은 경우에는 
					  속도가 저하
					   => REBUILD를 사용해서 처리
				삭제)
					DROP INDEX index명

			rownum (222page)
				=> 오라클 지원하는 가상 컬럼(SQL문장에서만 사용)
				=> row마다 번호를 입력
				=> 번호가 중복이 없다
				=> sql문장으로 ROWNUM의 값을 변경 = 인라인뷰
				=> 몇개 / 페이지 사용
				=> TOP-N : 위에서부터 몇개
				     -------- 중첩 서브쿼리
*/