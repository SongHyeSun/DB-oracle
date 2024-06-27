--CH08. 그룹함수 
--테이블의 전체 행을 하나 이상의 컬럼을 기준으로 그룹화하여
--그룹별로 결과를 출력하는 함수
--그룹함수는 통계적인 결과를 출력하는데 자주 사용
---------------------------------------------------------
--SELECT  column, group_function(column)
--FROM  table
--[WHERE  condition]
--[GROUP BY  group_by_expression]
--[HAVING  group_condition]
--GROUP BY : 전체 행을 group_by_expression을 기준으로 그룹화
--HAVING : GROUP BY 절에 의해 생성된 그룹별로 조건 부여
-- 종류      의미
--COUNT:  행의 개수 출력
--MAX:    NULL을 제외한 모든 행에서 최대 값
--MIN:    NULL을 제외한 모든 행에서 최소 값
--SUM:    NULL을 제외한 모든 행의 합
--AVG:    NULL을 제외한 모든 행의 평균 값
-------까지 필수-------------
--STDDEV: NULL을 제외한 모든 행의 표준편차
--VARIANCE: NULL을 제외한 모든 행의 분산 값
--GROUPING: 해당 칼럼이 그룹에 사용되었는지 여부를 1 또는 0으로 반환
--GROUPING SETS: 한 번의 질의로 여러 개의 그룹화 기능

-- 1) COUNT 함수
-- 테이블에서 조건을 만족하는 행의 갯수를 반환하는 함수
-- ex) 101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라
SELECT COUNT(*), COUNT(comm)
FROM professor
WHERE deptno=101
;
--ex)102번 학과 학생들의 몸무게 평균과 합계를 출력하여라
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno=102
;
--ex)교수 테이블에서 급여의 표준편차와 분산을 출력
SELECT STDDEV(sal), VARIANCE(sal)
FROM professor
;
--ex)학과별  학생들의 인원수, 몸무게 평균과 합계를 출력하여라
SELECT deptno, count(*), AVG(weight), SUM(weight)
FROM student
GROUP BY deptno
;
--ex) 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
;
-- ex)교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
--    단 학과별로 교수 수가 2명 이상인 학과만 출력
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
HAVING COUNT(*)>1
;
--ex)학생 수가 4명이상이고 평균키가 168이상인  학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
--   단, 평균 키와 평균 몸무게는 소수점 두 번째 자리에서 반올림 하고, 
--   출력순서는 평균 키가 높은 순부터 내림차순으로 출력하고 
--   그 안에서 평균 몸무게가 높은 순부터 내림차순으로 출력
SELECT grade, COUNT(*),
       ROUND(AVG(HEIGHT),1) avg_height,
       ROUND(AVG(WEIGHT),1) avg_weight
FROM student
GROUP BY grade
HAVING COUNT(*)>=4
AND ROUND(AVG(HEIGHT))>=168
ORDER BY avg_height DESC, avg_weight DESC
;
--ex) 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT MAX(hiredate), MIN(hiredate)
FROM emp
;
--ex) 부서별 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT deptno, MAX(hiredate), MIN(hiredate)
FROM emp
GROUP BY deptno
;
--ex)부서별, 직업별 count & sum[급여]    (emp)
SELECT deptno,job, COUNT(*), SUM(sal)
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job
;
--ex)부서별 급여총액 3000이상 부서번호,부서별 급여최대    (emp)
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal)>=3000
;
--ex)전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여, 
--   학과와 학년별 인원수, 평균 몸무게를 출력, 
--   (단, 평균 몸무게는 소수점 이하 첫번째 자리에서 반올림 )  STUDENT
SELECT deptno, grade, COUNT(*), ROUND(AVG(weight))
FROM student
GROUP BY deptno, grade
ORDER BY deptno, grade
;
-- ROLLUP 연산자
-- GROUP BY 절의 그룹 조건에 따라 전체 행을 그룹화하고 각 그룹에 대해 부분합을 구하는 연산자
-- 문) 소속 학과별로 교수 급여 합계와 모든 학과 교수들의 급여 합계를 출력하여라
SELECT deptno, SUM(sal)
FROM professor
GROUP BY ROLLUP(deptno)
;
--ex) ROLLUP 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY ROLLUP(deptno, position)
;
-- CUBE 연산자
-- ROLLUP에 의한 그룹 결과와 GROUP BY 절에 기술된 조건에 따라 그룹 조합을 만드는 연산자
--ex)CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라.
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY CUBE(deptno, position)
;
-------------------------------------------------------------------------
---- --------DeadLock    ---------
-------------------------------------------------------------------------
--Transaction A  ---> Developer
--1) Smith
UPDATE emp      ---> 자원1
SET    sal = sal*1.1
WHERE  empno=7369
;
--2 King        ---> A가 자원 2요구
UPDATE emp
SET    sal = sal*1.1
WHERE  empno=7839
;

--Transaction B ---> Sqlplus
UPDATE emp
SET    comm=500
WHERE  empno=7839
;
UPDATE emp      -->자원1 요구
SET    comm=300
WHERE  empno=7369
;

-- READ COMMITED
Insert INTO dept Values(72,'kk','kk');
COMMIT
;

