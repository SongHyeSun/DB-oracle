--Q1)101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라
SELECT COUNT(*), COUNT(comm)
FROM professor
WHERE deptno=101
;
--Q2)102번 학과 학생들의 몸무게 평균과 합계를 출력하여라
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno=102
;
--Q3)교수 테이블에서 급여의 표준편차와 분산을 출력
SELECT STDDEV(sal), VARIANCE(sal)
FROM professor
;
--Q4)학과별  학생들의 인원수, 몸무게 평균과 합계를 출력하여라
SELECT deptno, COUNT(*), AVG(weight), SUM(weight)
FROM student
GROUP BY deptno
;
--Q5)교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno
;
--Q6)교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
--   단 학과별로 교수 수가 2명 이상인 학과만 출력
SELECT deptno, COUNT(*), COUNT(COMM)
FROM professor
GROUP BY DEPTNO
HAVING COUNT(*)>=2
;
--Q7)학생 수가 4명이상이고 평균키가 168이상인  학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
--   단, 평균 키와 평균 몸무게는 소수점 두 번째 자리에서 반올림 하고, 
--   출력순서는 평균 키가 높은 순부터 내림차순으로 출력하고 
--   그 안에서 평균 몸무게가 높은 순부터 내림차순으로 출력
SELECT GRADE, COUNT(*), 
       ROUND(AVG(HEIGHT),1) avg_height,
       ROUND(AVG(WEIGHT),1) avg_weight
FROM STUDENT
GROUP BY GRADE
HAVING COUNT(*)>=4
AND ROUND(AVG(HEIGHT),1)>=168
ORDER BY avg_height DESC, avg_weight DESC
;
--Q8)최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT MAX(hiredate), MIN(HIREDATE)
FROM EMP
;
--Q9)부서별 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT DEPTNO, MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
GROUP BY DEPTNO
;
--Q10)부서별, 직업별 count & sum[급여]    (emp)
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;
--Q11)부서별 급여총액 3000이상 부서번호,부서별 급여최대    (emp)
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
;
--Q12)전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여, 
--   학과와 학년별 인원수, 평균 몸무게를 출력, 
--   (단, 평균 몸무게는 소수점 이하 첫번째 자리에서 반올림 )  STUDENT
SELECT DEPTNO, GRADE, COUNT(*), ROUND(AVG(WEIGHT))
FROM student
GROUP BY DEPTNO, GRADE
ORDER BY DEPTNO, GRADE
;
--Q13)소속 학과별로 교수 급여 합계와 모든 학과 교수들의 급여 합계를 출력하여라
SELECT DEPTNO, SUM(SAL)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO)
;
--Q14)ROLLUP 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO, POSITION)
;
--Q15)CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라.
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY CUBE(DEPTNO, POSITION)
;
--Q16)학번이 10101인 학생의 이름과 소속 학과 이름을 출력하여라
SELECT NAME, DEPTNO
FROM STUDENT
WHERE STUDNO=10101
;
--Q17)학과를 가지고 학과이름
SELECT DNAME
FROM department
WHERE DEPTNO=101
;
--Q18)  [Q16] + [Q17] 한방 조회  ---> Join
SELECT S.STUDNO, S.NAME, D.DEPTNO, D.DNAME
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO = D.DEPTNO
;
--Q19)JOIN할 때 조심해야할 것 (오류가 뜬다.)
--Q20)애매모호성 (ambiguously)--> 해결: 별명(alias)
--Q21)전인하 학생의 학번, 이름, 학과 이름 그리고 학과 위치를 출력
SELECT S.DEPTNO, S.NAME, D.DNAME, D.LOC
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO = D.DEPTNO
AND S.NAME='전인하'
;
--Q22)몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
SELECT S.STUDNO, S.NAME, S.WEIGHT, D.DNAME, D.LOC
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO=D.DEPTNO
AND S.WEIGHT>=80
;
--Q23)카티션 곱  : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합

--Q24)oracle(오라클)Join 표기법
--Q25)ANSI 표기법
--Q26)NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라
--Q27)NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라
--Q28)JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
--Q29)EQUI JOIN의 3가지 방법을 이용하여 성이 ‘김’씨인 학생들의 이름, 학과번호,학과이름을 출력
--    1) Oracle-->  WHERE 절을 사용한 방법
--    2) NATURAL JOIN절을 사용한 방법
--    3) JOIN ~ USING절을 사용한 방법
--    4) ANSI JOIN (INNER JOIN ~ ON)
--Q30)교수 테이블과 급여 등급 테이블을 NON-EQUI JOIN하여 
--    교수별로 급여 등급을 출력하여라
--Q31)학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력
--    단, 지도교수가 배정되지 않은 학생이름도 함께 출력하여라. (==outer join을 걸어라)
--Q32)ANSI LEFT OUTER JOIN
--Q33)학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
--    단, 지도학생을 배정받지 않은 교수 이름도 함께 출력하여라
--Q34)
--Q35)
--Q36)
--Q37)
--Q38)
--Q39)
--Q40)
--Q41)
--Q42)
--Q43)
--Q44)
--Q45)
--Q46)
--Q47)
--Q48)
--Q49)
--Q50)
--Q51)
--Q52)
--Q53)
--Q54)
--Q55)
--Q56)
--Q57)
--Q58)
--Q59)
--Q60)
--Q61)
--Q62)
--Q63)
--Q64)
--Q65)
--Q66)
--Q67)
--Q68)
--Q69)
--Q70)
--Q71)
--Q72)
--Q73)
--Q74)
--Q75)
--Q76)
--Q77)
--Q78)
--Q79)
--Q80)
--Q81)
--Q82)
--Q83)
--Q84)
--Q85)
--Q86)
--Q87)
--Q88)
--Q89)
--Q90)
--Q91)
--Q92)
--Q93)
--Q94)
--Q95)
--Q96)
--Q97)
--Q98)
--Q99)
--Q100)