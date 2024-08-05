-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : 하나 이상의 기본 테이블이나 다른 뷰를 이용하여 생성되는 가상 테이블
--        뷰는 데이터딕셔너리 테이블에 뷰에 대한 정의만 저장
--       장점 : 1) 보안 
--             2) 고급 기술자가 초급 기술자의 SQL 능력을 cover
--       단점 : Performance(성능)은 더 저하
CREATE OR REPLACE VIEW VIEW_PROFESSOR AS
SELECT profno, name, userid, position, hiredate, deptno
FROM professor
;
--조회하는 순간 professor가 받아서 전체적으로 실행
SELECT * FROM VIEW_PROFESSOR ;

-- 제약조건에 걸리지 않는다면 뷰를 통한 입력 가능
INSERT INTO view_professor VALUES(2000,'view','userid','position',sysdate,101)
;
--name에 제약조건 not null이 있는데 name을 입력하지 않아서 에러!
--cannot insert NULL into("SCOTT"."PROFESSOR"."NAME")
INSERT INTO view_professor(profno, userid, position, hiredate, deptno)
    VALUES(2001,'userid2','position2',sysdate,101);
    
-- 현장work01) VIEW 이름 v_emp_sample  : emp(empno , ename , job, mgr,deptno)
CREATE OR REPLACE VIEW V_EMP_SAMPLE AS
SELECT empno, ename, job, mgr, deptno
FROM emp
;

INSERT INTO V_EMP_SAMPLE(empno , ename , job, mgr,deptno)
    VALUES(2001,'userid2','position2',7839,10);
    
--현장 work2) 복합 view / 통계뷰 v_emp_complex(emp+dept) -> insert 안됨!
CREATE OR REPLACE VIEW v_emp_complex AS
SELECT *
FROM emp NATURAL JOIN dept
;

INSERT INTO v_emp_complex(empno, ename)
        VALUES (1504,'홍길동4')
;
--cannot modify more than one base table through a join view
INSERT INTO v_emp_complex(empno, ename, deptno)
        VALUES (1500,'홍길동',20)
;
--전체 다 해도 마찬가디로 cannot modify more than one base table through a join view
INSERT INTO v_emp_complex(empno, ename, deptno, dname, loc)
        VALUES(1500,'홍길동',77,'공무팀','낙성대')
;

--일반 oracle join으로 했을 때는, insert 된다.!
CREATE OR REPLACE VIEW v_emp_complex3 AS
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
;
--Insert OK (oracle join에서!)
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1500,'홍길동')
;
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1501,'홍길동1')
;
INSERT INTO v_emp_complex3(empno, ename, deptno)
        VALUES (1502,'홍길동2',20)
;
INSERT INTO v_emp_complex3(empno, ename, deptno, dname, loc)
        VALUES(1503,'홍길동3',77,'공무팀','낙성대')
;
ROLLBACK;
--위치 바꿔서 해보기
CREATE OR REPLACE VIEW v_emp_complex4 AS
SELECT d.deptno, d.dname, d.loc, e.empno, e.ename, e.job
FROM dept d, emp e
WHERE d.deptno = e.deptno
;
--Insert OK (oracle join에서!)
INSERT INTO v_emp_complex3(empno, ename)
        VALUES (1601,'홍길동1')
;
INSERT INTO v_emp_complex4(empno, ename, deptno)
        VALUES (1602,'홍길동2',20)
;
INSERT INTO v_emp_complex4(empno, ename, deptno, dname, loc)
        VALUES(1603,'홍길동3',77,'공무팀','낙성대')
