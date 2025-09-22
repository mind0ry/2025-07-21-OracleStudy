-- 142page ~ 178page DQL (SELECT문 => 검색)
/*
	1) SQL : 문자열 형식
	    DQL : 오라클에서 가장 많이 사용되는 언어
			SELECT
	    DML : INSERT / UPDATE / DELETE
	    DDL : 테이블 생성 , 뷰 생성 ...
			CREATE / ALTER / DROP / RENAME
	    DCL : 제어 언어
			GRANT / REVOKE
	    TCL : 저장 / 취소
			COMMIT / ROLLBACK
	2)  총정리
		SELECT : 데이터 조회
		WHERE : 조건 검색
		GROUP BY : 그룹별 집계
		JOIN : 다른 테이블 연결
		SUBQUERY : SQL문장 여러개를 모아서 한개문장
		DDL : 정의
		DML : 조작
		TCL : 트랜잭션 제어
	3) 데이터 검색
		SELECT
		형식) 
			테이블의 구조 : 컬럼명 / 데이터형 => DESC table_name
			--------------------------------------------------
			SELECT (DISTINCT|ALL) * | 선택 (column_list)
			FROM table_name | view_name | SELECT
			-------------------------------------------------- 필수
			[
				WHERE 조건문 (연산자)
				GROUP BY => 통계 / 집계 => 같은 값을 가지고 있는 컬럼
								      => 함수
				HAVING => 그룹에 대한 조건
				ORDER BY => 정렬 (어떤  컬럼) 
			]
			1. 연산자 
				산술연산자 : + , - , * , / => %(MOD)
						  / => 정수/정수=실수
						 + => 덧셈 기능만 가지고 있다
						    => 문자열 결합 : ||
				비교연산자 : =  , !=(<>) , < , > , <= , >=
						=> 서브쿼리에서 주로 사용
				논리연산자 : AND : 범위 지정                           
						  OR : 둘중에 한개 이상 true
				BETWEEN ~ AND : 기간 , 범위를 포함
				IN : OR가 많은 경우에 대체
				NOT : 부정 연산자
				LIKE : 검색시에 주로 사용
					글자가 정해진 경우 : _
					글자수 미지정 : %
				NULL : 연산 처리가 안된다
					IS NULL / IS NOT NULL

			2. 내장 함수
				단일행 함수
					문자 함수
					  SUBSTR : 문자 자르기
					    =>SUBSTR(문자열|컬럼,시작위치,개수)
					    => 오라클은 문자번호 : 1
					  INSER : 문자의 위치 확인 
					    => INSTR(문자열|컬럼,찾는문자,시작위치,몇 번째)
					    => indexOf / lastIndexOf
					    => 예) 서울시 서초구 ~동....
					  REPLACE : 변경
					    => REPLACE(문자열|컬럼,찾는문자,변경문자)
					    => 이미지 (URL)=> &
					  LENGTH : 문자 개수
					    => LENGTH(문자열|컬럼)
					  RPAD : 문자가 지정된 개수보다 작은 경우
							다른 문자로 대체 (아이디 찾기)
					    => RPAD(문자|컬럼,출력글자수,대체문자)
					숫자 함수
					  MOD : 나머지
					    => MOD(10,2) => 10%2		
					  ROUND : 반올림
					    => ROUND(실수,자리수)
					  CEIL : 올림
					    => 총페이지
					    => CEIL(실수) => 소수점이 1이상
					날짜 함수
					  SYSDATE : 시스테므이 현재 날짜/시간
					    => 게시판 , 회원 , 예약 , 결제 ...
					  MONTHS_BETWEEN : 지정된 기간의 개월  수
					    => MONTHS_BETWEEN(현재, 과거)
					변환 함수
					  TO_CHAR : 문자열 변환
					    => 날짜
						YYYY/RRRR 년도
						MM 월
						DD 일
						HH : HH243 => 시간 => 댓글 / 공지사항
						MI : 분
						SS : 초
						DY : 요일
					    => 숫자
						9,999,999,999
					기타 
					  NVL : NULL값인 경우에 다른 값으로 변경
					    => NVL(컬럼,대체값)
					    		----- NULL일 경우에만 수행
					    => 컬럼의 데이터형 , 대체값의 데이터형 일치
				*** 집계함수 , 단일형 함수는 같이 사용 금지
				*** 같이 사용 => GROUP BY 
				집계 함수
				  COUNT : ROW의 개수
				  COUNT(*) / COUNT(컬럼)
					|		|
				  NULL 포함  NULL 제외
				  => 로그인 , 아이디찾기 , 장바구니 개수 , 검색 건수
				  MAX :  ROW전체 최대값
						=> 자동 증가번호 => CREATE SEQUENCE
				  SUM : ROW의 총합
				  AVG : ROW의 평균 
					
			3. GROUP BY
				: 같은 값을 가진 컬럼을 그룹으로 설정후에
				  그룹별 통계 => ID / 부서명 / 입사년도
			4. HAVING 
				GROUP에 대한 조건을 설정
			5. ORDER BY : 정렬
			  = ORDER BY 컬럼|함수 ASC|DESC
			  = 이중 
			    ORDER BY 컬럼 , 컬럼
					    ----   -----> 같은 값을 가지고 있는 경우
				= 대댓글 / 묻고 답하기 ...
			-----------------------------------------------------------------
			6. JOIN : 한개이상의 테이블 연결해서 데이터 추출
		           =테이블은 정규화에 따라 여러개로 나눠서 작업
			  INNER JOIN : 같은 값을 가지고 있거나 포함하는 경우
					    ----------------------- =    ----- BETWEEN , 논리연산자
				= 가장 많이 사용되는 JOIN
				1) 오라클 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A,B
				  WHERE A.col=B.col
				2) ANSI 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A JOIN B
				  ON A.col=B.col
			-------------------------------------------
			  OUTER JOIN : 누락 방지
				1) 오라클 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A,B
				  WHERE A.col=B.col(+)
				2) ANSI 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A LEFT OUTER JOIN B
				  ON A.col=B.col
				1) 오라클 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A,B
				  WHERE A.col(+)=B.col
				2) ANSI 조인
				  SELECT 컬럼(A),컬럼(B)
				  FROM A RIGHT OUTER JOIN B
				  ON A.col=B.col
			  SELF JOIN : 자신 테이블 (같은 테이블을 가지고 연결)
				
		---------------------------------------------------------------------
		서브쿼리 : 쿼리안에 다른 쿼리문장 추가 => 여러개의 SQL문장을 한개로 연결
		  MainQuery 연산자 (서브쿼리)
					     ----------- 실행 => 결과값 MainQuery
		 => 장점
		  => SQL만으로 복잡한 연산 처리
		  => 가독성이 높다 , 쿼리를 단계별로 나눠서 작성
		  => 속도가 빠르다 (오라클 연결 => 시간이 오래 걸린다) 
		  
		 => 단점
		  => SQL문장이 비대 => 분석하기 어려울 수 있다
		  -------------------------------------------------------
		    1) 사용법 => 조인 SELECT만 가능
			조인 => SELECT
			서브쿼리 => SELECT , INSERT , UPDATE , DELETE
		       SELECT 뒤에
			SELECT ename , (SELECT ~) => 컬럼 대신 사용 : 스칼라 서브쿼리
		       FROM 뒤에 (SELECT~) => 테이블 대신 사용 : 인라인 뷰
					---------- 보안
	               WHERE 뒤에 조건값 => 서브쿼리
					------------------------
					1. 단일행 서브쿼리 => 컬럼 1개
					  비교연산자를 주로 사용 
					2. 다중행 서브쿼리 => 컬럼 1개
					  IN / ANY / SOME / ALL
					  IN 검색된 모든 값을 적용 
					  IN(SELECT DISTINCT deptno FROM emp)
					  IN(10,20,30)
					  > ANY(SOME)
					     ANY(SELECT DISTINCT deptno FROM emp) 
					  > ANY(10,20,30) => 10 적용
					  < ANY(SOME)
					  < ANY(10,20,30) => 30 적용
					  > ALL(10,20,30) => 30 적용
					  < ALL(10,20,30) => 10 적용
					  ---------------------------------
					    MIN / MAX
					------------------------
					3. 다중컬럼 서브쿼리
					4. 연관 서브쿼리
						  
			형식)
				- 급여의 평균
				SELECT AVG(sal) FROM emp
				-- 평균보다 작은 사원 
				SELECT * form emp
				WHERE sal<2073;
				------------------------------------
				SELECT * form emp
				WHERE sal<(SELECT AVG(sal) FROM emp);
								|
								2037
				=> MainQuery 실행				
*/
-- 1. KING과 같은 부서에 있는 모든 사원의 정보
-- KING의 부서 찾기
-- WHERE에 대입
/*
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename='KING');
*/
/*
	컬럼은 1개 / 컬럼이 여러개 => 다중 컬럼 서브쿼리
	1) 자바에서 오라클 서버에 접근시에는 최대한 횟수를 줄인다
	2) 속도의 최적화
	** JOIN은 테이블에 있는 데이터 통합
	** SubQuery는 SQL문장 통합
*/
/*
set linesize250
set pagesize 25
-- SCOTT가 받는 급여와 동일한 급여를 받는 사원 출력
SELECT *
FROM emp
WHERE sal=(SELECT sal FROM emp WHERE ename='SCOTT')
AND ename<>'SCOTT';

-- 급여가 가장 작은 사원과 같은 부서에 있는 사원의 모든 정보
SELECT * 
FROM emp
WHERE deptno=(SELECT deptno FROM emp
			WHERE sal=(SELECT MIN(sal) FROM EMP));

-- 직위가 CLECK인 사원의 부서의 사원 모든 정보 출력
SELECT deptno FROM emp WHERE job='CLERK';
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE job='CLERK');
-- 10
SELECT *
FROM emp
WHERE deptno > ANY (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno < ANY (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno > ALL (SELECT deptno FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno < ALL (SELECT deptno FROM emp WHERE job='CLERK');

-- 10
SELECT *
FROM emp
WHERE deptno = (SELECT MAX(deptno) FROM emp WHERE job='CLERK');

SELECT *
FROM emp
WHERE deptno = (SELECT MIN(deptno) FROM emp WHERE job='CLERK');
*/
-- 부서별 최고 급여 사원 조회
SELECT deptno,MAX(sal)
FROM emp
GROUP BY deptno;

