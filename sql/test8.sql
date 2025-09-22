-- 2025-09-03 집합함수
/*
	1. 형식 / 동작 순서 / 연산자 / 내장함수 => 단일 테이블
	    다중 테이블 : 조인 , 서브쿼리 => SELECT
	1) SELECT 문장의 형식
	    *** 개발자 => 오라클에 요청 (데이터 추출) => 142page
						SQL
	    자바(JDBC = MyBatis = JPA) ===> 오라클 
						<===
						실행결과 ResultSet (메모리 공간)
		    |
		  콘솔
	 	왼도우 , 브라우저
	    *** SELECT => 오라클 데이터 검색(추출)을 요청 => 문자열
	    SELECT *(전체) | column_list (화면 출력부분)
	    FROM table_name
	    [
		WHERE => 조건에 맞는 데이터만 추출
			       --------------------------- 연산자
		GROUP BY => 그룹별 묶어서 통계 , 기능 처리 ==> 관리자 모드
		HAVING => GROUP BY가 있는 경우에만 사용 (그룹 조건)
		ORDER BY => 정렬 (최신 데이터 => DESC)
		----------- 단순한 데이터 => 데이터 많은 경우(INDEX)
	    ]
	    WHERE 문장 사용 => 연산자
	       	산술연산자 : + , - , * , / (정수/정수=실수)
			      --- 산술연산
			      --- 문자열 결합 ||
			      --- '100'+1 => 101
				  -------- 속도가 늦다
			      --- TO_NUMBER('100') + 1
		비교연산자 : = , !=(<>) , < , > , <= , >=
		논리연산자 : AND (범위 포함), OR(범위 퐇마이 안된 상태)
		BETWEEN ~ AND : 기간 , 범위 >= AND <=
						      ------------- 권장
		=> 브라우저 : 쓰레드 (문자열 , 이미지)
		IN : OR가 많은 경우
		NULL : 컬럼값이 NULL일 경우 => 연산처리가 안된다 (결과값:NULL)
			 컬럼=null => IS NULL
			 컬럼!=null => IS NOT NULL
		NOT : 부정
			NOT IN , NOT BETWEEN , NOT LIKE
		LIKE : % : 개수의 제한이 없다 , _ : 한글자
			컬럼 LIKE 'A%' => 자동완성기
			컬럼 LIKE '%A' 
			컬럼 LIKE '%A%' => 주로 검색

		------------------------------------------------------------------------
		내장함수
		 ROW 단위 처리 (단일행 함수)
			문자 함수
				LENGTH : 문자 개수 LENGTH(컬럼명)
				SUBSTR : 문자 자르기
						SUBSTR(컬럼명, 시작위치,개수)
						** 자바는 문자열 번호 0
					 	** 오라클은 1번
				INSTR : 문자 찾기 => indexOf , lastIndexOf
					  INSTR(컬럼|문자열 , 찾는 문자 , 시작 위치 , 몇번째)
				RPAD : 문자가 없는 경우에 다른 문자 대체
					 => ID찾기
				REPLACE : 다른 문자로 대체 & , ||
					REPLACE(문자열|컬럼, 찾는문자,변경문자)
 
			숫자 함수
				MOD : 나머지 => MOD(10,3) => 10%3
				ROUND : 반올림 => 평균
					ROUND(실수,자리)
				CEIL : 올림 => 총페이지
					CEIL(실수) => 정수 => 소수점이 1이상
			날짜 함수
				SYSDATE : 시스템의 날짜 / 시간
						등록일
				MONTHS_BETWEEN : 해당 기간의 달수
						MONTHS_BETWEEN(최근,과거)
			변환 함수
				TO_CHAR : 날짜,숫자 => 문자열화
					       ----
						YYYY (RRRR) / MM / DD
						HH(HH24) / MI / SS
						DY => 요일
			기타 
				NVL => NULL을 대체해서 출력
					NVL(컬럼명,대체값)
					=>  ------- 데이터형과 동일 
					=> 컬럼 : VARCHAR2 => 문자열
							NUMBER => 숫자
							DATE => 날짜형
		 컬럼 전체 단위 (집계 함수 , 집합 함수) => 통계
			***1. COUNT => ROW의 개수
				COUNT(컬럼명) => NULL값 제외
				COUNT(*) => NULL값 포함
					=> 로그인 (ID존재여부)
					=> 검색결과
					=> 아이디 중복체크
					=> 장바구니 빈상태 확인
			***2. MAX / MIN : 전체 대상으로 최대/최소
			3. AVG : 전체 대상의 평균
			***4. SUM : 전체 대상의 총합 => 결제
			5. RANK() : 순위 결정 => DESC / ASC
			  RANK() OVER(ORDER BY 컬럼 ASC|DESC) => 기록 경기
				1
				2
				2
				4
			  DENSE_RANK() OVER(ORDER BY 컬럼 ASC|DESC) => 노래,영화
				1
				2
				2
				3
		*** 집합함수를 시용시에는 컬럼 , 단일행 함수를 사용할 수 없다
		단 , 컬럼을 사용할때는 GROUP BY를 사용하면 가능하다
*/
/*
-- emp에 있는 인원 확인 => COUNT
SELECT COUNT(*) "총인원",COUNT(mgr) "사수가 있는 사원",COUNT(comm) "성과급"
FROM emp;
*/
-- emp안에 급여를 가장 많이 받는 사람 , 가장 작게 받는 사람
-- MAX(컬럼명) / MIN(컬럼명) => MAX는 자동 증가 MAX+1 => SEQUENCE
/*
SELECT MAX(sal) , MIN(sal)
FROM emp;
*/
--emp안에 급여의 평균 / 총합
-- AVG(컬럼명) / SUM(컬럼명)
/*
SELECT ROUND(AVG(sal)),SUM(sal)
FROM emp;
*/
-- 부서번호가 10번 => 급여의 총합 / 급여 평균 / 가장 많이 받는 급여 / 가장 적은 급여 / 인원
/*
SELECT SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal) ,COUNT(*)
FROM emp
WHERE deptno = 10;

SELECT SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal) ,COUNT(*)
FROM emp
WHERE deptno = 20;

SELECT SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal) ,COUNT(*)
FROM emp
WHERE deptno = 30;

SELECT SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal) ,COUNT(*)
FROM emp
GROUP BY deptno;
*/
-- emp에서 사원중에 급여의 평균보다 적게 받는 사원의 모든 정보 출력
SELECT ROUND(AVG(sal))
FROM emp;
SELECT *
WHERE sal < 2073;

SELECT * 
FROM emp
WHERE sal < (SELECT ROUND(AVG(sal)) FROM emp);












