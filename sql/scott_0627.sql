--CH08. �׷��Լ� 
--���̺��� ��ü ���� �ϳ� �̻��� �÷��� �������� �׷�ȭ�Ͽ�
--�׷캰�� ����� ����ϴ� �Լ�
--�׷��Լ��� ������� ����� ����ϴµ� ���� ���
---------------------------------------------------------
--SELECT  column, group_function(column)
--FROM  table
--[WHERE  condition]
--[GROUP BY  group_by_expression]
--[HAVING  group_condition]
--GROUP BY : ��ü ���� group_by_expression�� �������� �׷�ȭ
--HAVING : GROUP BY ���� ���� ������ �׷캰�� ���� �ο�
-- ����      �ǹ�
--COUNT:  ���� ���� ���
--MAX:    NULL�� ������ ��� �࿡�� �ִ� ��
--MIN:    NULL�� ������ ��� �࿡�� �ּ� ��
--SUM:    NULL�� ������ ��� ���� ��
--AVG:    NULL�� ������ ��� ���� ��� ��
-------���� �ʼ�-------------
--STDDEV: NULL�� ������ ��� ���� ǥ������
--VARIANCE: NULL�� ������ ��� ���� �л� ��
--GROUPING: �ش� Į���� �׷쿡 ���Ǿ����� ���θ� 1 �Ǵ� 0���� ��ȯ
--GROUPING SETS: �� ���� ���Ƿ� ���� ���� �׷�ȭ ���

-- 1) COUNT �Լ�
-- ���̺��� ������ �����ϴ� ���� ������ ��ȯ�ϴ� �Լ�
-- ex) 101�� �а� �����߿��� ���������� �޴� ������ ���� ����Ͽ���
SELECT COUNT(*), COUNT(comm)
FROM professor
WHERE deptno=101
;
--ex)102�� �а� �л����� ������ ��հ� �հ踦 ����Ͽ���
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno=102
;
--ex)���� ���̺��� �޿��� ǥ�������� �л��� ���
SELECT STDDEV(sal), VARIANCE(sal)
FROM professor
;
--ex)�а���  �л����� �ο���, ������ ��հ� �հ踦 ����Ͽ���
SELECT deptno, count(*), AVG(weight), SUM(weight)
FROM student
GROUP BY deptno
;
--ex) ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
;
-- ex)���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
--    �� �а����� ���� ���� 2�� �̻��� �а��� ���
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
HAVING COUNT(*)>1
;
--ex)�л� ���� 4���̻��̰� ���Ű�� 168�̻���  �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
--   ��, ��� Ű�� ��� �����Դ� �Ҽ��� �� ��° �ڸ����� �ݿø� �ϰ�, 
--   ��¼����� ��� Ű�� ���� ������ ������������ ����ϰ� 
--   �� �ȿ��� ��� �����԰� ���� ������ ������������ ���
SELECT grade, COUNT(*),
       ROUND(AVG(HEIGHT),1) avg_height,
       ROUND(AVG(WEIGHT),1) avg_weight
