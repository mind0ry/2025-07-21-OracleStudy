 -- 사용자 정의 테이블 생성 
/*
	개념적 설계 => 데이터 추출 (요구사항 , 페이지 분석)
		|		뮤직
				순위 , 노래명 , 가수명 , 앨범명 , 등폭 , 상태 , 동영상 키
	논리적 설계
		|		순위(NUMBER) , 노래명(VARCHAR2) ,
				 가수명(VARCHAR2) , 앨범명(VARCHAR2) , 
				등폭(NUMBER) , 상태(VARCHAR2) , 동영상 키(VARCHAR2)
	물리적 설계
				순위 NUMBER(3) ....

	형식)
		CREATE TABLE table_name(
			컬럼명 데이터형 [제약조건],
			컬럼명 데이터형 [제약조건],
			컬럼명 데이터형 [제약조건],
			-------------------------------- 컬럼레벨
				=> 컬럼 생성과 동시에 제약조건 생성
				=> 반드시 사용 : NOT NULL , DEFAULT
			[제약조건],
			[제약조건],
			[제약조건]
			-------------------------------- 테이블레벨
				=> 테이블이 만들어진 후에 나중에 제약조건  생성
				=> PRIMARY KEY , FOREIGN KEY , CHECK , UNIQUE
		)

		제약조건 제어 : 제약조건 이름 부여
				      ---------
					user_constaints : 한곳에 저장
					테이블명_컬럼명_제약조건약자
					----- 약자
					nn : NOT NULL
					pk : PRIMARY KEY 
					fk : FOREIGN KEY
					ck : CHECK
					uk : UNIQUE
*/
/*
	emp / dept
	사번 : empno = PRIMARY KEY
	이름 : ename = NOT NULL
	직위 : job 	   = NOT NULL / CHECK
	사수 : mgr	   = NULL 허용
	입사일 : hiredate = DATE => DEFAULT
	급여 : sal	= NOT NULL
	성과급 : comm = NULL 허용
	부서번호 : deptno = FOREIGN KEY
--------------------------------------
	부서번호 : deptno = PRIMARY KEY
	부서명 : dname (CHECK) = NOT NULL
	근무지 : loc (CHECK) = NOT NULL

	회원 => 참조 (ID) 예약 , 댓글 , 결제 ....
	
	1. 테이블
	2. 제약조건
	3. 테이블 연결

	 => 판매전표 / 제품 / 전표상세

	판매전표
	---------------------------------------------------
	컬럼명    전표번호   판매일자   고객명   총액
	---------------------------------------------------
	제약조건     PK		NN         NN  CHECK
				    DEFAULT
	---------------------------------------------------
	참조테이블
	---------------------------------------------------
	참조 컬럼
	---------------------------------------------------
	체크							>0
	---------------------------------------------------
	데이터형  VARCHAR2 DATE	VARCHAR2 NUMBER
	---------------------------------------------------
	크기 	       13			     51	8,2
	-----------------------------------------------------------

	제품
	---------------------------------------------------
	컬럼명    제품번호   제품명   제품단가  
	---------------------------------------------------
	제약조건     PK		NN         CK
	---------------------------------------------------
	참조테이블
	---------------------------------------------------
	참조 컬럼
	---------------------------------------------------
	체크							>0
	---------------------------------------------------
	데이터형  VARCHAR2 VARCHAR2 NUMBER
	---------------------------------------------------
	크기 	       13		  51		8,2
	-----------------------------------------------------------

	전표상세
	--------------------------------------------------------
	컬럼명    전표번호   제품번호   수량   단가   금액  
	--------------------------------------------------------
	제약조건   PK/FK		FK         NN     NN    CK
	--------------------------------------------------------
	참조테이블	판매전표  제품
	--------------------------------------------------------
	참조 컬럼  전표번호    제품번호
	--------------------------------------------------------
	체크							      >0
	--------------------------------------------------------
	데이터형  VARCHAR2 VARCHAR2 NUMBER NUMBER NUMBER
	--------------------------------------------------------
	크기 	       13		  51		8,2		8,2		8,2
	-----------------------------------------------------------

*/
/*
DROP TABLE 판매전표;
DROP TABLE 제품;
DROP TABLE 전표상세;
CREATE TABLE 판매전표 (
    전표번호 VARCHAR2(13),
    판매일자 DATE DEFAULT SYSDATE CONSTRAINT 판매전표_판매일자_nn NOT NULL,
    고객명   VARCHAR2(51) CONSTRAINT 판매전표_고객명_nn NOT NULL,
    총액     NUMBER CONSTRAINT 판매전표_총액_ck CHECK(총액 > 0), 
    CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호)
);

CREATE TABLE 제품 (
    제품번호 VARCHAR2(13),
    제품명   VARCHAR2(51) CONSTRAINT 제품_제품명_nn NOT NULL,
    제품단가 NUMBER CONSTRAINT 제품_제품단가_ck CHECK(제품단가 > 0), 
    CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호)
);

CREATE TABLE 전표상세 (
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(13),
    수량     NUMBER CONSTRAINT 전표상세_수량_nn NOT NULL,
    단가     NUMBER CONSTRAINT 전표상세_단가_nn NOT NULL,
    금액     NUMBER CONSTRAINT 전표상세_금액_ck CHECK(금액 > 0),
    -- 전표번호와 제품번호를 함께 PK로 잡는 게 일반적입니다 (한 전표에 여러 제품 가능)
    CONSTRAINT 전표상세_pk PRIMARY KEY(전표번호, 제품번호),
    CONSTRAINT 전표상세_전표번호_fk FOREIGN KEY(전표번호)
        REFERENCES 판매전표(전표번호),
    CONSTRAINT 전표상세_제품번호_fk FOREIGN KEY(제품번호)
        REFERENCES 제품(제품번호)
);
*/
-- ALTER를 이용한 제약조건 설정
DROP TABLE 판매전표;
DROP TABLE 제품;
DROP TABLE 전표상세;
-- 오타/괄호/타입 불일치만 수정
CREATE TABLE 판매전표 (
    전표번호 VARCHAR2(13),
    판매일자 DATE,
    고객명   VARCHAR2(51),
    총액     NUMBER
);
/*
	1. NOT NULL => MODIFY 컬럼명 데이터형 제약조건
	2. CHECK , PRIMARY KEY , FOREIGN KEY , UNIQUE => ADD CONSTRAINT 제약조건
	3. 제약조건 삭제
	    ALTER TABLE table_name DROP CONSTRAINT 이름 ;
									    ------
									판매전표_전표번호_pk 
	=> 한번에 완성이 안된다
		컬럼 추가 , 컬럼 크기 변경 , 컬럼 삭제가 가능 => 184~815
		ALTER TABLE table_name ADD 컬럼명 데이터형 [제약조건]
		ALTER TABLE table_name MODIFY 컬럼명 데이터형
									  ----------
		ALTER TABLE table_name DROP COLUMN col_name
		=> COLUMN 단위
		=> 제약조건 설정 => 데이터가 있는 경우
		제약조건 추가 , 제약조건 변경 , 제약 조건 삭제 가능
		ALTER TABLE table_name ADD CONSTRAINT ~
						   ------ PK,FK,CK,UK
		ALTER TABLE table_name MODIFY 컬럼명 데이터형 CONSTRAINT ~
						   ---------- NN
		** DEFAULT 사용시에는 CONSTRAINT앞에 설정
		ALTER TABLE table_name DROP CONSTRAINT constraint_name
*/
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호);
ALTER TABLE 판매전표 MODIFY 판매일자 DATE DEFAULT SYSDATE CONSTRAINT 판매전표_판매일자_nn NOT NULL;
ALTER TABLE 판매전표 MODIFY 고객명 VARCHAR2(51) CONSTRAINT 판매전표_고객명_nn NOT NULL;
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_총액_ck CHECK(총액 > 0);
CREATE TABLE 제품 (
    제품번호 VARCHAR2(13),
    제품명   VARCHAR2(51) ,
    제품단가 NUMBER
);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호);
ALTER TABLE 제품 ADD NUMBER CONSTRAINT 제품_제품단가_ck CHECK(제품단가 > 0);
ALTER TABLE 제품 MODIFY 제품명 VARCHAR2(51) CONSTRAINT 제품_제품명_nn NOT NULL;
CREATE TABLE 전표상세 (
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(13),  -- 상위(제품.제품번호)와 길이 일치
    수량     NUMBER,
    단가     NUMBER,
    금액     NUMBER
);

