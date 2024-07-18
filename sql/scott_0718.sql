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

CREATE TABLE MEMBER1
    (id         VARCHAR2(10)
     CONSTRAINT PK_MEMBERY1_ID PRIMARY KEY, --ID
     password   VARCHAR2(20),       --비밀번호
     name       VARCHAR2(100),      --이름
     reg_date   Date                --일자
     ) TABLESPACE "SYSTEM";
     
INSERT INTO scott.member1 (ID,password,name,reg_date)
VALUES ('aa','1234','김유신',sysdate);