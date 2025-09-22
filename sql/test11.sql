-- 2025-09-04 GROUP BY / JOIN / SUBQUERY
/*
	GROUP BY : 데이터 그룹별로 묶어서 집계 = 관리자 모드
	JOIN : 여러개의 테이블을 연결 필요한 데이터를 추출
		 ------------------ 정규화 => 테이블이 많이 나눠진다
	=> 데이터 추출
	SUBQUERY : 여러개의 SQL을 한개의 SQL문장으로 변경
			  SELECT 뒤에 => 스칼라 서브쿼리 (컬럼 대신)
			  FROM 뒤에 => 인라인 뷰 (테이블 대신)
			  WHERE 뒤에 => 서브쿼리 (조건값을 대신)

	1. GROUP BY =159page
	   ------------
	  	같은 값을 가진 컬럼을 묶어서 따로 통계
								------
								집합함수를 이용한다
		=> COUNT / MAX / MIN / SUM / AVG
		1) 주의점
			WHERE / HAVING은 혼합하면  => 문제가 발생할 수 있다
			단일행 함수를 사용할 수 없다 , 그룹으로 지정된 컬럼외는
			다른 컬럼을 사용할 수 없다
		2) 실행 순서
			SELECT ----4
			FROM ------1
			GROUP BY ----2
			HAVING -------3
			ORDER BY ---5

		=> 컬럼값중에 같은 값을 가지고 있는 찾아서 그룹
			예) emp
				deptno (부서번호) / job(직위) / 입사년도별 (hiredate)
		=> SQL 문장
			GROUP BY 컬럼 / 함수
			SELECT 컬럼명|함수명 , 집계함수 ....
			FROM table_name
			GROUP BY 컬럼명|함수명
			HAVING 조건 (그룹에 대한 조건) => GROUP BY있는 경우 사용이 가능
			--------------- 필요시에만 사용
			ORDER BY 컬럼명|함수명
*/
-- 부서(deptno)별 급여 평균을 구한다
set linesize 250
set pagesize25
/*
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
ORDER BY deptno;
*/
/*
-- 부서별 인원수 , 급여총합 , 급여 평균 , 최대값 , 최소값
SELECT deptno,
	   COUNT(*) "인원수",
	   SUM(sal) "급여총합",
	   AVG(sal) "급여 평균",
	   MAX(sal) "최대값",
  	   MIN(sal) "최소값"
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
-- 직위별 (job)
SELECT job,
	   COUNT(*) "인원수",
	   SUM(sal) "급여총합",
	   AVG(sal) "급여 평균",
	   MAX(sal) "최대값",
  	   MIN(sal) "최소값"
FROM emp
GROUP BY job
ORDER BY job ASC;
--입사연도별
SELECT
	  TO_CHAR(hiredate,'yyyy'),
	   COUNT(*) "인원수",
	   SUM(sal) "급여총합",
	   AVG(sal) "급여 평균",
	   MAX(sal) "최대값",
  	   MIN(sal) "최소값"
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy')
ORDER BY TO_CHAR(hiredate,'yyyy') ASC;

--입사 요일 -- MyBatis => 별칭
-- 1차 => DataBase : MyBatis (XML , Annotation)
SELECT
	  TO_CHAR(hiredate,'dy"요일"') "요일",
	   COUNT(*) "인원수",
	   SUM(sal) "급여총합",
	   AVG(sal) "급여 평균",
	   MAX(sal) "최대값",
  	   MIN(sal) "최소값"
FROM emp
GROUP BY TO_CHAR(hiredate,'dy"요일"')
ORDER BY TO_CHAR(hiredate,'dy"요일"') ASC;

-- 그룹 조건 : HAVING
-- 평균 급여가 2000이상인 부서만 출력
SELECT deptno,COUNT(*),AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

-- 부서별 인원이 4명이상인 부서의 인원수, 급여의 총합
SELECT deptno , COUNT(*) , SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*) >= 4;
*/
/*
	159page
	-----------
	GROUP BY 에서 사용하는 함수(집계함수) => CUBE / ROLLUP
	------------ MIN/MAX/COUNT/AVG/SUM
	| 같은 값을 가지고 있는 컬럼 / 함수
	161page 주의점 / 실행순서
	=> 마이페이지 / 관리자 페이지
	=> 단일행 함수 : ROW단위
	=> 집합 함수 : COLUMN단위
	=> 단일행 함수와 집합함수는 혼합이 불가능
		=> 예외) 그룹으로 사용하는 함수
			SELECT ename,UPPER(ename),COUNT(*) => 오류
	=> 단일 그룹 / 다중 그룹
	부서별 => 직위별 , 입사일 => 요일
*/
/*
SELECT deptno,job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY deptno,job
ORDER BY deptno ASC;

SELECT TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'dy'),COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'dy')
ORDER BY TO_CHAR(hiredate,'YYYY') DESC;
*/
/*
	교재에서 사용하는 테이블
	orders : 구매내역 book : 책정보 , customer : 회원정보
	-------
		ORDERID => 구매번호 => 중복없는 데이터 (PRIMARY KEY)
		CUSTID => 회원 ID
		BOOKID => 책 ID
		SALEPRICE => 가격
		ORDERDATE => 구매일
*/
/*
SELECT orderid,name,bookname,saleprice,orderdate
FROM orders,customer,book
WHERE orders.custid=customer.custid
AND orders.bookid=book.bookid;
*/
--1. 가장 비싼 책을 출력
/*
SELECT MAX(saleprice)
FROM orders;

SELECT bookname
FROM book
WHERE  price=(SELECT MAX(saleprice)
FROM orders);
*/
-- 160page => 교재 예제
-- 가격이 8000원이상 도서를 구매한 고객별 주문도서의 총 수량
SELECT custid,COUNT(*) as "도서수량" --5
FROM orders --1
WHERE saleprice >= 8000 --2
GROUP BY custid --3
HAVING COUNT(*)>=2 --4
ORDER BY custid;
-- 고객별로  도서수량 , 총액을 출력
SELECT custid "고객 아이디" , COUNT(*) "도서수량", SUM(saleprice) "총액"
FROM orders
GROUP BY custid
ORDER BY custid;