SELECT ename,deptno,sal
FROM emp
WHERE (deptno,sal) IN(SELECT deptno,MAX(sal)
				FROM emp
				GROUP BY deptno);
-- 사원 이름 , 입사일 , 급여(emp) , 부서명 , 근무지(dept)
-- 자주 사용되는 SQL => FUNCTION
-- 실행 후 받는 컬럼 1개 , 컬럼 여러개
SELECT ename,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- 스칼라 서브 쿼리
SELECT ename,hiredate,sal,
	(SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	(SELECT loc FROM dept WHERE deptno=emp.deptno) "loc"
FROM emp;
-- 테이블 대신 사용
SELECT ename,hiredate,sal
FROM (SELECT * FROM emp);

-- 원하는 개수만큼 출력
-- emp에서 위에서부터 5명 추출
SELECT empno,ename,hiredate,job,rownum                                                                           
FROM emp
WHERE rownum<=5;

SELECT ename,sal
FROM emp
ORDER BY sal DESC;

SELECT empno,ename,hiredate,job,sal,rownum
FROM (SELECT *
		FROM emp
		ORDER BY sal DESC)
WHERE rownum<=5;

--rownum의 단점 => TOP-N

SELECT empno,ename,hiredate,job,sal,rownum
FROM (SELECT *
		FROM emp
		ORDER BY sal DESC)
WHERE rownum BETWEEN 1 AND 5;

-- 인라인뷰 => (보안 , 페이징) =>
SELECT empno,ename,hiredate,job,num
FROM (SELECT empno,ename,hiredate,job,rownum as num
FROM (SELECT empno,ename,hiredate,job
FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 6 AND 10;

/*
	***단일행 서브쿼리
	***다중행 서브쿼리 =>IN , MAX / MIN
	다중컬럼 서브쿼리 => GROUP BY
	연관 서브쿼리
	 EXISTS => 존재여부 (true => 문장 , false => 실행 x)
*/
-- 부서 테이블(DEPT)에 존재하는 부서에 속한 사원의 이름 / 부서번호 출력
/*
SELECT ename,deptno
FROM emp e
WHERE EXISTS(SELECT 1
		     FROM dept d
		     WHERE d.deptno=e.deptno);
*/

-- 상관 서브쿼리
/*
	비상관 서브쿼리
	 => 메인쿼리와 독립적으로 먼저 실행
	상관 서브쿼리
	 => 메인쿼리에서 ROW마다 반복실행
*/
SELECT e1.ename,e1.sal,e1.deptno
FROM emp e1 
WHERE e1.sal > (SELECT AVG(e2.sal)
			FROM emp e2
			WHERE e2.deptno=e1.deptno);
-- 각 부서별 평균 급여보다 높은 사원 조회
/*
	단일행 / 다중행 (IN)
	스칼라 서브쿼리 / 인라인뷰

	=> 서브쿼리 순서
	 1. 서브쿼리 실행 => 결과값 반환
	 2. 메인쿼리에서 결과값을 받아서 조건/테이블 활용
	 3. 메인에서 최종 결과값
*/
