--SQL �Լ��� ����
--1) ���� �� �Լ� : ���̺� ����Ǿ� �ִ� ���� ���� ������� �Լ��� �����Ͽ�
--                �ϳ��� ����� ��ȯ�ϴ� �Լ�
--  [1] ������ ���� �����ϴµ� �ַ� ���
--  [2] �ະ�� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ�ϴ� �Լ�
--2) ���� �� �Լ�: ���ǿ� ���� ���� ���� �׷�ȭ�Ͽ�
--                �׷캰�� ����� �ϳ��� ��ȯ�ϴ� �Լ�
-- -----------------------------------------------------------------
--1. ���� �Լ�
--   ���� �����͸� �Է��Ͽ� ���ڳ� ���ڸ� ����� ��ȯ�ϴ� �Լ�
--INITCAP
--���ڿ��� ö ��° ���ڸ� �빮�ڷ� ��ȯ
--INITCAP(��student��) �� Student
--ex)�л� ���̺��� ���迵�ա� �л��� �̸�, ����� ���̵� ����Ͽ���.
--   �׸��� ����� ���̵��� ù ���ڸ� �빮�ڷ� ��ȯ�Ͽ� ����Ͽ���
SELECT name, userid, INITCAP(userid)
FROM student
WHERE name = '�迵��'
;
--LOWER
--���ڿ� ��ü�� �ҹ��ڷ� ��ȯ
--LOWER(��STUDENT��) ��student
--UPPER
--���ڿ� ��ü�� �빮�ڷ� ��ȯ
--UPPER(��student��)��STUDENT
--ex)�л� ���̺��� �й��� ��20101���� �л��� ����� ���̵� 
--   (�ҹ��ڿ� �빮�ڷ� ��ȯ�Ͽ� ���)
SELECT userid , LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101
;

--���ڿ� ���� ��ȯ �Լ�
-- 1)LENGTH �Լ��� �μ��� �ԷµǴ� Į���̳� ǥ������ ���ڿ��� ���̸� ��ȯ�ϴ� �Լ��̰�,
-- 2)LENGTHB �Լ��� ���ڿ��� ����Ʈ ���� ��ȯ�ϴ� �Լ��̴�.
--ex) �μ� ���̺��� �μ� �̸��� ���̸� ���� ���� ����Ʈ ���� ���� ����Ͽ���
SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM dept
;
--�ѱ� ���ڿ� ����  Test --> Insert �� �� ǥ�� utf-8
INSERT INTO dept VALUES(59,'�濵������','������');

--���� ���� �Լ��� ����
--CONCAT :�� ���ڿ��� ����, ��||���� ����
SELECT name ||'�� ��å�� '
FROM professor
;
SELECT CONCAT(name,'�� ��å�� ')
FROM professor
;
SELECT CONCAT(CONCAT(name,'�� ��å�� '), position)
FROM professor
;
--SUBSTR :Ư�� ���� �Ǵ� ���ڿ� �Ϻθ� ����
--ex) �л� ���̺��� 1�г� �л��� �ֹε�� ��ȣ���� ������ϰ� �¾ ���� �����Ͽ�
--    �̸�, �ֹι�ȣ, �������, �¾ ��, ������ ����Ͽ���
SELECT name, idnum, SUBSTR(idnum,1,6) birth_date, SUBSTR(idnum,3,2) birth_mon, SUBSTR(idnum,7,1) gender
FROM student
WHERE grade=1
;
--INSTR :Ư�� ���ڰ� �����ϴ� ù ��° ��ġ�� ��ȯ
--���ڿ��߿��� ����ڰ� ������ Ư�� ���ڰ� ���Ե� ��ġ�� ��ȯ�ϴ� �Լ�
--ex) �а�  ���̺��� �μ� �̸� Į������ ������ ������ ��ġ�� ����Ͽ���
SELECT dname, INSTR(dname,'��')
FROM department
;

--LPAD :������ ������ �������� �������ڸ� ����
--RPAD :���� ������ ���������� ���� ���ڸ� ����
--LPAD�� RPAD �Լ��� ���ڿ��� ������ ũ�Ⱑ �ǵ���
--                  ���� �Ǵ� �����ʿ� ������ ���ڸ� �����ϴ� �Լ�
--ex) �������̺��� ���� Į���� ���ʿ� ��*�� ���ڸ� �����Ͽ� 10����Ʈ�� ����ϰ�
--    ���� ���̵� Į���� �����ʿ� ��+�����ڸ� �����Ͽ� 12����Ʈ�� ���
SELECT position, LPAD(position, 10,'*') lpad_position,
        userid,  RPAD(userid,12,'+')     rpad_userid
