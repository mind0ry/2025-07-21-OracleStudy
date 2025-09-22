-- SEQUENCE : �ڵ� ���� ��ȣ
/*
	����Ŭ������ ��ü
		=> TABLE / SEQUENCE / VIEW / INDEX
		=> CREATE / DROP
	=> START WITH --> �ð���ȣ
		INCREMENT BY --> ����
		NOCACHE : CACHE --> �̸� ���� (20������)
		NOCYCLE : CYCLE --> ó�� �ٽ� ����
		1,2,3,4,6 .....
		=> �ʱ�ȭ : SEQUENCE ���� => �ٽ� ����

		=> currval / nextval
				=> ���� ��
			=> ���� ��
		INSERT INTO student VALUES(my_seq.nextval....)

	���̺� ����
		���̺�
		SEQUENCE => PRIMARY KEY : �ߺ��� ���� ������
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
	3��
	 DQL / DML / DDL
	 DQL : ������ �˻� => SELECT
	 1) SELECT�� ���� , ����
		** SELECT���� => �÷� ��� , ���̺� ��� , ���� ��
										| �Ϲ� ���� ����
								| �ζ��κ�
						| ��Į�� ��������
		SELECT * | column_list
		FROM table_name | SELECT ~ | view_name
		[
			WHERE ���ǹ� (������)
			GROUP BY �׷��÷�|�Լ� => �׷캰 ��� => ������ ������
			HAVING �׷� ����
			ORDER BY �÷�|�Լ� (ASC|DESC)
		]

		=> ����
		FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

		������
		  ��� ������ => SELECT �ڿ�
				   | +�� ������ ���� => ���ڿ� ���� ||
				   | /�� ����/���� = �Ǽ�
				   | %�� ������� �ʴ´� (MOD())
		  �񱳿����� => = , <>(!=) < , .....
		  �������� => AND , OR
					( || => ���ڿ� ���� , & => �Է°� )
		   BETWEEN ~ AND : �Ⱓ => ������ ����
						����¡ ���
		   IN : OR�� �������� ���
			WHERE deptno=10 OR deptno=20 OR deptno=30
			WHERE deptno IN(10,20,30)
			=> ���� ���ǰ��� �ִ� ��� => ����
		  NOT : ����
			NOT IN() , NOT BETWEEN , NOT LIKE ....
		  LIKE : �˻�
			% : ���� ���̸� �𸣴� ���
			 _  : ���� �� ����
			startsWith : A%
		 	endsWith : %T
			contains : %T% => ���� ���� ���
		  => �ֽ�
			REGEXP_LIKE() => ������ LIKE [��-�R]
				startsWith => ^[A]
				endsWith => [A]$
				contains => [A]
		------------------------------------------------------------------
		�����Լ�
		���̺� ����
		DML
		  INSERT 
			INSERT INTO table_name VALUES(��...)
			INSERT INTO table_name(�÷�,�÷�) VALUES(��...)
		  UPDATE
			UPDATE table_name
			SET �÷���=��,�÷���=��
			[WHERE ���ǹ�]
		  DELETE
			DELETE FROM table_name
			[WHERE ���ǹ�]
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
INSERT INTO emp VALUES(8000,'ȫ�浿','�븮',7788,SYSDATE,2500,0,10);
COMMIT;
*/
/*
SELECT *
FROM emp
WHERE REGEXP_LIKE(ename,'[��-�R]');
*/
/*
INSERT INTO emp VALUES(8001,'ABCȫ�浿','�븮',7788,SYSDATE,2500,0,10);
INSERT INTO emp VALUES(8002,'ȫ�浿ABC','�븮',7788,SYSDATE,2500,0,10);
COMMIT;
*/
/*
SELECT *
FROM emp
WHERE REGEXP_LIKE(ename,'[��-�R]$');
*/

delete from emp
where empno>=8000;
commit;

