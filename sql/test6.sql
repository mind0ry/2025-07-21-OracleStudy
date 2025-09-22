-- 정렬 => ORDER BY => 속도가 늦다 (대체 : INDEX)
-- INDEX가 속도가 늦는 경우 : 추가 , 삭제 , 수정이 많은 경우 => 게시판
/*
	ORDER BY는 SQL문장의 마지막에 첨부
	ORDER BY 컬럼명(함수) ASC|DESC
*/
-- emp에 있는 사원 출력 => 급여가 많은 순서 (숫자 , 문자 , 날짜)
SELECT *
FROM emp
ORDER BY sal DESC;

SELECT *
FROM emp
ORDER BY sal;

SELECT empno,ename,hiredate,sal
FROM emp
ORDER BY 4,1 DESC;

-- 이름 순서 => 올림차순
SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY hiredate;

-- 내장함수 : 오라클에 지원하는 라이브러리 => SELECT , WHERE
/*
	단일행 함수
		문자 관련 함수
			***1) UPPER => 대문자 변환
			2) LOWER => 소문자 변환
			3) INITCAP => 이니셜 => 첫자만 대문자
			***4) SUBSTR => 문자 자르기
			5) INSTR => 문자 찾기
			6) LPAD / ***RPAD => 문자가 모자라는 경우에 문자 대체
				RPAD('abcde',10'*') abcde*****
			7) LTRIM / RTRIM / TRIM
			***8) LENGTH
			***9) REPLACE : 변경 => &변경
			10)ASCII : char를 숫자 변경
			11) CHAR => 숫자 => char
			12) LENGTHB => byte개수
		숫자 관련 함수
		날짜 관련 함수
		변환 관련 함수
		기타 
	집합 함수 : 통계
*/
/*
-- UPPER('abc') = ABC / LOWER('ABC') = abc / INITCAP('ABC') = Abc
SELECT ename,UPPER(ename),LOWER(ename),INITCAP(ename)
FROM emp;

SELECT *
FROM emp
WHERE ename=UPPER('king');

-- LENGTH('ABC') = 3 LENGTH('홍길동') = 3 
-- LENGTHB('ABC') = 3 LENGTHB('홍길동') = 9
SELECT LENGTH('ABC') , LENGTH('홍길동') FROM DUAL;
SELECT LENGTHB('ABC') , LENGTHB('홍길동') FROM DUAL;
*/
/*
	SUBSTR => 문자열 자르기
	오라클 문자열
	 Hello Oracle
	 123456789...
	SUBSTR(문자열,시작위치,개수)
	사원 입사일 => 몇월에 입사했는지
	YY/MM/DD
	1234 5 6 78
*/
SELECT ename,SUBSTR(hiredate,7,2)
FROM emp;
/*
	INSTR => indexOf / lastIndexOf => 문자위치 찾기
	INSTR(문자열 , 찾는 문자 , 시작위치 , 몇번째)
	Hello
*/
SELECT INSTR('Hello','l',1,2) FROM DUAL;
/*
	LPAD / RPAD
	L=Left , R=Right

	LPAD(문자열,문자개수,대체문자)
	LPAD('Hello',8,'#')
		 ------	###Hello
	LPAD('Hello',3,'*')
		 ------	Hel

	RPAD(문자열,문자개수,대체문자)
	RPAD('Hello',8,'#')
		 ------	Hello###
	RPAD('Hello',3,'*')
		 ------	Hel
*/
SELECT RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*')
FROM emp;

-- ASCII => ASCII('A') ==> 65 , CHR(65) => 'A'
SELECT ASCII('K') , CHR(68) FROM DUAL;

/*
	TRIM : 좌우 문자 제거
	LTRIM : 왼쪽 문자 제거
	RTRIM : 오른쪽 문자 제거
	LTRIM('ABCDA','A') => BCDA
	RTRIM('ABCDA','A') => ABCD
	LTRM('ABCD') => 공백 제거
	TRIM('A' FROM 'ABCDA') BCD
	---------------------------------- 자바 trim

	실제
		사용자로부터 데이터를 받아서 => 자바 (문자제어)  
		데이터베이스 제어 전송 (오라클 제어)
	REPLACE(문자열,'old','new')
	REPLACE('Oracle AND Java', 'a' , 'b') => Orbcle AND Jbvb
*/
SELECT LTRIM('ABCDA','A') , RTRIM('ABCDA','A') , TRIM('A' FROM 'ABCDA')
FROM DUAL;
SELECT REPLACE('Oracle AND Java', 'a' , 'b') FROM DUAL;
SELECT REPLACE('Oracle AND Java', 'Java' , 'Oracle') FROM DUAL;
-- &