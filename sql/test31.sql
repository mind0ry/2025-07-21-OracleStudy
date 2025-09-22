-- 5장 (프로그램 : 오라클 프로그램 , JDBC프로그램 , 웹프로그램
/*
 	6장 : ER-MODEL : 데이터베이스 설계 => 데이터 추출 / 데이터 설계
		키의 종류
	7장 : 정규화
	8장 : 트랜젝션
	------------------------
	보강 : 튜닝

	오라클 프로그램 => PL/SQL (FUNCTION / PROCEDURE / TRIGGER)
	------------------
	  => SQL확장 / 변수선언 / 연산자 / 제어문
	  => 재사용 가능 /예외처리 지원 / 서버에서 실행 => 성능 향상
	  => 보안 뛰어나다 / 가독성이 낮다 (내장함수)
	기본 구성
	  DECLARE 
	    변수 선언
	 BEGIN
	    구현부 => SQL문장으로 구현
	 EXCEPTOIN 
	    예외처리
	 END;

	
*/
-- 출력 
/*
	프로시저로 만드는 객체
	1. FUNCTION : 리턴값을 가지고 있는 함수 = 내장 함수
	2. PROCEDURE : 리턴형이 없이 기능만 수행하는 함수
	3. TRIGGER : 자동 이벤트 처리
*/
/*
	문법
	  1. 변수
	  	***= 스칼라 변수
			변수 데이터형
			no NUMBER
			name VARCHAR2(10)
	
		***= type변수
			empno emp.empno%TYPE
				   ------------- 실제 데이터형을 첨부
		= rowtype 변수
			전체 column의 데이터형 읽기
			emp emp%ROWTYPE
			       ----- emp가 가지고 있는 모든 컬럼 => VO
		= record
			테이블 여러개에서 데이터 변수 : join
		--------------------------------------- row단위
		***= cursor
			여러개의 row를 동시에 처리

	  2. 제어문
		조건문 : if , if~else , if~elsif ~ elsif ... / case
		반복문 : 일반 반복문 , while / for
	  3. 예외처리
*/
/*
-- 변수
-- System.out.println() => DBMS_OUTPUT_LINE()
-- Scanner => &
-- SELECT => 변수가 아니다 / 화면에 출력
SET SERVEROUTPUT ON;
-- 스칼라 변수 (변수명 데이터형)
DECLARE
 pEmpno NUMBER(4);
 -- 초기값 => pEmpno NUMBER(4)=100 (x)  pEmpno NUMBER(4):=100(O)
 pEname VARCHAR2(30);
 pJob VARCHAR2(20);
 pHiredate DATE;
 pSal NUMBER(7,2);
BEGIN
 SELECT empno,ename,job,hiredate,sal
 INTO pEmpno,pEname,pJob,pHiredate,pSal
 FROM emp
 WHERE empno=7900;
 -- 변수값 출력
 DBMS_OUTPUT.PUT_LINE('사번''||pEmpno);
 DBMS_OUTPUT.PUT_LINE('이름''||pEname);
 DBMS_OUTPUT.PUT_LINE('직위''||pJob);
 DBMS_OUTPUT.PUT_LINE('입사일''||pHiredate);
 DBMS_OUTPUT.PUT_LINE('급여'||pSal);
END;
*/

/*
DECLARE
 pEmpno NUMBER(4);
 -- 초기값 => pEmpno NUMBER(4)=100 (x)  pEmpno NUMBER(4):=100(O)
 pEname VARCHAR2(30);
 pJob VARCHAR2(20);
 pHiredate DATE;
 pSal NUMBER(7,2);
BEGIN
 SELECT empno,ename,job,hiredate,sal
 INTO pEmpno,pEname,pJob,pHiredate,pSal
 FROM emp
 WHERE empno=&empno;
 -- 변수값 출력
 EXCEPTION
	WHEN NO_DATA_FOUND THEN
	  DBMS_OUTPUT.PUT_LINE('해당 사번이 없습니다');
	WHEN TOO_MANY_ROWS THEN
	  DBMS_OUTPUT.PUT_LINE('2개 이상의 행이 반환');
	WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('기타 오류 발생');

 DBMS_OUTPUT.PUT_LINE('사번'||pEmpno);
 DBMS_OUTPUT.PUT_LINE('이름'||pEname);
 DBMS_OUTPUT.PUT_LINE('직위'||pJob);
 DBMS_OUTPUT.PUT_LINE('입사일'||pHiredate);
 DBMS_OUTPUT.PUT_LINE('급여'||pSal);
END;
/
*/
/*
-- TYPE : 실제 테이블에 저장된 데이터형을 가지고 온다
-- 형식) 변수명 테이블명.컬럼명%TYPE
DECLARE
  pEmpno emp.empno%TYPE;
  pEname emp.ename%TYPE;
  pJob emp.job%TYPE;
BEGIN
 -- 구현부 => DML을 주로 사용
  SELECT empno,ename,job INTO pEmpno,pEname,pJob
  FROM emp
  WHERE empno=7788;
   DBMS_OUTPUT.PUT_LINE('사번'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('이름'||pEname);
   DBMS_OUTPUT.PUT_LINE('직위'||pJob);

END;
/
*/
/*
SET SERVEROUTPUT ON;
-- ROWTYPE => VO : 한개의 테이블이 가지고 있는 모든 데이터형을 읽어온다
-- 테이블변수 테이블명%ROWTYPE
DECLARE
	pEmp emp%ROWTYPE;
BEGIN
	SELECT * INTO pEmp
	FROM emp
	WHERE empno=7900;
	DBMS_OUTPUT.PUT_LINE('사번:'||pEmp.empno);
	DBMS_OUTPUT.PUT_LINE('이름:'||pEmp.ename);
	DBMS_OUTPUT.PUT_LINE('직위:'||pEmp.job);
	DBMS_OUTPUT.PUT_LINE('입사일:'||pEmp. hiredate);
	DBMS_OUTPUT.PUT_LINE('급여'||pEmp.sal);
END;
/
*/
-- JOIN => 테이블 여러개 연동 => RECORD
-- IF / IF~ELSE / FOR
-- 조인 => FUNCTION
/*
	TYPE empDept IS RECORD(
		empno emp.empno%TYPE,
		ename emp.ename%TYPE,
		job emp.job%TYPE,
		dname demp.dname%TYPE,
		loc dept.loc%TYPE
	
	);
	-- GROUP BY , JOIN , SUBQUERY
*/
/*
DECLARE
   -- class EmpDeptGradeVO
   -- 데이터형을 사용자 정의로 설정
   TYPE empDeptSalGrade IS RECORD(
	empno emp.empno%TYPE,
	ename emp.ename%TYPE,
	job emp.job%TYPE,
	dname dept.dname%TYPE,
	loc dept.loc%TYPE,
	grade salgrade.grade%TYPE
   );
   -- 변수 선언
   edg EmpDeptSalGrade;
BEGIN
   SELECT empno,ename,job,dname,loc,grade
   	INTO edg
   FROM emp,dept,salgrade
   WHERE emp.deptno=dept.deptno
   AND sal BETWEEN losal AND hisal
   AND empno=7788;
   DBMS_OUTPUT.PUT_LINE('사번:'||edg.empno);
   DBMS_OUTPUT.PUT_LINE('이름:'||edg.ename);
   DBMS_OUTPUT.PUT_LINE('직위:'||edg.job);
   DBMS_OUTPUT.PUT_LINE('부서명:'||edg.dname);
   DBMS_OUTPUT.PUT_LINE('근무지:'||edg.loc);
   DBMS_OUTPUT.PUT_LINE('등급:'||edg.grade);
END;
/
*/
-- 스칼라변수 (변수 데이터형), TYPE변수 (실제 데이터형 읽기)
/*
	형식)
		------------- 익명
		DECLARE
		   변수선언
		------------- CREATE FUNCTION func_name(매개변수)
				 CREATE PROCEDURE pro_name(매개변수)
				 CREATE TRIGGER tri_name
		BEGIN
		   구현
			SELECT => 값을 받아서 변수에 저장 INTO
			=> 제어 시작
			=> 연산자 : SQL에 있는 연산자 대입
			=> 제어문 
		EXCEPTION
		   예외처리
		화면 출력
		END;
		/
		
		제어문
		  = 조건문
		  	1) 단일 조건문
			   IF 조건문 THEN => if(조건문)
				실행문장 => 조건이 true일때 수행
			   END IF;
			2) 선택 조건문
			   IF 조건문 THEN => if(조건문)
				실행문장 => 조건이 true
			   ELSE => else
				실행문장 => 조건이 false
			   END IF;
			3) 다중 조건문 => 한개의 조건만 실행
			   IF 조건문 THEN
				실행문장
			   ELSIF 조건문 THEN
				실행문장	   
			   ELSIF 조건문 THEN
				실행문장	
			   ELSE => 생략이 가능
				실행문장	
			   END IF;
*/
/*
-- 단일 조건문 IF 조건문 THEN
DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;

   IF pDeptno=10 THEN
   	pDname:='개발부'; -- 값을 대입 :=
   END IF;
   IF pDeptno=20 THEN
   	pDname:='행정부'; -- 값을 대입 :=
   END IF;
   IF pDeptno=30 THEN
   	pDname:='자재부'; -- 값을 대입 :=
   END IF;
   IF pDeptno=40 THEN
   	pDname:='회계부'; -- 값을 대입 :=
   END IF;
   DBMS_OUTPUT.PUT_LINE('사번:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('이름:'||pEname);
   DBMS_OUTPUT.PUT_LINE('직위:'||pJob);
   DBMS_OUTPUT.PUT_LINE('부서번호:'||pDeptno);
END;
/
*/
/*
DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;

   IF pDeptno=10 THEN
   	pDname:='개발부'; -- 값을 대입 :=
   ELSIF pDeptno=20 THEN
   	pDname:='행정부'; -- 값을 대입 :=

   ELSIF pDeptno=30 THEN
   	pDname:='자재부'; -- 값을 대입 :=

   ELSIF pDeptno=40 THEN
   	pDname:='회계부'; -- 값을 대입 :=
   END IF;
   DBMS_OUTPUT.PUT_LINE('사번:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('이름:'||pEname);
   DBMS_OUTPUT.PUT_LINE('직위:'||pJob);
   DBMS_OUTPUT.PUT_LINE('부서번호:'||pDeptno);
END;
/
*/
/*
-- IF ~ ELSE
DECLARE
  pEname emp.ename%TYPE;
  pComm emp.comm%TYPE;
  pSal emp.sal%TYPE;
  pTotal NUMBER(7,2):=0;
BEGIN
  SELECT ename,comm,sal,sal+NVL(comm,0)
   INTO pEname,pComm,pSal,pTotal
  FROM emp
  WHERE empno=&empno;
  -- pComm = 0 , pComm = null => else문장 수행
  --			연산 수행이 안된다
  IF pComm>0 THEN
	DBMS_OUTPUT.PUT_LINE(pEname||'님의 급여는 '||pSal||'이고 성과급은 '||pComm||'이며 총급여는 '||pTotal||'입니다');
  ELSE 
	DBMS_OUTPUT.PUT_LINE(pEname||'님의 급여는 '||pSal||'이고 성과급은 없고 총급여는 '||pTotal||'입니다');
  END IF;
END;
/
*/

DECLARE
   pEmpno emp.empno%TYPE;
   pEname emp.ename%TYPE;
   pJob emp.job%TYPE;
   pDname dept.dname%TYPE;
   pDeptno emp.deptno%TYPE;
BEGIN
   SELECT empno,ename,job,deptno
   	INTO pEmpno,pEname,pJob,pDeptno
   FROM emp
   WHERE empno=&empno;
	
   pDname:=CASE pDeptno -- switch(deptno)
		WHEN 10 THEN '개발부' -- case 10
		WHEN 20 THEN '영업부' -- case 20
		WHEN 30 THEN '자재부' -- case 30
		ELSE '신입' -- default
		END;
DBMS_OUTPUT.PUT_LINE('사번:'||pEmpno);
   DBMS_OUTPUT.PUT_LINE('이름:'||pEname);
   DBMS_OUTPUT.PUT_LINE('직위:'||pJob);
   DBMS_OUTPUT.PUT_LINE('부서:'||pDname);
		
END;
/