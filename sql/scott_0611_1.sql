create or replace PROCEDURE Emp_Info2
( p_empno In emp.empno%Type, 
  p_ename OUT emp.ename%Type, 
  p_sal OUT emp.sal%Type 
)
IS
    --%Type 데이터형 변수 선언   변수 선언인 것을 알아보기 위해 써둔 것
    v_empno emp.empno%TYPE;
Begin
        DBMS_OUTPUT.ENABLE;
        -- %TYPE 데이터형 변수 사용
        SELECT empno, ename  , sal
        INTO v_empno, p_ename, p_sal
        FROM emp
        WHERE empno = p_empno;
        --결과값 출력
        DBMS_OUTPUT.PUT_LINE ( '사원번호 : ' || v_empno || CHR(10) || CHR(13) || '줄바뀜');
        DBMS_OUTPUT.PUT_LINE ( '사원이름 : ' || p_ename);
        DBMS_OUTPUT.PUT_LINE ( '사원급여 : ' || p_sal);
END;