FROM professor
;

--LTRIM :���� ���� ���ڸ� ����
--RTRIM :������ ���� ���ڸ� ����
--LTRIM�� RTRIM �Լ��� ���ڿ����� Ư�� ���ڸ� �����ϱ� ���� ���
--�Լ��� �μ����� ������ ���ڸ� �������� ������ ���ڿ��� �յ� �κп� �ִ� ���� ���ڸ� ����
SELECT ' abcdefg ', LTRIM(' abcdefg ',' ')
FROM dual
;
--ex) �а� ���̺��� �μ� �̸��� ������ ������ �������� �����Ͽ� ����Ͽ���
SELECT dname, RTRIM(dname,'��')
FROM department
;

-- ------------------------------------------------------------------------
--���� �Լ� (**)
--���� �����͸� ó���ϱ� ���� �Լ�
--1) ROUND: ������ �Ҽ��� �ڸ��� ���� �ݿø�
--          ������ �ڸ� ���Ͽ��� �ݿø��� ��� ���� ��ȯ�ϴ� �Լ�
-- ex) ���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ� �Ҽ��� ù° �ڸ��� 
--     ��° �ڸ����� �ݿø� �� ���� �Ҽ��� ���� ù° �ڸ����� �ݿø��� ���� ����Ͽ���
SELECT name, sal, sal/22, ROUND(sal/22),ROUND(sal/22,2), ROUND(sal/22,-1)
FROM professor
WHERE deptno=101
;

--2)TRUNC: ������ �Ҽ��� �ڸ����� ����� ���� ����
-- ex)���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ�
--    �Ҽ��� ù° �ڸ��� ��° �ڸ����� ���� �� ���� 
--    �Ҽ��� ���� ù° �ڸ����� ������ ���� ���
SELECT name, sal, sal/22, TRUNC(sal/22), TRUNC(sal/22,2), TRUNC(sal/22,-1)
FROM professor
WHERE deptno=101
;

--3)MOD: m��n���� ���� ������
--       MOD �Լ��� ������ �����Ŀ� �������� ����ϴ� �Լ� 
-- ex) ���� ���̺��� 101�� �а� ������ �޿���
--     ������������ ���� �������� ����Ͽ� ����Ͽ���
SELECT name, sal, comm, MOD(sal,comm)
FROM professor
WHERE deptno=101
;

--4)CEIL (�ø�): ������ ������ ū�� �߿��� ���� ���� ����
--5)FLOOR(����): ������ ������ ������ �߿��� ���� ū ����
-- CEIL �Լ��� ������ ���ں��� ũ�ų� ���� ���� �߿��� �ּ� ���� ����ϴ� �Լ�
-- FLOOR�Լ��� ������ ���ں��� �۰ų� ���� ���� �߿��� �ִ� ���� ����ϴ� �Լ�
-- ex)19.7���� ū ���� �߿��� ���� ���� ������
--    12.345���� ���� ���� �߿��� ���� ū ������ ����Ͽ���
SELECT CEIL(19.7), FLOOR(12.345)
FROM dual
;

---------------------------------------------------------
-- ���� �Լ� ***
-- 1) ��¥ + ���� = ��¥ (��¥�� �ϼ��� ����)
-- ex) ���� ��ȣ�� 9908�� ������ �Ի����� �������� �Ի� 30�� �Ŀ� 60�� ���� ��¥�� ���
SELECT name, hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno=9908
;
--2) SYSDATE �Լ�
--   SYSDATE �Լ��� �ý��ۿ� ����� ���� ��¥�� ��ȯ�ϴ� �Լ��μ�, �� �������� ��ȯ
SELECT sysdate
FROM dual
;

-- 3) ��¥ - ���� = ��¥ (��¥�� �ϼ��� ����)
SELECT name, hiredate, hiredate-30, hiredate-60
FROM professor
WHERE profno=9908
;

-- 4) ��¥ - ��¥=  �ϼ� (��¥�� ��¥�� ����)
SELECT name, hiredate, sysdate, sysdate-hiredate
FROM professor
WHERE profno=9908
;

