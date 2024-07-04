------------------------------------------------------------
--  EMP ���̺��� ����� �Է¹޾� �ش� ����� �޿��� ���� ������ ����.
-- �޿��� 2000 �̸��̸� �޿��� 6%, 
-- �޿��� 3000 �̸��̸� 8%, 
-- 5000 �̸��̸� 10%, 
-- �� �̻��� 15%�� ����
--- FUNCTION  emp_tax3
-- 1) Parameter : ��� p_empno
--    ����       : v_sal(�޿�)
--                v_pct(����)
-- 2) ����� ������ �޿��� ����
-- 3) �޿��� ������ ���� ��� 
-- 4) ��� �� �� Return   number
-------------------------------------------------------------
CREATE OR REPLACE FUNCTION emp_tax3 --1) Parameter: ���
 (p_empno in emp.empno%TYPE)
 RETURN NUMBER
IS
    v_sal emp.sal%TYPE;
    v_pct number(5,2);
BEGIN
    --2) ����� ������ �޿��� ����
    SELECT sal
    INTO v_sal
    FROM emp
    WHERE empno=p_empno;
    --3) �޿��� ������ ���� ���
    IF      v_sal<2000 THEN
            v_pct := v_sal*0.06;
    ELSIF   v_sal<3000 THEN
            v_pct := v_sal*0.08;
    ELSIF   v_sal<5000 THEN
            v_pct := v_sal*0.10;
    ELSE    v_pct := v_sal*0.15;
    END IF;
    RETURN v_pct;
END emp_tax3;

SELECT ename, sal, EMP_TAX3(empno) emp_rate
FROM emp
;

-----------------------------------------------------
--  Procedure up_emp ���� ���
-- SQL> EXECUTE up_emp(1200);  -- ��� p_empno
-- ���: �޿� �λ� ����
--      ���۹���
-- ����: v_job(����)
--      v_up(�ӱ��λ�)

-- ���� 1) job = SALE����         v_up : 10
--        IF  v_job LIKE 'SALE%' THEN
--     2)                 MAN  v_up : 7  
--     3)                      v_up : 5
-- job�� ���� �޿� �λ��� ����  sal = sal+sal*v_up/100 --> �ӱ� �λ��
-- Ȯ�� : DB -> TBL
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE up_emp
 (p_empno IN emp.empno%TYPE)
IS
    v_job emp.job%TYPE;
    v_up  number(3);
BEGIN
    SELECT job
    INTO v_job
    FROM emp
    WHERE empno=p_empno;
    
    IF    v_job LIKE 'SALE%' THEN
          v_up := 10;
    ELSIF v_job LIKE 'MAN%' THEN
          v_up := 7;
    ELSE  v_up := 5;
    END IF;
    
    UPDATE emp
    SET sal=sal+(sal*v_up/100)
    WHERE empno=p_empno;
END up_emp;

----------------------------------------------------------
--HW01)
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- �����ȣ : 5555
-- ����̸� : 55
-- �� �� �� : 81/12/03
-- ������ ���� ����
--  1. Parameter : ��� �Է�
--  2. ��� �̿��� �����ȣ ,����̸� , �� �� �� ���
--  3. ��� �ش��ϴ� ������ ���� 
---------------------------------------------------------
CREATE OR REPLACE PROCEDURE Delete_emp
 --PARAMETER
 (p_empno IN emp.empno%TYPE)
IS
    --����
    v_emp emp%ROWTYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT *
    INTO v_emp
    FROM emp
    WHERE deptno=p_deptno;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||p_empno);
    DBMS_OUTPUT.PUT_LINE('����̸� : '||d_ename);
    DBMS_OUTPUT.PUT_LINE('�� �� �� : '||d_hiredate);
    
    DELETE FROM emp
    WHERE p_empno = empno;
END Delete_emp;

---------------------------------------------------------
--���� work02)
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
---------------------------------------------------------
CREATE OR REPLACE PROCEDURE DeptEmpSearch1
 (p_deptno IN emp.deptno%TYPE)
IS
 v_empno emp.empno%TYPE;
 v_ename emp.ename%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT empno, ename
    INTO v_empno, v_ename
    FROM emp
    WHERE deptno=p_deptno;
    
    DBMS_OUTPUT.PUT_LINE ( '��� : ' || v_empno);
    DBMS_OUTPUT.PUT_LINE ( '�̸� : ' || v_ename);
END DeptEmpSearch1;

CREATE OR REPLACE PROCEDURE DeptEmpSearch2
 (p_deptno IN emp.deptno%TYPE)
