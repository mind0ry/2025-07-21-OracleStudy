-- Ʈ���� : PL/SQL => Function / Procedure / Trigger
/*
	Ʈ���� : Ư�� �̺�Ʈ (INSERT / UPDATE / DELETE)�� �߻����� ��쿡 �ڵ� ���� ���ν���
	Ư¡ : ���̺� / �信�� ����
		 �̺�Ʈ�� �߻��ϸ� �ڵ�ȣ��
	   	  INSERT / UPDATE / DELETE������ ����� ����
		  �α����� / ����ÿ� �ַ� ���
		  �԰� => ��� �ڵ�ȭ / ��� => ��� �ڵ�ȭ
		   ***���� => �� => �򰳼� ����
				  ---- ���� ��ȣ => Function �̿� 
		   ***���ν��� : ��� (������Ʈ)
	����)
		CREATE [OR REPLACE] TRIGGER tri_name
		{BEFORE|AFTER} {�̺�Ʈ:INSERT | UPDATE | DELETE} ON � ���̺�
		��� ROW�� ����
		{FOR EACH ROW}
		BEGIN
		  Ʈ���� ���� ���� => �԰�
						-----
						���� ��ǰ ==> UPDATE
						������ ��ǰ ==> INSERT
						���
						-----
						=> ������ 0�̸� => DELETE
						=> UPDATE
		END;
		-------------------------------------------------------------------
		���� : ���� Ʈ���� ó��
		BEFORE : DML ���� ���� ���� => �߻��� ���̺� �������� TRIGGER����
		AFTER : DML���� �Ŀ� ���� => �߻��� ���̺� �����Ŀ� TRIGGER����
	
	  	����� / �� ����
		���ึ�� ���� : FOR EACH ROW (default)
		SQL�� ��ü�� �ѹ��� ���� : ����

		�÷�
		 ���� ������ �� => :NEW.�÷� (INSERT / UPDATE)
		 ������ �ִ� �� => :OLD.�÷� (UPDATE / DELETE)
		��)
			�԰� (��ǰ��ȣ , ���� , �ܰ�)
			=> INSERT INTO �԰� VALUES(1,5,1500)
								   --------- ���ο� ��
				:NEW.����
*/
-- emp
/*
CREATE TABLE emp_trg
AS
   SELECT empno,ename,sal,deptno 
   FROM emp;
*/
/*
ALTER TABLE emp_trg ADD CONSTRAINT et_empno_pk PRIMARY KEY(empno);
-- �α� ���̺�
CREATE TABLE emp_log(
   log_id NUMBER,
   empno NUMBER,
   action VARCHAR2(20),
   log_date DATE DEFAULT SYSDATE,
   CONSTRAINT el_id_pk PRIMARY KEY(log_id),
   CONSTRAINT el_empno_fk FOREIGN KEY(empno)
   REFERENCES emp_trg(empno)
);
CREATE SEQUENCE el_id_seq
   START WITH 1
   INCREMENT BY 1
   NOCYCLE
   NOCACHE;
*/
-- Ʈ���Ŵ� �ڵ����� COMMIT => COMMIT�� ����ϸ� ���� �߻�
/*
CREATE OR REPLACE TRIGGER log_insert
AFTER INSERT ON emp_trg
FOR EACH ROW
BEGIN
   INSERT INTO emp_log VALUES(el_id_seq.nextval,:NEW.empno,
   'INSERT',SYSDATE);
END; 
/
INSERT INTO emp_trg VALUES((SELECT NVL(MAX(empno)+1,1) FROM  emp_trg),
   'ȫ�浿',3000,10);
COMMIT;
SELECT * FROM emp_trg;
*/
-- UPDATE 
-- ��ȿ�� �˻� -- SQL���� �˻� , ������ �߰� (���Ἲ üũ)
/*
CREATE OR REPLACE TRIGGER trg_update
BEFORE UPDATE OF sal ON emp_trg
FOR EACH ROW
BEGIN
   IF :NEW.sal > :OLD.sal * 2 THEN
      RAISE_APPLICATION_ERROR(-21000,'�޿��� ������ 2�踦 ���� �� ����');
   END IF;
END;
/
UPDATE emp_trg SET
sal=7000
WHERE empno=7935;
*/
/*
CREATE TABLE emp_backup
AS
  SELECT * FROM emp_trg;
*/
/*
CREATE OR REPLACE TRIGGER tri_backup
BEFORE DELETE ON emp_trg
FOR EACH ROW -- ��ü �߰�
BEGIN
   INSERT INTO emp_backup(empno,ename,sal,deptno)
   VALUES(:OLD.empno,:OLD.ename,:OLD.sal,:OLD.deptno);
END;
/
DELETE FROM emp_log
WHERE empno=7935;
DELETE FROM emp_trg
WHERE empno=7935;
SELECT * FROM emp_trg;
SELECT * FROM emp_backup;
*/
-- ������ (BEFORE DELETE) => �������� ���� �����͸� ���� (:OLD)
DROP TRIGGER tri_backup;
DROP TRIGGER trg_update;
DROP TRIGGER log_insert;
DROP TABLE emp_log;
DROP TABLE emp_backup;
DROP TABLE emp_trg;