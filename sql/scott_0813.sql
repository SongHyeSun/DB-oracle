CREATE OR REPLACE PROCEDURE Dept_Insert3
(vdeptno    IN dept.deptno%TYPE,
 vdname     IN dept.dname%TYPE,
 vloc       IN dept.loc%TYPE,
 p_deptno   OUT dept.deptno%TYPE,
 p_dname    OUT dept.dname%TYPE,
 p_loc      OUT dept.loc%TYPE)
IS
BEGIN
    INSERT INTO dept VALUES(vdeptno, vdname, vloc);
    COMMIT;
    
    DBMS_OUTPUT.ENABLE;
    -- %TYPE �������� ���� ���
    SELECT  deptno, dname, loc
    INTO    p_deptno, p_dname, p_loc
    FROM    dept
    WHERE   deptno=vdeptno;
    
    --����� ���
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '||p_deptno);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : '||p_dname);
    DBMS_OUTPUT.PUT_LINE('�μ���ġ : '||p_loc);
END;

CREATE OR REPLACE PROCEDURE Dept_Cursor3
(sdeptno     IN dept.deptno%TYPE,
 edeptno     IN dept.deptno%TYPE,
 Dept_Cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN Dept_Cursor
        For
            SELECT  deptno, dname, loc
            FROM    dept
            WHERE   deptno BETWEEN sdeptno AND edeptno;
END Dept_Cursor3;