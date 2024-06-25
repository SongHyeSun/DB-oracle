-- CRUD
INSERT INTO DEPT
    VALUES(50,'영업1팀','이대');
    
Update DEPT
SET    denamme = '', LOC = '홍대'
WHERE  DEPTNO = 50;

Rollback;

SELECT *
FROM   DEPT;

DELETE DEPT
WHERE  DEPTNO = 50;

Select dname,loc From Dept Where deptno=51;

Commit;

Select * From emp
;




-----프로시저
Create OR REPLACE  Procedure Dept_Insert
 (p_deptno in dept.deptno%type,
  p_dname  in dept.dname% type,
  p_loc    in dept.loc%Type
  )
 Is
    Insert into dept values (p_deptno, p_dname, p_loc);
    commit;
End;





 begin

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
--       DBMS_OUTPUT.PUT_LINE ( '사원번호 : ' || v_empno || CHR(10) || CHR(13) || '줄바뀜');
--       DBMS_OUTPUT.PUT_LINE ( '사원이름 : ' || p_ename);
--       DBMS_OUTPUT.PUT_LINE ( '사원급여 : ' || p_sal);
END;