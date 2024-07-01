-------------------------------------------------------------
------------            ��������(Constraint)        ***          ------------
--  ����  : �������� ��Ȯ���� �ϰ����� ����
-- 1. ���̺� ������ ���Ἲ ���������� ���� ����
-- 2. ���̺� ���� ����, ������ ��ųʸ��� ����ǹǷ� ���� ���α׷����� �Էµ� 
--     ��� �����Ϳ� ���� �����ϰ� ����
-- 3. ���������� Ȱ��ȭ, ��Ȱ��ȭ �� �� �ִ� ���뼺
-------------------------------------------------------------

-------------------------------------------------------------
------------            ��������(Constraint)   ����      ***  ------------
-- 1 .NOT NULL  : ���� NULL�� ������ �� ����
-- 2. �⺻Ű(primary key) : UNIQUE +  NOT NULL + �ּҼ�  ���������� ������ ����
-- 3. ����Ű(foreign key) :  ���̺� ���� �ܷ� Ű ���踦 ���� ***
-- 4. CHECK : �ش� Į���� ���� ������ ������ ���� ������ ���� ����
-------------------------------------------------------------
-- 1.  ��������(Constraint) ���� ���� ����(subject) ���̺� �ν��Ͻ�
CREATE TABLE subject (
    subno       NUMBER(5)    CONSTRAINT subject_no_pk   PRIMARY KEY,
    subname     VARCHAR2(20) CONSTRAINT subject_name_nn NOT NULL,
    term        VARCHAR2(1)  CONSTRAINT subject_term_ck CHECK(term IN('1','2')),
    typeGubun   VARCHAR2(1)  
);

COMMENT ON COLUMN subject.subno     IS '������ȣ';
COMMENT ON COLUMN subject.subname   IS '��������';
COMMENT ON COLUMN subject.term      IS '�б�';

INSERT INTO subject(subno, subname, term)
            VALUES (10000,'��ǻ�Ͱ���','1');
INSERT INTO subject(subno, subname, term, typeGubun)
            VALUES (10001,'DB����','2','1');
INSERT INTO subject(subno, subname, term, typeGubun)
            VALUES (10002,'JSP����','1','1');
--PK Constraint --> Unique
INSERT INTO subject(subno, subname, term, typeGubun)
            VALUES (10001,'Spring����','1','1');
--PK Constraint --> NN(Not Null)
INSERT INTO subject(subname, term, typeguBun)
            VALUES ('Spring����2','1','1');
--subname NN
INSERT INTO subject(subno, term, typeGubun)
            VALUES (10003,'1','1');
--term�� check���� �ɾ��־��� ������ (1�� 2�� �Է� ����)
INSERT INTO subject(subno, subname, term, typeGubun)
            VALUES (10004,'Spring����3','5','1');

-- Table ����� ���Ѱ��� ���� ���� ����
-- Student Table �� idnum�� unique�� ����
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum)
;
INSERT INTO student(studno, name, idnum)
            VALUES(30101,'������', '8012311036613')
;
--unique�� �������� idnum���� �ߺ��Ǿ ���� (unique constraint)
INSERT INTO student(studno, name, idnum)
            VALUES(30102,'������', '8012311036613')
;
COMMIT;

INSERT INTO student(studno, name)
            VALUES(30103,'����÷')
;
-- Student Table �� name�� NN�� ���� 
ALTER TABLE student
MODIFY (name  CONSTRAINT stud_name_nn NOT NULL)
;

INSERT INTO student(studno, idnum)
            VALUES(30103, '8012301036614')
;

--CONSTRAINT ��ȸ
SELECT CONSTRAINT_name, CONSTRAINT_Type
FROM user_CONSTRAINTs
WHERE table_name IN('SUBJECT','STUDENT')
;

--FK **
DELETE emp
WHERE empno = 1000;
-- 1. Restrict : �ڽ� ���� ���� �ȵ�  (���� ���� ����)
--    1) ����   Emp Table����  REFERENCES DEPT (DEPTNO) 
--    2) ����   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
DELETE dept
WHERE deptno = 50;

ROLLBACK;
-- 2. Cascading Delete : ���� ����
--    1)���ӻ��� ���� : Emp Table���� REFERENCES DEPT (DEPTNO) ON DELETE CASCADE
DELETE dept
WHERE deptno = 50;

