-- 224page 서브쿼리 => 조인 / 서브쿼리
/*
	조인 : SELECT 문장에서만 사용이 가능
	서브쿼리 : SELECT , INSERT , UPDATE , DELETE
	----------
	1) WHERE 뒤에 => 조건 검색값
	   --------------- 서브쿼리
		= 단일형 서브쿼리 : 서브쿼리의 결과값이 1개인 경우
			10
		= 다중행 서브쿼리 : 서브쿼리의 결과값이 여러개 경우
			10
			20
			30
			=> 전체 처리 => IN
			=> 한개 처리 => MIN / MAX
						ANY / ALL	
						
		-------------------------- 컬럼을 한개만 이용 
		= 다중컬럼서브쿼리 : 컬럼이 여러개인 경우
		= 형식
			SELECT * ===============> 3
			FROM table_name ==============> 1
			WHERE 컬럼명 연산자 (서브쿼리) =====> 2
							----------
								1
	조인 VS 서브쿼리
	조인 => 데이터 추출 (테이블 1개 이상)
	서브쿼리 => SQL을 통합
	---------------------------- 자바 : 네트워크 => 최대한 연결을 줄인다
	1) 연결 => 
	2) SQL전송
	3) 결과값 읽기
	4) 닫기
	1) 연결
	2) SQL전송
	3) 결과값 읽기
	4) 닫기
	1) 연결
	2) SQL전송
	3) 결과값 읽기
	4) 닫기
	-------------------------------
	2) SELECT 뒤에 : 컬럼 대신 사용 = 스칼라 서브쿼리 
	3) FROM 뒤에 : 테이블 대신 사용 = 인라인 뷰 (보안)

			스칼라 서브쿼리 						인라인뷰
	사용위치  SELECT , WHERE , HAVING , ORDER BY		FROM
	결과값 	단일값							다중행,다중컬럼
	용도(사용처) 계산 , 조건 비교 					임시테이블 , JOIN ,GROUP BY, 필터링
	특징 		쿼리와 1:1							외부와 조인 , 결과값 가상 테이블 형식
	=> 뷰 : 저장이 될때 => sql 문장에 저장 
*/
/*
-- 1. 사원 급여와 평균 급여 비교
SELECT ename sal,(SELECT ROUND(AVG(sal)) FROM emp) as avg_sal
FROM emp
WHERE sal>(SELECT ROUND(AVG(sal)) FROM emp);
--2. myFood 가격 기준 사원 조회
SELECT ename,sal
FROM emp
WHERE sal>=(SELECT MIN(price) FROM myFood) AND
	sal<=(SELECT MAX(price) FROM myFood);
-- 3. 살 수 있는 음식 => (인라인뷰 + JOIN)
SELECT ename,sal,name,price
FROM emp
JOIN (SELECT * FROM myFood) mf
ON sal=mf.price;
-- 조인 대신 사용 / 테이블 대신 사용 => 보안
SELECT ename,sal,dname,price
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN myFood 
ON emp.sal=myFood.price;

SELECT ename,sal,(SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
		(SELECT DISTINCT price FROM myFood WHERE price=emp.sal) "price"
FROM emp;
*/
-- 인라인 뷰 => 테이블 대신 사용
-- 가상 테이블
SELECT empno,ename,job,hiredate,sal
FROM (SELECT * FROM emp);

SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc
	FROM emp,dept
	WHERE emp.deptno,dept.deptno);