IS
-- v_empno emp.empno%TYPE;
-- v_ename emp.ename%TYPE;
   v_emp emp%ROWTYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT *
    INTO v_emp
    FROM emp
    WHERE deptno=p_deptno;
    
    DBMS_OUTPUT.PUT_LINE ( '��� : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE ( '�̸� : ' || v_emp.ename);
END DeptEmpSearch2;

CREATE OR REPLACE PROCEDURE DeptEmpSearch3
 (p_deptno IN emp.deptno%TYPE)
IS
-- EXCEPTION �̿��ϴ� ���
   v_emp emp%ROWTYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT *
    INTO v_emp
    FROM emp
    WHERE deptno=p_deptno;
    DBMS_OUTPUT.PUT_LINE ( '��� : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE ( '�̸� : ' || v_emp.ename);

-- Multi Row Error --> ���� ������ �䱸�� �ͺ��� ���� ���� ���� ����
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERR CODE 1 : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERR CODE 2 : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
END DeptEmpSearch3;

--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.���� : Oracle Server�� SQL���� �����ϰ� ó���� ������ �����ϱ� ���� 
--          "Private SQL Area" �̶�� �ϴ� �۾������� �̿�
--       �� ������ �̸��� �ο��ϰ� ����� ������ ó���� �� �ְ� ���ִµ� �̸� CURSOR
-- 2. ���� : Implicit(��������) CURSOR -> DML���� SELECT���� ���� ���������� ���� 
--          Explicit(�������) CURSOR -> ����ڰ� �����ϰ� �̸��� �����ؼ� ��� 
-- 3.attribute
--   1) SQL%ROWCOUNT : ���� �ֱ��� SQL���� ���� ó���� Row ��
--   2) SQL%FOUND    : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ �� ���̻��̸� True
--   3) SQL%NOTFOUND : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ ������True
-- 4. 4�ܰ� ** 
--     1) DECLARE �ܰ� : Ŀ���� �̸��� �ο��ϰ� Ŀ�������� ������ SELECT���� ���������ν� CURSOR�� ����
--     2) OPEN �ܰ� : OPEN���� �����Ǵ� ������ �����ϰ�, SELECT���� ����
--     3) FETCH �ܰ� : CURSOR�κ��� Pointer�� �����ϴ� Record�� ���� ������ ����
--     4) CLOSE �ܰ� : Record�� Active Set�� �ݾ� �ְ�, �ٽ� ���ο� Active Set������� OPEN�� �� �ְ� ����
--------------------------------------------------------------------------------

---------------------------------------------------------
-- EXECUTE ���� �̿��� �Լ��� �����մϴ�.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------
CREATE OR REPLACE PROCEDURE show_emp3
 (p_empno IN emp.empno%TYPE)
IS
    --1.DECLARE �ܰ�
    CURSOR emp_cursor IS
    SELECT ename, job, sal
    FROM   emp
    WHERE  empno Like p_empno ||'%';
    
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
    v_job   emp.job%TYPE;
    
BEGIN
    --2) OPEN �ܰ�
    OPEN emp_cursor;
        DBMS_OUTPUT.PUT_LINE('�̸�  '||'����'||'�޿�');
        DBMS_OUTPUT.PUT_LINE('-------------------');
    LOOP
        --3) FETCH �ܰ� --> �ϳ��� ����
        FETCH emp_cursor INTO v_ename, v_job, v_sal;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_ename||'  '||v_job||'  '||v_sal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT||'���� �� ����.');
    --4) CLOSE �ܰ�
    CLOSE emp_cursor;
END;

-----------------------------------------------------
-- Fetch ��    ***
-- SQL> EXECUTE  Cur_sal_Hap (5);
-- CURSOR �� �̿� ���� 
-- �μ���ŭ �ݺ� 
-- 	�μ��� : �λ���
-- 	�ο��� : 5
-- 	�޿��� : 5000
--  Cursor : dept_sum
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE Cur_sal_Hap
 (p_deptno IN emp.deptno%TYPE)
IS
    CURSOR dept_sum IS
    SELECT d.dname, COUNT(*) cnt , SUM(e.sal) sumSal
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
    AND e.deptno LIKE p_deptno||'%'
    GROUP BY d.dname;
    
    vdname dept.dname%TYPE;
    vcnt NUMBER;
    vsumSal NUMBER;
    
BEGIN
    DBMS_OUTPUT.ENABLE;
    --2) OPEN �ܰ�
    OPEN dept_sum;
    LOOP
        --3)FETCH �ܰ�
--            ����4��  2  7000
--            �濵3��  2  7350
--            ����1��  1  3000
        FETCH dept_sum INTO vdname, vcnt, vsumSal;
        EXIT WHEN dept_sum%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('�μ��� : '||vdname);
        DBMS_OUTPUT.PUT_LINE('�ο��� : '||vcnt);
        DBMS_OUTPUT.PUT_LINE('�޿��� : '||vsumSal);
    END LOOP;
    --4)CLOSE �ܰ�
    CLOSE dept_sum;
END;

