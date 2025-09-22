/*
	교재
	 book : 책
	  bookid / bookname / publisher / price
	 customer : 회원
	  custid / name / address / phone
	 orders : 구매 테이블
	  orderid / custid / bookid / saleprice / orderdate
	  
*/
-- 책중에 가장 비싼 책
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price) FROM book);
-- MAX 값을 가지고 와서 => price => WHERE => SELECT
-- FROM - WHERE - SELECT 서브쿼리 => 메인 쿼리
-- 도서를 구매한 적이 없는 고객의 이름 출력
SELECT name
FROM customer
WHERE custid NOT IN(SELECT DISTINCT custid FROM orders);

SELECT name
FROM (
	SELECT customer.name,COUNT(orders.orderid) AS order_cnt
	FROM customer
	JOIN orders ON customer.custid=orders.custid
	GROUP BY customer.name
	ORDER BY order_cnt DESC
)
WHERE rownum=1;

SELECT c.name,COUNT(o.orderid) AS order_cnt
FROM customer c JOIN orders o
ON c.custid=o.custid
GROUP BY c.custid , c.name
HAVING COUNT(o.orderid) >= ALL(
	SELECT COUNT(o2.orderid)
	FROM orders o2
	GROUP BY o2.custid
);
--------------------- SELECT (DQL)