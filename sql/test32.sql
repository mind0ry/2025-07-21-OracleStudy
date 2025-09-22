-- PL/SQL => 반복문 , CURSOR (*****핵심 기능*****)
-- FUNCTION (스칼라 서브쿼리 , 모든 영역에 댓글이 가능 : PROCEDURE)
/*
	반복문 : BASIC => do ~ while
		    WHILE
		    FOR
	반복문
		1) 기본 반목문
		    형식)
			LOOP
			   반복 처리문장
			   EXIT 조건 ===> 종료 조건
			END LOOP;
			
			 do
			 {
				반복 조건문
			 } while(조건문);
		2) WHILE
		    형식)
			WHILE 조건 LOOP
				반복 처리 문장
			END LOOP;
		
			while(조건)
			{
				반복 처리 문장
			}
		3) FOR (******)
		    형식)
			FOR 변수 IN low..hi LOOP
			  처리문장
			END LOOP;

			예)
				1~9
				FOR i IN 1..9 LOOP
				   출력문장
				END LOOP;

				9~1
				FOR i IN RESERVE 1..9 LOOP
				    출력문장
				END LOOP;
*/
/*
-- LOOP (basic = do~while)
DECLARE
   sno NUMBER:=1;
   eno NUMBER:=10;
BEGIN
   LOOP
	DBMS_OUTPUT.PUT_LINE(sno);
	sno:=sno+1; -- sno++
	EXIT WHEN sno>eno;
   END LOOP;
END;
/
-- WHILE (while = while)
DECLARE
   no NUMBER:=1; -- C언어 형식 : 변수를 반드시 먼저 선언
BEGIN
   WHILE no<=10 LOOP
	DBMS_OUTPUT.PUT_LINE(no);
	no:=no+1; --no++
   END LOOP;
END;
/
-- FOR
DECLARE 
BEGIN
   FOR i IN 1..10 LOOP
	DBMS_OUTPUT.PUT_LINE(i);
   END LOOP;
END;
/

-- 역순 출력
DECLARE 
BEGIN
   FOR i IN REVERSE 1..10 LOOP
	DBMS_OUTPUT.PUT_LINE(i);
   END LOOP;
END;
/
*/
/*
-- FOR + IF
-- 1~10 => 짝수
DECLARE
BEGIN
   FOR i IN 1..10 LOOP
	IF MOD(i,2)=0 THEN
	   DBMS_OUTPUT.PUT_LINE(i);
	END IF;
   END LOOP;
END;
/
-- 1~100 => 짝수의 합 , 홀수의 합 , 전체 합
DECLARE
   even NUMBER:=0;
   odd NUMBER:=0;
   total NUMBER:=0;
BEGIN
   FOR i IN 1..100 LOOP
   	total:=total+i;
	IF MOD(i,2)=0 THEN
	   even:=even+i;
	ELSE
	   odd:=odd+i;
	END IF;
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('1~100까지 전체 합:'||total);
   DBMS_OUTPUT.PUT_LINE('1~100까지 홀수 합:'||odd);
   DBMS_OUTPUT.PUT_LINE('1~100까지 짝수 합:'||even);
END;
/
*/
-- CURSOR : ResultSet => ArrayList => 목록
/*
	형식)
		CURSOR 커서명 IS 
		   SELECT ~
*/
/*
-- 목록 출력
DECLARE
   vemp emp%ROWTYPE;
   -- CURSOR 선언
   CURSOR cur IS
	SELECT * FROM emp;
BEGIN 
   FOR vemp IN cur LOOP -- for(EmpVO vo:list)
	DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
   END LOOP;
END;
/
*/
/*
	형식)
		선언부 DECLARE
		구현부 BEGIN ~ END
 		예외처리 EXCEPTION => 구현부에 포함

		DECLARE
		   변수 선언 : 스칼라 변수 (일반 = 변수명 데이터형)
				   %TYPE : 실제 테이블의 컬럼 데이터형을 가지고 온다
				   CURSOR : 목록 => ResultSet
		BEGIN
		   연산자 : 연산자는 그대로 사용
	           제어문 : IF ~ , IF ~ ELSE , FOR
		   => PL/SQL => SQL문장으로 제어
			SELECT에서 값을 받는 경우 => INTO
		   END;
*/
-- 사용자 정의 함수 => 270page
-- subquery 사용시에 주로 사용 => 반복 제거 : 내장함수
/*
	형식)
		CREATE [OR REPLACE] FUNCTION func_name(매개변수....)
		RETURN 데이터형
		IS
		   지역변수
		BEGIN
			구현
			RETURN 값
		END;
		/
		=> SELECT / WHERE / GROUP BY / ORDER BY ...
		*** 반드시 결과값은 1개만 설정
*/
/*
-- SELECT * FROM student; => 단일행 함수 (row단위로 처리)
-- JOIN이 있는 경우
-- DROP FUNCTION func_name
CREATE OR REPLACE FUNCTION stdSum(pHakbun student.hakbun%TYPE)
RETURN NUMBER
IS
   vTotal NUMBER:=0;
BEGIN
   SELECT kor+eng+math INTO vTotal
   FROM student
   WHERE hakbun=pHakbun;
   RETURN vTotal;
END;
/

CREATE OR REPLACE FUNCTION stdAvg(pHakbun student.hakbun%TYPE)
RETURN NUMBER
IS
   vAvg NUMBER:=0;
BEGIN
   SELECT ROUND((kor+eng+math)/3.0,2) INTO vAvg
   FROM student
   WHERE hakbun=pHakbun;
   RETURN vAvg;
END;
/
*/
/*
SELECT hakbun,name,kor,eng,math,(kor+eng+math) "sum",
	   ROUND((kor+eng+math)/3.0,2) "avg"
FROM student;

SELECT hakbun,name,kor,eng,math,stdSum(hakbun) "sum",
	   stdAvg(hakbun) "avg"
FROM student;
*/
/*
	FUNCTION : 급여 / 세금 계산
			  데이터 변환 (날짜 => 문자열)
			  복잡한 조건 점수 계산 => 상품 점수 , 고객 등급 선정
			  JOIN / SUBQUERY가 많은 경우
*/ 
-- 부서명
CREATE OR REPLACE FUNCTION getDname(pDeptno dept.deptno%TYPE)
RETURN VARCHAR2
IS 
  -- 지역변수 설정
  pDname dept.dname%TYPE;