ROLLBACK;
-- 3.  SET NULL   
--    1) ���� NULL ���� : Emp Table���� REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
DELETE dept
WHERE deptno = 50;

ROLLBACK;
---------------------------------------------------------------
-----      INDEX      ***
--  �ε����� SQL ��ɹ��� ó�� �ӵ��� ���(*) ��Ű�� ���� Į���� ���� �����ϴ� ��ü
--  �ε����� ����Ʈ�� �̿��Ͽ� ���̺� ����� �����͸� ���� �׼����ϱ� ���� �������� ���
--  [1]�ε����� ����
--   1)���� �ε��� : ������ ���� ������ Į���� ���� �����ϴ� �ε����� ��� �ε��� Ű��
--           ���̺��� �ϳ��� ��� ����
CREATE UNIQUE INDEX idx_dept_name
ON     department(dname)
;

INSERT INTO department VALUES(300,'�̰�����','10','���а�');
--unique constraint
INSERT INTO department(deptno, dname, college, loc) VALUES(301,'�̰�����','10','�����');

-- ����� �ε��� birthdate  --> constraint  X   , ���ɿ��� ���� ��ħ 
-- 2)����� �ε���
-- ex) �л� ���̺��� birthdate Į���� ����� �ε����� �����Ͽ���
CREATE INDEX idx_stud_birthdate
ON student(birthdate);

INSERT INTO student(studno, name, idnum, birthdate)
            VALUES (30102,'������','8012301036614','84/09/16');
            
SELECT *
FROM student
WHERE birthdate = '84/09/16'
;

--   3)���� �ε��� : �ϳ��� index�� �ϳ��� column�� �ɸ��� ��
--   4)���� �ε��� :  �� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���
--     ��) �л� ���̺��� deptno, grade Į���� ���� �ε����� ����
--          ���� �ε����� �̸��� idx_stud_dno_grade �� ����
CREATE INDEX idx_stud_dno_grade
ON student(deptno, grade)
;
SELECT *
FROM student
WHERE grade=2
AND deptno=101
--WHERE deptno=101
--AND grade=2
;
SELECT *
FROM student
--WHERE grade=2
--AND deptno=101
WHERE deptno=101
AND grade=2
;

--- Optimizer
--- 1) RBO  2) CBO
-- RBO ����
ALTER SESSION SET OPTIMIZER_MODE=RULE;
--�ٽ� SESSION �󿡼� ����
ALTER SESSION SET OPTIMIZER_MODE=RULE;
--CBO
ALTER SESSION SET OPTIMIZER_MODE=CHOOSE;
--4-5���θ� ��������, �����ش� (������ ���� ������.)
ALTER SESSION SET OPTIMIZER_MODE=first_rows;
--��ü ������ �� �������� ��, (���� ������ ������.)
ALTER SESSION SET OPTIMIZER_MODE=ALL_ROWS;

-- SQL Optimizer
SELECT /*+ first_rows*/ename FROM emp;

SELECT /* +rule*/ename FROM emp;

-- OPTIMIZER ��� Ȯ��
SELECT NAME, VALUE, ISDEFAULT, ISMODIFIED, DESCRIPTION
FROM V$SYSTEM_PARAMETER
WHERE NAME LIKE '%optimizer_mode%'
;

-- [2]�ε����� ȿ������ ��� 
--   1) WHERE ���̳� ���� ���������� ���� ���Ǵ� Į��
--   2) ��ü �������߿��� 10~15%�̳��� �����͸� �˻��ϴ� ���
--   3) �� �� �̻��� Į���� WHERE���̳� ���� ���ǿ��� ���� ���Ǵ� ���
--   4) ���̺� ����� �������� ������ �幮 ���
--   5) ���� �� ���� ���� ���Ե� ���, ���� �������� ���� ���ԵȰ��
---------------------------------------------------------------
-- �л� ���̺� ������ PK_DEPTNO �ε����� �籸��
ALTER INDEX PK_DEPTNO REBUILD;
-- 1. Index ��ȸ
SELECT index_name, table_name, column_name
FROM user_ind_columns
;
--2. Index ���� emp(job)
CREATE INDEX inx_emp_job ON emp(job);
--3. ��ȸ
ALTER SESSION SET OPTIMIZER_MODE=rule;
SELECT * FROM emp WHERE job = 'MANAGER';       --= Index OK
SELECT * FROM emp WHERE job <> 'MANAGER';       --<> Index NO
SELECT * FROM emp WHERE job LIKE '%NA%';       --Like '%NA%' Index NO
SELECT * FROM emp WHERE job LIKE 'MA%';       --Like 'MA%' Index OK
SELECT * FROM emp WHERE UPPER(job) = 'MANAGER';       --UPPER(job) Index NO