-- 5) MONTHS_BETWEEN : date1�� date2 ������ ���� ���� ���
--    ADD_MONTHS        : date�� ���� ���� ���� ��¥ ���
--    MONTHS_BETWEEN�� ADD_MONTHS �Լ��� �� ������ ��¥ ������ �ϴ� �Լ� 
-- ex) �Ի����� 120���� �̸��� ������ ������ȣ, �Ի���, �Ի��Ϸ� ���� �����ϱ����� ���� ��,
--     �Ի��Ͽ��� 6���� ���� ��¥�� ����Ͽ���
SELECT profno, hiredate,
       MONTHS_BETWEEN(SYSDATE,hiredate) working_day,
       ADD_MONTHS(hiredate,6)           hire_6after
FROM   professor
WHERE  MONTHS_BETWEEN(SYSDATE,hiredate)<120
;

--TO_CHAR �Լ�: ��¥�� ���ڸ� ���ڷ� ��ȯ�ϱ� ���� ���
--ex) �л� ���̺��� ������ �л��� �й��� ������� �߿��� ����� ����Ͽ���
--MM/MONTH/MON/YYYY/YY/DD/DY
DAY
SELECT studno,
       TO_CHAR(birthdate, 'YY/MM') birthdate1,
       TO_CHAR(birthdate, 'yy-mm') birthdate2,
       TO_CHAR(birthdate, 'yymm') birthdate3,
       TO_CHAR(birthdate, 'yymmdd') birthdate4,
       TO_CHAR(birthdate, 'yyyymmdd') birthdate5
FROM   student
WHERE  name='������'
;
--(2006-10-10,'MONTH')
SELECT TO_CHAR(sysdate,'MONTH') monthDate
FROM   dual
;

-- LAST_DAY, NEXT_DAY
-- LAST_DAY �Լ��� �ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
-- NEXT_DAY �Լ��� �ش� ���� �������� ��õ� ������ ���� ��¥�� ��ȯ�ϴ� �Լ�
-- ex)������ ���� ���� ������ ��¥�� �ٰ����� �Ͽ����� ��¥�� ����Ͽ���
SELECT sysdate, LAST_DAY(sysdate), NEXT_DAY(sysdate,'��')
FROM   dual
;

--ROUND, TRUNC �Լ�
SELECT TO_CHAR(sysdate, 'YY/MM/DD HH24:MI:SS') NORMAL,
       TO_CHAR(sysdate, 'YY/MM/DD HH24:MI:SS') TRUNC,
       TO_CHAR(sysdate, 'YY/MM/DD HH24:MI:SS') ROUND
FROM   dual
;

SELECT name,
       TO_CHAR(hiredate, 'YY/MM/DD HH24:MI:SS') hiredate,
       TO_CHAR(ROUND(hiredate,'dd'),'YY/MM/DD') round_dd,
       TO_CHAR(ROUND(hiredate,'mm'),'YY/MM/DD') round_mm,
       TO_CHAR(ROUND(hiredate,'yy'),'YY/MM/DD') round_yy
FROM   professor
;

-- CW : TO_CHAR �Լ��� ��¥�� ���ڸ� ���ڷ� ��ȯ�ϱ� ���� ���   ***
-- ex)�л� ���̺��� ������ �л��� �й��� ������� �߿��� ����� ���ڷ� ����Ͽ���
SELECT name, studno,
       TO_CHAR(birthdate, 'YY/MM') birthdate
FROM   student
WHERE  name = '������'
;
--TO_CHAR �Լ��� �̿��� ���� ��� ���� ��ȯ-->9
--ex) (1234, ��99999��)--> 1234
-- ���ڸ� ���� �������� ��ȯ
-- ex)cw02) ���������� �޴� �������� �̸�, �޿�, ��������, 
--    �׸��� �޿��� ���������� ���� ���� 12�� ���� ����� �������� ���
SELECT name, sal, comm, TO_CHAR((sal+comm)*12,'9,999') anual_sal
FROM professor
WHERE comm IS NOT NULL
;

SELECT TO_NUMBER('123')
FROM   dual
;

