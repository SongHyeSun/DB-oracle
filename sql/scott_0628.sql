-----------------------------------------------------------------
----- SUB Query   ***
-- �ϳ��� SQL ��ɹ��� ����� �ٸ� SQL ��ɹ��� �����ϱ� ���� 
-- �� �� �̻��� SQL ��ɹ��� �ϳ��� SQL��ɹ����� �����Ͽ�
-- ó���ϴ� ���
-- ���� 
-- 1) ������ ��������
-- 2) ������ ��������
-------------------------------------------------------------------
-- ex)��ǥ : ���� ���̺��� ���������� ������ ������ ������ ��� ������ �̸� �˻�
--    1-1 ���� ���̺��� ���������� ������ ���� �˻� SQL ��ɹ� ����
SELECT position
FROM professor
WHERE name='������'
;
--    1-2 ���� ���̺��� ���� Į������ 1 ���� ���� ��� ����
--        ������ ������ ���� ���� �˻� ��ɹ� ����
SELECT name, position
FROM professor
WHERE position = '���Ӱ���'
;
-- 1.��ǥ : ���� ���̺��� ���������� ������ ������ ������ ��� ������ �̸� �˻�--> SUB Query
 SELECT name, position
 FROM professor
 WHERE position = (
                   SELECT position
                   FROM professor
                   WHERE name = '������'
        )
;

-- ���� 
-- 1) ������ ��������
--  ������������ �� �ϳ��� �ุ�� �˻��Ͽ� ���������� ��ȯ�ϴ� ���ǹ�
--  ���������� WHERE ������ ���������� ����� ���� ��쿡�� �ݵ�� ������ �� ������ �� 
--  �ϳ��� ����ؾ���

--ex) ����� ���̵� ��jun123���� �л��� ���� �г��� �л��� �й�, �̸�, �г��� ����Ͽ���
SELECT studno, name, grade
FROM student
WHERE grade = (
               SELECT grade
               FROM student
               WHERE userid='jun123'
     )
;
--ex)101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �г� , �а���ȣ, �����Ը�  ���
--   ���� : �а��� �������� ���
SELECT name, grade, deptno, weight
FROM student
WHERE weight < (
                SELECT AVG(weight)
                FROM student
                WHERE deptno=101
      )
ORDER BY deptno
;
--ex) 20101�� �л��� �г��� ����, Ű�� 20101�� �л����� ū �л��� 
-- �̸�, �г�, Ű, �а��� ����Ͽ���
-- ���� : �а��� �������� ���
SELECT s.name, s.grade,s.height, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.grade = (
               SELECT grade
               FROM student
               WHERE studno=20101
    )
AND s.height > (
              SELECT height
              FROM student
              WHERE studno=20101
    )
ORDER BY d.dname DESC
;
-- 2) ������ ��������
-- ������������ ��ȯ�Ǵ� ��� ���� �ϳ� �̻��� �� ����ϴ� ��������
-- ���������� WHERE ������ ���������� ����� ���� ��쿡�� ���� �� �� ������ �� ����Ͽ� ��
-- ���� �� �� ������ : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��, ��=���񱳸� ����
-- 2) ANY, SOME  : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��
-- 3) ALL             : ���� ������ �� ������ ���������� ����߿��� ��簪�� ��ġ�ϸ� ��, 
-- 4) EXISTS        : ���� ������ �� ������ ���������� ����߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- 1.  IN �����ڸ� �̿��� ���� �� ��������
--  single-row subquery returns more than one row
SELECT name, grade, deptno
FROM student
WHERE deptno = (
                SELECT deptno
                FROM department
                WHERE college=100
      )
;
SELECT name, grade, deptno
FROM student
WHERE deptno IN (
                 SELECT deptno
                 FROM department
                 WHERE college=100
      )
;
SELECT name, grade, deptno
FROM student
WHERE deptno IN (
                101,102
      )
;
--2. ANY �����ڸ� �̿��� ���� �� �������� (or��� ����)
-- ex)��� �л� �߿��� 4�г� �л� �߿��� Ű�� ���� ���� �л����� Ű�� ū �л��� �й�, �̸�, Ű�� ����Ͽ���
SELECT studno, name, height
FROM student
WHERE height > ANY (
                    -- 175 or 176 or 177--> MIN ����
                    SELECT height
                    FROM student
                    WHERE grade='4'
               )
