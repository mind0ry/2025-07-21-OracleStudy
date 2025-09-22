-- 집합 함수 : column단위 (집계함수)
/*
	-- SQL문장 내부 실행 순서 => 144page
	-- SELECT문장 => 145page
	-- 연산자 => 149page
	-- 내장함수 => 단일행 함수 => 209page , 210page
	-- 숫자 => 211page
	-- 문자 => 213page
	-- 날짜 => 216page
	-- 변환 => 218page
	-- NULL => 219page
	
	COUNT : row의 개수
			COUNT(*) / COUNT(column)
			-----------    -------------------
			null 포함	  null 제외
	=> 로그인 아이디 존재여부
	=> 아이디 중복 체크
	=> 검색 개수
	=> 장바구니 여부 
	
	MAX : 최대값 ==> MAX(컬럼명)
	=> 자동 증가번호
	=> 중복없는 데이터 첨부 (PRIMATY KEY)
	=> 번호 / 날짜 (등록일)
			------------- 사용자 입력 (예약일 , 생일...)

	MIN : 최소값 => 사용빈도는 없다

	SUM : 총합 / AVG : 평균 
*/
SELECT MAX(empno),MAX(empno)+1
FROM emp;