--   5)�Լ� ��� �ε���(FBI) function based index
--      ����Ŭ 8i �������� �����ϴ� ���ο� ������ �ε����� Į���� ���� �����̳� �Լ��� ��� ����� 
--      �ε����� ���� ����
--      UPPER(column_name) �Ǵ� LOWER(column_name) Ű����� ���ǵ�
--      �Լ� ��� �ε����� ����ϸ� ��ҹ��� ���� ���� �˻�
CREATE INDEX uppercase_idx ON emp(UPPER(job));
SELECT * FROM emp WHERE UPPER(job)='SALESMAN';

---------------------------------------------------------------------------------
-- Ʈ����� ����  ***
-- ������ �����ͺ��̽����� ����Ǵ� ���� ���� SQL��ɹ��� �ϳ��� ���� �۾� ������ ó���ϴ� ����
-- COMMIT : Ʈ������� �������� ����
--               Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ��ũ�� ���������� �����ϰ� 
--               Ʈ������� ����
--               �ش� Ʈ����ǿ� �Ҵ�� CPU, �޸� ���� �ڿ��� ����
--               ���� �ٸ� Ʈ������� �����ϴ� ����
--               COMMIT ��ɹ� �����ϱ� ���� �ϳ��� Ʈ����� ������ �����
--               �ٸ� Ʈ����ǿ��� ������ �� ������ �����Ͽ� �ϰ��� ����
 
-- ROLLBACK : Ʈ������� ��ü ���
--                   Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ���� ����ϰ� Ʈ������� ����
--                   CPU,�޸� ���� �ش� Ʈ����ǿ� �Ҵ�� �ڿ��� ����, Ʈ������� ���� ����
---------------------------------------------------------------------------------

----------------------------------
-- SEQUENCE ***
-- ������ �ĺ���
-- �⺻ Ű ���� �ڵ����� �����ϱ� ���Ͽ� �Ϸù�ȣ ���� ��ü
-- ���� ���, �� �Խ��ǿ��� ���� ��ϵǴ� ������� ��ȣ�� �ϳ��� �Ҵ��Ͽ� �⺻Ű�� �����ϰ��� �Ҷ� 
-- �������� ���ϰ� �̿�
-- ���� ���̺��� ���� ����  -- > �Ϲ������δ� ������ ��� 
----------------------------------
-- 1) SEQUENCE ����
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : ������ ��ȣ�� ����ġ�� �⺻�� 1,  �Ϲ������� ?1 ���
--START WITH n : ������ ���۹�ȣ, �⺻���� 1
--MAXVALUE n : ���� ������ �������� �ִ밪
--MAXVALUE n : ������ ��ȣ�� ��ȯ������ ����ϴ� cycle�� ������ ���, MAXVALUE�� ������ �� ���� �����ϴ� ��������
--CYCLE | NOCYCLE : MAXVALUE �Ǵ� MINVALUE�� ������ �� �������� ��ȯ���� ������ ��ȣ�� ���� ���� ����
--CACHE n | NOCACHE : ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� ������ ����, �⺻���� 20

-- 2) SEQUENCE sample ����
CREATE SEQUENCE sample_seq
INCREMENT BY 1
START WITH 10000;

SELECT sample_seq.nextval FROM dual;
SELECT sample_seq.CURRVAL FROM dual;

-- 3) SEQUENCE sample ����2 --> �� ��� ����
CREATE SEQUENCE dept_dno_seq
INCREMENT BY 1
START WITH 76;

