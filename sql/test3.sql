-- 3장 SQL기초 
/*
	1. DML (CRUD) => 3,4,5
	2. DDL => table , index , view ... => 데이터베이스 설계 6,7
	3. TCL => COMMIT / ROLLBACK 8

	SQL (명령어 기반) => 형식 , 순서
	--------------------
		DML : 데이터 조작언어 ======> ROW
			SELECT : 데이터 검색 => 예약정보 확인 , 회원 정보 확인
			INSERT : 데이터 추가 => 예약 등록 , 회원 등록
			UPDATE : 데이터 수정 => 예약 수정 , 회원 수정
			DELETE : 데이터 삭제 => 예약 취소 , 회원 탈퇴
		DDL : 데이터 저장 공간 만들기 ======> COLUMN
			CREATE : 생성 , ALTER : 수정 
						(ADD , MODIFY , DROP , 컬럼명 변경 RENAME)
		DCL : GRANT / REVOKE => DBA
		TCL : 정상 (COMMIT 저장) / 비정상 (명령어 취소 => ROLLBACK) 

		1. 데이터 검색
			SELECT 
			    | 연산자 (조건문)
			    | 내장 함수 (문자 , 숫자 , 날짜 , 변환 , 기타)
			    | 여러개 테이블 제어
			    | 서브 쿼리 => 인라인뷰 (페이징)
			1) 형식
				=> 테이블 정보 : 컬럼확인
							----- 자바의 VO와 동일
					DESC table명;
					emp
					EMPNO NUMBER(4)          => 정수                                                                                                                                                         					ENAME VARCHAR2(10)     => 문자열
					JOB NUMBER(4)            => 문자열                                                                                                                                                                    
					MGR NUMBER(4)         => 정수                                                                                                                                                                      
					HIREDATE DATE               => 날짜형    => 실제 저장은 문자열                                                                                                                                                 
 					SAL NUMBER(7,2)       => 정수 (실수)   12345.67                                                                                                                                                                    
 					COMM NUMBER(7,2)   => 정수 (실수)                                                                                                                                                                          
 					DEPTNO NUMBER(2)     => 정수        
				--------------------------------------------------------------------                                                                                                                                                       
				SELECT * (전체) | column_list (원하는 컬럼만 데이터만 추출)
				FROM table_name
				-------------------------------------------------------------------- 필수
				[
					WHERE 조건문 => 연산자
					----------------------------- 
					GROUP BY 그룹컬럼
					HAVING 그룹조건
					-----------------------------
					ORDER BY 컬럼명 (ASC|DESC)
								  ----- 생략이 가능
				]

				WHERE : 조건문
				연산자
					산술연산자 : 순수하게 산술
							  + - / => 나머지 (MOD())
							   / => 0으로 나눌 수 없다
							      => 정수/정수 = 실수
					비교연산자	: = , != (<>,^=) , < , > , <= , >=
								   ----
					논리연산자 : AND (&&=>입력값), OR (||=> 문자열 결합)
					BETWEEN ~ AND : 기간 , 범위
							>= AND <=
					IN : OR가 많은 경우에 사용
						WHERE deptno=10 OR deptno=20 OR deptno=30
						WHERE deptno IN(10,20,30)
					NULL : NULL값이 있는 경우 연산처리가 안된다
							IS NULL => NULL이라면
							IS NOT NULL => NULL이 아니라면
					NOT : 부정 => !(사용하지 않는다)
					 	 NOT IN , NOT BETWEEN
					LIKE : 포함 데이터 검색
						 A% ==> %는 문자의 개수 상관없다 => startsWith
						 %A ==> endsWith
						 %A% ==> contains
						 % : 문자제한이 없다
						 _ : 문자 1개
						 __A% _B_ 

				1. 산술연산자 => 조건문에 사용할 수 없다
				   ------------- SELECT (통계=평균,총합)
				2. 나머지 => WHERE 뒤에 사용
				3. 형식
					SELECT
					FROM
					WHERE 컬럼명 연산자 값 
						   ------------------- true일 경우에만 출력

				4. 순서
					SELECT --- 6
					FROM  --- 1
					WHERE --- 2
					GROUP BY --- 3
					HAVING --- 4
					ORDER BY --- 5
				
*/
/*
-- 1. emp(사원 정보)에 있는 모든 사원들을 출력 (가독성) => 상세보기
SELECT *
FROM emp;
-- 2. emp(사원정보) 있는 사원들의 이름,직위,입사일 => 목록 출력
SELECT ename,job,hiredate
FROM emp;
*/
-- 1. 산술연산자
-- 1) 사원의 받는 급여의 총액을 출력 => 이름 , 총액
SELECT ename,sal,comm,sal+NVL(comm,0) 
FROM  emp;
-- 주로 사용처 : 오라클 (세로 통계(O) , 가로 통계(X) => 산술 연산자 사용) : 평균 , 총점
-- 2. 산술연산자 ( / )
-- 비절차적 언어
-- SELECT 5/0 FROM DUAL;
-- SELECT 5/2 FROM DUAL;
-- 3. 비교연산자
/*
	UPDATE emmp SET
	ename='홍길동'
 	WHERE empno=7788
*/
-- 1) = 사원중에 이름이 SCOTT인 사원의 모든 정보를 출력
/*
SELECT * 
FROM emp
WHERE ename='SCOTT';
*/

-- 2) != , <>(권장) , ^=
-- 사원중에 job(직위)가 manager가 아닌 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE job <> 'MANAGER';

SELECT *
FROM emp
WHERE job != 'MANAGER';

SELECT *
FROM emp
WHERE job ^= 'MANAGER'; 

-- 3) < 작다
-- 1. 사원중에 급여가 2000보다 적게 받는 사원의 이름, 입사일, 급여 출력
SELECT ename,hiredate,sal
FROM emp
WHERE sal < 2000;

-- 4) > 크다
-- 1. 사원중에 입사일이 08/04/01 보다 늦게 입사한 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE hiredate > '81/04/01';
-- 비교 연산자는 숫자 , 문자열 , 날짜까지 비교가 가능
-- 날짜 / 문자열은 반드시 ' '을 사용한다
-- 5) <= 작거나 같다 급여가 3000이하인 모든 사원의 정보 출력
SELECT *
FROM emp
WHERE sal >= 3000;
-- 6) >= 크거나 같다 KING보다 크거나 같은 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE ename >= 'KING';
-- SELECT ename, sal, sal*12, (sal*12)/12, sal+comm FROM emp