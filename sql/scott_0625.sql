-- 현재 계정의 모든 table을 조회
SELECT * FROM tab;
-- dept table의 내용 조회
DESC dept;
-- dept TBL -> deptno, loc 보여줘
Select deptno, loc From dept;

--부서 테이블에서 부서이름(dname)과 부서번호(deptno)를 출력하여라
SELECT dname, deptno FROM dept;
--학생 테이블에서 중복되는 학과 번호(deptno)를 제외하고 출력하여라 --> distinct
SELECT distinct deptno FROM student;


--별명(alias) 부여 방법
--칼럼 이름과 별명 사이에 공백을 추가하는 방법
--칼럼 이름과 별명 사이에 AS 키워드를 추가하는 방법
--큰따옴표를 사용하는 방법
--칼럼 이름과 별명 사이에 공백을 추가하는 경우
--특수문자를 추가하거나 대소문자를 구분하는 경우

--ex 부서 테이블에서 부서 이름 칼럼의 별명은 dept_name,
--   부서 번호 칼럼의 별명은 DN으로 부여하여 출력하여라
SELECT dname dept_name, deptno AS dn
FROM   department;


--합성(concatenation)연산자 (||)
--하나의 칼럼과 다른 칼럼,
--산술 표현식 또는 상수 값과 연결하여 하나의 칼럼처럼 출력할 경우에 사용
--ex)학생 테이블에서 학번과 이름 칼럼을 연결하여
--   “StudentAli”라는 별명으로 하나의 칼럼처럼 연결하여 출력하여라
SELECT studno|| ' ' || name "StudentAli"
FROM   student;

-- cw1. 학생의 몸무게를 pound로 환산하고
--      칼럼 이름을 'weigh_pound'라는 별명으로 출력하여라.
--      출력 내용은 이름, 몸무게, weigh_pound
--      1kg은 2.2pound
SELECT name, weight, weight*2.2 AS weigh_pound
From student;

--CHAR와 VARCHAR2의 비교 예시 문장
-- 아래 table만드는 것을 DDL이라 부른다.
CREATE TABLE ex_type
(c   CHAR(10),
 v   VARCHAR2(10)
 )
 -- DML이라 부른다.
 INSERT INTO ex_type
 VALUES('sql','sql');
 --DCL이 commit
 COMMIT;
 
 SELECT *
 FROM   ex_type
 WHERE  c = 'sql'
 ;
 
 SELECT *
 FROM   ex_type
 WHERE  v = 'sql'
 ;
 
 SELECT *
 FROM   ex_type
 WHERE  v = c
 ;
 
 --조건절 where절
 --ex) 학생 테이블에서 1학년 학생만 검색하여 학번, 이름, 학과 번호를 출력하여라 (HW01)
 SELECT studno, name, deptno
 FROM student
 WHERE grade = '1'
 ;
 --'1'로 하면 자동으로 To_number로 자바의 형변환 같이 해준다.
 --(시스템에서 자동으로 해주는데 방법 알아보기 위해서)
 SELECT studno, name, deptno
 FROM student
 WHERE grade = TO_NUMBER('1')
 ;
 
 --ex) 학생 테이블에서 몸무게가 70kg 이하인 학생만 검색하여
 --    학번, 이름, 학년, 학과번호, 몸무게를 출력하여라.
 SELECT studno, name, grade, deptno, weight
 FROM student
 WHERE weight <= 70
 ;
 --ex)학생 테이블에서 1학년 이면서 몸무게가 70kg 이상인 학생만 검색하여
 --   이름, 학년, 몸무게, 학과번호를 출력하여라
 SELECT name, grade, weight, deptno
 FROM student
 WHERE grade = 1
 AND   weight >=70
 ;
 
 --ex) 학생 테이블에서 1학년이거나 몸무게가 70kg 이상인 학생만 검색하여
 --    이름, 학년, 몸무게, 학과번호를 출력하여라.
 SELECT name, grade, weight, deptno
 FROM student
 WHERE grade = 1
 OR   weight >=70
 ;
 
 --ex) BETWEEN 연산자를 사용하여 몸무게가 50kg에서 70kg 사이인 학생의
 --    학번, 이름, 몸무게를 출력하여라
 SELECT studno, name, weight
 FROM student
 WHERE weight BETWEEN 50 AND 70
 ;
 
 --ex) 학생테이블에서 81년에서 83년도에 태어난 학생의
 --    이름과 생년월일을 출력해라
 SELECT name, birthdate
 FROM student
 --WHERE birthdate BETWEEN '81/01/01' AND '83/12/31'
 WHERE birthdate BETWEEN TO_DATE('810101') AND TO_DATE('831231')
 ;
 
 --ex) IN 연산자를 사용하여 102번 학과와 201번 학과 학생의
 --    이름, 학년, 학과번호를 출력하여라
 SELECT name, grade, deptno
 FROM student
 WHERE deptno IN(102,201)
