--------------------------------------------------------------
--  20240705 ����Work01
-- 1.  PROCEDURE update_empno
-- 2.  parameter -> p_empno, p_job
-- 3.  �ش� empno�� ���õǴ� �������(Like) job�� ����� ������ p_job���� ������Ʈ
-- 4. Update -> emp ����
-- 5.              �Ի����� ��������
-- 6.  �⺻��  EXCEPTION  ó�� 
-------------------------------------------------------------
CREATE OR REPLACE PROCEDURE update_empno
 (p_empno IN emp.empno%TYPE,
  p_job   IN emp.job%TYPE)
IS
    CURSOR emp_cursor IS
        SELECT empno
        FROM emp
        WHERE empno LIKE p_empno||'%';
    
   
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR emp_list IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('��� : '||emp_list.empno);
        UPDATE emp
        SET job = p_job, hiredate = SYSDATE
        WHERE empno = emp_list.empno;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('���� ����');
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻�');
END;

---------------------------------------------------------------------------------------
-----    Package
--  ���� ����ϴ� ���α׷��� ������ ���ȭ
--  ���� ���α׷��� ���� ���� �� �� ����
--  ���α׷��� ó�� �帧�� �������� �ʾ� ���� ����� ����
--  ���α׷��� ���� �������� �۾��� ��
--  ���� �̸��� ���ν����� �Լ��� ���� �� ����

----------------------------------------------------------------------------------------
--- 1.Header -->  ���� : ���� (Interface ����)
--     ���� PROCEDURE ���� ����
CREATE OR REPLACE PACKAGE emp_info AS
    PROCEDURE all_emp_info;     --��� ����� ��� ����
    PROCEDURE all_sal_info;     --�μ��� �޿� ����
    PROCEDURE dept_emp_info(p_deptno IN NUMBER);    --Ư�� �μ��� ��� ����
END emp_info;

--2. Body ����: ���� ����
CREATE OR REPLACE PACKAGE BODY emp_info AS
-----------------------------------------------------------------
    -- ��� ����� ��� ����(���, �̸�, �Ի���)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� ���,�̸�,�Ի��� 
    -- 4. �⺻��  EXCEPTION  ó�� 
    -----------------------------------------------------------------
    PROCEDURE all_emp_info     --��� ����� ��� ����
    IS
        CURSOR emp_cursor IS
            SELECT empno, ename, TO_CHAR(hiredate, 'YYYY/MM/DD') hiredate
            FROM emp
            ORDER BY hiredate;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR emp_list  IN emp_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('��� : '||emp_list.empno);
            DBMS_OUTPUT.PUT_LINE('���� : '||emp_list.ename);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||emp_list.hiredate);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻�');
    END all_emp_info;
    
    -----------------------------------------------------------------------
    -- ��� ����� �μ��� �޿� ����
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� �μ��� ,��ü�޿���� , �ִ�޿��ݾ� , �ּұ޿��ݾ�
   -----------------------------------------------------------------------
    PROCEDURE all_sal_info
    IS
        CURSOR empdept_cursor IS
            SELECT d.dname �μ���, ROUND(AVG(e.sal),3) avg_sal, MAX(e.sal) max_sal, MIN(e.sal) min_sal
            FROM dept d, emp e
            WHERE d.deptno = e.deptno
            GROUP BY d.dname;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR empdept IN empdept_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('�μ��� : '||empdept.�μ���);
            DBMS_OUTPUT.PUT_LINE('��ü �޿� ��� : '||empdept.avg_sal);
            DBMS_OUTPUT.PUT_LINE('�ִ� �޿� �ݾ� : '||empdept.max_sal);
            DBMS_OUTPUT.PUT_LINE('�ּ� �޿� �ݾ� : '||empdept.min_sal);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻�');
    END all_sal_info;

-----------------------------------------------------------------
    --Ư�� �μ��� ��� ����
    -- ���, ����, �Ի���
-----------------------------------------------------------------
    PROCEDURE dept_emp_info(p_deptno IN NUMBER)
    IS
        CURSOR dept_cursor IS
            SELECT empno, ename, TO_CHAR(hiredate,'YYYY/MM/DD') hiredate
            FROM emp
            WHERE deptno = p_deptno
            ORDER BY hiredate;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR empdept IN dept_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('��� : '||empdept.empno);
            DBMS_OUTPUT.PUT_LINE('���� : '||empdept.ename);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||empdept.hiredate);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻�');
    END dept_emp_info;
END emp_info;