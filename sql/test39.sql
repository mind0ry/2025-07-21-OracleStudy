-- 6�� / 7�� => �����ͺ��̽� ����
/*
	6�� => �䱸���� �м� / ER-Model
	7�� => ����ȭ
	8�� => Ʈ�����
	---------------------- SQL Ʃ�� (SQL������ ����ȭ)
				   ----------- INDEX�� ���� ���
	page 313
	1) �����ͺ��̽� �𵨸�
	    => ������Ʈ�� �ʿ��� �����͸� ����ȭ�Ͽ� DB�� ���� => ����
	    => ����
		   1) ������ ���Ἲ : PRIMARY KEY
		   2) ������ �ϰ��� 
		   3) ȿ������ ��ȸ 
	    => ���� ������� ����Ʈ�� ��� : ��ġ��ŷ ==> ���� �����͸� ����
	    => � ��� / ���� => ���̺� ����
			| ERD				| ��Ű��
	    => ������ �� : �Ӽ�(�÷�)�� ���� ����
	    => ���� �� : ����ȭ => ��ü��
	    => ������ �� : �ε��� , Ű ���� => ��Ƽ�� / �ε��� => ���� �ִ�ȭ 
	    => �䱸���� �м� / �����ͺ��̽� ���� : DBA
	2) �����ͺ��̽� �����ֱ� 
	    �䱸���� �м�
		|
	      ��ġ��ŷ => ������ ���� / �м�
	        |
	      ����
	        |
	      ���� => �� ������
	    	|
	      ����Ʈ ȣ���� : ���� => AWS => CI/CD (��� : SE)
		|
	      �������� (���� / ����)
*/
/*
	1 �ܰ�
	   �䱸���� �м�
	   = ���� : � �����͸� �ٷ��� / ����Ʈ ���� Ȯ�� 
							| ��� => ���� ���	
	   = ���
		��ġ��ŷ / ������ ������ ���� 
	   = ����� (���⹰)
		��� / ���� / ���̺� ����
	   = ��)
		���θ� => ���ξ�ü , ����� , ���� / ��ٱ���
	   -----------------------------------------------------------
	   1) ������ ����
		= �÷� ���� (������ ����) => ���赵
		   ----------------------------------------
		   ����� ----- ��ٱ��� ----- ���ξ�ü
			      1:N 		  N:M
			1:1 / 1:N / N:M
		   ----------------------------------------
		= �����
			=> member(ID,PWD,Name,sex,address,phone)
				ERD
					member : �簢��
					   |
				--------------------------------
				|    |    |    |    |    |    |    |    |
			       ID PWD --------------------------> Ÿ����
			=> ERD �ܼ�ȭ
				����� ----> ��ٱ��� <---- ���ξ�ü
 	    2) ���� ����
		: ���̺� ���� / ����ȭ ����
		  -------
		  ȸ��(ID(PK),���,�̸�....)
		  ��ǰ����(��ǰ��ȣ(PK), ��ǰ�� , �̹���....)
		  ��ٱ���(��ȣ(PK), ID(FK) , ��ǰ��ȣ(FK), ����,�ݾ�)
		  => ���赵 : 1:1 / 1:N / N:M
		  => �⺻Ű / �ܷ�Ű ����
		  => ����ȭ 
			1 => ���ڰ� �켱	��� : ���,����.. => ��̸� �ٸ� ���̺� ����
			2 => �ߺ� ����
			3 => �Ѱ��� �÷����� row�� ����
	    3) ������ ����
		=> ���������� ��� (VARCHAR2 , NUMBER, DATE...)
		=> �ε��� ����
		=> �������� (PK,CK,UK,FK...NN) 
		=> SQL��ũ��Ʈ ����  : .sql , .csv
		=> DDL�� �̿��Ѵ�
	    -------------------------------------------------------------------
	    1. �䱸���� �м�
		���� ����Ʈ / ���θ� / ���� ����
		| ��� / ���Ϲ���
		-------------------
		 1) ����
		 2) ��
		 3) �䱸���� ����
		    = ���
			**����� ����
			   = **ȸ������ , �Ҽ� �α��� (īī�� , ���̹� , ����...)
			   = **����������
			      ------------- **������ (���� , Ż��) , ���� / ����
			���� ������
			   = ��Ʈ���� (��Ʃ�� => Ű) , �ٿ�ε� , �������
			   = **�ٹ� , �� , ����
			   = **���  
			�˻�
			   = ���հ˻� : ���͸� => MyBatis ���� ����
			   = ī�װ��� �˻� / ��õ 
							----- ����� ����
				=> �Ұ�
			����ȭ ��õ
				���ƿ� / �� / ��Ʈ
			�ΰ��� ������
				���� ���� , �Ű���
			��Ƽ�÷��� 
				����� / �� ����
			���� / ����
			------------- OPEN API
		    = ����
			���� : SQL ����ȭ (Ʃ��) => �̹��� (����)
			SELECT * 
			FROM emp
			WHERE sal>2000;
			1) ��ü ��ĵ 
			2) �÷��� ������ �ӵ� => ��¿� �ʿ��� ���븸
			    SELECT empno,ename,job
			    FROM emp
			    WHERE sal>=2000;
			3) �ε���
			    CREATE INDEX sal_idx ON emp(sal)
			SELECT ename,hiredate
			FROM emp
			WHERE hiredate >= '81/01/01'
				   --------------------------
						TO_DATE(hiredate,'YY/MM/DD')
			�����ͺ��̽� ���� vs ��ü ���� ���� (SOLID)

			���� : JSP => ��й�ȣ ��ȣȭ / ��ȣȭ
				Spring Security : ���� / ��ȣȭ ....
				-----------------
				=> JWT / Settion
				     ----- ����
			Ȯ�强 : ���Ϲ��� = ���
				    ��) ��ȭ ���� => �װ��� ����
			ȣȯ�� : ũ�� = FF = IE
				    ����� ȣȯ : ������ ��
			--------------------------------------------------
		    => �䱸���� ����
			ID      ���       ����        ����						����
			FR-01 �α���     ���        īī��,���� �������� �α��� ����     	   ��
			FR-02 ���հ˻�  ���	     ����/���/�ٹ�				   ��
			NFR-01 ����ӵ� ����     2�� ���� ó�� (������ ���� �ӵ�) 	   ��
			------------------------------------------------------------------------------
			���� : ���������� / ������ ������
			   *** �Ϲ� ����� 
			   ������ : ���� ���� / ���� ���ϱ� / ȸ�� ���� / ��� ����
			-------------------------------------------
			  => �������̽� ���̾�׷�
			  => ���̾������� (ȭ�� UI) 
			  => ERD
			----------------------------------------------------------------------
			��� : �޴� / ��ư
				-------------
			������ : ȭ�� (�󼼺���)
			----------------------------------------------------------------------
			�⺻
			   �ó�����
				= �α��� / ȸ���������� ����
				= ��� �� �� �ִ�
				= �˻��� ����
				= ����� Ŭ���ϸ� �󼼺��� => ������ ���
			   ������ ���� (������ ����)
				���Ϲ���
					����
					����
					�̹���
					���
					������
					�ٹ�
					����
					������ key
				--------------------------
			   ���� ����	
				���Ϲ���(����(PK),����(CK),�̹���,���,������,�ٹ�,����,KEY)
					     ---------------------------------------------------- -----
						=> ���Ϲ���						��Ʃ��
			   ������ ����
			   -------------- ũ�� ���� => ���̺��� ����
			   ER-Model
			   �����
				|- ID
				|- PWD
				|- NAME
		
			   ����
				|- ����
				|- ���

			   ���赵
				����� ------- ����
					   1:N
				����� ------- �Խ���
					   1:N
				-------------------------- 1:N / 1:1 / N:M
			   => �������� ����
				 	���� ==> NUMBER
					���� ==> �ϰ� , ���� , �ϰ� => CHAR(6)
					�̹��� ==> 260
					��� ==> 200
					������ ==> 100
					�ٹ� ==> 200
					���� ==> NUMBER
					������ key ==> 100
				=> �帣�� �з�
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
   CONSTRAINT gm_state_ck CHECK(state IN('����','���','�ϰ�'))
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
   CONSTRAINT mm_state_ck CHECK(state IN('����','���','�϶�'))
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

Ŀ�Ǻ� (������ ����)
��ǰ la a
	��ǰ�� p.txt_box span.name
	������� p.txt_box span.num
	���� p.text_box span.price
	�̹���  p.photo img

	


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