BEGIN
  -- 구현부
  SELECT dname INTO pDname
  FROM dept
  WHERE deptno=pDeptno;
  RETURN pDname;
END;
/
-- 근무지
CREATE OR REPLACE FUNCTION getLoc(pDeptno dept.deptno%TYPE)
RETURN VARCHAR2
IS 
  -- 지역변수 설정
  pLoc dept.loc%TYPE;
BEGIN
  -- 구현부
  SELECT pLoc INTO pLoc
  FROM dept
  WHERE deptno=pDeptno;
  RETURN pLoc;
END;
/
-- 급여 등급 -- error : show error
CREATE OR REPLACE FUNCTION getGrade(pSal emp.sal%TYPE)
RETURN NUMBER
IS
  vGrade salgrade.grade%TYPE; 
BEGIN
  SELECT grade INTO vGrade 
  FROM salgrade
  WHERE pSal BETWEEN losal AND hisal;
  RETURN vGrade;
END;
/

SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

SELECT empno,ename,job,hiredate,sal,
	   (SELECT dname FROM dept WHERE deptno=emp.deptno) "dname",
	   (SELECT loc FROM dept WHERE deptno=emp.deptno) "loc",
	   (SELECT dname FROM salgrade WHERE emp.sal BETWEEN losal AND hisal) "grade"
FROM emp;
-- FUNCTION => 자주 사용하는 부분에서 : ROW 단위 집계
SELECT empno,ename,job,hiredate,sal,
	   getDname(deptno) "dname",
	   getLoc(deptno) "loc",
	   getGrade(sal) "grade"
FROM emp;