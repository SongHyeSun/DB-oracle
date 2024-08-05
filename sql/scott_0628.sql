-----------------------------------------------------------------
----- SUB Query   ***
-- 하나의 SQL 명령문의 결과를 다른 SQL 명령문에 전달하기 위해 
-- 두 개 이상의 SQL 명령문을 하나의 SQL명령문으로 연결하여
-- 처리하는 방법
-- 종류 
-- 1) 단일행 서브쿼리
-- 2) 다중행 서브쿼리
-------------------------------------------------------------------
-- ex)목표 : 교수 테이블에서 ‘전은지’ 교수와 직급이 동일한 모든 교수의 이름 검색
--    1-1 교수 테이블에서 ‘전은지’ 교수의 직급 검색 SQL 명령문 실행
SELECT position
FROM professor
WHERE name='전은지'
;
--    1-2 교수 테이블의 직급 칼럼에서 1 에서 얻은 결과 값과
--        동일한 직급을 가진 교수 검색 명령문 실행
SELECT name, position
FROM professor
WHERE position = '전임강사'
;
-- 1.목표 : 교수 테이블에서 ‘전은지’ 교수와 직급이 동일한 모든 교수의 이름 검색--> SUB Query
 SELECT name, position
 FROM professor
 WHERE position = (
                   SELECT position
                   FROM professor
                   WHERE name = '전은지'
        )
;

-- 종류 
-- 1) 단일행 서브쿼리
--  서브쿼리에서 단 하나의 행만을 검색하여 메인쿼리에 반환하는 질의문
--  메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 반드시 단일행 비교 연산자 중 
--  하나만 사용해야함

--ex) 사용자 아이디가 ‘jun123’인 학생과 같은 학년인 학생의 학번, 이름, 학년을 출력하여라
SELECT studno, name, grade
FROM student
WHERE grade = (
               SELECT grade
               FROM student
               WHERE userid='jun123'
     )
;
--ex)101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학년 , 학과번호, 몸무게를  출력
--   조건 : 학과별 오름차순 출력
SELECT name, grade, deptno, weight
FROM student
WHERE weight < (
                SELECT AVG(weight)
                FROM student
                WHERE deptno=101
      )
ORDER BY deptno
;
--ex) 20101번 학생과 학년이 같고, 키는 20101번 학생보다 큰 학생의 
-- 이름, 학년, 키, 학과명를 출력하여라
-- 조건 : 학과별 내림차순 출력
SELECT s.name, s.grade,s.height, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.grade = (
               SELECT grade
               FROM student
               WHERE studno=20101
    )
AND s.height > (
              SELECT height
              FROM student
              WHERE studno=20101
    )
ORDER BY d.dname DESC
;
-- 2) 다중행 서브쿼리
-- 서브쿼리에서 반환되는 결과 행이 하나 이상일 때 사용하는 서브쿼리
-- 메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 다중 행 비교 연산자 를 사용하여 비교
-- 다중 행 비교 연산자 : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참, ‘=‘비교만 가능
-- 2) ANY, SOME  : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참
-- 3) ALL             : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 모든값이 일치하면 참, 
-- 4) EXISTS        : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참

-- 1.  IN 연산자를 이용한 다중 행 서브쿼리
--  single-row subquery returns more than one row
SELECT name, grade, deptno
FROM student
WHERE deptno = (
                SELECT deptno
                FROM department
                WHERE college=100
      )
;
SELECT name, grade, deptno
FROM student
WHERE deptno IN (
                 SELECT deptno
                 FROM department
                 WHERE college=100
      )
;
SELECT name, grade, deptno
FROM student
WHERE deptno IN (
                101,102
      )
;
--2. ANY 연산자를 이용한 다중 행 서브쿼리 (or라고 생각)
-- ex)모든 학생 중에서 4학년 학생 중에서 키가 제일 작은 학생보다 키가 큰 학생의 학번, 이름, 키를 출력하여라
SELECT studno, name, height
FROM student
WHERE height > ANY (
                    -- 175 or 176 or 177--> MIN 생각
                    SELECT height
                    FROM student
                    WHERE grade='4'
               )