;
--- 3. ALL �����ڸ� �̿��� ���� �� �������� (and��� ����)
SELECT studno, name, height
FROM student
WHERE height > ALL (
                    -- 175 and 176 and 177--> MAX ����
                    SELECT height
                    FROM student
                    WHERE grade='4'
               )
;
--- 4. EXISTS �����ڸ� �̿��� ���� �� ��������
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- ���簡 1 ROW�� �ִٸ�,(exists)
              SELECT position
              FROM professor
              WHERE comm IS NOT NULL
      )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- ���簡 1 ROW�� �ִٸ�,(exists)
              SELECT position
              FROM professor
              WHERE deptno=202
      )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- ���簡 1 ROW�� �ִٸ�,(exists)
              SELECT position
              FROM professor
              WHERE deptno=203
      )
;
--ex1)���������� �޴� ������ �� ���̶� ������ 
--   ��� ������ ���� ��ȣ, �̸�, �������� �׸��� �޿��� ���������� ��(NULLó��)sal_comm ���
SELECT profno, name, sal, comm, sal+NVL(comm,0) sal_comm
FROM professor
WHERE EXISTS (
              SELECT profno
              FROM professor
              WHERE comm IS NOT NULL
      )
;
--ex2) �л� �߿��� ��goodstudent���̶�� ����� ���̵� ������ 1�� ����Ͽ���
SELECT 1 userid_exist
FROM dual
WHERE NOT EXISTS (
                  SELECT userid
                  FROM student
                  WHERE userid = 'goodstudent'
      )
;

-- ���� �÷� ��������
-- ������������ ���� ���� Į�� ���� �˻��Ͽ� ���������� �������� ���ϴ� ��������
-- ���������� ������������ ���������� Į�� ����ŭ ����
-- ����
-- 1) PAIRWISE : Į���� ������ ��� ���ÿ� ���ϴ� ���
-- 2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���

-- 1) PAIRWISE ���� Į�� ��������
-- ex1) PAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� 
--      �л��� �̸�, �г�, �����Ը� ����Ͽ���
SELECT name, grade, weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MIN(weight)
                          FROM student
                          GROUP BY grade
                          ORDER BY grade
                      )
;
--  2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���
-- ex)UNPAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ���
SELECT name, grade, weight
FROM student
    --1,2,3,4
WHERE grade IN (SELECT grade
                FROM student
                GROUP BY grade
                )
                --52,42,70,72
AND weight IN (SELECT MIN(weight)
               FROM student
               GROUP BY grade
              )
;

-- ��ȣ���� ��������     ***
-- ������������ ������������ �˻� ����� ��ȯ�ϴ� ��������
-- ��1)  �� �а� �л��� ��� Ű���� Ű�� ū �л��� �̸�, �а� ��ȣ, Ű�� ����Ͽ���
--   ������� 1
---- ������� 3
SELECT deptno, name, grade, height
FROM student s1
WHERE height > (SELECT AVG(height)
                FROM student s2
                -- WHERE s2.deptno = 101
                --  ������� 2
                WHERE s2.deptno = s1.deptno
               )
ORDER BY deptno, grade
;
-------------  HW (emp table) -----------------------
-- 1. Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷����϶�
SELECT ename, hiredate, deptno
FROM emp
WHERE deptno = (
                SELECT deptno
                FROM emp
                WHERE ename='BLAKE'
      )
;
-- 2. ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ��� ����. 
--    �� ����� �޿� �������� �����϶�
SELECT empno, ename, sal
FROM emp
WHERE sal >= (
              SELECT AVG(sal)
              FROM emp
      )
ORDER BY sal DESC
;
-- 3. (���ʽ��� �޴� ����� �μ� ��ȣ�� 
--    �޿��� ��ġ�ϴ� ���)�� �̸�, �μ� ��ȣ �׸��� �޿��� ���÷����϶�.
SELECT e1.ename, e1.deptno, e1.sal
FROM emp e1, emp e2
WHERE (e1.deptno, e2.sal) IN (
                       SELECT deptno, sal
                       FROM emp
                       WHERE comm IS NOT NULL
                       AND e1.sal = e2.sal
                       AND e1.ename != e2.ename
                   )
