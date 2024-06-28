--Q1)101�� �а� �����߿��� ���������� �޴� ������ ���� ����Ͽ���
SELECT COUNT(*), COUNT(comm)
FROM professor
WHERE deptno=101
;
--Q2)102�� �а� �л����� ������ ��հ� �հ踦 ����Ͽ���
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno=102
;
--Q3)���� ���̺��� �޿��� ǥ�������� �л��� ���
SELECT STDDEV(sal), VARIANCE(sal)
FROM professor
;
--Q4)�а���  �л����� �ο���, ������ ��հ� �հ踦 ����Ͽ���
SELECT deptno, COUNT(*), AVG(weight), SUM(weight)
FROM student
GROUP BY deptno
;
--Q5)���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
;
--Q6)���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
--   �� �а����� ���� ���� 2�� �̻��� �а��� ���
SELECT deptno, COUNT(*), COUNT(COMM)
FROM professor
GROUP BY DEPTNO
HAVING COUNT(*)>=2
;
--Q7)�л� ���� 4���̻��̰� ���Ű�� 168�̻���  �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
--   ��, ��� Ű�� ��� �����Դ� �Ҽ��� �� ��° �ڸ����� �ݿø� �ϰ�, 
--   ��¼����� ��� Ű�� ���� ������ ������������ ����ϰ� 
--   �� �ȿ��� ��� �����԰� ���� ������ ������������ ���
SELECT GRADE, COUNT(*), 
       ROUND(AVG(HEIGHT),1) avg_height,
       ROUND(AVG(WEIGHT),1) avg_weight
FROM STUDENT
GROUP BY GRADE
HAVING COUNT(*)>=4
AND ROUND(AVG(HEIGHT),1)>=168
ORDER BY avg_height DESC, avg_weight DESC
;
--Q8)�ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT MAX(hiredate), MIN(HIREDATE)
FROM EMP
;
--Q9)�μ��� �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT DEPTNO, MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
GROUP BY DEPTNO
;
--Q10)�μ���, ������ count & sum[�޿�]    (emp)
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;
--Q11)�μ��� �޿��Ѿ� 3000�̻� �μ���ȣ,�μ��� �޿��ִ�    (emp)
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
;
--Q12)��ü �л��� �Ҽ� �а����� ������, ���� �а� �л��� �ٽ� �г⺰�� �׷����Ͽ�, 
--   �а��� �г⺰ �ο���, ��� �����Ը� ���, 
--   (��, ��� �����Դ� �Ҽ��� ���� ù��° �ڸ����� �ݿø� )  STUDENT
SELECT DEPTNO, GRADE, COUNT(*), ROUND(AVG(WEIGHT))
FROM student
GROUP BY DEPTNO, GRADE
ORDER BY DEPTNO, GRADE
;
--Q13)�Ҽ� �а����� ���� �޿� �հ�� ��� �а� �������� �޿� �հ踦 ����Ͽ���
SELECT DEPTNO, SUM(SAL)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO)
;
--Q14)ROLLUP �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO, POSITION)
;
--Q15)CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���.
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY CUBE(DEPTNO, POSITION)
;
--Q16)�й��� 10101�� �л��� �̸��� �Ҽ� �а� �̸��� ����Ͽ���
SELECT NAME, DEPTNO
FROM STUDENT
WHERE STUDNO=10101
;
--Q17)�а��� ������ �а��̸�
SELECT DNAME
FROM department
WHERE DEPTNO=101
;
--Q18)  [Q16] + [Q17] �ѹ� ��ȸ  ---> Join
SELECT S.STUDNO, S.NAME, D.DEPTNO, D.DNAME
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO = D.DEPTNO
;
--Q19)JOIN�� �� �����ؾ��� �� (������ ���.)
--Q20)�ָŸ�ȣ�� (ambiguously)--> �ذ�: ����(alias)
--Q21)������ �л��� �й�, �̸�, �а� �̸� �׸��� �а� ��ġ�� ���
SELECT S.DEPTNO, S.NAME, D.DNAME, D.LOC
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO = D.DEPTNO
AND S.NAME='������'
;
--Q22)�����԰� 80kg�̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а���ġ�� ���
SELECT S.STUDNO, S.NAME, S.WEIGHT, D.DNAME, D.LOC
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO=D.DEPTNO
AND S.WEIGHT>=80
;
--Q23)īƼ�� ��  : �� �� �̻��� ���̺� ���� ���� ������ ���� ��� ����

--Q24)oracle(����Ŭ)Join ǥ���
--Q25)ANSI ǥ���
--Q26)NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���
--Q27)NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а��̸��� ����Ͽ���
--Q28)JOIN ~ USING ���� �̿��Ͽ� �й�, �̸�, �а���ȣ, �а��̸�, �а���ġ��
--       ����Ͽ���
--Q29)EQUI JOIN�� 3���� ����� �̿��Ͽ� ���� ���衯���� �л����� �̸�, �а���ȣ,�а��̸��� ���
--    1) Oracle-->  WHERE ���� ����� ���
--    2) NATURAL JOIN���� ����� ���
--    3) JOIN ~ USING���� ����� ���
--    4) ANSI JOIN (INNER JOIN ~ ON)
--Q30)���� ���̺�� �޿� ��� ���̺��� NON-EQUI JOIN�Ͽ� 
--    �������� �޿� ����� ����Ͽ���
--Q31)�л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ���
--    ��, ���������� �������� ���� �л��̸��� �Բ� ����Ͽ���. (==outer join�� �ɾ��)
--Q32)ANSI LEFT OUTER JOIN
--Q33)�л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, �������� �̸�, ������ ���
--    ��, �����л��� �������� ���� ���� �̸��� �Բ� ����Ͽ���
--Q34)
--Q35)
--Q36)
--Q37)
--Q38)
--Q39)
--Q40)
--Q41)
--Q42)
--Q43)
--Q44)
--Q45)
--Q46)
--Q47)
--Q48)
--Q49)
--Q50)
--Q51)
--Q52)
--Q53)
--Q54)
--Q55)
--Q56)
--Q57)
--Q58)
--Q59)
--Q60)
--Q61)
--Q62)
--Q63)
--Q64)
--Q65)
--Q66)
--Q67)
--Q68)
--Q69)
--Q70)
--Q71)
--Q72)
--Q73)
--Q74)
--Q75)
--Q76)
--Q77)
--Q78)
--Q79)
--Q80)
--Q81)
--Q82)
--Q83)
--Q84)
--Q85)
--Q86)
--Q87)
--Q88)
--Q89)
--Q90)
--Q91)
--Q92)
--Q93)
--Q94)
--Q95)
--Q96)
--Q97)
--Q98)
--Q99)
--Q100)