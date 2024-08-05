-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : �ϳ� �̻��� �⺻ ���̺��̳� �ٸ� �並 �̿��Ͽ� �����Ǵ� ���� ���̺�
--        ��� �����͵�ųʸ� ���̺� �信 ���� ���Ǹ� ����
--       ���� : 1) ���� 
--             2) ��� ����ڰ� �ʱ� ������� SQL �ɷ��� cover
--       ���� : Performance(����)�� �� ����
CREATE OR REPLACE VIEW VIEW_PROFESSOR AS
SELECT profno, name, userid, position, hiredate, deptno
FROM professor
;
--��ȸ�ϴ� ���� professor�� �޾Ƽ� ��ü������ ����
SELECT * FROM VIEW_PROFESSOR ;

-- �������ǿ� �ɸ��� �ʴ´ٸ� �並 ���� �Է� ����
INSERT INTO view_professor VALUES(2000,'view','userid','position',sysdate,101)
;
--name�� �������� not null�� �ִµ� name�� �Է����� �ʾƼ� ����!
--cannot insert NULL into("SCOTT"."PROFESSOR"."NAME")
INSERT INTO view_professor(profno, userid, position, hiredate, deptno)
    VALUES(2001,'userid2','position2',sysdate,101);
    
-- ����work01) VIEW �̸� v_emp_sample  : emp(empno , ename , job, mgr,deptno)
CREATE OR REPLACE VIEW V_EMP_SAMPLE AS
SELECT empno, ename, job, mgr, deptno
FROM emp
;

INSERT INTO V_EMP_SAMPLE(empno , ename , job, mgr,deptno)
    VALUES(2001,'userid2','position2',7839,10);
    
--���� work2) ���� view / ���� v_emp_complex(emp+dept) -> insert �ȵ�!
CREATE OR REPLACE VIEW v_emp_complex AS
SELECT *
FROM emp NATURAL JOIN dept
;

INSERT INTO v_emp_complex(empno, ename)
        VALUES (1504,'ȫ�浿4')
;
--cannot modify more than one base table through a join view
INSERT INTO v_emp_complex(empno, ename, deptno)
        VALUES (1500,'ȫ�浿',20)
;
--��ü �� �ص� ��������� cannot modify more than one base table through a join view
INSERT INTO v_emp_complex(empno, ename, deptno, dname, loc)
        VALUES(1500,'ȫ�浿',77,'������','������')
;

--�Ϲ� oracle join���� ���� ����, insert �ȴ�.!
CREATE OR REPLACE VIEW v_emp_complex3 AS
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
;
--Insert OK (oracle join����!)
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1500,'ȫ�浿')
;
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1501,'ȫ�浿1')
;
INSERT INTO v_emp_complex3(empno, ename, deptno)
        VALUES (1502,'ȫ�浿2',20)
;
INSERT INTO v_emp_complex3(empno, ename, deptno, dname, loc)
        VALUES(1503,'ȫ�浿3',77,'������','������')
;
ROLLBACK;
--��ġ �ٲ㼭 �غ���
CREATE OR REPLACE VIEW v_emp_complex4 AS
SELECT d.deptno, d.dname, d.loc, e.empno, e.ename, e.job
FROM dept d, emp e
WHERE d.deptno = e.deptno
;
--Insert OK (oracle join����!)
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1601,'ȫ�浿1')
;
INSERT INTO v_emp_complex4(empno, ename, deptno)
        VALUES (1602,'ȫ�浿2',20)
;
INSERT INTO v_emp_complex4(empno, ename, deptno, dname, loc)
        VALUES(1603,'ȫ�浿3',77,'������','������')
