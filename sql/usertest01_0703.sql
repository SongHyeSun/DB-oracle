--X
  CREATE TABLE "SCOTT"."BONUS" 
   (	"ENAME" VARCHAR2(10 BYTE), 
	"JOB" VARCHAR2(9 BYTE), 
	"SAL" NUMBER, 
	"COMM" NUMBER
   );

--X
SELECT * FROM scott.emp;
--ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:
--9행, 21열에서 오류 발생