;
SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN
            ( SELECT deptno, sal
              FROM emp
              WHERE comm IS NOT NULL
             )
;
SELECT ename, deptno, sal
FROM emp
WHERE deptno IN
            ( SELECT deptno
              FROM emp
              WHERE comm IS NOT NULL
             )
;
----------------------------------------------------------------------
--  ������ ���۾� (DML:Data Manpulation Language)  **  ----------
-- 1.���� : ���̺� ���ο� �����͸� �Է��ϰų� ���� �����͸� ���� �Ǵ� �����ϱ� ���� ��ɾ�
-- 2. ���� 
--  1) INSERT : ���ο� ������ �Է� ��ɾ�
--  2) UPDATE : ���� ������ ���� ��ɾ�
--  3) DELETE : ���� ������ ���� ��ɾ�
--  4) MERGE : �ΰ��� ���̺��� �ϳ��� ���̺�� �����ϴ� ��ɾ�

-- 1) Insert
--not enough values
INSERT INTO dept VALUES (73,'�λ�')
;
INSERT INTO dept VALUES (73,'�λ�','�̴�')
;
INSERT INTO dept(deptno, dname, loc) VALUES (74,'ȸ����','������')
;
INSERT INTO dept(deptno, loc, dname) VALUES (75,'�Ŵ��','������')
;
INSERT INTO dept(deptno, loc) VALUES (76,'ȫ��')
;
--professor table�� �� �߰�

--9920	������		������		06/01/01		102
--9910	��̼�		���Ӱ���		24/06/28		101
INSERT INTO professor(profno, name, position, hiredate, deptno)
       VALUES (9910,'��̼�','���Ӱ���',sysdate,101)
;
INSERT INTO professor(profno, name, position, hiredate, deptno)
       VALUES (9920,'������','������',TO_DATE('2006/01/01','YYYY/MM/DD'),102)
;

DROP TABLE JOB3
;
CREATE TABLE JOB3
(   jobno          NUMBER(2)      PRIMARY KEY,
	jobname       VARCHAR2(20)
)
;
INSERT INTO job3 VALUES (10,'�б�');
INSERT INTO job3 VALUES (11,'������');
INSERT INTO job3 VALUES (12,'�����');
INSERT INTO job3(jobno,jobname) VALUES (13,'����');
INSERT INTO job3(jobname,jobno) VALUES ('�߼ұ��',14);

--HW Insert ���ֱ�!!
CREATE TABLE Religion   
(   religion_no         NUMBER(2)     CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
	 religion_name     VARCHAR2(20)
) ;
--10	�⵶��
--20	ī�縯��
--30	�ұ�
--40	����
INSERT INTO Religion(religion_no, religion_name) VALUES (10,'�⵶��');
INSERT INTO Religion(religion_name, religion_no) VALUES ('ī�縯��',20);
INSERT INTO Religion VALUES (30,'�ұ�');
INSERT INTO Religion VALUES (40,'����');
COMMIT;
ROLLBACK;

--------------------------------------------------
-----   ���� �� �Է�                          ------
--------------------------------------------------
-- 1. ������ TBL�̿� �ű� TBL ����
CREATE TABLE dept_second
AS SELECT * FROM dept
;
--2. TBL ���� ����
CREATE TABLE emp20
AS SELECT empno, ename, sal*12 annsal
   FROM emp
   WHERE deptno=20
;
--3.TBL������ (�����⸸)
CREATE TABLE dept30
AS SELECT deptno, dname
   FROM dept
   WHERE 0=1
;
--4. column�߰�
ALTER TABLE dept30
ADD (birth DATE)
;
INSERT INTO dept30 VALUES (10,'�߾��б�',sysdate)
;
--5. Column����
--some value is too big
ALTER TABLE dept30
MODIFY dname varchar2(11)
;
ALTER TABLE dept30
MODIFY dname varchar2(30)
;
--6 Column ����
ALTER TABLE dept30
DROP COLUMN dname
;
--7. TBL �� ����
RENAME dept30 TO dept35
;
--8. TBL ����
DROP TABLE dept35
;
--9. Truncate
TRUNCATE TABLE dept_second
;