;
--- 3. ALL 연산자를 이용한 다중 행 서브쿼리 (and라고 생각)
SELECT studno, name, height
FROM student
WHERE height > ALL (
                    -- 175 and 176 and 177--> MAX 생각
                    SELECT height
                    FROM student
                    WHERE grade='4'
               )
;
--- 4. EXISTS 연산자를 이용한 다중 행 서브쿼리
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- 존재가 1 ROW라도 있다면,(exists)
              SELECT position
              FROM professor
              WHERE comm IS NOT NULL
      )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- 존재가 1 ROW라도 있다면,(exists)
              SELECT position
              FROM professor
              WHERE deptno=202
      )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS (
            -- 존재가 1 ROW라도 있다면,(exists)
              SELECT position
              FROM professor
              WHERE deptno=203
      )
;
--ex1)보직수당을 받는 교수가 한 명이라도 있으면 
--   모든 교수의 교수 번호, 이름, 보직수당 그리고 급여와 보직수당의 합(NULL처리)sal_comm 출력
SELECT profno, name, sal, comm, sal+NVL(comm,0) sal_comm
FROM professor
WHERE EXISTS (
              SELECT profno
              FROM professor
              WHERE comm IS NOT NULL
      )
;
--ex2) 학생 중에서 ‘goodstudent’이라는 사용자 아이디가 없으면 1을 출력하여라
SELECT 1 userid_exist
FROM dual
WHERE NOT EXISTS (
                  SELECT userid
                  FROM student
                  WHERE userid = 'goodstudent'
      )
;

-- 다중 컬럼 서브쿼리
-- 서브쿼리에서 여러 개의 칼럼 값을 검색하여 메인쿼리의 조건절과 비교하는 서브쿼리
-- 메인쿼리의 조건절에서도 서브쿼리의 칼럼 수만큼 지정
-- 종류
-- 1) PAIRWISE : 칼럼을 쌍으로 묶어서 동시에 비교하는 방식
-- 2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식

-- 1) PAIRWISE 다중 칼럼 서브쿼리
-- ex1) PAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 
--      학생의 이름, 학년, 몸무게를 출력하여라
SELECT name, grade, weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MIN(weight)
                          FROM student
                          GROUP BY grade
                          ORDER BY grade
                      )
;
--  2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식
-- ex)UNPAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력
SELECT name, grade, weight
FROM student
    --1,2,3,4
WHERE grade IN (SELECT grade
                FROM student
                GROUP BY grade
                )
                --52,42,70,72
AND weight IN (SELECT MIN(weight)
               FROM student
               GROUP BY grade
              )
;

-- 상호연관 서브쿼리     ***
-- 메인쿼리절과 서브쿼리간에 검색 결과를 교환하는 서브쿼리
-- 문1)  각 학과 학생의 평균 키보다 키가 큰 학생의 이름, 학과 번호, 키를 출력하여라
--   실행순서 1
---- 실행순서 3
SELECT deptno, name, grade, height
FROM student s1
WHERE height > (SELECT AVG(height)
                FROM student s2
                -- WHERE s2.deptno = 101
                --  실행순서 2
                WHERE s2.deptno = s1.deptno
               )
ORDER BY deptno, grade
;
-------------  HW (emp table) -----------------------
-- 1. Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이하라
SELECT ename, hiredate, deptno
FROM emp
WHERE deptno = (
                SELECT deptno
                FROM emp
                WHERE ename='BLAKE'
      )
;
-- 2. 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문을 생성. 
--    단 출력은 급여 내림차순 정렬하라
SELECT empno, ename, sal
FROM emp
WHERE sal >= (
              SELECT AVG(sal)
              FROM emp
      )
ORDER BY sal DESC
;
-- 3. (보너스를 받는 사원의 부서 번호와 
--    급여에 일치하는 사원)의 이름, 부서 번호 그리고 급여를 디스플레이하라.
SELECT e1.ename, e1.deptno, e1.sal
FROM emp e1, emp e2
WHERE (e1.deptno, e2.sal) IN (
                       SELECT deptno, sal
                       FROM emp
                       WHERE comm IS NOT NULL
                       AND e1.sal = e2.sal
                       AND e1.ename != e2.ename
                   )
