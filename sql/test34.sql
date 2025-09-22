-- 프로시저
-- 목록 읽기
CREATE OR REPLACE PROCEDURE foodListData(
   pStart NUMBER,
   pEnd NUMBER,
   pResult OUT SYS_REFCURSOR
)
IS
BEGIN
   OPEN pResult FOR
  	SELECT fno,name,poster,num
	FROM (SELECT fno,name,poster,rownum as num
	FROM (SELECT /*+ INDEX_ASC(menupan_food menuf_fno_pk)*/fno,name,poster
	FROM menupan_food))
	WHERE num BETWEEN pStart AND pEnd;
END;
/
-- 총페이지 
CREATE OR REPLACE PROCEDURE foodTotalPage(
   pTotal OUT NUMBER
)
IS
BEGIN
   SELECT CEIL(COUNT(*)/12.0) INTO pTotal
   FROM menupan_food;
END;
/
-- 상세 보기
CREATE OR REPLACE PROCEDURE foodDetailData(
   pFno NUMBER,
   pResult OUT SYS_REFCURSOR
)
IS
BEGIN
   OPEN pResult FOR
	SELECT fno,name,type,address,phone,score,
	parking,time,theme,content,poster,images,price 
	FROM menupan_food 
	WHERE fno=pFno;
END;
/