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
    -- %TYPE 데이터형 변수 사용
    SELECT  deptno, dname, loc
    INTO    p_deptno, p_dname, p_loc
    FROM    dept
    WHERE   deptno=vdeptno;
    
    --결과값 출력
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||p_deptno);
    DBMS_OUTPUT.PUT_LINE('부서이름 : '||p_dname);
    DBMS_OUTPUT.PUT_LINE('부서위치 : '||p_loc);
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