;
SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN
            ( SELECT deptno, sal
              FROM emp
              WHERE comm IS NOT NULL
             )
;
SELECT ename, deptno, sal
FROM emp
WHERE deptno IN
            ( SELECT deptno
              FROM emp
              WHERE comm IS NOT NULL
             )
;
----------------------------------------------------------------------
--  데이터 조작어 (DML:Data Manpulation Language)  **  ----------
-- 1.정의 : 테이블에 새로운 데이터를 입력하거나 기존 데이터를 수정 또는 삭제하기 위한 명령어
-- 2. 종류 
--  1) INSERT : 새로운 데이터 입력 명령어
--  2) UPDATE : 기존 데이터 수정 명령어
--  3) DELETE : 기존 데이터 삭제 명령어
--  4) MERGE : 두개의 테이블을 하나의 테이블로 병합하는 명령어

-- 1) Insert
--not enough values
INSERT INTO dept VALUES (73,'인사')
;
INSERT INTO dept VALUES (73,'인사','이대')
;
INSERT INTO dept(deptno, dname, loc) VALUES (74,'회계팀','충정로')
;
INSERT INTO dept(deptno, loc, dname) VALUES (75,'신대방','자재팀')
;
INSERT INTO dept(deptno, loc) VALUES (76,'홍대')
;
--professor table에 행 추가

--9920	최윤식		조교수		06/01/01		102
--9910	백미선		전임강사		24/06/28		101
INSERT INTO professor(profno, name, position, hiredate, deptno)
       VALUES (9910,'백미선','전임강사',sysdate,101)
;
INSERT INTO professor(profno, name, position, hiredate, deptno)
       VALUES (9920,'최윤식','조교수',TO_DATE('2006/01/01','YYYY/MM/DD'),102)
;

DROP TABLE JOB3
;
CREATE TABLE JOB3
(   jobno          NUMBER(2)      PRIMARY KEY,
	jobname       VARCHAR2(20)
)
;
INSERT INTO job3 VALUES (10,'학교');
INSERT INTO job3 VALUES (11,'공무원');
INSERT INTO job3 VALUES (12,'공기업');
INSERT INTO job3(jobno,jobname) VALUES (13,'대기업');
INSERT INTO job3(jobname,jobno) VALUES ('중소기업',14);

--HW Insert 해주기!!
CREATE TABLE Religion   
(   religion_no         NUMBER(2)     CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
	 religion_name     VARCHAR2(20)
) ;
--10	기독교
--20	카톨릭교
--30	불교
--40	무교
INSERT INTO Religion(religion_no, religion_name) VALUES (10,'기독교');
INSERT INTO Religion(religion_name, religion_no) VALUES ('카톨릭교',20);
INSERT INTO Religion VALUES (30,'불교');
INSERT INTO Religion VALUES (40,'무교');
COMMIT;
ROLLBACK;

--------------------------------------------------
-----   다중 행 입력                          ------
--------------------------------------------------
-- 1. 생성된 TBL이용 신규 TBL 생성
CREATE TABLE dept_second
AS SELECT * FROM dept
;
--2. TBL 가공 생성
CREATE TABLE emp20
AS SELECT empno, ename, sal*12 annsal
   FROM emp
   WHERE deptno=20
;
--3.TBL구조만 (껍데기만)
CREATE TABLE dept30
AS SELECT deptno, dname
   FROM dept
   WHERE 0=1
;
--4. column추가
ALTER TABLE dept30
ADD (birth DATE)
;
INSERT INTO dept30 VALUES (10,'중앙학교',sysdate)
;
--5. Column변경
--some value is too big
ALTER TABLE dept30
MODIFY dname varchar2(11)
;
ALTER TABLE dept30
MODIFY dname varchar2(30)
;
--6 Column 삭제
ALTER TABLE dept30
DROP COLUMN dname
;
--7. TBL 명 변경
RENAME dept30 TO dept35
;
--8. TBL 제거
DROP TABLE dept35
;
--9. Truncate
TRUNCATE TABLE dept_second
;