FROM student
GROUP BY grade
HAVING COUNT(*)>=4
AND ROUND(AVG(HEIGHT))>=168
ORDER BY avg_height DESC, avg_weight DESC
;
--ex) �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT MAX(hiredate), MIN(hiredate)
FROM emp
;
--ex) �μ��� �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT deptno, MAX(hiredate), MIN(hiredate)
FROM emp
GROUP BY deptno
;
--ex)�μ���, ������ count & sum[�޿�]    (emp)
SELECT deptno,job, COUNT(*), SUM(sal)
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job
;
--ex)�μ��� �޿��Ѿ� 3000�̻� �μ���ȣ,�μ��� �޿��ִ�    (emp)
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal)>=3000
;
--ex)��ü �л��� �Ҽ� �а����� ������, ���� �а� �л��� �ٽ� �г⺰�� �׷����Ͽ�, 
--   �а��� �г⺰ �ο���, ��� �����Ը� ���, 
--   (��, ��� �����Դ� �Ҽ��� ���� ù��° �ڸ����� �ݿø� )  STUDENT
SELECT deptno, grade, COUNT(*), ROUND(AVG(weight))
FROM student
GROUP BY deptno, grade
ORDER BY deptno, grade
;
-- ROLLUP ������
-- GROUP BY ���� �׷� ���ǿ� ���� ��ü ���� �׷�ȭ�ϰ� �� �׷쿡 ���� �κ����� ���ϴ� ������
-- ��) �Ҽ� �а����� ���� �޿� �հ�� ��� �а� �������� �޿� �հ踦 ����Ͽ���
SELECT deptno, SUM(sal)
FROM professor
GROUP BY ROLLUP(deptno)
;
--ex) ROLLUP �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY ROLLUP(deptno, position)
;
-- CUBE ������
-- ROLLUP�� ���� �׷� ����� GROUP BY ���� ����� ���ǿ� ���� �׷� ������ ����� ������
--ex)CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���.
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY CUBE(deptno, position)
;
-------------------------------------------------------------------------
---- --------DeadLock    ---------
-------------------------------------------------------------------------
--Transaction A  ---> Developer
--1) Smith
UPDATE emp      ---> �ڿ�1
SET    sal = sal*1.1
WHERE  empno=7369
;
--2 King        ---> A�� �ڿ� 2�䱸
UPDATE emp
SET    sal = sal*1.1
WHERE  empno=7839
;

--Transaction B ---> Sqlplus
UPDATE emp
SET    comm=500
WHERE  empno=7839
;
UPDATE emp      -->�ڿ�1 �䱸
SET    comm=300
WHERE  empno=7369
;

-- READ COMMITED
Insert INTO dept Values(72,'kk','kk');
COMMIT
;

----------------------------------------------------------------------
----                    9-1.     JOIN       ***                                           ---------
----------------------------------------------------------------------
-- 1) ������ ����
--  �ϳ��� SQL ��ɹ��� ���� ���� ���̺� ����� �����͸� �ѹ��� ��ȸ�Ҽ� �ִ� ���
--ex1-1) �й��� 10101�� �л��� �̸��� �Ҽ� �а� �̸��� ����Ͽ���
SELECT studno, name, deptno
FROM student
WHERE studno=10101
;
--ex1-2)�а��� ������ �а��̸�
SELECT dname
FROM department
WHERE deptno=101
;
--ex1-3)  [ex1-1] + [ex1-2] �ѹ� ��ȸ  ---> Join
SELECT studno, name,
       student.deptno, department.dname
FROM   student, department
WHERE  student.deptno = department.deptno
;
--JOIN�� �� �����ؾ��� �� (������ ���.)
SELECT studno, name, deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
--�ָŸ�ȣ�� ������!!
SELECT studno, name, s.deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
----�ָŸ�ȣ�� (ambiguously)--> �ذ�: ����(alias)
SELECT s.studno, s.name, d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
--ex) ������ �л��� �й�, �̸�, �а� �̸� �׸��� �а� ��ġ�� ���
SELECT s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.name= '������'
;
--ex)�����԰� 80kg�̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а���ġ�� ���
SELECT s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.weight>=80
;

-- īƼ�� ��  : �� �� �̻��� ���̺� ���� ���� ������ ���� ��� ����
--1) ������ �Ǽ�
--2) ���� �ʱ⿡ ���� Data ����
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM student s, department d
;
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM student s CROSS JOIN department d
;

-- ***
-- ���� ��� ���̺��� ���� Į���� ��=��(equal) �񱳸� ����
-- ���� ���� ������ ���� �����Ͽ� ����� �����ϴ� ���� ���
-- SQL ��ɹ����� ���� ���� ����ϴ� ���� ���
-- �ڿ������� �̿��� EQUI JOIN
-- ����Ŭ 9i �������� EQUI JOIN�� �ڿ������̶� ���
-- WHERE ���� ������� �ʰ�  NATURAL JOIN Ű���� ���
-- ����Ŭ���� �ڵ������� ���̺��� ��� Į���� ������� ���� Į���� ���� ��, ���������� ���ι� ����

