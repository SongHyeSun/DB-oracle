--------------------------------------------------------
--  DDL for Table BOARD
--------------------------------------------------------

  CREATE TABLE "SCOTT"."BOARD" 
   (	"NUM" NUMBER, 
	"WRITER" VARCHAR2(20 BYTE), 
	"SUBJECT" VARCHAR2(50 BYTE), 
	"CONTENT" VARCHAR2(500 BYTE), 
	"EMAIL" VARCHAR2(30 BYTE), 
	"READCOUNT" NUMBER DEFAULT 0, 
	"PASSWD" VARCHAR2(12 BYTE), 
	"REF" NUMBER, 
	"RE_STEP" NUMBER, 
	"RE_LEVEL" NUMBER, 
	"IP" VARCHAR2(20 BYTE), 
	"REG_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;

   COMMENT ON COLUMN "SCOTT"."BOARD"."REF" IS '답변글끼리 그룹';
   COMMENT ON COLUMN "SCOTT"."BOARD"."RE_STEP" IS 'ref내의 순서';
   COMMENT ON COLUMN "SCOTT"."BOARD"."RE_LEVEL" IS '들여쓰기';
REM INSERTING into SCOTT.BOARD
SET DEFINE OFF;
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (1,'강공','게시판 첫글','첫 판이네요
게시판 성시를 이루세요','aa@naver.com',0,'111',1,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (2,'길동1','재미있다 Jsp 1','대박 넌 누구냐 헐 ~ 1','kk1@k.com',0,'1',2,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (39,'양만춘','게시판 첫글','우리는 
당태종을
공격한다','kk18@k.com',8,'1',39,0,0,'0:0:0:0:0:0:0:1',to_date('24/04/09','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (4,'길동3','재미있다 Jsp 3','대박 넌 누구냐 헐 ~ 3','kk3@k.com',4,'1',4,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (36,'정도전','[답변]조선건국','새나라 조선은 신민중심의
나라가 되어야 하오
이방원을 경계하시오','jung@k.com',2,'1',6,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (6,'이성계','조선건국5','위화도 회군 이야기','Lee@k.com',13,'1',6,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (37,'김현주','애인 있어요','종방 됐어요
이젠 좀 쉬어야 겠군요 ^^','kim@k.com',6,'1',37,0,0,'0:0:0:0:0:0:0:1',to_date('24/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (8,'길동7','재미있다 Jsp 7','대박 넌 누구냐 헐 ~ 7','kk7@k.com',8,'1',8,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (38,'지진희','[답변] 애인 있어요  종방','아쉽군요','kk18@k.com',5,'1',37,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (10,'길동9','재미있다 Jsp 9','대박 넌 누구냐 헐 ~ 9','kk9@k.com',0,'1',10,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (11,'길동10','재미있다 케이팝',' 대박 넌 누구냐 헐 ~ 10
                                 ','kk10@k.com',2,'1',11,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (12,'길동11','재미있다 Jsp 11','대박 넌 누구냐 헐 ~ 11','kk11@k.com',0,'1',12,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (40,'사랑은 ','[답변] 정말 영원','정말 영원 한가요','kk18@k.com',2,'1',30,6,2,'0:0:0:0:0:0:0:1',to_date('24/04/09','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (14,'길동13','재미있다 Jsp 13','대박 넌 누구냐 헐 ~ 13','kk13@k.com',0,'1',14,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (15,'길동14','재미있다 Jsp 14','대박 넌 누구냐 헐 ~ 14','kk14@k.com',2,'1',15,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (16,'길동15','재미있다 Jsp 15','대박 넌 누구냐 헐 ~ 15','kk15@k.com',2,'1',16,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (17,'길동16','재미있다 Jsp 16','대박 넌 누구냐 헐 ~ 16','kk16@k.com',3,'1',17,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (18,'길동17','재미있다 Jsp 17','대박 넌 누구냐 헐 ~ 17','kk17@k.com',3,'1',18,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (19,'선덕','재미있다  18',' 대박 넌 누구냐 헐 ~ 18
                                 ','kk18@k.com',6,'1',19,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (20,'길동19','재미있다 Jsp 19111','   대박 넌 누구냐 헐 ~ 19
재미있나
                                 
                                 
                                 ','kk19@k.com',21,'1',20,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (21,'김유신','20수정 삼한일통','  나는 삼한일통 을 이루겠
 나다 ^^      ','kim20@k.com',52,'1234',21,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (22,'양만춘','안시대첩',' 우아 안시성 ㅋ                  
                                 
                                 ','kk21@k.com',6,'1',22,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (23,'길동22','재미있다 Jsp 22','대박 넌 누구냐 헐 ~ 22','kk22@k.com',7,'1',23,0,0,'0:0:0:0:0:0:0:1',to_date('24/05/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (24,'허균','[답변] 111','정말','aa@naver.com',2,'111',23,1,1,'0:0:0:0:0:0:0:1',to_date('24/05/28','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (25,'김춘추','[답변] 삼한일통','김장군
가능합니까?','aa@naver.com',3,'111',21,2,1,'0:0:0:0:0:0:0:1',to_date('24/05/29','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (26,'허균','[답변]정말','재밌냐          ','kim20@k.com',1,'111',20,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (27,'대조영','[답변]18댓글','음 대조영 입니다','kim20@k.com',0,'111',19,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (28,'김준수','드라큐라 ',' 드라큐라 멋있어요
음  미나....
1000년의 사랑','kim20@k.com',8,'1234',28,0,0,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (29,'정선아','[답변]그 사람을 만났는데..',' 꿈같던 세월 ~
눈앞에 선명한데  왜이렇게~
찬 바람이 불어오나 ......    ','jung@k.com',6,'1234',28,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (30,'옥주현','몬테크리스토','좋은 작품 이었어요','kim20@k.com',29,'111',30,0,0,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (31,'신성록','[답변]우리사랑 영원히','출렁거리는','sin@k.com',2,'111',30,5,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (32,'차지연','[답변]훌룡한 노래',' 엄기준,차지연도 있다규   
                                 ','kim20@k.com',9,'111',30,4,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (33,'엄기준','[답변]난 알아요','꿈 이기를 ..
그렇게 애타는 ..','um@k.comum',3,'111',30,3,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (34,'안예은 ','[답변]케이팝',' 미스타 미스테리','kim20@k.com',2,'111',11,1,1,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (35,'강공','[답변]스티커',' ㄴ맨발로 걸었어
난 고장났어
                                 ','kim20@k.com',2,'111',11,2,2,'0:0:0:0:0:0:0:1',to_date('24/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (41,'허균','[답변] 옥주현 답글','노래 훌룡해요','kkk@com',1,'1234',30,1,1,'0:0:0:0:0:0:0:1',to_date('24/04/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (42,'선덕','[답변] 조카','춘추야 그건 내가 내린 황명이었느리라','kkk@com',1,'1234',21,3,2,'0:0:0:0:0:0:0:1',to_date('24/04/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (43,'연개소문','[답변] 고구려','이것들이
내가 살아 있는한 어림없다','kkk@com',1,'1234',21,1,1,'0:0:0:0:0:0:0:1',to_date('24/04/27','RR/MM/DD'));
--------------------------------------------------------
--  DDL for Index SYS_C007041
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."SYS_C007041" ON "SCOTT"."BOARD" ("NUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "SCOTT"."BOARD" ADD PRIMARY KEY ("NUM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("REG_DATE" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("IP" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("RE_LEVEL" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("RE_STEP" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("REF" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("PASSWD" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("CONTENT" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("SUBJECT" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("WRITER" NOT NULL ENABLE);
