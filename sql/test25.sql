-- �ó�� => ���Ǿ� => ���̺�� ���� => ���θ� / ��� �����
/*
	CREATE �ó��
	CREATE PUBLIC �ó��
	=> ������ ������ ���� (hr)
	=> SYNONYM => ���̺� / �� / ������ / �Լ� ... ��Ī
	���� : ���̺� / �� / ������ / �Լ� => ��Ī�� �� ��쵵 �ִ�
		=> ����ų� / ª�� ���� ���
	Ư¡ 
		��Ī ���� , ���� / �۷ι� (��� �����)
		���� �ο��� �ʿ� : SYSTEM / SYSDBA 
		DCL => GRANT / REVOKE
				���� 	���� ����
		=> GRANT CREATE SYNONYM TO hr
			 GRANT CREATE VIEW TO hr
		=> REVOKE CREATE SYNONYM FROM hr
		***
*/
/*
CREATE VIEW emp_view
AS 
	SELECT * FROM emp;
*/
-- local : ���� �����
--CREATE SYNONYM emp_as FOR emp;
-- ��� �����
/*
CREATE PUBLIC SYNONYM emp_pub FOR emp;
DROP SYNONYM emp_as;
DROP PUBLIC SYNONYM emp_pub;
*/
/*
	1. �ٸ� ����� ���̺��� ���ϰ� ������ ����
	hr_1 / hr_2 / hr_3
	2. ���̺� �̸� ���� => SYNONYM�� �����ϸ� �ڵ� ���� �ּ�ȭ
					�������� ����
	3. ���� ���� => ������ : PUBLIC ��������
*/