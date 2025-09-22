-- PL/SQL => ���ν����� ����� ���� ��� (SQL�� �̿��ؼ� ����)
-- �������� ���� = ������� �޴� ��� : �����͸� �̿��Ѵ�
/*
	IN => �Ϲ� ���԰� : INSERT / UPDATE / DELETE
	OUT => ������� �޴� ��쿡 ��� : SELECT
	INOUT => �Ϲ� ���԰�,����� ó�� : SELECT
	--------
	IN������ WHERE�ڿ� , OUT������ ���� �о� ���� ����
	*** ������ ���� IN ������ �ν�
	*** OUT => Call By Reference�� �̿��Ѵ�
	
	���ν����� �ַ� ���ó
	=> ��ġ �۾� : ���� , ��� , ������ �̵�
	=> ������ ���̱׷��̼� : ���̺� �����͸� ���� , �̰� ó��
	=> �������� SQL�� ����� �ʿ��� ���
	=> SQL������ ������ ��� : ERP (����)
		������ , �����
	1) ����
	2) ����
	3) Ʈ����� ó��
	����)
		CREATE [OR REPLACE] PROCEDURE pro_name(�Ű�����..)
		IS
		  ���� ����
		BEGIN
		  ���� : SELECT / INSERT / UPDATE / DELETE
		END;
		/

		** �Ű������� ���ؼ� ������� �޴´�
		(pNo NUMBER, pName OUT VARCHAR2...)
*/
-- ���� : IN
CREATE OR REPLACE PROCEDURE stdInsert(
  pName student.name%TYPE,
  pKor student.kor%TYPE,
  pEng student.eng%TYPE,
  pMath student.math%TYPE
)
IS
BEGIN
  INSERT INTO student VALUES(
	(SELECT NVL(MAX(hakbun)+1,1) FROM student),
	pName,pKor,pEng,pMath,SYSDATE
  );
COMMIT;
END;
/
-- ���� : IN
CREATE OR REPLACE PROCEDURE stdUpdate(
  pName student.name%TYPE,
  pKor student.kor%TYPE,
  pEng student.eng%TYPE,
  pMath student.math%TYPE,
  pHakbun student.hakbun%TYPE
)
IS
BEGIN
  UPDATE student SET
  name=pName,kor=pKor,eng=pEng,math=pMath
  WHERE hakbun=pHakbun;
COMMIT;
END;
/
-- �������� �˻�
-- ���� : IN
CREATE OR REPLACE PROCEDURE stdDelete(pHakbun student.hakbun%TYPE)
IS 
BEGIN
  DELETE FROM student
  WHERE hakbun=pHakbun;
  COMMIT;
END;
/
-- �˻� : OUT
CREATE OR REPLACE PROCEDURE stdFind(
  pName OUT student.name%TYPE,
  pKor OUT student.kor%TYPE,
  pEng OUT student.eng%TYPE,
  pMath OUT student.math%TYPE,
  pHakbun student.hakbun%TYPE
)
IS
BEGIN
  SELECT name,kor,eng,math
	INTO pName,pKor,pEng,pMath
  FROM student
  WHERE hakbun=pHakbun;
END;
/