-- INSERT ALL(unconditional INSERT ALL) 명령문
-- 서브쿼리의 결과 집합을 조건없이 여러 테이블에 동시에 입력
-- 서브쿼리의 컬럼 이름과 데이터가 입력되는 테이블의 칼럼이 반드시 동일해야 함
CREATE TABLE height_info
( studno    NUMBER(5),
  name      VARCHAR2(20),
  height    NUMBER(5,2)
)
;
CREATE TABLE weight_info
( studno    NUMBER(5),
  name      VARCHAR2(20),
  weight    NUMBER(5,2)
)
;
INSERT ALL
INTO height_info VALUES(studno, name, height)
INTO weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight, grade
FROM student
WHERE grade>='2'
;
DELETE height_info;
DELETE weight_info;


-- INSERT ALL 
-- [WHEN 조건절1 THEN
-- INTO [table1] VLAUES[(column1, column2,…)]
-- [WHEN 조건절2 THEN
-- INTO [table2] VLAUES[(column1, column2,…)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,…)]
-- subquery;
--ex)학생 테이블에서 2학년 이상의 학생을 검색하여 
--   height_info 테이블에는 키가 170보다 큰 학생의 학번, 이름, 키를 입력
--   weight_info 테이블에는 몸무게가 70보다 큰 학생의 학번, 이름, 몸무게를 
--   각각 입력하여라
INSERT ALL
WHEN height>170 THEN
    INTO height_info VALUES(studno, name, height)
WHEN weight>75 THEN
    INTO weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade>='2'
;

-- 데이터 수정 개요
-- UPDATE 명령문은 테이블에 저장된 데이터 수정을 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행을 수정
--- Update 
-- ex1) 교수 번호가 9903인 교수의 현재 직급을 ‘부교수’로 수정하여라
UPDATE professor
SET position = '부교수', userid='kkk'
WHERE profno = 9903
;
UPDATE professor
SET position = '부교수', userid='kkk'
WHERE profno = 9903
OR    1=1
;
ROLLBACK;
--ex2) 서브쿼리를 이용하여 학번이 10201인 학생의 학년과 학과 번호를
--        10103 학번 학생의 학년과 학과 번호와 동일하게 수정하여라
UPDATE student 
SET (grade,deptno) = (
                      SELECT grade, deptno
                      FROM student
                      WHERE studno=10103
)
WHERE studno = 10201
;

-- 데이터 삭제 개요
-- DELETE 명령문은 테이블에 저장된 데이터 삭제를 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행 삭제

-- ex1) 학생 테이블에서 학번이 20103인 학생의 데이터를 삭제
DELETE
FROM student
WHERE studno=20103
;
--ex2)학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라.(HW-->Rollback)
DELETE
FROM student
WHERE deptno = (
                SELECT deptno
                FROM department
                WHERE dname='컴퓨터공학과'
               )
;
ROLLBACK;

----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE 개요
--     구조가 같은 두개의 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작어(DML)
--     WHEN 절의 조건절에서 결과 테이블에 해당 행이 존재하면 UPDATE 명령문에 의해 새로운 값으로 수정,
--     그렇지 않으면 INSERT 명령문으로 새로운 행을 삽입
------------------------------------------------------------------------------------
-- 1] MERGE 예비작업 
--  상황 
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert
CREATE TABLE professor_temp
AS     SELECT * FROM professor
       WHERE position='교수'
;
UPDATE professor_temp
SET position = '명예교수'
WHERE position ='교수'
;
INSERT INTO professor_temp
VALUES (9999,'김도경','aroma21','전임강사',200,sysdate,10,101)
;
COMMIT;
-- 2] professor MERGE 수행 
-- 목표 : professor_temp에 있는 직위   수정된 내용을 professor Table에 Update
--                         김도경 씨가 신규 Insert 내용을 professor Table에 Insert
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert
MERGE INTO professor p
USING professor_temp f
ON (p.profno = f.profno)
when matched then           --PK가 같으면 직위를 Update
    update set p.position = f.position
when not matched then       --PK가 없으면 신규 Insert
    insert values (f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno)
;