-- INSERT ALL(unconditional INSERT ALL) ��ɹ�
-- ���������� ��� ������ ���Ǿ��� ���� ���̺� ���ÿ� �Է�
-- ���������� �÷� �̸��� �����Ͱ� �ԷµǴ� ���̺��� Į���� �ݵ�� �����ؾ� ��
CREATE TABLE height_info
( studno    NUMBER(5),
  name      VARCHAR2(20),
  height    NUMBER(5,2)
)
;
CREATE TABLE weight_info
( studno    NUMBER(5),
  name      VARCHAR2(20),
  weight    NUMBER(5,2)
)
;
INSERT ALL
INTO height_info VALUES(studno, name, height)
INTO weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight, grade
FROM student
WHERE grade>='2'
;
DELETE height_info;
DELETE weight_info;


-- INSERT ALL 
-- [WHEN ������1 THEN
-- INTO [table1] VLAUES[(column1, column2,��)]
-- [WHEN ������2 THEN
-- INTO [table2] VLAUES[(column1, column2,��)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,��)]
-- subquery;
--ex)�л� ���̺��� 2�г� �̻��� �л��� �˻��Ͽ� 
--   height_info ���̺��� Ű�� 170���� ū �л��� �й�, �̸�, Ű�� �Է�
--   weight_info ���̺��� �����԰� 70���� ū �л��� �й�, �̸�, �����Ը� 
--   ���� �Է��Ͽ���
INSERT ALL
WHEN height>170 THEN
    INTO height_info VALUES(studno, name, height)
WHEN weight>75 THEN
    INTO weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade>='2'
;

-- ������ ���� ����
-- UPDATE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� ���� ����
--- Update 
-- ex1) ���� ��ȣ�� 9903�� ������ ���� ������ ���α������� �����Ͽ���
UPDATE professor
SET position = '�α���', userid='kkk'
WHERE profno = 9903
;
UPDATE professor
SET position = '�α���', userid='kkk'
WHERE profno = 9903
OR    1=1
;
ROLLBACK;
--ex2) ���������� �̿��Ͽ� �й��� 10201�� �л��� �г�� �а� ��ȣ��
--        10103 �й� �л��� �г�� �а� ��ȣ�� �����ϰ� �����Ͽ���
UPDATE student 
SET (grade,deptno) = (
                      SELECT grade, deptno
                      FROM student
                      WHERE studno=10103
)
WHERE studno = 10201
;

-- ������ ���� ����
-- DELETE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� �� ����

-- ex1) �л� ���̺��� �й��� 20103�� �л��� �����͸� ����
DELETE
FROM student
WHERE studno=20103
;
--ex2)�л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ���.(HW-->Rollback)
DELETE
FROM student
WHERE deptno = (
                SELECT deptno
                FROM department
                WHERE dname='��ǻ�Ͱ��а�'
               )
;
ROLLBACK;

----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE ����
--     ������ ���� �ΰ��� ���̺��� ���Ͽ� �ϳ��� ���̺�� ��ġ�� ���� ������ ���۾�(DML)
--     WHEN ���� ���������� ��� ���̺� �ش� ���� �����ϸ� UPDATE ��ɹ��� ���� ���ο� ������ ����,
--     �׷��� ������ INSERT ��ɹ����� ���ο� ���� ����
------------------------------------------------------------------------------------
-- 1] MERGE �����۾� 
--  ��Ȳ 
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert
CREATE TABLE professor_temp
AS     SELECT * FROM professor
       WHERE position='����'
;
UPDATE professor_temp
SET position = '������'
WHERE position ='����'
;
INSERT INTO professor_temp
VALUES (9999,'�赵��','aroma21','���Ӱ���',200,sysdate,10,101)
;
COMMIT;
-- 2] professor MERGE ���� 
-- ��ǥ : professor_temp�� �ִ� ����   ������ ������ professor Table�� Update
--                         �赵�� ���� �ű� Insert ������ professor Table�� Insert
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert
MERGE INTO professor p
USING professor_temp f
ON (p.profno = f.profno)
when matched then           --PK�� ������ ������ Update
    update set p.position = f.position
when not matched then       --PK�� ������ �ű� Insert
    insert values (f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno)
;