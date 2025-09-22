-- index => PL/SQL
/*
	DQL / DML => 웹 개발자 담당
	= SELECT / INSERT / UPDATE / DELETE
	   : JOIN / SubQuery
	   형식 / 동작 순서
	= DDL = CREATE / DROP / ALTER(ADD,MODIFY,DROP)
		TRUNCATE / RENAME
	      | SEQUENCE (자동 증가)
	      | VIEW
	      | INDEX
	= DCL = GRANT / REVOKE
	= TCL = COMMIT / ROLLBACK / SAVEPOINT => 8장
	= PL/SQL : FUNCTION / PROCEDURE / TRIGGER
	= 데이터베이스 설계 => 정규화
	= 프로그램(웹) 응용
	------------------------------------------------------------
	1. JSP 프로젝트 : 호스팅(AWS) => 데이터베이스 사용
	2. Spring 프로젝트 : CI/CD => 실무에 해당
	3. 개인프로젝트 : 신기술  
		=> 직무능력
	------------------------------------------------------------
	1) VIEW : 테이블 참조 (필요한 데이터를 추출 후 저장)
					--------------------------------- SELECT 문장으로 저장
		= 하나 이상의 테이블을 참조해서 만든 가상테이블
		= 실제로 데이터를 저장하는 것은 아니다 (SELECT문장만 저장)
			SELECT text
			FROM user_name='VIEW명(대문자)'
		= 복잡한 쿼리가 있는 경우 = SQL을 단순화 (재사용)
		 	=> 메모리에 저장 (보안)
		= DML사용이 가능 (제약)
		   : 단순뷰에서만 사용이 가능
		     ------- 테이블 한개 참조
		   *** DISTINCT , GROUP BY , JOIN , 집계함수 , UNION => DML사용이 안된다
		= 방식
			DML 가능 : WITH CHECK OPTION
			  ** 실제 참조하는 테이블에 적용
			DML 불가능 : WITH READ ONLY
		= 생성 방법
			CREATE VIEW view_name
			AS 
			     저장할 SELECT문장
		= 삭제 방법
			DROP VIEW view_name
		= 수정 방법
			CREATE OR REPLACE VIEW view_name
			AS
			     저장할 SELECT문장
		* View => 실제 테이블처럼 사용이 가능
		   SELECT ~
		   FROM (table_name|view_name|SELECT~)

		장점
		   = SQL문장 재사용 (복잡한 쿼리를 단순화)
			CREATE VIEW emp_view
			AS
				SELECT empno,ename,job,hiredate,sal,dname,loc,grade
				FROM emp,dept,salgrade
				WHERE emp.deptno=dept.deptno
				AND sal BETWEEN losal AND hisal
			=> SELECT * FROM emp_view
		   = 보안 강화 (컬럼을 감추는 경우) : SQL Injection
			시큐어코딩 (URL,username,password,컬럼,테이블=파일에 저장)
			
		단점
	    	   = 성능 저하 발생 (실행시마다 참조 테이블 조회) => 느려짐
		   = 제한된 DML 기능
		   = DML사용시 => 원본 테이블에 영향
		-------------------------------------------------------------------------------
		2) 인덱스(INDEX)
			= 데이터베이스 검색 속도를 향상 
			    데이터 구조 (B-tree)
			1 2 3 4 5 6 7

					4
					|
				---------------
				|		  | 
				2		  6
				|		  |
			  ----------	    -----------
			  |	     |	    |		|
			 1	     3	   5		7
			= 책 => 인덱스 => 특정값을 빠르게 찾을 수 있게 만든다
			= 장점 : SELECT 검색 속도 UP
					맛집 목록 / 레시피 / 영화 / 뮤직... => 크롤링
			= 단점 : INSERT , UPDATE , DELETE => 성능 저하
					게시판 , 댓글 , 예약 , 결제 , 장바구니 , 좋아요 , 찜..
			** 불필요한 인덱스는 삭제 권장
			** LIKE => %A% %A => 인덱스 적용이 안된다
					A%
			
			1) 특징
				1. 자동 생성
					PRIMARY KEY , UNIQUE 제약 조건 => 설정시에 자동 생성
				2. 수동 생성 : 업체명 , 영화명 , 장르 ....
					CREATE INDEX index명 ON 테이블명(컬럼명)
				3. 내부적으로  B-Tree구조가 일반적
			2) 인덱스의 종류
				1. 단일 인덱스 -> 컬럼 한개
					CREATE INDEX index명 ON 테이블명(컬럼명)
					CREATE INDEX index명 ON 테이블명(컬럼명 DESC)
				2. 복합 인덱스 -> 컬럼 두개 이상
					CREATE INDEX index명 ON 테이블명(컬럼명 DESC, 컬럼명 ASC)
					=> 왼쪽 우선 법칙
					=> (job ASC,deptno DESC)
					=> WHERE deptno>10 => 인덱스 적용이 안됨
				3. 고유 인덱스
					=> 중복 허용하지 않는 경우 : UNIQUE / PRIMARY KEY
					=> 정렬
						INDEX_ASC(테이블명,인덱스명)
						INDEX_DESC(테이블명,인덱스명)
				4. 함수 기반 인덱스
					CREATE INDEX index_emp_ename ON emp(ename)
					SELECT * 
					FROM emp
					WHERE ename=UPPER('king') => 적용이 안됨 
					CREATE INDEX index_emp_ename ON emp(UPPER(ename))
			3) INDEX 명령어 => user_indexes
				CREATE INDEX idx_테이블명_컬럼명
							   ------------------ sequence / constraint / index
				=> 인덱스 확인
					SELECT index_name,table_name,uniqueness
					FROM user_indexes
					WHERE table_name=''
				=> 인덱스 컬럼 확인
					SELECT index_name,column_name
					FROM user_ind_columns
					WHERE table_name=''
				=> DROP INDEX 인덱스명 => 삭제
			4) ename 검색 속도 향상
				CREATE INDEX ind_... ON emp(ename)
			5) 복합 인덱스
				CREATE INDEX idx_emp_job_deptno ON emp(job,deptno DESC)	
				SELECT * FROM emp WHERE job='CLERK'; // 인덱스 적용
				SELECT * FROM emp WHERE job='CLERK' AND deptno=20; // 인덱스 적용
				SELECT * FROM emp WHERE deptno=10; // 인덱스 미적용 
			6) 삭제
				DROP INDEX index명
			7) 인덱스 사용시 주의점
				1. DML이 있는 경우 => 성능 저하
				2. 조건절에서 함수 / 연산 => 무효
				   WHERE sal*12>3600
				3. 와일드카드 이용시에 제한 => %
				   WHERE ename LIKE '%SC' => 인덱스 적용 안됨
				   WHERE ename LIKE 'SC%' => 인덱스 적용
				4. 데이터가 적은 경우 => 효과 낮다
				5. 불필요한 인덱스 남용 금지
					=> 관리 비용 증가 / 성능 저하
				
				=> 252 page 
					인덱스 생성 시기
					1) 구별되는 값이 많은 경우 (PRIMARY KEY)
					2) WHERE절에서 자주 검색되는 컬럼이 있는 경우
					3) JOIN에서 주로 사용되는 컬럼 (deptno)
					4) NULL값을 포함하는 컬럼이 많은 경우 (comm,bunji)
					5) insert / update / delete 많은 경우
					     => 인덱스 변경 => rebuild => 성능 저하
				=> 자료를 쉽게 빠르게 검색할 수 있게 만든 데이터 구조
						루트 ==> B-Tree
						  |
					------------------
					|		     | ==> 내부 루트
				   -------- 		---------
				   |	    |		|	  | ==> LeafRoot

*/
/*
AAAStOAAHAAAAFcAAA
AAAStOAAHAAAAFcAAB
AAAStOAAHAAAAFcAAC
-------- ----- -------- ----- 3636
			     ROW의 구분자
	           블록번호
	   DataFile번호
table(Number)
*/
-- 정렬 
/*
	INDEX_ASC(테이블명 인덱스명) => 올림차순
	INDEX_DESC(테이블명 인덱스명) => 내림차순

	ON 테이블(컬럼) ==> ORDER BY 컬럼 ASC
	ON 테이블(컬럼 DESC) ==> ORDER BY 컬럼 DESC
	ON 테이블(컬럼 , 컬럼 ASC) ==> ORDER BY 컬럼 DESC, 컬럼 ASC
	ORDER BY => 대신
	  힌트 사용 => "/*+*/" --
		+INDEX(테이블명 인덱스명) => CREATE 사용 사용자 정의
		  ---------------------------- UNIQUE / PRIMARY KEY
		+INDEX_ASC(테이블명 인덱스명)
		+INDEX_DESC(테이 블명 인덱스명)
		-------------------------------------------------------------------
		INDEX 정리 
			1) 검색과 관련 = 빠른 속도 
			2) 성능 향상 
				단점) 인덱스를 저장하기 위한 메모리 공간이 필요 
					한테이블안에서 인덱스가 많은 경우 오라클 서버에 부담증가
					(4~5 적당)
			3) 언제
				테이블에 ROW가 맣은 경우 (100000개 이상)
				WHERE => 자주 사용되는 컬럼이 있는 경우
				검색결과 2~5%이상 검색 => 우편번호 검색
				JOIN에서 자주 사용되는 컬럼
				NULL이 많은 컬럼 
*/