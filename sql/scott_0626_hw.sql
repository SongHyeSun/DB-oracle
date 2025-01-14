-- Q1)학생 테이블에서 ‘김영균’ 학생의 이름, 사용자 아이디를 출력하여라.
--    그리고 사용자 아이디의 첫 문자를 대문자로 변환하여 출력하여라
SELECT name, INITCAP(userid)
FROM student
WHERE name = '김영균'
;
-- Q2)학생 테이블에서 학번이 ‘20101’인 학생의 사용자 아이디를 
--   (소문자와 대문자로 변환하여 출력)
SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno=20101
;
-- Q3)부서 테이블에서 부서 이름의 길이를 문자 수와 바이트 수로 각각 출력하여라
SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM dept
;
-- Q4)한글 문자열 길이  Test --> Insert 안 된 표준 utf-8
INSERT INTO dept VALUES (59,'경영지원팀', '충정로');
-- Q5)CONCAT :두 문자열을 결합, ‘||’와 동일
SELECT name ||'의 직책은 '
FROM professor
;
-- Q6)학생 테이블에서 1학년 학생의 주민등록 번호에서 생년월일과 태어난 달을 추출하여
--    이름, 주민번호, 생년월일, 태어난 달, 성별을 출력하여라
SELECT name, idnum,
       SUBSTR(idnum,1,6), SUBSTR(idnum, 3, 4), SUBSTR(idnum, 7,1)
