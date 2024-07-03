--1.scott�� �ִ� student TBL�� Read ���� usertest04 �ּ���
GRANT SELECT ON scott.student TO usertest04;

--.��SELECT ���� �ο� ������ ���� �ο� , WITH GRANT OPTION  --> �ϰ� �ض� ���� �ο�
GRANT SELECT ON scott.emp TO usertest02 WITH GRANT OPTION;

GRANT SELECT ON scott.stud_101 TO usertest02;

GRANT SELECT ON scott.JOB3 TO usertest02 WITH GRANT OPTION;
REVOKE SELECT ON scott.job3 FROM usertest02; --���ʿ� ���� ��

-- ���� ���Ǿ� -> scott�������� ���Ǿ� �����ؼ�, scott���������� ��� �����ϴ�
--Scott���� ���뵿�Ǿ ���������, scott�� ��� ����
CREATE SYNONYM privateTBL FOR system.privateTBL;
SELECT * FROM privateTBL;

--------------------------------------------------------------------
----------  PL/SQL
--------------------------------------------------------------------
--[����1] Ư���� ���� ������ 7%�� ����ϴ� Function tax�� �ۼ�
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
--���� WORK 02
--1) PROCEDURE INSERT_EMP
--2) PARAMETER(In) -> p_empno, p_ename, p_job, p_mgr, p_sal, p_deptno
--3) ������ v_comm
--4) ����
--    1 p_job MANAGER -> v_comm(1000)
--    2 p_job ELSE    -> v_comm(150)
--    3 emp TBL insert (hiredate->��������)
CREATE OR REPLACE PROCEDURE insert_emp
( p_empno  IN emp.empno%Type, 
  p_ename  IN emp.ename%Type, 
  p_job    IN emp.job%Type,
  p_mgr    IN emp.mgr%Type,
  p_sal    IN emp.sal%Type,
  p_deptno IN emp.deptno%TYPE
)
IS
    --%Type �������� ���� ����   ���� ������ ���� �˾ƺ��� ���� ��� ��
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