;
ROLLBACK;
------------     View  HomeWork     ----------------------------------------------------
---문1)  학생 테이블에서 101번 학과 학생들의 학번, 이름, 학과 번호로 정의되는 단순 뷰를 생성
---     뷰 명 :  v_stud_dept101
CREATE OR REPLACE VIEW v_stud_dept101 AS
SELECT studno, name, deptno
FROM student
WHERE deptno=101
;
--문2) 학생 테이블과 부서 테이블을 조인하여 102번 학과 학생들의 학번, 이름, 학년, 학과 이름으로 정의되는 복합 뷰를 생성
--      뷰 명 :   v_stud_dept102
CREATE OR REPLACE VIEW v_stud_dept102 AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno=d.deptno
AND   s.deptno=102
;
--문3)  교수 테이블에서 학과별 평균 급여와     총계로 정의되는 뷰를 생성
--  뷰 명 :  v_prof_avg_sal       Column 명 :   avg_sal      sum_sal
CREATE OR REPLACE VIEW v_prof_avg_sal AS
SELECT deptno, AVG(sal) avg_sal, SUM(sal) sum_sal
FROM professor
GROUP BY deptno
;
--2. GROUP 함수 COLUMN 등록 안됨
INSERT INTO v_prof_avg_sal
VALUES(203,600,300)
;
--VIEW 삭제
DROP VIEW v_stud_dept102;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
;
-------------------------------------
---- 계층적 질의문
-------------------------------------
-- 1. 관계형 데이터 베이스 모델은 평면적인 2차원 테이블 구조
-- 2. 관계형 데이터 베이스에서 데이터간의 부모 관계를 표현할 수 있는 칼럼을 지정하여 
--    계층적인 관계를 표현
-- 3. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)
-- 4. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력 기능 제공

-- 사용법
-- SELECT 명령문에서 START WITH와 CONNECT BY 절을 이용
-- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치 제어
-- 출력 형식은  top-down 또는 bottom-up
-- 참고) CONNECT BY PRIOR 및 START WITH절은 ANSI SQL 표준이 아님

-- 문1) 계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 단대,학부
-- 학과순으로 top-down 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 10번 부서
SELECT deptno, dname, college
FROM department
START WITH deptno=10
CONNECT BY PRIOR deptno = college
;
-- 문2)계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 학과,학부
-- 단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 102번 부서이다
SELECT Level, deptno, dname, college
FROM department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno
;
--- 문3) 계층적 질의문을 사용하여 부서 테이블에서 부서 이름을 검색하여 단대, 학부, 학과순의
---         top-down 형식으로 출력하여라. 단, 시작 데이터는 ‘공과대학’이고,
---        각 LEVEL(레벨)별로 우측으로 2칸 이동하여 출력
SELECT LPAD('  ',(Level-1)*2)||dname 조직도
FROM department
START WITH dname = '공과대학'
CONNECT BY PRIOR deptno = college
;

------------------------------------------------------
--       TableSpace  (실제 table이 저장되는 공간)
---정의  :데이터베이스 오브젝트 내 실제 데이터를 저장하는 공간
--       이것은 데이터베이스의 물리적인 부분이며, 세그먼트로 관리되는 모든 DBMS에 대해 
--       저장소(세그먼트)를 할당
------------------------------------------------------
-- 1. TableSpace 생성
CREATE TABLESPACE user1 DATAFILE 'C:\BACKUP\tableSpace\user1.ora' SIZE 100M;
CREATE TABLESPACE user2 DATAFILE 'C:\BACKUP\tableSpace\user2.ora' SIZE 100M;
CREATE TABLESPACE user3 DATAFILE 'C:\BACKUP\tableSpace\user3.ora' SIZE 100M;
CREATE TABLESPACE user4 DATAFILE 'C:\BACKUP\tableSpace\user4.ora' SIZE 100M;
-- 2. 테이블의 테이블 스페이스 변경
--    1) 테이블의 NDEX와 Table의  테이블 스페이스 조회
SELECT index_name, table_name, tablespace_name
FROM user_indexes
;
ALTER INDEX pk_religionno3 REBUILD TABLESPACE USER1
;
SELECT table_name, tablespace_name
FROM user_tables
;
ALTER TABLE JOB3 MOVE TABLESPACE USER2
;
-- 3.  테이블 스페이스 Size 변경
ALTER DATABASE DATAFILE 'C:\BACKUP\tableSpace\user4.ora' RESIZE 200M;
-----------cmd 입력!--------------------------------------
--전부 system에서 권한을 준 후에 할 수 있다. (system_0702.sql)
-- Oracle 전체 Backup  (scott) -> cmd에 입력!!
EXPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp;
-- Oracle 전체 Restore  (scott)
IMPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle 부분 Backup후  부분 Restore (남의 것을 함부러 restore 시키지 말아라)
EXP scott/tiger FILE=dept_second.dmp TABLES=dept_second
EXP scott/tiger FILE=address.dmp TABLES=address
;
IMP scott/tiger FILE=dept_second.dmp    tables=dept_second
IMP scott/tiger FILE=address.dmp    tables=address
;

