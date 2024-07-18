CREATE OR REPLACE PROCEDURE Emp_Info3
 (p_empno IN emp.empno%TYPE, p_sal OUT emp.sal%TYPE)
IS
    v_ename emp.ename%TYPE;
    v_empno emp.empno%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- %TYPE �������� ���� ���
    SELECT  empno, ename, sal
    INTO    v_empno, v_ename, p_sal
    FROM    emp
    WHERE empno = p_empno;
    
    --����� ���
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||v_empno);
    DBMS_OUTPUT.PUT_LINE('����̸� : '||v_ename);
    DBMS_OUTPUT.PUT_LINE('��   �� : '||p_sal);
    
END Emp_Info3;