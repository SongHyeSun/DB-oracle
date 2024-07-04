--Q1)
------------------------------------------------------------
--  EMP 테이블에서 사번을 입력받아 해당 사원의 급여에 따른 세금을 구함.
-- 급여가 2000 미만이면 급여의 6%, 
-- 급여가 3000 미만이면 8%, 
-- 5000 미만이면 10%, 
-- 그 이상은 15%로 세금
--- FUNCTION  emp_tax3
-- 1) Parameter : 사번 p_empno
--    변수       : v_sal(급여)
--                v_pct(세율)
-- 2) 사번을 가지고 급여를 구함
-- 3) 급여를 가지고 세율 계산 
-- 4) 계산 된 값 Return   number
-------------------------------------------------------------
--Q2)
-----------------------------------------------------
--  Procedure up_emp 실행 결과
-- SQL> EXECUTE up_emp(1200);  -- 사번 p_empno
-- 결과: 급여 인상 저장
--      시작문자
-- 변수: v_job(업무)
--      v_up(임금인상)

-- 조건 1) job = SALE포함         v_up : 10
--        IF  v_job LIKE 'SALE%' THEN
--     2)     MAN      v_up : 7  
--     3)              v_up : 5
-- job에 따른 급여 인상을 수행  sal = sal+sal*v_up/100 --> 임금 인상률
-- 확인 : DB -> TBL
-----------------------------------------------------
--Q3)
----------------------------------------------------------
--HW01)
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- 사원번호 : 5555
-- 사원이름 : 55
-- 입 사 일 : 81/12/03
-- 데이터 삭제 성공
--  1. Parameter : 사번 입력
--  2. 사번 이용해 사원번호 ,사원이름 , 입 사 일 출력
--  3. 사번 해당하는 데이터 삭제 
---------------------------------------------------------
--Q4)
---------------------------------------------------------
--현장 work02)
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
---------------------------------------------------------
--Q5)
---------------------------------------------------------
-- EXECUTE 문을 이용해 함수를 실행합니다.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------
--Q6)
-----------------------------------------------------
-- Fetch 문    ***
-- SQL> EXECUTE  Cur_sal_Hap (5);
-- CURSOR 문 이용 구현 
-- 부서만큼 반복 
-- 	부서명 : 인사팀
-- 	인원수 : 5
-- 	급여합 : 5000
--  Cursor : dept_sum
-----------------------------------------------------
--Q7)
------------------------------------------------------------------------
-- FOR문을 사용하면 커서의 OPEN, FETCH, CLOSE가 자동 발생하므로 
-- 따로 기술할 필요가 없고, 레코드 이름도 자동
-- 선언되므로 따로 선언할 필요가 없다.
-----------------------------------------------------------------------
--Q8)
-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  lowsal_err (최저급여 ->1500)  
-----------------------------------------------------------
--Q9)
-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  highsal_err (최고급여 ->9000 이상 오류 발생)  
---   2. 기타조건
---      1) emp.ename은 Unique 제약조건이 걸려 있다고 가정 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max 번호 입력 
---      3) hiredate     : 시스템 날짜 입력 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column입력한다 가정
---      5) DUP_VAL_ON_INDEX --> 중복 데이터 ename 존재 합니다 / DUP_VAL_ON_INDEX 에러 발생
 --          highsal_err  -->ERROR!!!-지정한 급여가 너무 많습니다. 9000이하으로 다시 입력하세요
-----------------------------------------------------------
--Q10)
--Q11)
--Q12)
--Q13)
--Q14)
--Q15)
--Q16)
--Q17)
--Q18)
--Q19)
--Q20)
--Q21)
--Q22)
--Q23)
--Q24)
--Q25)
--Q26)
--Q27)
--Q28)
--Q29)
--Q30)
--Q31)
--Q32)
--Q33)
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