FROM student
WHERE grade=1
;
-- Q7)학과  테이블의 부서 이름 칼럼에서 ‘과’ 글자의 위치를 출력하여라
SELECT dname, INSTR(dname,'과')
FROM department
;
-- Q8)교수테이블에서 직급 칼럼의 왼쪽에 ‘*’ 문자를 삽입하여 10바이트로 출력하고
--    교수 아이디 칼럼은 오른쪽에 ‘+’문자를 삽입하여 12바이트로 출력
SELECT name, LPAD(position,10,'*'), RPAD(userid,12,'+')
FROM professor
;
-- Q9)학과 테이블에서 부서 이름의 마지막 글자인 ‘과’를 삭제하여 출력하여라
SELECT dname, RTRIM(dname, '과')
FROM department
;
-- Q10)교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여 소수점 첫째 자리와 
--     셋째 자리에서 반올림 한 값과 소숫점 왼쪽 첫째 자리에서 반올림한 값을 출력하여라
SELECT name, sal/22, ROUND(sal/22,1), ROUND(sal/22,3), ROUND(sal/22,-1)
FROM professor
WHERE deptno=101
;
-- Q11)교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여
--     소수점 첫째 자리와 셋째 자리에서 절삭 한 값과 
--     소숫점 왼쪽 첫째 자리에서 절삭한 값을 출력
SELECT name, sal/22, TRUNC(sal/22,1), TRUNC(sal/22,3), TRUNC(sal/22,-1)
FROM professor
WHERE deptno=101
;
-- Q12)교수 테이블에서 101번 학과 교수의 급여를
--     보직수당으로 나눈 나머지를 계산하여 출력하여라
SELECT name, MOD(sal, comm)
FROM professor
WHERE deptno=101
;
-- Q13)19.7보다 큰 정수 중에서 가장 작은 정수와
--     12.345보다 작은 정수 중에서 가장 큰 정수를 출력하여라
SELECT CEIL(19.7), FLOOR(12.345)
FROM dual
;
-- Q14)교수 번호가 9908인 교수의 입사일을 기준으로 입사 30일 후와 60일 후의 날짜를 출력
SELECT hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno=9908
;
-- Q15)SYSDATE 함수는 시스템에 저장된 현재 날짜를 반환하는 함수로서, 초 단위까지 반환
SELECT sysdate
FROM dual
;
-- Q16)날짜 - 숫자 = 날짜 (날짜에 일수를 감산)
SELECT sysdate
FROM
-- Q17)날짜 - 날짜=  일수 (날짜에 날짜를 감산)
SELECT
-- Q18)입사한지 120개월 미만인 교수의 교수번호, 입사일, 입사일로 부터 현재일까지의 개월 수,
--     입사일에서 6개월 후의 날짜를 출력하여라
-- Q19)학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 출력하여라
-- Q20)오늘이 속한 달의 마지막 날짜와 다가오는 일요일의 날짜를 출력하여라
-- Q21)학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 문자로 출력하여라
-- Q22)cw02) 보직수당을 받는 교수들의 이름, 급여, 보직수당, 
--           그리고 급여와 보직수당을 더한 값에 12를 곱한 결과를 연봉으로 출력
-- Q23)student Table에서 주민등록번호에서 생년월일을 추출하여 문자 ‘YY/MM/DD’ 형태로 
--     별명 BirthDate로 출력하여라
-- Q24) NVL 함수는 NULL을 0 또는 다른 값으로 변환하기 위한 함수
-- 101번 학과 교수의 이름, 직급, 급여, 보직수당, 급여와 보직수당의 합계를 출력하여라. 
-- 단, 보직수당이 NULL인 경우에는 보직수당을 0으로 계산한다
-- Q25)salgrade 데이터 전체 보기
-- Q26)scott에서 사용가능한 테이블 보기
-- Q27)emp Table에서 사번 , 이름, 급여, 업무, 입사일
-- Q28)emp Table에서 급여가 2000미만인 사람 에 대한 사번, 이름, 급여 항목 조회
-- Q29)emp Table에서 80/02이후에 입사한 사람에 대한  사번,이름,업무,입사일
-- Q30)emp Table에서 급여가 1500이상이고 3000이하 사번, 이름, 급여  조회(2가지)
-- Q31)emp Table에서 사번, 이름, 업무, 급여 출력 [ 급여가 2500이상이고  업무가 MANAGER인 사람]
-- Q32)emp Table에서 이름, 급여, 연봉 조회 
--    [단 조건은  연봉 = (급여+상여) * 12  , null을 0으로 변경]
-- Q33)emp Table에서  81/02 이후에 입사자들중 xxx는 입사일이 xxX
--  [ 전체 Row 출력 ] --> 2가지 방법 다
-- Q34)emp Table에서 이름속에 T가 있는 사번,이름 출력
-- Q35)102번 학과 교수중에서 보직수당을 받는 사람은 급여와 보직수당을 더한 값을
--     급여 총액으로 출력하여라. 
--     단, 보직수당을 받지 않는 교수는 급여만 급여 총액으로 출력하여라.
-- Q36)교수 테이블에서 이름의 바이트 수와 사용자 아이디의 바이트 수를 비교해서
--     같으면 NULL을 반환하고 
--     같지 않으면 이름의 바이트 수를 반환
-- Q37)교수 테이블에서 교수의 소속 학과 번호를 학과 이름으로 변환하여 출력하여라.
--     학과 번호가 101이면 ‘컴퓨터공학과’, 102이면 ‘멀티미디어학과’, 201이면 ‘전자공학과’,
--     나머지 학과 번호는 ‘기계공학과’(default)로 변환
-- Q38)교수 테이블에서 소속 학과에 따라 보너스를 다르게 계산하여 출력하여라. (별명 --> bonus)
--    학과 번호별로 보너스는 다음과 같이 계산한다.
--    학과 번호가 101이면 보너스는 급여의 10%, 102이면 20%, 201이면 30%, 나머지 학과는 0%
--     2가지 다 해보기
-- Q39)emp Table 의 이름을 대문자, 소문자, 첫글자만 대문자로 출력
-- Q40)emp Table 의  이름, 업무, 업무를 2-5사이 문자 출력
-- Q41)emp Table 의 이름, 이름을 10자리로 하고 왼쪽에 #으로 채우기
-- Q42)emp Table 의  이름, 업무, 업무가 MANAGER면 관리자로 출력
-- Q43)emp Table 의  이름, 급여/7을 각각 정수, 소숫점 1자리. 10단위로   반올림하여 출력
-- Q44)emp Table 의  이름, 급여/7을 각각 절사하여 출력
-- Q45)emp Table 의  이름, 급여/7한 결과를 반올림,절사,ceil,floor
-- Q46)emp Table 의 이름, 급여, 입사일, 입사기간(각각 날자,월)출력,  소숫점 이하는 반올림
-- Q47)emp Table 의  job 이 'CLERK' 일때 10% ,'ANALYSY' 일때 20% 
--                        'MANAGER' 일때 30% ,'PRESIDENT' 일때 40%
--                        'SALESMAN' 일때 50% 
--                        그외일때 60% 인상 하여 
--   empno, ename, job, sal, 및 각 인상 급여를 출력하세요(CASE/Decode문 사용)
-- Q48)
-- Q49)