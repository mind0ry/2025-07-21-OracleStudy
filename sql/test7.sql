-- 숫자 함수
/*
	MOD : 나머지 MOD(10,2) = 10%2
	***ROUND : 반올림 => 평균
	TRUNC : 버림 => 퇴직금
	***CEIL : 올림 => 총페이지
*/
SELECT MOD(5,2) FROM DUAL;
SELECT empno,ename,sal,hiredate
FROM emp
WHERE MOD(empno,2)=0
ORDER BY empno ASC;
 
SELECT ROUND(123.56,1),TRUNC(123.56,1),CEIL(123.56) FROM DUAL;
SELECT CEIL(COUNT(*)/20.0) FROM food;
-- 날짜 함수
/*
	SYSDATE : 시스템의 시간 / 날짜 => 등록일
	MONTHS_BETWEEN : 기간의 개월수
	ADD_MONTHS : 추가후에 날짜
	ADD_MONTHS('25/07/21',6)
	NEXT_DAY(SYSDATE,'화') 
	LAST_DAY(SYSDATE) => 30
*/
-- SYSDATE
SELECT SYSDATE-1,SYSDATE,SYSDATE+1
FROM DUAL;
SELECT ename,hiredate,sal,ROUND(ROUND(MONTHS_BETWEEN(SYSDATE,hiredate))/12) "month"
FROM emp;

SELECT SYSDATE,ADD_MONTHS(SYSDATE,5) FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;
SELECT LAST_DAY('25/08/01') FROM DUAL;

/*
	변환 함수
		************문자함수 => 문자변환 TO_CHAR()
		숫자함수 => 숫자변환 TO_NUMBER() 1+'1' = 2
		날짜함수 => 날짜변환 TO_DATE()

	자바 => 입력된 시간출력이 안된다
	TO_CHAR : 숫자를 문자열로 변환
			100,000
			9,999,999 
			날짜변환
			YYYY / YY (RRRR / RR)
			MM / M
			DD / D
			HH / HH24
			MI
			SS
			DY : 요일 
*/
-- 2025년 09월 02일 => YY/MM/DD
SELECT TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일"') FROM DUAL;
SELECT ename,TO_CHAR(hiredate,'YYYY-MM-DD') "hiredate",
		TO_CHAR(sal,'L99,999') "sal"
FROM emp;

SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD HH24:MI:SS')
FROM DUAL;

-- Date
SELECT TO_NUMBER('100') FROM DUAL;
SELECT TO_DATE(SYSDATE,'YYYY-MM-DD') FROM DUAL;
-- 체크인 / 체크아웃 / 예약일
/*
	기타
		****************************NVL (null값일때 다른 값으로 대체)
	NVL(컬럼명, 대체)
		DECODE : switch
		CASE (PL/SQL) : 다중 if
*/
SELECT ename,hiredate,sal,NVL(comm, 0) "comm"
FROM emp;

SELECT ename,hiredate,sal,(sal + NVL(comm, 0)) "comm"
FROM emp;

-- DECODE
SELECT ename,job,hiredate,DECODE(deptno,10,'영업부',
						  20,'개발부',
						  30,'총무부',
						  40,'신입') dname
FROM emp;

-- CASE
SELECT ename,job,hiredate,CASE
					WHEN deptno=10 THEN '개발부'
					WHEN deptno=20 THEN '영업부'
					WHEN deptno=30 THEN '총무부'
					WHEN deptno=40 THEN '신입'
					END "dname"
FROM emp;
/*
	문자 관련 : LENGTH , SUBSTR , INSTR , RPAD , UPPER , REPLACE
	숫자 관련 : ROUND , CEIL
	날짜 관련 : SYSDATE , MONTHS_BETWEEN
	변환 관련 : TO_CHAR
	기타 : NVL

	= 연산자
		비교연산자 / 논리연산자
		BETWEEN ~ AND / IN /LIKE => NOT
	= 자바에서 오라클로 SQL로 전송
*/