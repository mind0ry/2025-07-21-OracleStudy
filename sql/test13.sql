-- JOIN
set linesize 250
set pagesize 25
-- 사원이름이 SCOTT인 사원의 사번 , 이름 , 부서명 , 근무지 출력
/*
SELECT empno,ename,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename='SCOTT';

-- 근무지가 DALLAS인 사원의 사번 , 이름 , 직원 부서명 , 근무지 , 입사일
SELECT empno , ename , job , dname , loc , hiredate
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND loc='DALLAS';

-- 이름 중에 A가 포함된 사원의 이름, 직위 , 부서명, 근무지 출력
SELECT ename,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
*/
/*
	INNER조인의 단점 => 연산자 (=) : NULL을 제외
	------------------------------------------------------
	| 보안 => null값이 있는 테이블 확인
	INNER JOIN + 알파 => OUTER JOIN
	OUTER JOIN (관리자모드)

	 1) LEFT OUTER JOIN 
		SELECT 컬럼(A),컬럼(B)
		FROM A,B
		WHERE A.col=B.col(+)
		
		SELECT 컬럼(A),컬럼(B)
		FROM A LEFT OUTER JOIN B
		ON A.col=B.col

	 2) RIGHT OUTER JOIN
		SELECT 컬럼(A),컬럼(B)
		FROM A,B
		WHERE A.col(+)=B.col
		
		SELECT 컬럼(A),컬럼(B)
		FROM A RIGHT OUTER JOIN B
		ON A.col=B.col

	 3) FULL OUTER JOIN (사용빈도가 거의 없다)
		SELECT 컬럼(A),컬럼(B)
		FROM A FULL OUTER JOIN B
		ON A.col=B.col
	INNER JOIN (= , 포함) : 조건에 맞는 ROW를 연결
	LEFT OUTER JOIN : 왼쪽 테이블에는 모두 나오고 , 오른쪽이 데이터가 없는 경우 NULL

	사용 목적
	1. 데이터 누락 방지
	2. NULL 처리 => 분석
	3. 통계 목적 
	----------------------------
	
*/
/*
-- RIGHT OUTER JOIN
SELECT ename,dname,loc
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT ename,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

SELECT ename,dname,loc
FROM emp FULL OUTER JOIN dept
ON emp.deptno=dept.deptno;
*/
-- 주의점 : 반드시 한쪽의 테이블 => 중복없는 값 : 참조 
-- LEFT OUTER JOIN
-- 모든 사원 출력 + 매니저 정보가 있으면 표시

SELECT e1.empno,e1.ename,e2.empno,e2.ename
FROM emp e1 , emp e2
ON e1.mgr=e2.empno(+);
/*
	WHERE emp.deptno=dept.deptno
		    -------------  --------------
			
	------------------------------------
LEFT	 : 왼쪽 테이블        사원
	------------------------------------
RIGHT : 오른쪽 테이블    부서
	------------------------------------
*/
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid(+);





