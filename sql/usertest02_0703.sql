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
--6행, 21열에서 오류 발생

--처음에는 X -> SCOTT에서 권한 할당받은 후 OK
--scott 계정에서 emp table권한 받은 후
SELECT * FROM scott.emp;

GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;

-->OK
SELECT * FROM scott.stud_101;
-->X (insufficient privileges)
GRANT SELECT ON scott.stud_101 TO usertest04;

-->x-->ok (SCOTT이 권한 부여)
SELECT * FROM scott.JOB3;
GRANT SELECT ON scott.JOB3 TO usertest04 WITH GRANT OPTION;