-- 4) SEQUENCE dept_dno_seq�� �̿� dept_second �Է� --> �� ��� ����
INSERT INTO dept_second
VALUES (dept_dno_seq.NEXTVAL, 'Accounting','NEW YORK');
SELECT dept_dno_seq.CURRVAL FROM dual;
--���� WORK (77,'ȸ��,'�̴�')
INSERT INTO dept_second
VALUES (dept_dno_seq.NEXTVAL, 'ȸ��','�̴�');
SELECT dept_dno_seq.CURRVAL FROM dual;
--���� WORK (78,'�λ���,'���')
INSERT INTO dept_second
VALUES (dept_dno_seq.NEXTVAL, '�λ���','���');
SELECT dept_dno_seq.CURRVAL FROM dual;

-- MAX ��ȯ 
INSERT INTO dept_second
VALUES((SELECT MAX(DEPTNO)+1 FROM dept_second)
        ,'�濵��', '�븲')
;
--80,'�λ���8','���8'
--unique constraint
INSERT INTO dept_second
VALUES (dept_dno_seq.NEXTVAL, '�λ���8','���8');
SELECT dept_dno_seq.CURRVAL FROM dual;

--4) SEQUENCE ����
DROP SEQUENCE SAMPLE_SEQ;

--5)  Data �������� ���� ��ȸ
SELECT sequence_name, min_value, max_value, increment_by
FROM user_sequences;

------------------------------------------------------
----               Table ����                     ----
------------------------------------------------------
-- 1.Table ����
CREATE TABLE address
( id    NUMBER(3),
  Name  VARCHAR2(50),
  addr  VARCHAR2(100),
  phone VARCHAR2(30),
  email VARCHAR2(100)
);

INSERT INTO ADDRESS
VALUES(1,'HGDONG','SEOUL','123-4567','gbhong@naver.com');

---    Homework
-- ��1) address ��Ű��/Data �����ϸ�     addr_second Table ����
CREATE TABLE addr_second
AS SELECT * FROM address
;
-- ��2) address ��Ű�� �����ϸ�  Data ���� ���� �ʰ�   addr_seven Table ����
CREATE TABLE addr_seven
AS SELECT * FROM address
WHERE 0=1
;
-- ��3) address(�ּҷ�) ���̺��� id, name Į���� �����Ͽ� addr_third ���̺��� �����Ͽ���
CREATE TABLE addr_third
AS SELECT id,name FROM address
;
-- ��4) addr_second ���̺� �� addr_tmp�� �̸��� ���� �Ͻÿ�
RENAME addr_second TO addr_tmp
;

------------------------------------------------------------------
-----     ������ ����
-- 1. ����ڿ� �����ͺ��̽� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺��� ����
-- 2. ���� ������ ������ ����Ŭ ������ ����
-- 3. ����Ŭ ������ ����Ÿ���̽��� ����, ����, ����� ����, ������ ���� ���� ������ �ݿ��ϱ� ����
--    ������ ���� �� ����
-- 4. ����Ÿ���̽� �����ڳ� �Ϲ� ����ڴ� �б� ���� �信 ���� ������ ������ ������ ��ȸ�� ����
-- 5. �ǹ������� ���̺�, Į��, �� ��� ���� ������ ��ȸ�ϱ� ���� ���

------------------------------------------------------------------

------------------------------------------------------------------
-----     ������ ���� ���� ����
-- 1.�����ͺ��̽��� ������ ������ ��ü�� ���� ����
-- 2. ����Ŭ ����� �̸��� ��Ű�� ��ü �̸�
-- 3. ����ڿ��� �ο��� ���� ���Ѱ� ��
-- 4. ���Ἲ �������ǿ� ���� ����
-- 5. Į������ ������ �⺻��
-- 6. ��Ű�� ��ü�� �Ҵ�� ������ ũ��� ��� ���� ������ ũ�� ����
-- 7. ��ü ���� �� ���ſ� ���� ���� ����
-- 8.�����ͺ��̽� �̸�, ����, ������¥, ���۸��, �ν��Ͻ� �̸�

------------------------------------------------------------------
-------     ������ ���� ����
-- 1. USER_ : ��ü�� �����ڸ� ���� ������ ������ ���� ��
-- user_tables�� ����ڰ� ������ ���̺� ���� ������ ��ȸ�� �� �ִ� ������ ���� ��.
SELECT table_name
FROM user_tables
;
SELECT *
FROM user_catalog
;
-- 2. ALL_    : �ڱ� ���� �Ǵ� ������ �ο� ���� ��ü�� ���� ������ ������ ���� ��
SELECT owner, table_name
FROM all_tables
;
-- 3. DBA_   : �����ͺ��̽� �����ڸ� ���� ������ ������ ���� ��
SELECT owner, table_name
FROM dba_tables
;