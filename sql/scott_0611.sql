-- CRUD
INSERT INTO DEPT
    VALUES(50,'����1��','�̴�');
    
Update DEPT
SET    denamme = '', LOC = 'ȫ��'
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




-----���ν���
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
    --%Type �������� ���� ����   ���� ������ ���� �˾ƺ��� ���� ��� ��
    v_empno emp.empno%TYPE;
Begin
    DBMS_OUTPUT.ENABLE;
       -- %TYPE �������� ���� ���
       SELECT empno, ename  , sal
       INTO v_empno, p_ename, p_sal
       FROM emp
       WHERE empno = p_empno;
       --����� ���
--       DBMS_OUTPUT.PUT_LINE ( '�����ȣ : ' || v_empno || CHR(10) || CHR(13) || '�ٹٲ�');
--       DBMS_OUTPUT.PUT_LINE ( '����̸� : ' || p_ename);
--       DBMS_OUTPUT.PUT_LINE ( '����޿� : ' || p_sal);
END;