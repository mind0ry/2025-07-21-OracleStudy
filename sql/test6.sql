-- ���� => ORDER BY => �ӵ��� �ʴ� (��ü : INDEX)
-- INDEX�� �ӵ��� �ʴ� ��� : �߰� , ���� , ������ ���� ��� => �Խ���
/*
	ORDER BY�� SQL������ �������� ÷��
	ORDER BY �÷���(�Լ�) ASC|DESC
*/
-- emp�� �ִ� ��� ��� => �޿��� ���� ���� (���� , ���� , ��¥)
SELECT *
FROM emp
ORDER BY sal DESC;

SELECT *
FROM emp
ORDER BY sal;

SELECT empno,ename,hiredate,sal
FROM emp
ORDER BY 4,1 DESC;

-- �̸� ���� => �ø�����
SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY hiredate;

-- �����Լ� : ����Ŭ�� �����ϴ� ���̺귯�� => SELECT , WHERE
/*
	������ �Լ�
		���� ���� �Լ�
			***1) UPPER => �빮�� ��ȯ
			2) LOWER => �ҹ��� ��ȯ
			3) INITCAP => �̴ϼ� => ù�ڸ� �빮��
			***4) SUBSTR => ���� �ڸ���
			5) INSTR => ���� ã��
			6) LPAD / ***RPAD => ���ڰ� ���ڶ�� ��쿡 ���� ��ü
				RPAD('abcde',10'*') abcde*****
			7) LTRIM / RTRIM / TRIM
			***8) LENGTH
			***9) REPLACE : ���� => &����
			10)ASCII : char�� ���� ����
			11) CHAR => ���� => char
			12) LENGTHB => byte����
		���� ���� �Լ�
		��¥ ���� �Լ�
		��ȯ ���� �Լ�
		��Ÿ 
	���� �Լ� : ���
*/
/*
-- UPPER('abc') = ABC / LOWER('ABC') = abc / INITCAP('ABC') = Abc
SELECT ename,UPPER(ename),LOWER(ename),INITCAP(ename)
FROM emp;

SELECT *
FROM emp
WHERE ename=UPPER('king');

-- LENGTH('ABC') = 3 LENGTH('ȫ�浿') = 3 
-- LENGTHB('ABC') = 3 LENGTHB('ȫ�浿') = 9
SELECT LENGTH('ABC') , LENGTH('ȫ�浿') FROM DUAL;
SELECT LENGTHB('ABC') , LENGTHB('ȫ�浿') FROM DUAL;
*/
/*
	SUBSTR => ���ڿ� �ڸ���
	����Ŭ ���ڿ�
	 Hello Oracle
	 123456789...
	SUBSTR(���ڿ�,������ġ,����)
	��� �Ի��� => ����� �Ի��ߴ���
	YY/MM/DD
	1234 5 6 78
*/
SELECT ename,SUBSTR(hiredate,7,2)
FROM emp;
/*
	INSTR => indexOf / lastIndexOf => ������ġ ã��
	INSTR(���ڿ� , ã�� ���� , ������ġ , ���°)
	Hello
*/
SELECT INSTR('Hello','l',1,2) FROM DUAL;
/*
	LPAD / RPAD
	L=Left , R=Right

	LPAD(���ڿ�,���ڰ���,��ü����)
	LPAD('Hello',8,'#')
		 ------	###Hello
	LPAD('Hello',3,'*')
		 ------	Hel

	RPAD(���ڿ�,���ڰ���,��ü����)
	RPAD('Hello',8,'#')
		 ------	Hello###
	RPAD('Hello',3,'*')
		 ------	Hel
*/
SELECT RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*')
FROM emp;

-- ASCII => ASCII('A') ==> 65 , CHR(65) => 'A'
SELECT ASCII('K') , CHR(68) FROM DUAL;

/*
	TRIM : �¿� ���� ����
	LTRIM : ���� ���� ����
	RTRIM : ������ ���� ����
	LTRIM('ABCDA','A') => BCDA
	RTRIM('ABCDA','A') => ABCD
	LTRM('ABCD') => ���� ����
	TRIM('A' FROM 'ABCDA') BCD
	---------------------------------- �ڹ� trim

	����
		����ڷκ��� �����͸� �޾Ƽ� => �ڹ� (��������)  
		�����ͺ��̽� ���� ���� (����Ŭ ����)
	REPLACE(���ڿ�,'old','new')
	REPLACE('Oracle AND Java', 'a' , 'b') => Orbcle AND Jbvb
*/
SELECT LTRIM('ABCDA','A') , RTRIM('ABCDA','A') , TRIM('A' FROM 'ABCDA')
FROM DUAL;
SELECT REPLACE('Oracle AND Java', 'a' , 'b') FROM DUAL;
SELECT REPLACE('Oracle AND Java', 'Java' , 'Oracle') FROM DUAL;
-- &