 -- 69page : 릴레이션 (테이블) 
/*
	릴레이션 : 관련된 데이터를 모아준 곳 (회원, 게시판, 맛집, 여행, 쇼핑...)
			여러개 사용이 가능 (정규화) = 중복의 최소화
	특징
	  1) 유일값을 가지고 있다 : 같은 데이터베이스 내에서 같은 이름을 사용이 불가능
	  2) 컬럼은 순서가 없다
	      컬럼 + 데이터 값
	  3) 데이터 순서가 없다 (정렬)
	  4) 이차원 구조 (컬럼 , 컬럼에 해당되는 데이터값)
	  5) 테이블(릴레이션) 구조 (릴레이션 제어 => 단위 record , ROW)
	      -------------------------------
		 id 	  name 	 sex       class Member{
							String id,name,sex			
						     }
		=> 컬럼 , 자바(멤버변수, 인스턴스 변수)
 	      -------------------------------
		aaa	   홍길동	남자 	    Member m=new Member()
						    m.id="aaa"
						    m.name="홍길동"
						    m.sex="남자"
		=> row / record , 자바(객체, 인스턴스)
							| 실제 메모리에 저장된 상태
		=> 데이터베이스 용어 : 튜플
	      -------------------------------
		bbb	   박문수	남자
	      -------------------------------

		72page 
		    속성 : 컬럼 (어떤 데이터를 저장할 지 여부)
				=> 데이터베이스 설계
				=> 벤치마킹 => 필요한 데이터를 추출
		    도메인 => 한개의 컬럼이 가지고 있는 데이터
 		    차수  => 컬럼의 개수
		    튜플 => 한줄 => 모든 정보를 저장하고 있다 (한개 , 한명)
		    카디널리티 : 튜플의 개수 => COUNT(*)

			-----------------------------------------
			릴레이션 : 테이블				파일
			-----------------------------------------
			인스턴스 : 실제 저장된 데이터	데이터
			-----------------------------------------
			튜플 : 행					레코드
			-----------------------------------------
			속성 : 열(column)				필드
			-----------------------------------------
			
			-----------------------------------------

			74 page
				= 속성값은 단일 값을 가지고 있다 (원자값)
				    id hobby
				  aaa  운동, 낚시, 등산 => 수정 , 삭제 => 테이블 한개 생성
				  -----------
				  aaa 운동
				  aaa 낚시
				  aaa 등산	===> 1정규화
				  -----------
				= 속성명은 다른 명칭을 가지고 있다
				= 속성은 순서가 없다
				= 한개의 데이터베이스 안에 같은 테이블명이 존재하면 안된다
				= 튜플은 순서가 없다 => ORDER BY 
			76 page
				키
				1. 중복된 데이터가 없게 만든다
				   --------------------------------- 이상 현상 방지
									    -----------
									   수정, 삭제시에 
				=> 영향이 없게 제작 : 데이터 무결성
				=> 기본키 : PRIMARY KEY
				     -------- ID , 번호 (영화번호,맛집번호,게시물번호...)
				     -------- 자동 증가 번호
				2. 대체키 (후보키) => email,phone => UNIQUE
				3. 외래키 (참조키) => 테이블 연결 => FOREGIN KEY
				4. CHECK , NOT NULL , DEFAULT
				----------------------------------------------------- 6장 / 7장
	
				90 page 관계 대수
					    ----------- 연산 (수학적 의미)
					1. 프로젝션
					   ----------- 원하는 데이터만 출력
					2. 셀렉션
					   ----------- 조건에 맞는 데이터 출력
					3. 합집합 / 교집합 / 차집합
								    MINUS
							INTERSECT
					   UNION ALL / UNION
					4. 조인
					   동등 조인 / 비등가 조인
					   --------------------------- INNSER JOIN
					   equals / non-equals (포함)
					   NULL 값 포함 => OUTER JOIN
						LEFT OUT JOIN
						RIGHT OUT JOIN
						FULL OUT JOIN
					자연 조인
						NATURAL JOIN
					------------------------------------ SELECT
*/
-- 프로젝션
/*
SELECT empno,ename,job,hiredate,sal
FROM emp;
*/
-- 셀렉션
/*
SELECT empno,ename,job,hiredate,sal
FROM emp
WHERE sal=3000;
*/
/*
CREATE TABLE test1(
	no number
);
CREATE TABLE test2(
	no number
);

INSERT INTO test1 VALUES(1);
INSERT INTO test1 VALUES(2);
INSERT INTO test1 VALUES(3);
INSERT INTO test1 VALUES(4);
INSERT INTO test1 VALUES(5);

INSERT INTO test2 VALUES(4);
INSERT INTO test2 VALUES(5);
INSERT INTO test2 VALUES(6);
INSERT INTO test2 VALUES(7);
INSERT INTO test2 VALUES(8);
COMMIT;
*/
/*
-- 교집합
SELECT no FROM test1
INTERSECT
SELECT no FROM test2;

-- 합집합
SELECT no FROM test1
UNION
SELECT no FROM test2;

SELECT no FROM test1
UNION ALL
SELECT no FROM test2;

-- 차집합
SELECT no FROM test1
MINUS
SELECT no FROM test2;

SELECT no FROM test2
MINUS
SELECT no FROM test1;
*/
/*
--조인
--EQUI_JOIN => INNER JOIN
-- 오라클 조인
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- ANSI 조인
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
-- 자연 조인
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp NATURAL JOIN dept;
-- JOIN~USING
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept USING(deptno);
*/
SELECT e1.ename "본인",e2.ename "사수"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno(+);

SELECT e1.ename "본인",e2.ename "사수"
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

SELECT empno,ename,job,dname,loc,dept.deptno
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT empno,ename,job,dname,loc,dept.deptno
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;