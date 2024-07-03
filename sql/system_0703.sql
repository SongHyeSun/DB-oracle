-----------------------------------------------
---   �����ͺ��̽� ����
-- 1. ���� ����� ȯ��(multi-user environment)
---  1) ����ڴ� �ڽ��� ������ ��ü�� ���� �������� ������ �����Ϳ� ���� �����̳� ��ȸ ����
---  2) �ٸ� ����ڰ� ������ ��ü�� �����ڷκ��� ���� ������ �ο����� �ʴ� ���� �Ұ�
---  3) ���� ����� ȯ�濡���� �����ͺ��̽� �������� ��ȣ�� ö���ϰ� ����
---2. �߾� �������� ������ ����
---3. �ý��� ����
---  1) �����ͺ��̽� �����ڴ� ����� ����, ��ȣ ����, ����ں� ��� ������ ��ũ���� �Ҵ�
---  2) �ý��� ���� �������� �����ͺ��̽� ��ü�� ���� ���� ������ ����
---4. ������ ����
---  1) ����ں��� ��ü�� �����ϱ� ���� ���� ����
---  2) �����ͺ��̽� ��ü�� ���� ���� ������ ����
-----------------------------------------------
----------------------------------------------------------------------
---����(Privilege) �ο�
---1. ���� : ����ڰ� �����ͺ��̽� �ý����� �����ϰų� ��ü�� �̿��� �� �ִ� �Ǹ�
---2. ���� 
--- 1) �ý��� ���� : �ý��� ������ �ڿ� ������ ����� ��Ű�� ��ü ���� ��� ���� 
---                 �����ͺ��̽� ���� �۾��� �� �� �ִ� ����
---  [1]  �����ͺ��̽� �����ڰ� ������ �ý��� ����
---       CREATE USER     :  ����ڸ� ������ �� �ִ� ����
---       DROP    USER     : ����ڸ� ������ �� �ִ� ����
---       DROP ANY TABLE : ������ ���̺��� ������ �� �ִ� ����
---       QUERY REWRITE  : �Լ� ��� �ε����� �����ϱ� ���� ����
---  [2]  �Ϲݻ���ڰ� ������ �ý��� ����
---       CREATE SESSION      : DB�� ������ �� �ִ� ����
---       CREATE TABLE          : ����� ��Ű������ ���̺��� ������ �� �ִ� ����
---       CREATE SEQUENCE   : ����� ��Ű������ �������� ������ �� �ִ� ����
---       CREATE VIEW            : ����� ��Ű������ �並 ������ �� �ִ� ����
---       CREATE PROCEDURE : ����� ��Ű������ ���ν���, �Լ�, ��Ű���� ������ �� �ִ� ����
--- 2) ��ü ����    : ���̺�, ��, ������, �Լ� ��� ���� ��ü�� ������ �� �ִ� ����
----------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---��(role)
---1. ���� : �ټ� ����ڿ� �پ��� ������ ȿ�������� �����ϱ� ���Ͽ� ���� ���õ� ������ �׷�ȭ�� ����
---          �Ϲ� ����ڰ� �����ͺ��̽��� �̿��ϱ� ���� �������� ����
--          (�����ͺ��̽� ���ӱ���, ���̺� ����, ����, ����, ��ȸ ����, �� ���� ����)�� �׷�ȭ
--          ������ ���ǵ� ��
--2. CONNECT ��
-- 1) ����ڰ� �����ͺ��̽��� �����Ͽ� ������ ������ �� �ִ� ����
-- 2) ���̺� �Ǵ� ��� ���� ��ü�� ������ �� �ִ� ����
--3. RESOURCE ��
-- 1) ����ڿ��� �ڽ��� ���̺�, ������, ���ν���, Ʈ���� ��ü ���� �� �� �ִ� ����
-- 2) ����� ������ : CONNECT �Ѱ� RESOURCE ���� �ο�
--4.  DBA ��
-- 1) �ý��� �ڿ��� ���������� ����̳� �ý��� ������ �ʿ��� ��� ����
-- 2) DBA ������ �ٸ� ������� �ο��� �� ����
-- 3) ��� ����� ������ CONNECT, RESOURCE, DBA ������ ������ ��� ������ �ο� �� öȸ ����

---------------------------------------------------------------------------------------------
-----------------------------------------------
---   Admin ����� ���� /���� �ο�
------------------------------------------------
-- 1-1. USER ����
CREATE USER usertest01 IDENTIFIED BY tiger;
-- 1-2. USER ����
CREATE USER usertest02 IDENTIFIED BY tiger;
-- 1-3. USER ����
CREATE USER usertest03 IDENTIFIED BY tiger;
-- 1-4. USER ����
CREATE USER usertest04 IDENTIFIED BY tiger;

-- 2-1. session ���� �ο�  --> ���� ���Ѹ� �־���
GRANT CREATE session to usertest01;
-- 2-1. session ���� �ο� --> ���� ����, table ����, view ����
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO usertest02;

-- 2-2. ���忡�� DBA��  ������ ���� �ο� (connect�� resource�� �־�� �Ѵ�.)
GRANT CONNECT, RESOURCE TO usertest03;
-- 2-3. ���� �ο��� ȸ��
GRANT DBA TO usertest04;    --���߿� sysnonym ���� �ֱ� ����
--DBA ���� ȸ��
REVOKE DBA FROM usertest04;
GRANT CONNECT, RESOURCE to usertest04;

SELECT * FROM scott.emp;

----------------------------------------------------------------------------------------------------
-- ���Ǿ�(synonym)
-- 1. ���� : �ϳ��� ��ü�� ���� �ٸ� �̸��� �����ϴ� ���
--      ���Ǿ�� ����(Alias) ������
--      ���Ǿ�� �����ͺ��̽� ��ü���� ���
--      ������ �ش� SQL ���ɹ������� ���
-- 2. ���Ǿ��� ����
--   1) ���� ���Ǿ�(private synonym) 
--      ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ���
--
--   2) ���� ���Ǿ�(public sysnonym)
--      ������ �ִ� ����ڰ� ������ ���Ǿ�� ������ ���
--      DBA ������ ���� ����ڸ� ���� (�� : ������ ��ųʸ�)
 
-------------------------------------------------------------------------------------------------
--���� ���Ǿ�(public sysnonym)
CREATE TABLE systemTBL(
    memo VARCHAR2(50)
);
INSERT INTO systemTBL VALUES('7�� Ǫ��');
INSERT INTO systemTBL VALUES('��� ��������');

--���� ������ ��ȸ ����
SELECT * FROM systemTBL;
--���� work) system �� �ִ� systemTBL�� READ ���� usertest04���� �ּ���
GRANT SELECT ON system.systemTBL TO usertest04 WITH GRANT OPTION;

-- ���� �ο� ������ ���ŷο�
CREATE PUBLIC SYNONYM pub_system FOR systemTBL;
--DROP PUBLIC SYNONYM synonym��;
DROP PUBLIC SYNONYM pub_system;

--�ǹ�����
CREATE PUBLIC SYNONYM systemTBL FOR systemTBL;

--���� ���Ǿ�(private synonym)
CREATE TABLE privateTBL(
    memo VARCHAR2(50)
);
INSERT INTO privateTBL VALUES('���� ��¥ Ȳ����');
INSERT INTO privateTBL VALUES('�� �̻����� ���ܹ�><');

--systemt�� �ִ� privateTBL Read ���� usertest04 �ּ���
GRANT SELECT ON system.privateTBL TO usertest04 WITH GRANT OPTION;
GRANT SELECT ON system.privateTBL TO scott WITH GRANT OPTION;