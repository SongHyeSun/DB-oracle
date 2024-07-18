CREATE OR REPLACE PROCEDURE Emp_Info3
 (p_empno IN emp.empno%TYPE, p_sal OUT emp.sal%TYPE)
IS
    v_ename emp.ename%TYPE;
    v_empno emp.empno%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- %TYPE 데이터형 변수 사용
    SELECT  empno, ename, sal
    INTO    v_empno, v_ename, p_sal
    FROM    emp
    WHERE empno = p_empno;
    
    --결과값 출력
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||v_empno);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '||v_ename);
    DBMS_OUTPUT.PUT_LINE('급   여 : '||p_sal);
    
END Emp_Info3;