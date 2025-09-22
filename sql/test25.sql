-- 시노님 => 동의어 => 테이블명에 대한 => 개인만 / 모든 사용자
/*
	CREATE 시노님
	CREATE PUBLIC 시노님
	=> 단점은 권한이 없다 (hr)
	=> SYNONYM => 테이블 / 뷰 / 시퀀스 / 함수 ... 별칭
	목적 : 테이블 / 뷰 / 시퀀스 / 함수 => 명칭이 긴 경우도 있다
		=> 숨기거나 / 짧게 만들어서 사용
	특징 
		별칭 생성 , 로컬 / 글로벌 (모든 사용자)
		권한 부여가 필요 : SYSTEM / SYSDBA 
		DCL => GRANT / REVOKE
				권한 	권한 해제
		=> GRANT CREATE SYNONYM TO hr
			 GRANT CREATE VIEW TO hr
		=> REVOKE CREATE SYNONYM FROM hr
		***
*/
/*
CREATE VIEW emp_view
AS 
	SELECT * FROM emp;
*/
-- local : 현재 사용자
--CREATE SYNONYM emp_as FOR emp;
-- 모든 사용자
/*
CREATE PUBLIC SYNONYM emp_pub FOR emp;
DROP SYNONYM emp_as;
DROP PUBLIC SYNONYM emp_pub;
*/
/*
	1. 다른 사용자 테이블을 편리하게 접근이 가능
	hr_1 / hr_2 / hr_3
	2. 테이블 이름 변경 => SYNONYM만 변경하면 코드 수정 최소화
					가독성이 좋다
	3. 보안 목적 => 주의점 : PUBLIC 권한주의
*/