;
ROLLBACK;
------------     View  HomeWork     ----------------------------------------------------
---��1)  �л� ���̺��� 101�� �а� �л����� �й�, �̸�, �а� ��ȣ�� ���ǵǴ� �ܼ� �並 ����
---     �� �� :  v_stud_dept101
CREATE OR REPLACE VIEW v_stud_dept101 AS
SELECT studno, name, deptno
FROM student
WHERE deptno=101
;
--��2) �л� ���̺�� �μ� ���̺��� �����Ͽ� 102�� �а� �л����� �й�, �̸�, �г�, �а� �̸����� ���ǵǴ� ���� �並 ����
--      �� �� :   v_stud_dept102
CREATE OR REPLACE VIEW v_stud_dept102 AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno=d.deptno
AND   s.deptno=102
;
--��3)  ���� ���̺��� �а��� ��� �޿���     �Ѱ�� ���ǵǴ� �並 ����
--  �� �� :  v_prof_avg_sal       Column �� :   avg_sal      sum_sal
CREATE OR REPLACE VIEW v_prof_avg_sal AS
SELECT deptno, AVG(sal) avg_sal, SUM(sal) sum_sal
FROM professor
GROUP BY deptno
;
--2. GROUP �Լ� COLUMN ��� �ȵ�
INSERT INTO v_prof_avg_sal
VALUES(203,600,300)
;
--VIEW ����
DROP VIEW v_stud_dept102;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
;
-------------------------------------
---- ������ ���ǹ�
-------------------------------------
-- 1. ������ ������ ���̽� ���� ������� 2���� ���̺� ����
-- 2. ������ ������ ���̽����� �����Ͱ��� �θ� ���踦 ǥ���� �� �ִ� Į���� �����Ͽ� 
--    �������� ���踦 ǥ��
-- 3. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ����(recursive relationship)
-- 4. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ��� ��� ����

-- ����
-- SELECT ��ɹ����� START WITH�� CONNECT BY ���� �̿�
-- ������ ���ǹ������� �������� ��� ���İ� ���� ��ġ ����
-- ��� ������  top-down �Ǵ� bottom-up
-- ����) CONNECT BY PRIOR �� START WITH���� ANSI SQL ǥ���� �ƴ�

-- ��1) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �ܴ�,�к�
-- �а������� top-down ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 10�� �μ�
SELECT deptno, dname, college
FROM department
START WITH deptno=10
CONNECT BY PRIOR deptno = college
;
-- ��2)������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �а�,�к�
-- �ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 102�� �μ��̴�
SELECT Level, deptno, dname, college
FROM department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno
;
--- ��3) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �μ� �̸��� �˻��Ͽ� �ܴ�, �к�, �а�����
---         top-down �������� ����Ͽ���. ��, ���� �����ʹ� ���������С��̰�,
---        �� LEVEL(����)���� �������� 2ĭ �̵��Ͽ� ���
SELECT LPAD('  ',(Level-1)*2)||dname ������
FROM department
START WITH dname = '��������'
CONNECT BY PRIOR deptno = college
;

------------------------------------------------------
--       TableSpace  (���� table�� ����Ǵ� ����)
---����  :�����ͺ��̽� ������Ʈ �� ���� �����͸� �����ϴ� ����
--       �̰��� �����ͺ��̽��� �������� �κ��̸�, ���׸�Ʈ�� �����Ǵ� ��� DBMS�� ���� 
--       �����(���׸�Ʈ)�� �Ҵ�
------------------------------------------------------
-- 1. TableSpace ����
CREATE TABLESPACE user1 DATAFILE 'C:\BACKUP\tableSpace\user1.ora' SIZE 100M;
CREATE TABLESPACE user2 DATAFILE 'C:\BACKUP\tableSpace\user2.ora' SIZE 100M;
CREATE TABLESPACE user3 DATAFILE 'C:\BACKUP\tableSpace\user3.ora' SIZE 100M;
CREATE TABLESPACE user4 DATAFILE 'C:\BACKUP\tableSpace\user4.ora' SIZE 100M;
-- 2. ���̺��� ���̺� �����̽� ����
--    1) ���̺��� NDEX�� Table��  ���̺� �����̽� ��ȸ
SELECT index_name, table_name, tablespace_name
FROM user_indexes
;
ALTER INDEX pk_religionno3 REBUILD TABLESPACE USER1
;
SELECT table_name, tablespace_name
FROM user_tables
;
ALTER TABLE JOB3 MOVE TABLESPACE USER2
;
-- 3.  ���̺� �����̽� Size ����
ALTER DATABASE DATAFILE 'C:\BACKUP\tableSpace\user4.ora' RESIZE 200M;
-----------cmd �Է�!--------------------------------------
--���� system���� ������ �� �Ŀ� �� �� �ִ�. (system_0702.sql)
-- Oracle ��ü Backup  (scott) -> cmd�� �Է�!!
EXPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp;
-- Oracle ��ü Restore  (scott)
IMPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle �κ� Backup��  �κ� Restore (���� ���� �Ժη� restore ��Ű�� ���ƶ�)
EXP scott/tiger FILE=dept_second.dmp TABLES=dept_second
EXP scott/tiger FILE=address.dmp TABLES=address
;
IMP scott/tiger FILE=dept_second.dmp    tables=dept_second
IMP scott/tiger FILE=address.dmp    tables=address
;

