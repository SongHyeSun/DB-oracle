Update Dept
set    dname = 'kk' , loc = 'kk'
where  deptno= 59;

CREATE OR REPLACE FUNCTION func_sal
 (p_empno in number)
 RETURN number
IS
    vsal emp.sal%type;   -- emp table�� sal�� ���� Ÿ��
BEGIN
    -- �޿� 10% Up
    UPDATE emp 
    SET    sal=sal*1.1
    Where  empno = p_empno;
    commit;
    SELECT sal 
    INTO   vsal
    From   emp
    Where  empno=p_empno;
    Return vsal;
END;