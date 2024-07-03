CREATE TABLE sampleTBL (
    memo VARCHAR2(50)
);

INSERT INTO sampleTBL VALUES('7월 더움');
INSERT INTO sampleTBL VALUES('결실을 맺으리라');

COMMIT;

--
SELECT * FROM sampleTBL;
--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--13행, 21열에서 오류 발생

--x-> OK (usertest04에서 read 할당받음) --> USERTEST04가 권환 회수한 이후로는 다시 x
SELECT * FROM scott.emp;
GRANT SELECT ON scott.emp TO usertest03;

-->x-->ok (USERTEST04가 권한 부여)
SELECT * FROM scott.JOB3;