-- WHERE deptno = 102
-- OR    deptno = 201
 ;
 
-- LIKE 연산자
--?칼럼에 저장된 문자열중에서 LIKE 연산자에서 지정한 문자 패턴과 부분적으로 일치하면 참이 되는 연산자
--ex) 학생 테이블에서 성이 ‘김’씨인 학생의 이름, 학년, 학과 번호를 출력하여라
SELECT name, grade, deptno
FROM student
WHERE name LIKE '김%'
;
--ex) 이름 중 '진'
SELECT name, grade, deptno
FROM student
WHERE name LIKE '%진%'
;
--ex) 이름 끝 '진'
SELECT name, grade, deptno
FROM student
WHERE name LIKE '%진'
;
--ex)학생 테이블에서 이름이 3글자, 성은 ‘김’씨고
--   마지막 글자가 ‘영’으로 끝나는 학생의 이름, 학년, 학과 번호를 출력하여라
SELECT name, grade, deptno
FROM student
WHERE name LIKE '김%영'
;
SELECT name, grade, deptno
FROM student
WHERE name LIKE '김_영'
;

--NULL의 개념
--NULL은 미확인 값이나 아직 적용되지 않은 값을 의미
 SELECT empno, sal, comm
 FROM emp;
 
 SELECT empno, sal, comm, sal + comm
 FROM emp;
  
 SELECT empno, sal, comm, sal + NVL(comm,0)
 FROM emp;
 
 
 --ex) 교수 테이블에서 이름, 직급, 보직수당을 출력하여라
 SELECT name, position, comm
 FROM professor
 ;
 
 --ex) 교수 테이블에서 보직수당이 없는 교수의 이름, 직급, 보직수당을 출력하여라
 SELECT name, position, comm
 FROM professor
 WHERE comm IS null
 --WHERE comm = null 으로 하면 안된다.
 ;
 
 --ex) 교수 테이블에서 급여에 보직수당을 더한 값은 sal_com이라는 별명으로
 --    교수의 이름, 직급, 보직수당, sal_com을 출력하여라
 SELECT name, position, comm, sal+comm sal_com
 FROM professor
 ;
 
 --ex) 교수 테이블에서 급여에 보직수당을 더한 값은 sal_com이라는 별명으로 출력
 --    조건: sal_com 항목은 comm이 Null이면 0으로 취급
 SELECT name, position, comm, sal + NVL(comm,0) sal_com
 FROM professor
 ;
 
 --ex)102번 학과의 학생 중에서 1학년 또는 4학년 학생의
