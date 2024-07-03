--X --> grant the user space
CREATE TABLE sampleTBL (
    memo VARCHAR2(50)
);

--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--6��, 21������ ���� �߻�

--ó������ X -> SCOTT���� ���� �Ҵ���� �� OK
--scott �������� emp table���� ���� ��
SELECT * FROM scott.emp;

GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;

-->OK
SELECT * FROM scott.stud_101;
-->X (insufficient privileges)
GRANT SELECT ON scott.stud_101 TO usertest04;

-->x-->ok (SCOTT�� ���� �ο�)
SELECT * FROM scott.JOB3;
GRANT SELECT ON scott.JOB3 TO usertest04 WITH GRANT OPTION;