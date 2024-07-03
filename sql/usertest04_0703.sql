CREATE TABLE sampleTBL4 (
    memo VARCHAR2(50)
);

INSERT INTO sampleTBL4 VALUES('7�� ����4');
INSERT INTO sampleTBL4 VALUES('����� ��������4');

COMMIT;

SELECT * FROM sampleTBL4;

--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--12��, 21������ ���� �߻�

--OK -> scott�� ������ �Ҵ�
--scott�������� student table�� read�� ���� ������ ���� ��,
SELECT * FROM scott.student;

--���� ȸ�� ����
REVOKE SELECT ON scott.emp FROM USERTEST03;


--insufficient privileges (���� �ȵ�)
UPDATE scott.student
SET    name = '������'
WHERE  studno = 30102
;

--ó������ X -> USERTEST02�� ���� �Ҵ���� �� OK
--USERTEST02 �������� emp table���� ���� ��
SELECT * FROM scott.emp;

GRANT SELECT ON scott.emp TO usertest03;

--WITH GRANT OPTION ���ְ� ����
-->x-->ok (USERTEST02�� ���� �ο�)
SELECT * FROM scott.JOB3;
GRANT SELECT ON scott.JOB3 TO usertest03;

SELECT * FROM system.systemTBL;

SELECT * FROM pub_system;

SELECT * FROM systemTBL;

SELECT * FROM system.privateTBL;
-- 
CREATE SYNONYM privateTBL FOR system.privateTBL;
SELECT * FROM privateTBL;