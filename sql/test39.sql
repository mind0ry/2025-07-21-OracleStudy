-- 6장 / 7장 => 데이터베이스 설계
/*
	6장 => 요구사항 분석 / ER-Model
	7장 => 정규화
	8장 => 트랜잭션
	---------------------- SQL 튜닝 (SQL문장의 최적화)
				   ----------- INDEX를 많이 사용
	page 313
	1) 데이터베이스 모델링
	    => 프로젝트에 필요한 데이터를 구조화하여 DB에 저장 => 설계
	    => 목적
		   1) 데이터 무결성 : PRIMARY KEY
		   2) 데이터 일관성 
		   3) 효율적인 조회 
	    => 현재 상용중인 사이트를 모방 : 벤치마킹 ==> 추출 데이터를 저장
	    => 어떤 기능 / 비기능 => 테이블 생성
			| ERD				| 스키마
	    => 개념적 모델 : 속성(컬럼)의 관계 설정
	    => 논리적 모델 : 정규화 => 구체적
	    => 물리적 모델 : 인덱스 , 키 설정 => 파티션 / 인덱스 => 성능 최대화 
	    => 요구사항 분석 / 데이터베이스 설계 : DBA
	2) 데이터베이스 생명주기 
	    요구사항 분석
		|
	      벤치마킹 => 데이터 수집 / 분석
	        |
	      설계
	        |
	      구현 => 웹 개발자
	    	|
	      사이트 호스팅 : 관리 => AWS => CI/CD (운영자 : SE)
		|
	      유지보수 (개선 / 감시)
*/
/*
	1 단계
	   요구사항 분석
	   = 목적 : 어떤 데이터를 다룰지 / 사이트 가능 확장 
							| 모방 => 없는 기능	
	   = 방법
		벤치마킹 / 기존의 문서를 참조 
	   = 결과물 (산출물)
		기능 / 비기능 / 테이블 추출
	   = 예)
		쇼핑몰 => 쇼핑업체 , 사용자 , 결제 / 장바구니
	   -----------------------------------------------------------
	   1) 개념적 설계
		= 컬럼 추출 (데이터 추출) => 관계도
		   ----------------------------------------
		   사용자 ----- 장바구니 ----- 쇼핑업체
			      1:N 		  N:M
			1:1 / 1:N / N:M
		   ----------------------------------------
		= 사용자
			=> member(ID,PWD,Name,sex,address,phone)
				ERD
					member : 사각형
					   |
				--------------------------------
				|    |    |    |    |    |    |    |    |
			       ID PWD --------------------------> 타원형
			=> ERD 단순화
				사용자 ----> 장바구니 <---- 쇼핑업체
 	    2) 논리적 설계
		: 테이블 설계 / 정규화 수행
		  -------
		  회원(ID(PK),비번,이름....)
		  상품정보(상품번호(PK), 상품명 , 이미지....)
		  장바구니(번호(PK), ID(FK) , 상품번호(FK), 수량,금액)
		  => 관계도 : 1:1 / 1:N / N:M
		  => 기본키 / 외래키 설정
		  => 정규화 
			1 => 원자값 우선	취미 : 등산,낚시.. => 취미만 다른 테이블 생성
			2 => 중복 제거
			3 => 한개의 컬럼으로 row를 제어
	    3) 물리적 설계
		=> 데이터형을 등록 (VARCHAR2 , NUMBER, DATE...)
		=> 인덱스 설계
		=> 제약조건 (PK,CK,UK,FK...NN) 
		=> SQL스크립트 제작  : .sql , .csv
		=> DDL을 이용한다
	    -------------------------------------------------------------------
	    1. 요구사항 분석
		뮤직 사이트 / 쇼핑몰 / 서울 여행
		| 멜론 / 지니뮤직
		-------------------
		 1) 목적
		 2) 비교
		 3) 요구사항 도출
		    = 기능
			**사용자 관리
			   = **회원가입 , 소셜 로그인 (카카오 , 네이버 , 구글...)
			   = **마이페이지
			      ------------- **프로필 (수정 , 탈퇴) , 구독 / 결제
			뮤직 컨텐츠
			   = 스트리밍 (유튜브 => 키) , 다운로드 , 가사출력
			   = **앨범 , 곡 , 가수
			   = **재생  
			검색
			   = 통합검색 : 필터링 => MyBatis 동적 쿼리
			   = 카테고리별 검색 / 추천 
							----- 사용자 정보
				=> 소개
			개인화 추천
				좋아요 / 찜 / 히트
			부가적 콘텐츠
				공연 정보 , 매거진
			멀티플랫폼 
				모바일 / 웹 연동
			결제 / 구독
			------------- OPEN API
		    = 비기능
			성능 : SQL 최적화 (튜닝) => 이미지 (보류)
			SELECT * 
			FROM emp
			WHERE sal>2000;
			1) 전체 스캔 
			2) 컬럼이 많으면 속도 => 출력에 필요한 내용만
			    SELECT empno,ename,job
			    FROM emp
			    WHERE sal>=2000;
			3) 인덱스
			    CREATE INDEX sal_idx ON emp(sal)
			SELECT ename,hiredate
			FROM emp
			WHERE hiredate >= '81/01/01'
				   --------------------------
						TO_DATE(hiredate,'YY/MM/DD')
			데이터베이스 설계 vs 객체 지향 설계 (SOLID)

			보안 : JSP => 비밀번호 암호화 / 복호화
				Spring Security : 권한 / 암호화 ....
				-----------------
				=> JWT / Settion
				     ----- 람다
			확장성 : 지니뮤직 = 멜론
				    예) 영화 예매 => 항공사 예약
			호환성 : 크롬 = FF = IE
				    모바일 호환 : 반응형 웹
			--------------------------------------------------
		    => 요구사항 명세서
			ID      기능       유형        설명						순위
			FR-01 로그인     기능        카카오,구글 계정으로 로그인 가능     	   상
			FR-02 통합검색  기능	     가수/곡명/앨범				   상
			NFR-01 응답속도 비기능     2초 내에 처리 (페이지 응답 속도) 	   하
			------------------------------------------------------------------------------
			구분 : 마이페이지 / 관리자 페이지
			   *** 일반 사용자 
			   관리자 : 예약 관리 / 묻고 답하기 / 회원 관리 / 통계 관리
			-------------------------------------------
			  => 유스케이스 다이어그램
			  => 와이어프레임 (화면 UI) 
			  => ERD
			----------------------------------------------------------------------
			기능 : 메뉴 / 버튼
				-------------
			데이터 : 화면 (상세보기)
			----------------------------------------------------------------------
			기본
			   시나리오
				= 로그인 / 회원가입으로 접속
				= 목록 볼 수 있다
				= 검색이 가능
				= 목록을 클릭하면 상세보기 => 동영상 출력
			   데이터 추출 (개념적 설계)
				지니뮤직
					순위
					상태
					이미지
					곡명
					가수명
					앨범
					등폭
					동영상 key
				--------------------------
			   논리적 설계	
				지니뮤직(순위(PK),상태(CK),이미지,곡명,가수명,앨범,등폭,KEY)
					     ---------------------------------------------------- -----
						=> 지니뮤직						유튜브
			   물리적 설계
			   -------------- 크기 결정 => 테이블이 생성
			   ER-Model
			   사용자
				|- ID
				|- PWD
				|- NAME
		
			   뮤직
				|- 순위
				|- 곡명

			   관계도
				사용자 ------- 뮤직
					   1:N
				사용자 ------- 게시판
					   1:N
				-------------------------- 1:N / 1:1 / N:M
			   => 데이터형 설정
				 	순위 ==> NUMBER
					상태 ==> 하강 , 유지 , 하강 => CHAR(6)
					이미지 ==> 260
					곡명 ==> 200
					가수명 ==> 100
					앨범 ==> 200
					등폭 ==> NUMBER
					동영상 key ==> 100
				=> 장르별 분류
					=> cno
					=> no
					=> hit / jjim / like
				------------------------------------------
*/
/*
CREATE TABLE genie_music(
   no NUMBER,
   cno NUMBER,
   rank NUMBER CONSTRAINT gm_rank_nn NOT NULL,
   title VARCHAR2(200) CONSTRAINT gm_title_nn NOT NULL,
   singer VARCHAR2(100) CONSTRAINT gm_singer_nn NOT NULL,
   album VARCHAR2(200) CONSTRAINT gm_album_nn NOT NULL,
   poster VARCHAR2(260) CONSTRAINT gm_poster_nn NOT NULL,
   state CHAR(6) ,
   idcrememt NUMBER,
   key VARCHAR2(100),
   hit NUMBER DEFAULT 0,
   likecount NUMBER DEFAULT 0,
   CONSTRAINT gm_no_pk PRIMARY KEY(no),
   CONSTRAINT gm_state_ck CHECK(state IN('유지','상승','하강'))
);

CREATE TABLE melon_music(
   no NUMBER,
   rank NUMBER CONSTRAINT mm_rank_nn NOT NULL,
   title VARCHAR2(200) CONSTRAINT mm_title_nn NOT NULL,
   singer VARCHAR2(100) CONSTRAINT mm_singer_nn NOT NULL,
   album VARCHAR2(200) CONSTRAINT mm_album_nn NOT NULL,
   poster VARCHAR2(260) CONSTRAINT mm_poster_nn NOT NULL,
   state CHAR(6) ,
   idcrememt NUMBER,
   key VARCHAR2(100),
   hit NUMBER DEFAULT 0,
   likecount NUMBER DEFAULT 0,
   CONSTRAINT mm_no_pk PRIMARY KEY(no),
   CONSTRAINT mm_state_ck CHECK(state IN('유지','상승','하락'))
);
CREATE SEQUENCE gm_no_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;

CREATE SEQUENCE mm_no_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;
*/

커피빈 (개념적 설계)
상품 la a
	상품명 p.txt_box span.name
	유통기한 p.txt_box span.num
	가격 p.text_box span.price
	이미지  p.photo img

	


CREATE TABLE coffee(
   no NUMBER,
   name VARCHAR2(100) CONSTRAINT cf_name_nn NOT NULL,
   exdate VARCHAR2(200) CONSTRAINT cf_exdate_nn NOT NULL,
   price VARCHAR2(50) CONSTRAINT cf_price_nn NOT NULL,
   image VARCHAR2(260) CONSTRAINT cf_poster_nn NOT NULL,
   CONSTRAINT cf_no_pk PRIMARY KEY(no)
);

CREATE SEQUENCE cf_no_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;