--    이름, 학년, 학과 번호를 출력하여라
 SELECT name, grade, deptno
 FROM student
 WHERE deptno = 102
 AND (grade = 1 OR grade = 4)
 ;
 
 --집합연산자: 테이블을 구성하는 행집합에 대해 테이블의 부분 집합을 결과로 반환하는 연산자
 --유형
 --UNION: 두 집합에 대해 중복되는 행을 제외한 합집합
 --UNION ALL: 두 집합에 대해 중복되는 행을 포함한 합집합
 --MINUS: 두 집합간의 차집합
 --INTERSECT: 두 집합간의 교집합
 --ex) 1학년 이면서 몸무게가 70kg 이상인 학생의 집합 --> Table  stud_heavy
 CREATE TABLE stud_heavy
 AS
    SELECT *
    FROM student
    WHERE grade = 1
    AND   weight >= 70
 ;
 
 --ex) 1학년 이면서 101번 학과에 소속된 학생(stud_101)
 CREATE TABLE stud_101
 AS
    SELECT *
    FROM student
    WHERE grade = 1
    AND deptno = 101
    ;
    
--UNION--> Error의 이유: 동일 컬럼의 수 X
SELECT studno, name, userid
FROM   stud_heavy
UNION
SELECT studno, name
FROM stud_101
;
SELECT studno, name
FROM   stud_heavy
UNION
SELECT studno, name
FROM stud_101
;
-- Union  중복 제거   (박동진 , 서재진) + (박미경 , 서재진)
SELECT studno, name
FROM   stud_heavy
UNION ALL
SELECT studno, name
FROM stud_101
;

-- Intersect --> 공통
SELECT studno, name
FROM   stud_heavy
INTERSECT
SELECT studno, name
FROM stud_101
;

--Minus (박동진, 서재진) - (박미경, 서재진)
SELECT studno, name
FROM   stud_heavy
MINUS
SELECT studno, name
FROM stud_101
;

--정렬(sorting)
--SQL 명령문에서 검색된 결과는 테이블에 데이터가 입력된 순서대로 출력
--하지만, 데이터의 출력 순서를 특정 컬럼을 기준으로 오름차순 또는 내림차순으로 정렬하는 경우가 자주 발생
--여러 개의 칼럼에 대해 정렬 순서를 정하는 경우도 발생
--ORDER BY : 칼럼이나 표현식을 기준으로 출력 결과를 정렬할 때 사용
--ASC : 오른차순으로 정렬, 기본 값
--DESC : 내림차순으로 정렬하는 경우에 사용, 생략 불가능
--ex) 학생 테이블에서 이름을 가나다순으로 정렬하여 이름, 학년, 전화번호를 출력하여라
SELECT   name, grade, tel
FROM     student
--ORDER BY name
--ORDER BY name ASC
ORDER BY name DESC
;

--ex) 학생 테이블에서 학년을 내림차순으로 정렬하여 이름, 학년, 전화번호를 출력하여라
SELECT name, grade, tel
FROM student
ORDER BY grade DESC
;

--ex) 모든 사원의 이름과 급여 및 부서번호를 출력하는데,
--    부서 번호로 결과를 정렬한 다음 급여에 대해서는 내림차순으로 정렬하라.
SELECT ename, job, deptno, sal
FROM emp
ORDER BY deptno, sal DESC
;

--여기부터 현장 Work -->(HW)
--Q1) 부서 10과 30에 속하는 모든 사원의 이름과 부서번호를
--    이름의 알파벳 순으로 정렬되도록 질의문을 형성하라.
SELECT ename, deptno
FROM   emp
ORDER BY ename ASC
;
--Q2) 1982년에 입사한 모든 사원의 이름과 입사일을 구하는 질의문
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '82/01/01' AND '82/12/31'
;
--Q3) 보너스를 받는 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는
--    질의문을 형성하라. 단 급여와 보너스에 대해서 내림차순 정렬
SELECT ename, sal, comm, sal + NVL(comm,0) sal_com
FROM emp
ORDER BY sal_com DESC
;
--Q4) 보너스가 급여의 20% 이상이고 부서번호가 30인 모든 사원에 대해서
--    이름, 급여 그리고 보너스를 출력하는 질의문을 형성하라
SELECT ename, sal, comm
FROM emp
WHERE comm >= sal*0.2
AND deptno = 30
;