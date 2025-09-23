/*
    조인 / 서브쿼리 => 최적화 (SQL튜닝)
    SQL 튜닝 조건
    1) 불필요한 JOIN 제거
    2) JOIN 순서 최적화
        => 작은 집합 -> 
            emp / dept => 순서 변경 (힌트)
    3) 인덱스 사용
    = 조인 종류 => 한개 이상의 테이블에서 필요한 데이터 추출
                  => 정규화하면 테이블 분리가 된다
       INNER JOIN => 단점 NULL값이 있는 경우에는 제외
                     => 보완 : OUTER JOIN
        = EQUI_JOIN : = 연산자 (교집합)
          SELECT A.col,B.col
          FROM A,B
          WHERE A.col=B.col;
          
          SELECT A.col,B.col
          FROM A JOIN B
          ON A.col=B.col
        = NON_EQUI_JOIN : = 아닌 연산자 => 포함 
          SELECT A.col,B.col
          FROM A,B
          WHERE A.col BETWEEN B.col AND B.col
                      -------       ---
         * JOIN인 경우에는 해당 ROW전체 값을 제어
        *** JOIN => 항상 컬럼명이 다른 경우도 있다
        *** 같은 컬럼을 가지고 있는 경우
            => NATUTAL JOIN (자연조인)
               SELECT col1,col2... => 구분자가 없어야 한다
               FROM A NATURAL JOIN B
            => JOIN ~ USING
               SELECT col1,col2...
               FROM A JOIN B
               USING(공통컬럼)
        OUTER JOIN : NULL을 포함
        = LEFT OUTER JOIN
          SELECT A.col,B.col
          FROM A, B
          WHERE A.col=B.col(+)
          
          SELECT A.col,B.col
          FROM A LEFT OUTER JOIN B
          ON A.col=B.col
        = RIGHT OUTER JOIN
          SELECT A.col,B.col
          FROM A, B
          WHERE A.col(+)=B.col
          
          SELECT A.col,B.col
          FROM A RIGHT OUTER JOIN B
          ON A.col=B.col
*/
-- 예제 (emp,dept)
/*
    FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
*/
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM  emp ,dept 
WHERE emp.deptno=dept.deptno;

SELECT empno,ename,job,hiredate,sal,dname,loc,e.deptno
FROM  emp e,dept d
WHERE e.deptno=d.deptno;

SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
/*
    식별자
      테이블명.컬럼명
      별칭.컬럼명
*/
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp e NATURAL JOIN dept d;

SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp e JOIN dept d USING(deptno);

/*
    for(DeptVO e:Dept)
    {
        for(EmpVO d:Emp)
        {
            if(e.deptno==d.deptno)
            {
                데이터 출력
            }
        }
    }
*/
-- 튜닝 (작은 데이터 - 큰 데이터 비교)
SELECT /*+ LEADING(emp,dept) USE_NL(dept)*/ 
    e.empno,e.ename,d.dname
FROM emp e, dept d
WHERE e.deptno=d.deptno;
/*
    LEADING(emp,dept) => 조인 순서 emp->dept 고정
    USE_NL(dept) : dept조인시에 Nested Loop를 사용
*/
-- 필터 조건 (조인 + 일반 조건)
-- deptno=10 => empno,ename,job,hiredate,dname,loc
-- 잘못된 예시
SELECT empno,ename,job,hiredate,dname,loc
FROM emp e
JOIN dept d
ON e.deptno=d.deptno
WHERE d.deptno=10;
-- 좋은 예시 => 필터링은 먼저 수행 (인라인뷰로 개수를 적게 만들기)
SELECT empno,ename,job,hiredate,dname,loc
FROM (SELECT * FROM dept WHERE deptno=10) d
JOIN emp e ON e.deptno=d.deptno;
-- dept => 전체 풀 스캔 -> emp와 불필요한 JOIN발생
/*
    for(int i=0;i<arr.length-1;i++)
    {
    
    }
*/

