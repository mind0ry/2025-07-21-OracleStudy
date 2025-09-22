-- SEQUENCE : ÀÚµ¿ Áõ°¡ ¹øÈ£
/*
	¿À¶óÅ¬¿¡¼­´Â °´Ã¼
		=> TABLE / SEQUENCE / VIEW / INDEX
		=> CREATE / DROP
	=> START WITH --> ½Ã°¢¹øÈ£
		INCREMENT BY --> Áõ°¡
		NOCACHE : CACHE --> ¹Ì¸® »ý¼º (20°³Á¤µµ)
		NOCYCLE : CYCLE --> Ã³À½ ´Ù½Ã ½ÃÀÛ
		1,2,3,4,6 .....
		=> ÃÊ±âÈ­ : SEQUENCE »èÁ¦ => ´Ù½Ã »ý¼º

		=> currval / nextval
				=> ´ÙÀ½ °ª
			=> ÇöÀç °ª
		INSERT INTO student VALUES(my_seq.nextval....)

	Å×ÀÌºí ¼³°è
		Å×ÀÌºí
		SEQUENCE => PRIMARY KEY : Áßº¹ÀÌ ¾ø´Â µ¥ÀÌÅÍ
*/
/*
CREATE SEQUENCE my_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;
*/
/*
SELECT my_seq.nextval FROM DUAL;
DROP SEQUENCE my_seq;
*/
/*
	3Àå
	 DQL / DML / DDL
	 DQL : µ¥ÀÌÅÍ °Ë»ö => SELECT
	 1) SELECTÀÇ Çü½Ä , ¼ø¼­
		** SELECT¹®Àå => ÄÃ·³ ´ë½Å , Å×ÀÌºí ´ë½Å , Á¶°Ç °ª
										| ÀÏ¹Ý ¼­ºê Äõ¸®
								| ÀÎ¶óÀÎºä
						| ½ºÄ®¶ó ¼­ºêÄõ¸®
		SELECT * | column_list
		FROM table_name | SELECT ~ | view_name
		[
			WHERE Á¶°Ç¹® (¿¬»êÀÚ)
			GROUP BY ±×·ìÄÃ·³|ÇÔ¼ö => ±×·ìº° Åë°è => °ü¸®ÀÚ ÆäÀÌÁö
			HAVING ±×·ì Á¶°Ç
			ORDER BY ÄÃ·³|ÇÔ¼ö (ASC|DESC)
		]

		=> ¼ø¼­
		FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

		¿¬»êÀÚ
		  »ê¼ú ¿¬»êÀÚ => SELECT µÚ¿¡
				   | +´Â µ¡¼À¸¸ °¡´É => ¹®ÀÚ¿­ °áÇÕ ||
				   | /´Â Á¤¼ö/Á¤¼ö = ½Ç¼ö
				   | %´Â »ç¿ëÇÏÁö ¾Ê´Â´Ù (MOD())
		  ºñ±³¿¬»êÀÚ => = , <>(!=) < , .....
		  ³í¸®¿¬»êÀÚ => AND , OR
					( || => ¹®ÀÚ¿­ °áÇÕ , & => ÀÔ·Â°ª )
		   BETWEEN ~ AND : ±â°£ => ¹üÀ§¸¦ Æ÷ÇÔ
						ÆäÀÌÂ¡ ±â¹ý
		   IN : OR°¡ ¿©·¯°³ÀÎ °æ¿ì
			WHERE deptno=10 OR deptno=20 OR deptno=30
			WHERE deptno IN(10,20,30)
			=> ´ÙÁß Á¶°Ç°ªÀÌ ÀÖ´Â °æ¿ì => ÇÊÅÍ
		  NOT : ºÎÁ¤
			NOT IN() , NOT BETWEEN , NOT LIKE ....
		  LIKE : °Ë»ö
			% : ¹®ÀÚ ±æÀÌ¸¦ ¸ð¸£´Â °æ¿ì
			 _  : ¹®ÀÚ ÇÑ ±ÛÀÚ
			startsWith : A%
		 	endsWith : %T
			contains : %T% => °¡Àå ¸¹ÀÌ »ç¿ë
		  => ÃÖ½Å
			REGEXP_LIKE() => º¹ÀâÇÑ LIKE [°¡-ÆR]
				startsWith => ^[A]
				endsWith => [A]$
				contains => [A]
		------------------------------------------------------------------
		³»ÀåÇÔ¼ö
		Å×ÀÌºí Á¤¸®
		DML
		  INSERT 
			INSERT INTO table_name VALUES(°ª...)
			INSERT INTO table_name(ÄÃ·³,ÄÃ·³) VALUES(°ª...)
		  UPDATE
			UPDATE table_name
			SET ÄÃ·³¸í=°ª,ÄÃ·³¸í=°ª
			[WHERE Á¶°Ç¹®]
		  DELETE
			DELETE FROM table_name
			[WHERE Á¶°Ç¹®]
*/
/*
-- A B C D E 
SELECT ename 
FROM emp
WHERE ename LIKE '%A%' OR
	ename LIKE '%B%' OR
	ename LIKE '%C%' OR
	ename LIKE '%D%' OR
	ename LIKE '%E%';
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'A|B|C|D|E');
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'A-E');
*/
/*
INSERT INTO emp VALUES(8000,'È«±æµ¿','´ë¸®',7788,SYSDATE,2500,0,10);
COMMIT;
*/
/*
SELECT *
FROM emp
WHERE REGEXP_LIKE(ename,'[°¡-ÆR]');
*/
/*
INSERT INTO emp VALUES(8001,'ABCÈ«±æµ¿','´ë¸®',7788,SYSDATE,2500,0,10);
INSERT INTO emp VALUES(8002,'È«±æµ¿ABC','´ë¸®',7788,SYSDATE,2500,0,10);
COMMIT;
*/
/*
SELECT *
FROM emp
WHERE REGEXP_LIKE(ename,'[°¡-ÆR]$');
*/

delete from emp
where empno>=8000;
commit;

