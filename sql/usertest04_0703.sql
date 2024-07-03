CREATE TABLE sampleTBL4 (
    memo VARCHAR2(50)
);

INSERT INTO sampleTBL4 VALUES('7월 더움4');
INSERT INTO sampleTBL4 VALUES('결실을 맺으리라4');

COMMIT;

SELECT * FROM sampleTBL4;

--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--12행, 21열에서 오류 발생

--OK -> scott가 권한을 할당
--scott계정에서 student table의 read에 관한 권한을 받은 후,
SELECT * FROM scott.student;

--권한 회수 성공
REVOKE SELECT ON scott.emp FROM USERTEST03;


--insufficient privileges (원래 안됨)
UPDATE scott.student
SET    name = '김춘추'
WHERE  studno = 30102
;

--처음에는 X -> USERTEST02의 권한 할당받은 후 OK
--USERTEST02 계정에서 emp table권한 받은 후
SELECT * FROM scott.emp;

GRANT SELECT ON scott.emp TO usertest03;

--WITH GRANT OPTION 없애고 실행
-->x-->ok (USERTEST02가 권한 부여)
SELECT * FROM scott.JOB3;
GRANT SELECT ON scott.JOB3 TO usertest03;

SELECT * FROM system.systemTBL;

SELECT * FROM pub_system;

SELECT * FROM systemTBL;

SELECT * FROM system.privateTBL;
-- 
CREATE SYNONYM privateTBL FOR system.privateTBL;
SELECT * FROM privateTBL;