SELECT empno,ename,dname
FROM emp
JOIN dept ON emp.deptno=dept.deptno
WHERE dept.loc LIKE '%NEW%';

-- 인덱스 적용
SELECT empno,ename,dname
FROM emp
JOIN dept ON emp.deptno=dept.deptno
WHERE dept.loc LIKE '%NEW%';

--LOOP줄이기
SELECT empno,ename,dname
FROM (SELECT deptno,dname FROM dept WHERE loc LIKE '%NEW%') d
JOIN emp ON emp.deptno=d.deptno;

/*
    조인 범위 축소 => 성능 향상
    ------------ 조건을 먼저 수행 => 조인
                 -------------- 인라인뷰
    조인에 사용하는 컬럼은 인덱스 처리
    => 힌트 : 작은량 / 큰량
            Nested Loop / Hash JOIN
            => 인덱스 적용 => LIKE : 데이터%
    => 분석
    
*/
-- 조인 => GROUP BY / HAVING
SELECT empno,ename,sal,dname
FROM emp
JOIN dept ON emp.deptno=dept.deptno
WHERE dept.deptno IN(
    SELECT deptno
    FROM emp
    GROUP BY deptno
    HAVING AVG(sal)>=2000
);
-- 서브쿼리 -> 부서별 그룹핑후 emp에 두번 접근
-- 중복
-- LOOP를 여러번 수행
SELECT empno,ename,sal,dname
FROM (SELECT deptno
      FROM emp
      GROUP BY deptno
      HAVING AVG(sal)>=2000) v
JOIN emp e ON e.deptno=v.deptno
JOIN dept d ON e.deptno=d.deptno;
      
-- ROWNUM => 데이터가 많은 경우에는 페이징 처리
-- 급여를 가장 많이 받는 사원 찾기
-- 사번 , 이름 , 급여 , 부서명 , 근무지
SELECT empno,ename,sal,dname,loc
FROM emp
JOIN dept ON emp.deptno=dept.deptno
WHERE sal=(SELECT MAX(sal) FROM emp);
-- MAX(sal) => emp 전체에서 검색 (풀스캔)
-- emp가 두번 접근
-- ORDER BY + ROWNUM (TOP-N)
-- 랜덤 처리
SELECT empno,ename,sal,dname,loc
FROM (SELECT empno,ename,sal,dname,loc
      FROM emp
      JOIN dept ON emp.deptno=dept.deptno
      ORDER BY sal DESC)
WHERE rownum=1;
-- FULL SCAN을 방지
-- 부서별 인원 수 + 평균 급여 출력
-- 부서번호 , 부서명 인원수 평균급여 => GROUP BY 
SELECT dept.deptno,dname,COUNT(empno) AS emp_cnt,AVG(sal) AS avg_sal
FROM  dept
JOIN emp ON dept.deptno=emp.deptno
GROUP BY dept.deptno,dname;
-- dept : 소속이 없는 부서가 있다
-- emp에만 존재하는 부서 => 누락 => OUTER JOIN
-- 불필요한 JOIN순서 => 성능 저하 => 순서 결정
SELECT /*+ USE_HASH(emp,dept)*/
    dept.deptno,dname,COUNT(empno) "cnt",
    AVG(sal) "emp_sal"
FROM dept
LEFT OUTER JOIN emp ON dept.deptno=emp.deptno
GROUP BY dept.deptno,dname;
/*
    인라인뷰 => 테이블에 접근 횟수를 줄일 수 있다
    데이터 누락을 방지 => 필요시에는 OUTER JOIN
    JOIN전에 다른 조건을 처리
    인덱스 활용 / 실행 계획
    
        => LIKE => 인덱스 적용 => startsWith
        => GROUP BY => (테이블 접근) 중복을 최소화
                        ---------------------- 인라인뷰
        => MAX / MIN => 서브쿼리 대신 ORDER BY => ROWNUM
        
        IN => EXISTS
         => 서브쿼리를 여러번 사용 => JOIN 
*/
-- 비효율적 (IN)
SELECT empno,ename,sal
FROM emp
WHERE deptno IN(SELECT deptno FROM dept WHERE loc='NEW YORK');

