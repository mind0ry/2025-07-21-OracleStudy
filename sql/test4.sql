-- 오라클 2일차 => DQL(SELECT) : 데이터 검색
-- 조건 (WHERE => 연산자) , 내장함수 이용
-- ORDER BY : 정렬
/*
	SELECT : 데이터 검색
			테이블 구조 => 컬럼명 / 데이터형
				DESC table명
			데이터형
				= NUMBER : 숫자 (int , double)
				= VARCHAR2,CHAR,CLOB : String
				= DATE : hava.util.Date
				= BLOB , BFILE : java.io.InputStream
				= 문자열 , 날짜 => "
			* 문장이 종료되면 ;
			* 대소문자 구분이 없다 = 키워드는 대문자 사용
			  ** 실제 저장된 데이터 대소문자 구분
			  ** 자바에는 ;을 사용하지 않는다 (자동 첨부)
	형식 , 순서)	
			--------------------------------------------------------
			SELECT *(전체) | column_list(원하는 데이터 추출)
			FROM table_name (view_name,SELECT~)
			--------------------------------------------------------
			[
				WHERE 조건문 (연산자) = if문
					   ------------------ 컬럼명 연산자 값 => true
				GROUP BY 그룹컬럼 = 통계 (관리자 모드)
								장바구니 , 로그인 횟수 ...
				HAVING 그룹조건
				-------------------- 반드시 GROUP BY가 있는 경우에만 사용
				ORDER BY 정렬 컬럼 (ASC|DESC)
							       ---------- 생략이 가능
			]
			SQL Plus 조절
			set linesize 250 => width (80)
			set pagesize 25 => default(14줄)
			=> sqldeveloper
*/
-- 1. 데이터 전체 출력 : *
-- *을 사용하면 순서는 DESC에서 출력된 순서로 나온다
/*
SELECT * 
FROM emp;
*/
-- 2. 원하는 데이터만 추출 => 프로젝션
SELECT empno,ename,job,hiredate,sal
FROM emp;
-- 3. 조건에 맞는 데이터만 추출 => 셀렉션
-- WHERE 컬럼 연산자 값 => if(컬럼 연산자 값)
/*
	오라클 연산자
	   = 산술연산자 : SELECT => 통계
		+ , - , * , /
		-- 순수하게 산술만 처리 (문자열 결합은 없다 => ||)
		/ : 0으로 나눌 수 없다
		    정수/정수 = 실수 => 5/2=2.5
		+ : 총점 , 급여+성과급
		- : 급여-소득세
		* : 연봉 구하기 / 당수 구하기
		/ : 날자수
	   ----------------------- true / false
	   = 비교연산자
		= 같다 (UPDATE에서 =은 대입)
		<>(권장) , != , ^= : 같지 않다
		< : 작다
		> : 크다
		<= : 작거나 같다
		>= : 크거나 같다
	   = 논리연산자
		|| (문자열 결합) , && (입력값을 받는 경우에 사용)
		AND , OR
		=> 직렬연산자 => (조건) AND (조건)
					   ------         ------
					      |		       |
					      ---------------
						      |
						 결과값 => 조건 두개가 true일때만 수행
						 => 범위, 기간이 포함이 되는 경우
						 => BETWEEN ~ AND
			예) 1~10 사이면 
			     no >= 1 AND no <=10
			     no BETWEEN 1 AND 10 => 페이지 나누기
		=> 병렬연산자 => (조건) OR (조건)
					   ------       ------
					      |		    |
					      ------------
						     |
						결과값 => 조건 한개이상이면 true
						=> 범위,기간을 벗어나는 경우
						=> IN
						=> 검색어 여러개인 경우
			=> A , B , C
			WHERE fd='A' OR fd='B' OR fd='C'
			WHERE fd IN('A','B','C')
	   = BETWEEN ~ AND : 기간 , 범위 처리
	   = IN : 검색할 데이터가 많은 경우 OR를 대체
	   = NULL
		*** NULL은 값이 없는 상태 => NULL일 경우에는 연산처리가 안된다
							  ------------------------------------------
							  NULL을 포함하면 모든 연산 결과는 NULL
		NULL 경우 : IS NULL
		NULL 이 아닌 경우 : IS NOT NULL
 	   = LIKE => 검색
		% : 문자제한이 없는 경우
		_ : 한글자
		시작하는 문자열 : 시작문자% => startsWith
			=> 서제스트 (자동 완성기)
			=> 자음으로 처리
		끝나는 문자열 : %끝문자 => endsWith
		포함 문자열 : %문자% => contains : 가장 많이 사용
		글자수를 아는 경우
			예) 3번째 C ==> __C%
				글자수 5개 => _B___ 
		
	   = NOT
		부정연산자
		WHERE NOT(조건)
		=> NOT BETWEEN ~ AND
		=> NOT IN
		=> NOT LIKE
	   ----------------------- WHERE
*/
-- 성과급을 받는 사람의 모든 정보
/*
SELECT *
FROM emp 
WHERE comm IS NOT NULL AND comm <> 0;
-- 성과급이 없는 사람의 모든 정보
SELECT *
FROM emp 
WHERE comm IS NULL OR comm = 0;
*/
/*
book
BOOKID NUMBER
BOOKNAME VARCHAR2(40)
PUBLISHER VARCHAR2(40)
PRICE NUMBER(8)
*/
/*
-- 전체 출력
SELECT *
FROM book;
-- 원하는 컬럼만 출력
SELECT bookname,price
FROM book;
*/
/*
SELECT publisher "출판사"
FROM book;
-- 중복 제거 => DISTINCT
SELECT DISTINCT publisher "출판사"
FROM book;
*/
-- 조건 검색 => 연산자 WHERE
/*
	오라클에서 제공하는 데이터형
	1) 문자 저장
		** 오라클에서 한글 3byte 성별 => CHAR(6)
		CHAR(1~2000byte) => 고정 바이트 (같은 글자수 저장)
		예) data CHAR(10) => data='A' => 메모리는 10byte 이다
		***VARCHAR2(1~4000byte) => 가변 바이트
		예) data VARCHAR2(1000) => data='A' => 메모리는 1byte
		CLOB : 4기가 => 가변형
		=> 줄거리, 카페, 블로그, 회사소개
	2) 숫자 저장
		NUMBER => 정수/실수
		NUMBER => 8자리
		NUMBER(4) => 1~4까지 사용이 가능 => 0~9999
		NUMBER(7,2) => 자리는 7자리 사용이 가능 (정수)
					 자리는 5자리 , 소수점 2자리 사용
		5.0 , 4.5...
		NUMBER(2,1)
		=> 자리수는 38자리 , 소수점 128자리
	3) 날짜 저장
		DATE => 날짜 , 시간 => default : YY/MM/DD => '81/01/23'
		=> 문자열 형식으로 저장
	** 문자/날짜 => 검색시에 반드시 ''를 사용
	** 저장된 데이터는 대소문자를 구분한다
*/
-- 산술연산자
/*
CREATE TABLE student(
	hakbun NUMBER,
	name VARCHAR2(51),
	kor NUMBER(3),
	eng NUMBER(3),
	math NUMBER(3)
);
INSERT INTO student VALUES(1,'홍길동',90,87,67);
INSERT INTO student VALUES(2,'심청이',78,82,62);
INSERT INTO student VALUES(3,'박문수',67,83,68);
INSERT INTO student VALUES(4,'이순신',89,85,69);
INSERT INTO student VALUES(5,'강감찬',77,86,70);
COMMIT;
*/
/*
SELECT hakbun,name,kor,eng,math,(kor+eng+math) "total",
	ROUND((kor+eng+math)/3,2) "avg",
	RANK() OVER(ORDER BY (kor+eng+math) DESC) "rank"
FROM student;
*/
-- 산술 연산자 : SELECT => 통계
-- 비교 연산자 = : 상세보기
-- 사원 중에 SCOTT사원의 모든 정보 출력
/*
SELECT * 
FROM emp
WHERE ename = 'SCOTT';
-- 사원중에 직위(job)가 CLERK인 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE job='CLERK';
-- 사원의 사번이 7900인 사원의 사번,이름,입사일,급여 출력
SELECT empno,ename,hiredate,sal
FROM emp
WHERE empno=7900; 

--SELECT 1||'10' FROM DUAL;
-- <> 같지 않다 (!= , <> , ^=)
-- 전체 사원에서 사원이 아닌 사람들을 출력
SELECT *
FROM emp
WHERE job<>'CLERK';

SELECT *
FROM emp
WHERE job!='CLERK';

SELECT *
FROM emp
WHERE job^='CLERK';
*/
-- 오라클의 단점 같은 내용을 출력시에 경우의 수가 많다 (분석이 어렵다)
-- 프로그램은 구현방식이 여러가지 있기 때문에 어렵다
-- 예) 이번 메소드 , 람다식
-- 가장 쉬운 프로그램 : 데이터베이스 연동
-- < 작다 ==> 날짜 , 문자까지 사용이 가능
-- 사원중에 급여(sal)가 2000보다 많이 받는 사원의 모든 정보 출력
SELECT * 
FROM emp
WHERE sal>2000;

-- 사원중에 입사일이 '81/05/09'보다 나중에 입사한 사원의 모든 정보
SELECT *
FROM emp
WHERE hiredate>'81/05/09';

-- 사원중에 급여(sal)가 2000(포함)보다 많이 받는 사원의 모든 정보 출력
SELECT * 
FROM emp
WHERE sal>=2000;

-- 사원중에 입사일이 '81/05/09'(포함)보다 먼저 입사한 사원의 모든 정보
SELECT *
FROM emp
WHERE hiredate<='81/05/09';

-- 사원중에 입사일이 '81/05/09'(포함)보다 나중에 입사한 사원의 모든 정보
SELECT *
FROM emp
WHERE hiredate>='81/05/09';