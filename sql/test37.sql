-- Ʈ����
/*
CREATE TABLE ��ǰ(
   ǰ�� NUMBER,
   ��ǰ�� VARCHAR2(30),
   �ܰ� NUMBER
);
CREATE TABLE �԰�(
   ǰ�� NUMBER,
   ���� NUMBER,
   �ݾ� NUMBER
);
CREATE TABLE ���(
   ǰ�� NUMBER,
   ���� NUMBER,
   �ݾ� NUMBER
);
-- �ڵ�ȭ ó��
CREATE TABLE ���(
   ǰ�� NUMBER,
   ���� NUMBER,
   �ݾ� NUMBER,
   �����ݾ� NUMBER
);
*/

/*
	������
	 Ʈ���žȿ��� DML ����� �����ÿ� ���ѷ���
	 ������ SQL������ Ʈ���ź��� ���ν����� ����
	 Ʈ���Ŵ� ������� ��ƴ� (�׽�Ʈ�� ���� �ؾ� �ȴ�)
	 => Ű����
		INSERTING / UPDATING / DELETEING
							| DELETE ������ ������
					| UPDATE ������
			| INSERT ������ ������
		=> BOOLEAN 
	=> IF INSERTING THEN
	      ELSIF UPDATING THEN
	      ELSIF DELETING THEN
*/
-- �԰� : INSERT / UPDATE / DELETE
-- ��� : INSERT / UPDATE / DELETE
/*
CREATE TABLE emp_trg(
   empno NUMBER,
   ename VARCHAR2(30),
   sal NUMBER,
   deptno NUMBER
);
*/
SET SERVEROUTPUT ON;
/*
DROP TRIGGER tri_test;


CREATE OR REPLACE TRIGGER tri_test
AFTER INSERT OR UPDATE OR DELETE ON emp_trg
FOR EACH ROW
BEGIN
   IF INSERTING THEN 
	DBMS_OUTPUT.PUT_LINE('INSERT �߻�:'||:NEW.ename);
   ELSIF UPDATING THEN 
	DBMS_OUTPUT.PUT_LINE('UPDATE �߻�:'||:OLD.ename||' '||:NEW.ename);
   ELSIF DELETING THEN 
	DBMS_OUTPUT.PUT_LINE('DELETE �߻�:'||:OLD.ename);
   END IF;
END;
/
*/
/*
	INSERT => NEW
	UPDATE => OLD , NEW
	DELETE => OLD

*/
/*
INSERT INTO emp_trg VALUES(1,'ȫ�浿',3000,10);
COMMIT;
*/
/*
INSERT INTO ��ǰ VALUES(100,'�����',1500);
INSERT INTO ��ǰ VALUES(200,'���ڱ�',1000);
INSERT INTO ��ǰ VALUES(300,'������',2000);
INSERT INTO ��ǰ VALUES(400,'¯��',500);
INSERT INTO ��ǰ VALUES(500,'������',2500);
COMMIT;
*/
-- �԰� 
/*
drop TRIGGER input_trigger;
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON �԰�
FOR EACH ROW
DECLARE
   -- ���� ����
   v_cnt NUMBER:=0;
BEGIN
   SELECT COUNT(*) INTO v_cnt
   FROM ���
   WHERE ǰ��=:NEW.ǰ��;
   IF v_cnt=0 THEN -- ������ ��ǰ�� ���� ���
	INSERT INTO ��� VALUES(:NEW.ǰ��,:NEW.����,:NEW.�ݾ�,:NEW.����*:NEW.�ݾ�);
   ELSE -- ������ ��ǰ�� �ִ� ��� 
	UPDATE ��� SET
	����=����+:NEW.����,
	�����ݾ� =�����ݾ�+(:NEW.����*:NEW.�ݾ�)
	WHERE ǰ��=:NEW.ǰ��;
   END IF;
END;
/
*/
/*
INSERT INTO �԰� VALUES(100,3,1500);
COMMIT;
SELECT * FROM �԰�;
SELECT * FROM ���;
*/
/*
	�԰� === ���
		     ��ǰ ���� => ���� / ���� �ݾ� ���� => UPDATE
		     ��ǰ ������ => INSERT �߰�
	��� === ��� 
		     ��ǰ�� �
			0: DELETE
			>0 : UPDATE

*/
/*
CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON ���
FOR EACH ROW
DECLARE
  v_cnt NUMBER:=0;
BEGIN
  SELECT ���� INTO v_cnt
  FROM ���
  WHERE ǰ��=:NEW.ǰ��;
  IF :NEW.���� =v_cnt THEN
	DELETE FROM ���
	WHERE ǰ��=:NEW.ǰ��;
  ELSE
	UPDATE ��� SET
	����=����-:NEW.����,
	�����ݾ�=�����ݾ�-(:NEW.����*:NEW.�ݾ�)
	WHERE ǰ��=:NEW.ǰ��;
  END IF;
END;
/
*/
INSERT INTO ��� VALUES(100,1,1500);
COMMIT;