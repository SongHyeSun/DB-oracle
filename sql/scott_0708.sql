SELECT SUM(COL1) + SUM(COL2) + SUM(COL3) FROM Test2;

CREATE OR REPLACE PROCEDURE in_emp3
 (p_name IN emp.ename%TYPE,
  p_sal IN emp.sal%TYPE,
  p_job IN emp.job%TYPE)
IS
  v_emame emp.ename%TYPE;
  highsal_err EXCEPTION;
BEGIN
    DBMS_OUTPUT.ENABLE;
????    SELECT MAX(empno)+1
????    INTO v_empno
????    FROM emp;

    INSERT INTO emp(empno, ename, sal, job, hiredate)
    ????????VALUES(v_empno, p_name, p_sal, p_job, SYSDATE);

    EXCEPTION
????????        WHEN DUP_VAL_ON_INDEX THEN
????????????            DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
????????        WHEN highsal_err THEN
????????????            DBMS_OUTPUT.PUT_LINE('최고급여 -> 9000 이상 오류');
END;
    