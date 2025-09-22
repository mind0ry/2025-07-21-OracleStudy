-- 5장 => 데이터베이스 개발자 / 데이터베이스 연동 (DAO) / 웹 개발자 (JSP)
/*
	5장 => PL/SQL : PROCEDURE를 만드는 언어
				=> 제어는 SQL
	***1. 변수 선언 / 매개변수 
		***스칼라변수 : 데이터형을 임의로 설정
			no NUMBER , name VARCHAR2(20)
		***TYPE : 실제 테이블의 컬럼 데이터형을 읽기
		    fno menupan_food.fno%TYPE
		    empno emp.empno%TYPE
		ROWTYPE : VO와 동일 => 테이블 컬럼 전체 데이터형을 한번에 읽기
			emp emp%TYPE
				--- emp가 가지고 있는 모든 컬럼의 데이터형 읽기 
				사용법 : emp.empno , emp.ename...
				단점 : 한개의 테이블만 사용이 가능
		RECORD : 사용자 정의 (여러개 테이블을 사용하는 경우)
				| 서브쿼리 , 조인
				TYPE type명 IS RECORD(
					변수 데이터형 ,
					변수 데이터형
					...
				)
		***CURSOR : 다중행 (ROW가 여러개인 경우)
		   | 사용법
			CURSOR cur명 IS 
				SELECT ~~ => JOIN , SUBQUERY
			=> 자바 : ResultSet
	2. 제어문 
		= 조건문
		   = 단일 조건문
			IF 조건문 THEN
				처리문장 => 조건이 true일때
			END IF;
		   = 선택 조건문
			IF 조건문 THEN
				처리문장 => 조건 true일때
			ELSE
				처리문장 => 조건 false일때
			END IF;
		= 반복문
		   	= LOOP : do~while
				LOOP
				  반복 수행 문장
				  EXIT 종료조건
				END LOOP;
				=> do
				     {
					반복수행문장
				     } while(조건식)
			= WHILE
				WHILE 조건 LOOP
				  반복 수행 문장
				END LOOP;
				=> while(조건문)
				      {
					반복 수행 문장
				      }
			= FOR
				FOR 변수 IN lo..hi LOOP
				  반복 수행 문장
				END LOOP;
				=> 1~10
				FOR i IN 1..10 LOOP => for(int i=1;i<=10;i++)
					i 출력
				END LOOP
				= 10 ~ 1
				FOR i IN REVERSE 1..10 LOOP => for(int i=10;i>=1;i--)
					i 출력
				END LOOP;
			--------------------------------------- 일반 for
				for-each
				FOR 변수 IN cursor LOOP => for(MonieVO vo:list)
					변수 출력
				------------------------- 가장 많이 사용
				for(let vo in 배열) / for(let vo of 배열)
				map() / forEach()
				------------------------ 자바스크립트의 for문	
			형식
			   선언부
			   구현부
			   예외처리부 
			   DECLARE
				변수 선언 => C언어 형식 => 반드시 변수 설정은 처음에 한다
				=> 변수 성언시에 초기값은 :=
				=> 예) no NUMBER:=0;	
			   BEGIN
				구현 => SELECT / INSERT / UPDATE / DELETE
				EXCEPTION 
					WHEN exception의 종류 THEN => catch
						처리문장
						NO_DATA_FOUND
					WHEN OTHERS THEN => 기타
			   END;

			   DECLARE : 익명
			   ------------------
				CREATE [OR REPLACE] FUNCTION func_name(매개변수...)
				IS
				BEGIN
				   EXCEPTION
				END;

				CREATE [OR REPLACE] TRIGGER tri_name
				[AFTER|BEFORE] 종류 ON table명
						       ----- INSERT / UPDATE / DELETE
				FOR EACH ROW
				IS
				BEGIN
				   EXCEPTION
				END;
				삭제 : DROP FUNCTION func_name
					 DROP PROCEDURE pro_name
					 DROP TRIGGER tri_name

			
	3. FUNCTION
		=> 리턴형을 가지고 있는 함수 : 내장 함수
		=> ROW단위 집계 처리
		=> SubQuery , JOIN => 복잡한 쿼리 있는 자주 반복되는 곳
			CREATE OR PEPLACE FUNCTION fun_name(매개변수)
			RETURN NUMBER (VARCHAR2, DATE)
			IS
			  지역변수
			BEGIN
			  처리
			  RETURN 값
			END;
			/
			=> 사용위치
				SELECT 뒤에 : 컬럼 대신
				WHERE 뒤에 : 컬럼 대신 사용 | 값
				GROUP BY / ORDER BY
				=> 지원하지 않는 함수 => 사용자 함수
				=> 모든 프로그램 사용자 정의 (데이터형 , 함수 , 메소드)
					| class : record , cursor
				=> 사용자 정의가 없는 프로그램 : HTML/CSS
				=> SELECT 중심
	***4. PROCEDURE : 기능만 처리 : DML전체 사용이 가능
				   리턴형이 없다
		형식)
			CREATE OR REPLACE PROCEDURE pro_name(매개변수...)
			IS
			BEGIN
			   EXCEPTION
			END;
			매개변수
			  = SQL대입하는 변수 => IN (생략)
				pNum NUMBER => IN
				=> INSERT , UPDATE , DELETE , WHERE
			  = 값을 받는 변수 => OUT
				pNum OUT NUMBER => C언어 (포인터)
				=> INTO에서 사용 , :=
				=> Call By Reference : 배열 / 클래스
				=> int* p => &p
				=> C언어 / 오라클 => 일반 변수도 주소를 가지고 있다
				=> SELECT문장 
			  = SQL에 대입 + 값을 받는 변수 => INOUT
				pNum INPUT NUMBER
			  WHERE empno=pEmpno
						----------- IN
	***5. TRIGGER : 찜하기 = 단점 : 가독성이 전혀 없다
		    | 제어문 (IF / CASE)
	
	*** 1. 데이터베이스 설계 
		맛집 === 찜 === 찜하기 
*/