----------------------------------------------------------------------
----                    9-1.     JOIN       ***                                           ---------
----------------------------------------------------------------------
-- 1) 조인의 개념
--  하나의 SQL 명령문에 의해 여러 테이블에 저장된 데이터를 한번에 조회할수 있는 기능
--ex1-1) 학번이 10101인 학생의 이름과 소속 학과 이름을 출력하여라
SELECT studno, name, deptno
FROM student
WHERE studno=10101
;
--ex1-2)학과를 가지고 학과이름
SELECT dname
FROM department
WHERE deptno=101
;
--ex1-3)  [ex1-1] + [ex1-2] 한방 조회  ---> Join
SELECT studno, name,
       student.deptno, department.dname
FROM   student, department
WHERE  student.deptno = department.deptno
;
--JOIN할 때 조심해야할 것 (오류가 뜬다.)
SELECT studno, name, deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
--애매모호성 때문에!!
SELECT studno, name, s.deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
----애매모호성 (ambiguously)--> 해결: 별명(alias)
SELECT s.studno, s.name, d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
--ex) 전인하 학생의 학번, 이름, 학과 이름 그리고 학과 위치를 출력
SELECT s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.name= '전인하'
;
--ex)몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
SELECT s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.weight>=80
;

-- 카티션 곱  : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합
--1) 개발자 실수
--2) 개발 초기에 많은 Data 생성
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM student s, department d
;
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM student s CROSS JOIN department d
;

-- ***
-- 조인 대상 테이블에서 공통 칼럼을 ‘=‘(equal) 비교를 통해
-- 같은 값을 가지는 행을 연결하여 결과를 생성하는 조인 방법
-- SQL 명령문에서 가장 많이 사용하는 조인 방법
-- 자연조인을 이용한 EQUI JOIN
-- 오라클 9i 버전부터 EQUI JOIN을 자연조인이라 명명
-- WHERE 절을 사용하지 않고  NATURAL JOIN 키워드 사용
-- 오라클에서 자동적으로 테이블의 모든 칼럼을 대상으로 공통 칼럼을 조사 후, 내부적으로 조인문 생성

--oracle(오라클)Join 표기법
SELECT s.studno, s.name, d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;

--ANSI 표기법
--Natural Join Convert Error 해결
--NATURAL JOIN 시 조인 애트리뷰트에 테이블 별명을 사용하면 오류가 발생
SELECT s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
FROM student s
     NATURAL JOIN department d
;
SELECT s.studno, s.name, s.weight, d.dname, d.loc, deptno
FROM student s
     NATURAL JOIN department d
;
--ex) NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라
SELECT p.profno, p.name, deptno, d.dname
FROM professor p
     NATURAL JOIN department d
;
--ex) NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라
SELECT s.name, deptno, d.dname
FROM student s
     NATURAL JOIN department d
WHERE s.grade = '4'
;

-- JOIN ~ USING 절을 이용한 EQUI JOIN
-- USING절에 조인 대상 칼럼을 지정
-- 칼럼 이름은 조인 대상 테이블에서 동일한 이름으로 정의되어 있어야함
-- ex) JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
SELECT s.studno, s.name, deptno, dname
FROM student s JOIN department
     USING(deptno)
;

-- EQUI JOIN의 3가지 방법을 이용하여 성이 ‘김’씨인 학생들의 이름, 학과번호,학과이름을 출력
--1) Oracle-->  WHERE 절을 사용한 방법
SELECT s.name, d.deptno, d.dname
FROM student s , department d
WHERE s.deptno = d.deptno
AND s.name LIKE '김%'
;
--2) NATURAL JOIN절을 사용한 방법
SELECT s.name, deptno, d.dname
FROM student s NATURAL JOIN department d
WHERE s.name LIKE '김%'
;
--3) JOIN ~ USING절을 사용한 방법
SELECT s.name, deptno, d.dname
FROM student s JOIN department d
     USING(deptno)
WHERE s.name LIKE '김%'
;

-- 4) ANSI JOIN (INNER JOIN ~ ON)
SELECT s.name, d.deptno, d.dname
FROM student s INNER JOIN department d
ON   s.deptno=d.deptno
WHERE s.name LIKE '김%'
;

-- NON-EQUI JOIN **
-- ‘<‘,BETWEEN a AND b 와 같이 ‘=‘ 조건이 아닌 연산자 사용
-- eX) 교수 테이블과 급여 등급 테이블을 NON-EQUI JOIN하여 
--     교수별로 급여 등급을 출력하여라
CREATE TABLE "SCOTT"."SALGRADE2" 
   (	"GRADE" NUMBER(2,0), 
     	"LOSAL" NUMBER(5,0), 
    	"HISAL" NUMBER(5,0)
  );
  
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade2 s
WHERE p.sal BETWEEN s.losal AND s.hisal
;

-- OUTER JOIN  ***
-- EQUI JOIN에서 양측 칼럼 값중의 하나가 NULL 이지만 조인 결과로 출력할 필요가 있는 경우
-- OUTER JOIN 사용
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno
;
--ex) 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력
--    단, 지도교수가 배정되지 않은 학생이름도 함께 출력하여라. (==outer join을 걸어라)
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno(+)
;

--- ANSI OUTER JOIN
-- 1. ANSI LEFT OUTER JOIN
SELECT s.studno, s.name, s.profno, p.name
FROM student s
     LEFT OUTER JOIN professor p
     ON s.profno = p.profno
;
-- 2. ANSI RIGHT OUTER JOIN
--   1) ORACLE RIGHT OUTER JOIN
--ex) 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
--    단, 지도학생을 배정받지 않은 교수 이름도 함께 출력하여라
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno
ORDER BY p.profno
;