-- CW03)student Table���� �ֹε�Ϲ�ȣ���� ��������� �����Ͽ� ���� ��YY/MM/DD�� ���·� 
--      ���� BirthDate�� ����Ͽ���
SELECT name, TO_CHAR(TO_DATE(SUBSTR(idnum,1,6),'YYMMDD'),'YY/MM/DD') BirthDate
FROM student
;
-- CW04) NVL �Լ��� NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϱ� ���� �Լ�
-- 101�� �а� ������ �̸�, ����, �޿�, ��������, �޿��� ���������� �հ踦 ����Ͽ���. 
-- ��, ���������� NULL�� ��쿡�� ���������� 0���� ����Ѵ�
SELECT name, position, sal, comm, sal+comm,
       sal+NVL(comm,0) s1, NVL(sal+comm,sal) s2
FROM professor
WHERE deptno=101
;

-- ---------------------------------------------------------------
--QUESTION
-- ---------------------------------------------------------------
--Q1)salgrade ������ ��ü ����
SELECT * FROM salgrade;

--Q2)scott���� ��밡���� ���̺� ����
SELECT * FROM tab;

--Q3)emp Table���� ��� , �̸�, �޿�, ����, �Ի���
SELECT empno, ename, sal, job, hiredate
FROM emp
;

--Q4)emp Table���� �޿��� 2000�̸��� ��� �� ���� ���, �̸�, �޿� �׸� ��ȸ
SELECT empno, ename, sal
FROM emp
WHERE sal < 2000
;

--Q5) emp Table���� 80/02���Ŀ� �Ի��� ����� ����  ���,�̸�,����,�Ի���
SELECT empno, ename, job, hiredate
FROM emp
WHERE hiredate > '80/02/01'
;

--Q6) emp Table���� �޿��� 1500�̻��̰� 3000���� ���, �̸�, �޿�  ��ȸ(2����)
SELECT empno, ename, sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000
;
SELECT empno, ename, sal
FROM emp
WHERE sal>= 1500 
AND sal <= 3000
;

--Q7) emp Table���� ���, �̸�, ����, �޿� ��� [ �޿��� 2500�̻��̰�  ������ MANAGER�� ���]
SELECT empno, ename, job, sal
FROM emp
WHERE sal >= 2500
AND job='MANAGER'
;

--Q8)emp Table���� �̸�, �޿�, ���� ��ȸ 
--    [�� ������  ���� = (�޿�+��) * 12  , null�� 0���� ����]
SELECT ename, sal, (sal+NVL(comm,0))*12 anual_sal
FROM emp
;
SELECT ename, sal, NVL(sal+comm,sal)*12 anual_sal
FROM emp
;

--Q9) emp Table����  81/02 ���Ŀ� �Ի��ڵ��� xxx�� �Ի����� xxX
--  [ ��ü Row ��� ] --> 2���� ��� ��
SELECT CONCAT(CONCAT(ename,'�� �Ի����� '),CONCAT(hiredate,'�̴�'))
FROM emp
WHERE hiredate>'81/02/01'
;
SELECT ename||'�� �Ի����� '|| hiredate ||'�̴�.'
FROM emp
WHERE hiredate>'81/02/01'
;

--Q10)emp Table���� �̸��ӿ� T�� �ִ� ���,�̸� ���
SELECT empno, ename
FROM emp
WHERE ename LIKE '%T%'
;

-- --------------------------------------------------------
--�Ϲ��Լ�
--NVL2 �Լ�
--NVL2 �Լ��� ù ��° �μ� ���� NULL�� �ƴϸ� �� ��° �μ� ���� ����ϰ�,
--           ù ��° �μ� ���� NULL�̸� �� ��° �μ� ���� ����ϴ� �Լ�
-- ex) 102�� �а� �����߿��� ���������� �޴� ����� �޿��� ���������� ���� ����
--     �޿� �Ѿ����� ����Ͽ���. 
--     ��, ���������� ���� �ʴ� ������ �޿��� �޿� �Ѿ����� ����Ͽ���.
SELECT name, position, sal, comm,
       NVL2(comm,sal+comm,sal) total
FROM   professor
WHERE deptno=102
;

--NULLIF �Լ�
--NULLIF �Լ��� �� ���� ǥ������ ���Ͽ� ���� �����ϸ� NULL�� ��ȯ�ϰ�,
--             ��ġ���� ������ ù ��° ǥ������ ���� ��ȯ
--ex) ���� ���̺��� �̸��� ����Ʈ ���� ����� ���̵��� ����Ʈ ���� ���ؼ�
--      ������ NULL�� ��ȯ�ϰ� 
--      ���� ������ �̸��� ����Ʈ ���� ��ȯ
SELECT name, userid, LENGTHB(name), LENGTHB(userid),
       NULLIF(LENGTHB(name), LENGTHB(userid)) nullif_result
