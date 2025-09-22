-- 8장 ====> 웹 프로그램 제작시 응용
/*
   **3장 : SELECT => 데이터 검색
	      | JOIN / SUBQUERY
	      | 연산자
   4장 : **내장 함수 / DDL / DML (CREATE , ALTER , DROP , RENAME , TRUNCATE) / **DML (INSERT , UPDATE , DELETE)
   5장 : PL/SQL ( FUNCTION , PROCEDURE , TRIGGER )
   6장 : ER-MODEL (관계 1:1 , 1:N , N:M)
   7장 : 정규화
	   1 정규화 => 원자값 (컬럼은 단일값 우선) 
	   2 정규화 => 중복 제거
	   3 정규화 => 컬럼 => 모든 ROW의 컬럼을 제어
   8장 : **트랜잭션
	   => 일괄처리
	   => 오라클 일괄처리 => 자바 (AutoCommit)
						| 여러개의 SQL을 동시에 처리 (COMMIT해제)
	   try{
		연결 
		conn.setAutoCommit(false)
		INSERT 
		UPDATE 
		INSERT 
		INSERT 
		COMMIT
	   } catch(Exception e) {
		ROLLBACK
	   }
	   ** COMMIT 수행
		=> INSERT / UPDATE / DELETE => 오라클 데이터 변경이 되는 상태
		=> COMMIT이 수행이 되면 ROLLBACK은 사용할 수 없다
		=> 자동
			CREATE / DROP / ALTER / TRUNCATE
	   ** ROLLBACK 수행
		=> 지정 : SAVEPOINT (특정 지점을 저장) => 부분 ROLLBACK
*/
/*
CREATE TABLE emp_tr
AS
   SELECT empno,ename,job,sal,deptno
FROM emp
WHERE 1=2;
*/

/*
INSERT INTO emp_tr VALUES(100,'홍길동','대리','3500',10);
-- 실제 메모리 저장된 상태가 아니다
SELECT * FROM emp_tr;
*/
--ROLLBACK;

/*
INSERT INTO emp_tr VALUES(101,'박문수','과장','4000',20);
SAVEPOINT sp1;
INSERT INTO emp_tr VALUES(101,'심청이','부장','6000',30);
ROLLBACK TO sp1;
COMMIT;
*/
/*
INSERT INTO emp_tr VALUES(101,'심청이','부장','6000',30);
COMMIT;
UPDATE emp_tr SET sal=sal+100 WHERE deptno=10;
SAVEPOINT sp1;
UPDATE emp_tr SET sal=sal+200 WHERE deptno=20;
SAVEPOINT sp2;
UPDATE emp_tr SET sal=sal+300 WHERE deptno=30;
ROLLBACK TO sp2;
*/
/*
  COMMIT => 영구적인 저장
  ROLLBACK => 취소 (명령어 취소 = INSERT / UPDATE / DELETE)
  SAVEPOINT => 취소위치 => ROLLBACK TO savepoint명

  => Spring => 메소드 위에 @Transactional => AOP
*/  
-- 답변형 게시판
-- 테이블 제작
/*
				no  group  step  tab
	AAAAAA		 1	 1	  0	 0
	   => BBB		 2	 1	  1	 1
		=> CCC	 3	 1	  2	 2
	  => KKKK		 5	 1	  3 	 1
	DDDDD		 4	 2 	  0	 0
*/