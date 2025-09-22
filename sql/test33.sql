-- PL/SQL => 프로시저를 만들기 위한 언어 (SQL을 이용해서 제작)
-- 리턴형은 없다 = 결과값을 받는 경우 : 포인터를 이용한다
/*
	IN => 일반 대입값 : INSERT / UPDATE / DELETE
	OUT => 결과값을 받는 경우에 사용 : SELECT
	INOUT => 일반 대입값,결과값 처리 : SELECT
	--------
	IN변수는 WHERE뒤에 , OUT변수는 값을 읽어 오는 변수
	*** 생략된 경우는 IN 변수로 인식
	*** OUT => Call By Reference를 이용한다
	
	프로시저의 주로 사용처
	=> 배치 작업 : 복구 , 백업 , 데이터 이동
	=> 데이터 마이그레이션 : 테이블 데이터를 복사 , 이관 처리
	=> 여러개의 SQL과 제어문이 필요한 경우
	=> SQL문장이 유사한 경우 : ERP (대기업)
		금융권 , 공기업
	1) 재사용
	2) 보안
	3) 트랜잭션 처리
	형식)
		CREATE [OR REPLACE] PROCEDURE pro_name(매개변수..)
		IS
		  변수 설정
		BEGIN
		  구현 : SELECT / INSERT / UPDATE / DELETE
		END;
		/

		** 매개변수를 통해서 결과값을 받는다
		(pNo NUMBER, pName OUT VARCHAR2...)
*/
-- 저장 : IN
CREATE OR REPLACE PROCEDURE stdInsert(
  pName student.name%TYPE,
  pKor student.kor%TYPE,
  pEng student.eng%TYPE,
  pMath student.math%TYPE
)
IS
BEGIN
  INSERT INTO student VALUES(
	(SELECT NVL(MAX(hakbun)+1,1) FROM student),
	pName,pKor,pEng,pMath,SYSDATE
  );
COMMIT;
END;
/
-- 수정 : IN
CREATE OR REPLACE PROCEDURE stdUpdate(
  pName student.name%TYPE,
  pKor student.kor%TYPE,
  pEng student.eng%TYPE,
  pMath student.math%TYPE,
  pHakbun student.hakbun%TYPE
)
IS
BEGIN
  UPDATE student SET
  name=pName,kor=pKor,eng=pEng,math=pMath
  WHERE hakbun=pHakbun;
COMMIT;
END;
/
-- 자음으로 검색
-- 삭제 : IN
CREATE OR REPLACE PROCEDURE stdDelete(pHakbun student.hakbun%TYPE)
IS 
BEGIN
  DELETE FROM student
  WHERE hakbun=pHakbun;
  COMMIT;
END;
/
-- 검색 : OUT
CREATE OR REPLACE PROCEDURE stdFind(
  pName OUT student.name%TYPE,
  pKor OUT student.kor%TYPE,
  pEng OUT student.eng%TYPE,
  pMath OUT student.math%TYPE,
  pHakbun student.hakbun%TYPE
)
IS
BEGIN
  SELECT name,kor,eng,math
	INTO pName,pKor,pEng,pMath
  FROM student
  WHERE hakbun=pHakbun;
END;
/