------------------------------------------------------------------------
-- FOR���� ����ϸ� Ŀ���� OPEN, FETCH, CLOSE�� �ڵ� �߻��ϹǷ� 
-- ���� ����� �ʿ䰡 ����, ���ڵ� �̸��� �ڵ�
-- ����ǹǷ� ���� ������ �ʿ䰡 ����.
-----------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ForCursor_sal_Hap
IS
--1.DECLARE �ܰ� --> Cursor ����
CURSOR dept_sum 
    IS
       SELECT b.dname, COUNT(a.empno) cnt, SUM(a.sal) salary
       FROM emp a , dept b
       WHERE a.deptno=b.deptno
       GROUP BY b.dname;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        --Cursor�� FOR������ �����Ų��. --> OPEN, FETCH, CLOSE �� �ڵ� �߻�
        FOR emp_list IN dept_sum LOOP
            DBMS_OUTPUT.PUT_LINE('�μ��� : '||emp_list.dname);
            DBMS_OUTPUT.PUT_LINE('����� : '||emp_list.cnt);
            DBMS_OUTPUT.PUT_LINE('�޿��հ� : '||emp_list.salary);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    END;
-----------------------------------------------------------
--����Ŭ PL/SQL�� ���� �Ͼ�� ��� ���ܸ� �̸� ������ ��������, 
--�̷��� ���ܴ� �����ڰ� ���� ������ �ʿ䰡 ����.
--�̸� ���ǵ� ������ ����
-- NO_DATA_FOUND : SELECT���� �ƹ��� ������ ���� ��ȯ���� ���� ��
-- DUP_VAL_ON_INDEX : UNIQUE ������ ���� �÷��� �ߺ��Ǵ� ������ INSERT �� ��
-- ZERO_DIVIDE : 0���� ���� ��
-- INVALID_CURSOR : �߸��� Ŀ�� ����
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PreException
 (v_deptno IN emp.deptno%TYPE)
IS
    v_emp emp%ROWTYPE;
BEGIN
    DBMs_OUTPUT.ENABLE;
    
    SELECT empno, ename, deptno
    INTO v_emp.empno, v_emp.ename, v_emp.deptno
    FROM emp
    WHERE deptno=v_deptno;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '||v_emp.deptno);
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('�ߺ� �����Ͱ� ���� �մϴ�.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS ���� �߻�');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND ���� �߻�');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�');
END;

-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  lowsal_err (�����޿� ->1500)  
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE in_emp
 (p_name    IN  emp.ename%TYPE, --1) DUP_VAL_ON_INDEX
  p_sal     IN  emp.sal%TYPE,   --2) ������ Defind Error : lowsal_err(�����޿� ->1500)
  p_job     IN  emp.job%TYPE,
  p_deptno  IN  emp.deptno%TYPE
  )
IS
    v_empno emp.empno%TYPE;
    --������ Defind Error
    lowsal_err  EXCEPTION;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal >= 1500 THEN
        INSERT INTO emp(empno, ename, sal, job, deptno, hiredate)
        VALUES(v_empno, p_name, p_sal, p_job, 10, SYSDATE);
    ELSE
        RAISE lowsal_err;
    END IF;
    
    EXCEPTION
        --Oracle PreDefined Error
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('�ߺ� ������ ename �����մϴ�.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
        --������ Defined Error
        WHEN lowsal_err THEN
            DBMS_OUTPUT.PUT_LINE('ERROR!!! -������ �޿��� �ʹ� �����ϴ�. 1500�̻����� �ٽ� �Է��ϼ���.');
END in_emp;

-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  highsal_err (�ְ�޿� ->9000 �̻� ���� �߻�)  
---   2. ��Ÿ����
---      1) emp.ename�� Unique ���������� �ɷ� �ִٰ� ���� 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max ��ȣ �Է� 
---      3) hiredate     : �ý��� ��¥ �Է� 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column�Է��Ѵ� ����
---      5) DUP_VAL_ON_INDEX --> �ߺ� ������ ename ���� �մϴ� / DUP_VAL_ON_INDEX ���� �߻�
 --          highsal_err  -->ERROR!!!-������ �޿��� �ʹ� �����ϴ�. 9000�������� �ٽ� �Է��ϼ���
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE in_emp3
 ( p_name   IN  emp.ename%TYPE,
   p_sal    IN  emp.sal%TYPE,
   p_job    IN  emp.job%TYPE
 )
 IS
    v_empno emp.empno%TYPE;
    highsal_err EXCEPTION;
BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal<=9000 THEN
        INSERT INTO emp(empno, ename, sal, job, hiredate)
        VALUES(v_empno, p_name, p_sal, p_job, SYSDATE);
    ELSE
        RAISE highsal_err;
    END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('�ߺ� ������ ename ���� �մϴ�');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
        WHEN highsal_err THEN
            DBMS_OUTPUT.PUT_LINE('ERROR!!!-������ �޿��� �ʹ� �����ϴ�. 9000�������� �ٽ� �Է��ϼ���');
END in_emp3;