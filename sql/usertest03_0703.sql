CREATE TABLE sampleTBL (
    memo VARCHAR2(50)
);

INSERT INTO sampleTBL VALUES('7�� ����');
INSERT INTO sampleTBL VALUES('����� ��������');

COMMIT;

--
SELECT * FROM sampleTBL;
--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--13��, 21������ ���� �߻�

--x-> OK (usertest04���� read �Ҵ����) --> USERTEST04�� ��ȯ ȸ���� ���ķδ� �ٽ� x
SELECT * FROM scott.emp;
GRANT SELECT ON scott.emp TO usertest03;

-->x-->ok (USERTEST04�� ���� �ο�)
SELECT * FROM scott.JOB3;