----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. 정의 : 어떤 사건이 발생했을 때 내부적으로 실행되도록 데이터베 이스에 저장된 프로시저
--           트리거가 실행되어야 할 이벤트 발생시 자동으로 실행되는 프로시저 
--           트리거링 사건(Triggering Event), 즉 오라클 DML 문인 INSERT, DELETE, UPDATE이 
--           실행되면 자동으로 실행
--  2. 오라클 트리거 사용 범위
--    1) 데이터베이스 테이블 생성하는 과정에서 참조 무결성과 데이터 무결성 등의 복잡한 제약 조건 생성하는 경우 
--    2) 데이터베이스 테이블의 데이터에 생기는 작업의 감시, 보완 
--    3) 데이터베이스 테이블에 생기는 변화에 따라 필요한 다른 프로그램을 실행하는 경우 
--    4) 불필요한 트랜잭션을 금지하기 위해 
--    5) 컬럼의 값을 자동으로 생성되도록 하는 경우 
-------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER triger_test
BEFORE
UPDATE ON dept
FOR EACH ROW --old, new 사용하기 위해
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || :old.dname);
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || :new.dname);
END;
UPDATE dept
SET dname='회계3팀'
WHERE deptno=72
;
ROLLBACK;
COMMIT;

----------------------------------------------------------
--현장work2 ) emp Table의 급여가 변화시
--       화면에 출력하는 Trigger 작성( emp_sal_change)
--       emp Table 수정전
--      조건 : 입력시는 empno가 0보다 커야함

--출력결과 예시
--     이전급여  : 10000
--     신  급여  : 15000
 --    급여 차액 :  5000
CREATE OR REPLACE TRIGGER emp_sal_change
BEFORE DELETE OR INSERT OR UPDATE ON emp
FOR EACH ROW
    WHEN (new.empno > 0)
    DECLARE
        sal_diff number;
BEGIN
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('이전 급여 : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('신 급여 : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('급여 차액 : ' || sal_diff);
END;
--7369 emp 업데이트
UPDATE emp
SET sal=1000
WHERE empno=7369
;

-----------------------------------------------------------------------------
--  EMP 테이블에 INSERT,UPDATE,DELETE문장이 하루에 몇 건의 ROW가 발생되는지 조사
--  조사 내용은 EMP_ROW_AUDIT에 
--  ID ,사용자 이름, 작업 구분,작업 일자시간을 저장하는 
--  트리거를 작성
-----------------------------------------------------------------------------
-- 1. SEQUENCE
--DROP  SEQUENCE  emp_row_seq;
CREATE SEQUENCE emp_row_seq;
-- 2. Audit Table
--DROP  TABLE  emp_row_audit;
CREATE TABLE emp_row_audit(
    e_id    NUMBER(6)   CONSTRAINT emp_row_pk PRIMARY KEY,
    e_name  VARCHAR2(30),
    e_gubun VARCHAR2(30),
    e_date  DATE
);
--3.Trigger
CREATE OR REPLACE TRIGGER emp_row_aud
    AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:new.ename,'inserting',SYSDATE);
        ELSIF UPDATING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:old.ename,'updating',SYSDATE);
        ELSIF DELETING THEN
         INSERT INTO emp_row_audit
          VALUES(emp_row_seq.NEXTVAL,:old.ename,'deleting',SYSDATE);
        END IF;
    END;

INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(3000,'유지원',3500,51);
INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(3100,'황정후',3500,51);
UPDATE emp
SET ename='황보슬'
WHERE empno=1601
;
DELETE emp
WHERE empno = 1502
;