SELECT empno,ename,sal
FROM emp
WHERE EXISTS(SELECT 1 FROM dept
            WHERE dept.deptno=emp.deptno
            AND
            loc='NEW YORK');
            
-- FULL스캔이 안되게 한다
-- IN => NULL 값일 경우도 있다
-- EXISTS => NULL값에 대한 안정성
/*
    IN VS EXISTS
    비효율적 : 조건 검색 / Full Scan
    개선 : EXISTS -> 인덱스 활용
    서브쿼리 => JOIN => 반복 제거
    MAX => ROWNUM을 이용해서 단일 스캔
    NOT IN => NULL문제 / FULL Scan => ANSI JOIN : 안전 / 성능 새선
*/
/*
    서브쿼리 
     : SQL문장을 통합
     MainQuery = (SubQuery) => 반드시 ()에 설정
         2           1
    = 서브쿼리 => 조건값으로 사용
        = 단일행 서브쿼리 : 컬럼 1 , 결과값 1
        = 다중행 서브쿼리 : 컬럼 1 , 결과값 여러개
        = WHERE 위에
        *** = 다중컬럼 서브쿼리 : 컬럼 여러개 , 결과값 1
        =
    = 스칼라 서브쿼리 : 컬럼 대신 사용 
      = 튜닝 => 스칼라 서브쿼리 여러개 => 한번에 정리 (JOIN)
      = SELECT ~ (SELECT ~) 별칭...
      = FUNCTION 처리
    = 인라인 뷰 : 테이블 대신 사용
        => SELECT ~ 
           FROM (SELECT ~)
           => 페이징 기법
*/
-- 사원중에 평균 급여보다 적게 받는 사원의 이름 , 급여 , 입사일
SELECT AVG(sal) FROM emp;
-- 서브쿼리 => DML 사용이 가능
-- JOIN => SELECT에서만 가능
SELECT ename,sal,hiredate
FROM emp
WHERE sal<2073;

SELECT ename,sal,hiredate
FROM emp
WHERE sal<(SELECT AVG(sal) FROM emp);

-- 서브쿼리의 결과 여러개 (10,20,30)
/*
    전체 적용 : IN(******) => EXISTS
                => NULL 포함할 가능성 (불필요한 데이터 첨부)
    ANY(SOME)
    > ANY(10,20,30) => MIN => 10 적용
    < ANY(10,20,30) => MAX => 30 적용
    ALL
    > ALL(10,20,30) => MAX => 30 적용
    < ALL(10,20,30) => MIN => 10 적용
    --------------------------------- MAX/MIN
*/
SELECT DISTINCT deptno FROM emp;
SELECT ename,sal,hiredate,deptno
FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);

SELECT ename,sal,hiredate,deptno
FROM emp
WHERE deptno>ANY(SELECT DISTINCT deptno FROM emp);

SELECT ename,sal,hiredate,deptno
FROM emp
WHERE deptno<SOME(SELECT DISTINCT deptno FROM emp);

SELECT ename,sal,hiredate,deptno
FROM emp
WHERE deptno>=ALL(SELECT DISTINCT deptno FROM emp);

SELECT ename,sal,hiredate,deptno
FROM emp
WHERE deptno<=ALL(SELECT DISTINCT deptno FROM emp);
-- 스칼라 서브쿼리 => 반드시 결과값 1개의 컬럼만 사용이 가능 
SELECT empno,ename,job,hiredate,sal,
    (SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
    (SELECT loc FROM dept WHERE deptno=emp.deptno) "loc"
FROM emp; 

SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT empno,ename,job
FROM (SELECT * FROM emp);
-- 3장
/*
    내장 함수
    DDL => 제약조건 효율적 설정
    DML => INSERT / UPDATE / DELETE
    
    VIEW / INDEX
    => 간단하게 ERD
*/
    