--oracle(����Ŭ)Join ǥ���
SELECT s.studno, s.name, d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;

--ANSI ǥ���
--Natural Join Convert Error �ذ�
--NATURAL JOIN �� ���� ��Ʈ����Ʈ�� ���̺� ������ ����ϸ� ������ �߻�
SELECT s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
FROM student s
     NATURAL JOIN department d
;
SELECT s.studno, s.name, s.weight, d.dname, d.loc, deptno
FROM student s
     NATURAL JOIN department d
;
--ex) NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���
SELECT p.profno, p.name, deptno, d.dname
FROM professor p
     NATURAL JOIN department d
;
--ex) NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а��̸��� ����Ͽ���
SELECT s.name, deptno, d.dname
FROM student s
     NATURAL JOIN department d
WHERE s.grade = '4'
;

-- JOIN ~ USING ���� �̿��� EQUI JOIN
-- USING���� ���� ��� Į���� ����
-- Į�� �̸��� ���� ��� ���̺��� ������ �̸����� ���ǵǾ� �־����
-- ex) JOIN ~ USING ���� �̿��Ͽ� �й�, �̸�, �а���ȣ, �а��̸�, �а���ġ��
--       ����Ͽ���
SELECT s.studno, s.name, deptno, dname
FROM student s JOIN department
     USING(deptno)
;

-- EQUI JOIN�� 3���� ����� �̿��Ͽ� ���� ���衯���� �л����� �̸�, �а���ȣ,�а��̸��� ���
--1) Oracle-->  WHERE ���� ����� ���
SELECT s.name, d.deptno, d.dname
FROM student s , department d
WHERE s.deptno = d.deptno
AND s.name LIKE '��%'
;
--2) NATURAL JOIN���� ����� ���
SELECT s.name, deptno, d.dname
FROM student s NATURAL JOIN department d
WHERE s.name LIKE '��%'
;
--3) JOIN ~ USING���� ����� ���
SELECT s.name, deptno, d.dname
FROM student s JOIN department d
     USING(deptno)
WHERE s.name LIKE '��%'
;

-- 4) ANSI JOIN (INNER JOIN ~ ON)
SELECT s.name, d.deptno, d.dname
FROM student s INNER JOIN department d
ON   s.deptno=d.deptno
WHERE s.name LIKE '��%'
;

-- NON-EQUI JOIN **
-- ��<��,BETWEEN a AND b �� ���� ��=�� ������ �ƴ� ������ ���
-- eX) ���� ���̺�� �޿� ��� ���̺��� NON-EQUI JOIN�Ͽ� 
--     �������� �޿� ����� ����Ͽ���
CREATE TABLE "SCOTT"."SALGRADE2" 
   (	"GRADE" NUMBER(2,0), 
     	"LOSAL" NUMBER(5,0), 
    	"HISAL" NUMBER(5,0)
  );
  
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade2 s
WHERE p.sal BETWEEN s.losal AND s.hisal
;

-- OUTER JOIN  ***
-- EQUI JOIN���� ���� Į�� ������ �ϳ��� NULL ������ ���� ����� ����� �ʿ䰡 �ִ� ���
-- OUTER JOIN ���
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno
;
--ex) �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ���
--    ��, ���������� �������� ���� �л��̸��� �Բ� ����Ͽ���. (==outer join�� �ɾ��)
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno(+)
;

--- ANSI OUTER JOIN
-- 1. ANSI LEFT OUTER JOIN
SELECT s.studno, s.name, s.profno, p.name
FROM student s
     LEFT OUTER JOIN professor p
     ON s.profno = p.profno
;
-- 2. ANSI RIGHT OUTER JOIN
--   1) ORACLE RIGHT OUTER JOIN
--ex) �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, �������� �̸�, ������ ���
--    ��, �����л��� �������� ���� ���� �̸��� �Բ� ����Ͽ���
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno
ORDER BY p.profno
;
