-- SEQUENCE : 자동 증가 번호
/*
	오라클에서는 객체
		=> TABLE / SEQUENCE / VIEW / INDEX
		=> CREATE / DROP
	=> START WITH --> 시각번호
		INCREMENT BY --> 증가
		NOCACHE : CACHE --> 미리 생성 (20개정도)
		NOCYCLE : CYCLE --> 처음 다시 시작
		1,2,3,4,6 .....
		=> 초기화 : SEQUENCE 삭제 => 다시 생성

		=> currval / nextval
				=> 다음 값
			=> 현재 값
*/
CREATE SEQUENCE my_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;
SELECT my_seq.nextval FROM DUAL;