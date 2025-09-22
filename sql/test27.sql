-- 뷰(view)

/*
	TABLE / sequence / view / synonym / ps / sql

	| select / update / delete / insert
		

	VIEW
		= 기존의 테이블로부터 데이터를 참조하는 가상테이블
		= 보안 뛰어나다 / SQL 문장을 단순화 
		= 실제 데이터가 저장되는 것이 아니라 SELECT 문장을 저장하고 있다
		1. 단순뷰 : 테이블 한개 연결
		2. 복합뷰 : 테이블 여러개 연결 (JOIN / SUBQuery)
		3. 인라인뷰 : FROM 뒤에 SELECT
		** 주의 : DML이 가능 
			    --------------
			    => 참조하는 테이블 자체가 변경
		=> WITH CHECK OPTION / READONLY OPTION (View => 읽기 전용)
*/
-- 복합뷰
/*
conn system/happy
GRANT CREATE VIEW TO hr;
conn hr/happy
/*
CREATE VIEW emp_dept
AS
	SELECT empno,ename,sal,job,hiredate,dname,loc
	FROM emp,dept
	WHERE emp.deptno=dept.deptno;
*/
/*
2. 테이블 1개이상을 참조해서 새롭게 만들어진 가상 테이블
3. 뷰의 종류
	단순뷰 (테이블 한개 연결) => 사용빈도가 거의 없다 (테이블 사용)
			=> DML적용 
4. 목적
	=보안 => 가상 테이블이라 노출이 안된다
		=> VIEW는 실제 데이터를 저장하는 것이 아니다 (SQL문장만 저장)
	= 편리성 : SQL문장을 저장하고 있기 때문에 재사용
	= 독립적으로 사용이 가능
5. 뷰의 종류 (논리적)
	WITH CHECK OPTION = DML 적용 (DEFAULT)
	WITH READ ONLY = 읽기 전용  (SELECT)
6. 뷰 생성
	CREATE VIEW view_name
	AS 
		SELECT ~~
7. 뷰의 수정 (****)
	CREATE OR REPLACE VIEW view_name
	AS
		SELECT ~~
8. 뷰의 삭제
	DROP VIEW view_name
9. 뷰 확인
	SELECT text 
	FROM user_views
	WHERE view_name='대문자'

	*** 복잡한 SQL일 경우 => 계속 사용이 되면 VIEW를 고민
	*** 보안이 필요한 부분
	    ----------------------- 
*/
/*
SELECT text
FROM user_views
WHERE view_name='EMP_DEPT';
*/
-- 단순뷰 : 테이블 한개를 참조 => DML이 가능
-- 테이블 복사
/*
CREATE TABLE myDept
AS
	SELECT * FROM dept;
*/
/*
CREATE VIEW myView
AS
	SELECT * FROM myDept;
*/
/*
INSERT INTO myView VALUES(50,'개발부','서울');
COMMIT;
*/
-- 단순뷰 => 읽기 전용
--DROP VIEW myView;
/*
CREATE VIEW myView
AS
	SELECT * FROM myDept WITH READ ONLY;
*/
/*
INSERT INTO myView VALUES(50,'개발부','서울');
COMMIT;
*/
--DROP VIEW myView;
--DROP TABLE myDept;
--수정
/*
CREATE OR REPLACE VIEW emp_dept
AS
	SELECT empno,ename,job,hiredate,sal,dname,loc,grade
	FROM emp,dept,salgrade
	WHERE emp.deptno=dept.deptno
	AND sal BETWEEN losal AND hisal;
*/
-- 일반 테이블과 동일하게 사용이 가능
-- 조건이 있는 뷰
/*
CREATE OR REPLACE VIEW emp_view1
AS 
    SELECT empno,ename,job,hiredate,sal,
    	(SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	(SELECT loc FROM dept WHERE deptno=emp.deptno) "loc"
    FROM emp
    WHERE MOD(empno,2)=0;
*/
--SELECT ename,dname FROM emp_view1;
-- 조인 뷰
/*
CREATE OR REPLACE VIEW emp_view2
AS
   SELECT empno,ename,job,sal,hiredate,dname,loc,grade
   FROM emp JOIN dept
   ON emp.deptno=dept.deptno
   JOIN salgrade
   ON sal BETWEEN losal AND hisal;
*/

-- 집계 / 그룹
CREATE OR REPLACE VIEW emp_view3
AS
	SELECT deptno,TO_CHAR(hiredate,'YYYY') "regdate",COUNT(*) "count",
	MAX(sal) "max_sal",MIN(sal) "min_sal",
	SUM(sal) "sum_sal",ROUND(AVG(sal)) "avg_sal"
FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
HAVING AVG(sal) > 2073
ORDER BY deptno;