----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. ���� : � ����� �߻����� �� ���������� ����ǵ��� �����ͺ� �̽��� ����� ���ν���
--           Ʈ���Ű� ����Ǿ�� �� �̺�Ʈ �߻��� �ڵ����� ����Ǵ� ���ν��� 
--           Ʈ���Ÿ� ���(Triggering Event), �� ����Ŭ DML ���� INSERT, DELETE, UPDATE�� 
--           ����Ǹ� �ڵ����� ����
--  2. ����Ŭ Ʈ���� ��� ����
--    1) �����ͺ��̽� ���̺� �����ϴ� �������� ���� ���Ἲ�� ������ ���Ἲ ���� ������ ���� ���� �����ϴ� ��� 
--    2) �����ͺ��̽� ���̺��� �����Ϳ� ����� �۾��� ����, ���� 
--    3) �����ͺ��̽� ���̺� ����� ��ȭ�� ���� �ʿ��� �ٸ� ���α׷��� �����ϴ� ��� 
--    4) ���ʿ��� Ʈ������� �����ϱ� ���� 
--    5) �÷��� ���� �ڵ����� �����ǵ��� �ϴ� ��� 
-------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER triger_test
BEFORE
UPDATE ON dept
FOR EACH ROW --old, new ����ϱ� ����
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :old.dname);
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :new.dname);
END;
UPDATE dept
SET dname='ȸ��3��'
WHERE deptno=72
;
ROLLBACK;
COMMIT;

----------------------------------------------------------
--����work2 ) emp Table�� �޿��� ��ȭ��
--       ȭ�鿡 ����ϴ� Trigger �ۼ�( emp_sal_change)
--       emp Table ������
--      ���� : �Է½ô� empno�� 0���� Ŀ����

--��°�� ����
--     �����޿�  : 10000
--     ��  �޿�  : 15000
 --    �޿� ���� :  5000
CREATE OR REPLACE TRIGGER emp_sal_change
BEFORE DELETE OR INSERT OR UPDATE ON emp
FOR EACH ROW
    WHEN (new.empno > 0)
    DECLARE
        sal_diff number;
BEGIN
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('���� �޿� : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('�� �޿� : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('�޿� ���� : ' || sal_diff);
END;
--7369 emp ������Ʈ
UPDATE emp
SET sal=1000
WHERE empno=7369
;

-----------------------------------------------------------------------------
--  EMP ���̺� INSERT,UPDATE,DELETE������ �Ϸ翡 �� ���� ROW�� �߻��Ǵ��� ����
--  ���� ������ EMP_ROW_AUDIT�� 
--  ID ,����� �̸�, �۾� ����,�۾� ���ڽð��� �����ϴ� 
--  Ʈ���Ÿ� �ۼ�
-----------------------------------------------------------------------------
-- 1. SEQUENCE
--DROP  SEQUENCE  emp_row_seq;
CREATE SEQUENCE emp_row_seq;
-- 2. Audit Table
--DROP  TABLE  emp_row_audit;
CREATE TABLE emp_row_audit(
    e_id    NUMBER(6)   CONSTRAINT emp_row_pk PRIMARY KEY,
    e_name  VARCHAR2(30),
    e_gubun VARCHAR2(30),
    e_date  DATE
);
--3.Trigger
CREATE OR REPLACE TRIGGER emp_row_aud
    AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:new.ename,'inserting',SYSDATE);
        ELSIF UPDATING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:old.ename,'updating',SYSDATE);
        ELSIF DELETING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:old.ename,'deleting',SYSDATE);
        END IF;
    END;

INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(3000,'������',3500,51);
INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(3100,'Ȳ����',3500,51);
UPDATE emp
SET ename='Ȳ����'
WHERE empno=1601
;
DELETE emp
WHERE empno = 1502
;