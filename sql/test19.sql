-- 데이터 조작언어 (DML => INSERT / UPDATE / DELETE) = 187page
/*
	INSERT : 데이터 추가
	 = INSERT ALL : 이미 존재하는 테이블에서 전체 데이터를 나눠서 저장
	 ***= 전체 데이터 등록
		INSERT INTO table_name VALUES(값,값 ....) => DEFAULT가 적용이 안된다
				   ------------
				   컬럼과 매칭 => DEFAULT는 상관없이
	 = 원하는 데이터 등록 (NULL허용 , DEFAULT가 있는 경우)
	INSERT INTO table_name(컬럼,컬럼...) VALUES(값....)
*/
/*
-- INSERT ALL
CREATE TABLE emp_10
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_20
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_30
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;
*/
-- 파티션 테이블 => 분기별 통계 => 관리자 모드 (GROUP BY)
/*
DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;

CREATE TABLE emp_10
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_20
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_30
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

INSERT ALL
	WHEN deptno=10 THEN
	  INTO emp_10 VALUES(empno,ename,job,hiredate,sal)
	WHEN deptno=20 THEN
	  INTO emp_20 VALUES(empno,ename,job,hiredate,sal)
	WHEN deptno=30 THEN
	  INTO emp_30 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;
*/
--입사년도별
/*
CREATE TABLE emp_1980
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1981
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1982
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;

CREATE TABLE emp_1983
AS 
	SELECT empno,ename,job,hiredate,sal FROM emp
	WHERE 1=2;
drop table emp_ 1980;
drop table emp_ 1981;
drop table emp_ 1982;
drop table emp_ 1983;
INSERT ALL
	WHEN TO_CHAR(hiredate,'YYYY')=1980 THEN
	  INTO emp_1980 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1981 THEN
	  INTO emp_1981 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1982 THEN
	  INTO emp_1982 VALUES(empno,ename,job,hiredate,sal)
	WHEN TO_CHAR(hiredate,'YYYY')=1983 THEN
	  INTO emp_1983 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;
*/
/*
DROP TABLE 전표상세;
DROP TABLE 판매전표;
DROP TABLE 제품;

DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;
DROP TABLE emp_1980;
DROP TABLE emp_1981;
DROP TABLE emp_1982;
DROP TABLE emp_1983;
*/
/*
CREATE TABLE student(
	hakbun NUMBER,
	name VARCHAR2(52) CONSTRAINT student_name_nn NOT NULL,
	kor NUMBER(3) CONSTRAINT student_kor_nn NOT NULL,
	eng NUMBER(3) CONSTRAINT student_eng_nn NOT NULL,
	math NUMBER(3) CONSTRAINT student_math_nn NOT NULL,
	regdate DATE DEFAULT SYSDATE,
	CONSTRAINT student_hakbun_pk PRIMARY KEY(hakbun)
);
*/
--INSERT INTO table_name VALUES(값...)
-- 문자열 => '' , 날짜 => '' (SYSDATE)
-- DEFAULT가 있는 경우 => 컬럼을 설정
-- INSERT INTO table_name(컬럼.....) VALUES(값....)
-- 								      SYSDATE
--INSERT INTO student VALUES(100,'홍길동',90,80,95,'25/08/01');
--INSERT INTO student VALUES(101,'심청이',80,75,90,SYSDATE);
/*
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(102,'박문수',78,89,90);
COMMIT;
*/
-- subquery => insert,update,delete 에서 사용이 가능
-- insert => 자동 증가번호 만들기 SELECT NVL(MAX(hakbun)+1,100
/*
INSERT INTO student(hakbun,name,kor,eng,math) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
'이순신',89,90,98);
COMMIT;
*/
/*
INSERT INTO student(hakbun,name,kor,eng,math) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
'강감찬',80,95,90);
COMMIT;
*/
-- COMMIT이 없는 경우 => 오라클에서는 종료전까지 사용이 가능
-- 자바에서는 인식하지 못한다 (실제 저장된 메모리에서 읽기)
/*
INSERT INTO student(hakbun,name,kor,eng) 
VALUES((SELECT NVL(MAX(hakbun)+1,100) FROM student),
	'김두한',90,90);
*/
/*
CREATE TABLE student2
AS
	SELECT * FROM student
	WHERE 1=2;
*/
=> SELECT 문장을 이용해서 데이터 저장이 가능
=> 많이 사용되는 쿼리는 아니다 (데이터만 재사용)
/*
INSERT INTO student2(hakbun,name,kor,eng,math,regdate)
	SELECT * FROM student;
*/