FROM   professor
;

--DECODE �Լ�
--DECODE �Լ��� ���� ���α׷��� ���� IF���̳� CASE ������ ǥ���Ǵ� ������ �˰�����
--             �ϳ��� SQL ��ɹ����� �����ϰ� ǥ���� �� �ִ� ������ ���
--DECODE �Լ����� �� �����ڴ� ��=���� ����
--Java If ElseIf Else�� ���� �����
--ex) ���� ���̺��� ������ �Ҽ� �а� ��ȣ�� �а� �̸����� ��ȯ�Ͽ� ����Ͽ���.
--      �а� ��ȣ�� 101�̸� ����ǻ�Ͱ��а���, 102�̸� ����Ƽ�̵���а���, 201�̸� �����ڰ��а���,
--      ������ �а� ��ȣ�� �������а���(default)�� ��ȯ
SELECT name, deptno, DECODE(deptno,101,'��ǻ�Ͱ��а�',
                                   102,'��Ƽ�̵���а�',
                                   201,'���ڰ��а�',
                                       '�����а�')
FROM professor
;

-- CASE �Լ�
-- CASE �Լ��� DECODE �Լ��� ����� Ȯ���� �Լ� 
-- DECODE �Լ��� ǥ���� �Ǵ� Į�� ���� ��=�� �񱳸� ���� ���ǰ� ��ġ�ϴ� ��쿡�� �ٸ� ������ ��ġ�� �� ������
-- , CASE �Լ������� ��� ����, ���� ����, �� ����� ���� �پ��� �񱳰� ����
-- ���� WHEN ������ ǥ������ �پ��ϰ� ����
-- 8.1.7�������� �����Ǿ�����, 9i���� SQL, PL/SQL���� �Ϻ��� ���� 
-- DECODE �Լ��� ���� �������� ����ü��� �پ��� �� ǥ���� ���
SELECT name, deptno,
       CASE WHEN deptno=101 Then '��ǻ�Ͱ��а�'
            WHEN deptno=102 Then '��Ƽ�̵����а�'
            WHEN deptno=201 Then '���ڰ��а�'
            ELSE                 '�����а�'
       END deptname
FROM professor
;
-- ex)���� ���̺��� �Ҽ� �а��� ���� ���ʽ��� �ٸ��� ����Ͽ� ����Ͽ���. (���� --> bonus)
--    �а� ��ȣ���� ���ʽ��� ������ ���� ����Ѵ�.
--    �а� ��ȣ�� 101�̸� ���ʽ��� �޿��� 10%, 102�̸� 20%, 201�̸� 30%, ������ �а��� 0%
SELECT name, deptno,
       CASE WHEN deptno=101 THEN sal*0.1
            WHEN deptno=102 THEN sal*0.2
            WHEN deptno=201 THEN sal*0.3
            ELSE                 0
       END bonus
FROM professor
;
SELECT name, deptno, DECODE(deptno, 101,sal*0.1,
                                    102,sal*0.2,
                                    201,sal*0.3,
                                        0) bonus
FROM professor
;


-- --------HOMEWORK------------------------
--Q1)emp Table �� �̸��� �빮��, �ҹ���, ù���ڸ� �빮�ڷ� ���
SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
FROM emp
;
--Q2)emp Table ��  �̸�, ����, ������ 2-5���� ���� ���
SELECT ename, job, SUBSTR(job,2,5)
FROM emp
;
--Q3)emp Table �� �̸�, �̸��� 10�ڸ��� �ϰ� ���ʿ� #���� ä���
SELECT ename, LPAD(ename,10,'#') lpad_ename
FROM emp
;
--Q4)emp Table ��  �̸�, ����, ������ MANAGER�� �����ڷ� ���
SELECT ename, job, DECODE(job,'MANAGER','������')
FROM emp
;
--Q5)emp Table ��  �̸�, �޿�/7�� ���� ����, �Ҽ��� 1�ڸ�. 10������   �ݿø��Ͽ� ���
SELECT ename, ROUND(sal/7), ROUND(sal/7,1), ROUND(sal/7,-1)
FROM emp
;