--1.scott에 있는 student TBL에 Read 권한 usertest04 주세요
GRANT SELECT ON scott.student TO usertest04;

--.현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
GRANT SELECT ON scott.emp TO usertest02 WITH GRANT OPTION;

GRANT SELECT ON scott.stud_101 TO usertest02;

GRANT SELECT ON scott.JOB3 TO usertest02 WITH GRANT OPTION;
REVOKE SELECT ON scott.job3 FROM usertest02; --최초에 권한 준

-- 전용 동의어 -> scott계정에서 동의어 생성해서, scott계정에서만 사용 가능하다
--Scott에서 전용동의어를 만들었지만, scott만 사용 가능
CREATE SYNONYM privateTBL FOR system.privateTBL;
SELECT * FROM privateTBL;

--------------------------------------------------------------------
----------  PL/SQL
--------------------------------------------------------------------
--[예제1] 특정한 수에 세금을 7%로 계산하는 Function tax을 작성
create or replace FUNCTION TAX
 (p_num in number)
 RETURN number
IS
    v_tax number;
BEGIN
    v_tax := p_num*0.07;
    RETURN(v_tax);
End;

SELECT tax(100)
FROM dual
;
---------------------------------------------------------------------
--현장 WORK 02
--1) PROCEDURE INSERT_EMP
--2) PARAMETER(In) -> p_empno, p_ename, p_job, p_mgr, p_sal, p_deptno
--3) 변수명 v_comm
--4) 로직
--    1 p_job MANAGER -> v_comm(1000)
--    2 p_job ELSE    -> v_comm(150)
--    3 emp TBL insert (hiredate->현재일자)
CREATE OR REPLACE PROCEDURE insert_emp
( p_empno  IN emp.empno%Type, 
  p_ename  IN emp.ename%Type, 
  p_job    IN emp.job%Type,
  p_mgr    IN emp.mgr%Type,
  p_sal    IN emp.sal%Type,
  p_deptno IN emp.deptno%TYPE
)
IS
    --%Type 데이터형 변수 선언   변수 선언인 것을 알아보기 위해 써둔 것
    v_comm emp.comm%TYPE;
BEGIN
    IF p_job='MANAGER' THEN
         v_comm :=1000;
    ELSE v_comm :=150;
    END IF;
    
    INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES (p_empno, p_ename, p_job, p_mgr, SYSDATE, p_sal, v_comm, p_deptno);
    COMMIT;
END;