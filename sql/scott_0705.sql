--------------------------------------------------------------
--  20240705 현장Work01
-- 1.  PROCEDURE update_empno
-- 2.  parameter -> p_empno, p_job
-- 3.  해당 empno에 관련되는 사원들을(Like) job을 사람의 직업을 p_job으로 업데이트
-- 4. Update -> emp 직업
-- 5.              입사일은 현재일자
-- 6.  기본적  EXCEPTION  처리 
-------------------------------------------------------------
CREATE OR REPLACE PROCEDURE update_empno
 (p_empno IN emp.empno%TYPE,
  p_job   IN emp.job%TYPE)
IS
    CURSOR emp_cursor IS
        SELECT empno
        FROM emp
        WHERE empno LIKE p_empno||'%';
    
   
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR emp_list IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('사원 : '||emp_list.empno);
        UPDATE emp
        SET job = p_job, hiredate = SYSDATE
        WHERE empno = emp_list.empno;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('수정 성공');
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
END;

---------------------------------------------------------------------------------------
-----    Package
--  자주 사용하는 프로그램과 로직을 모듈화
--  응용 프로그램을 쉽게 개발 할 수 있음
--  프로그램의 처리 흐름을 노출하지 않아 보안 기능이 좋음
--  프로그램에 대한 유지보수 작업이 편리
--  같은 이름의 프로시저와 함수를 여러 개 생성

----------------------------------------------------------------------------------------
--- 1.Header -->  역할 : 선언 (Interface 역할)
--     여러 PROCEDURE 선언 가능
CREATE OR REPLACE PACKAGE emp_info AS
    PROCEDURE all_emp_info;     --모든 사원의 사원 정보
    PROCEDURE all_sal_info;     --부서별 급여 정보
    PROCEDURE dept_emp_info(p_deptno IN NUMBER);    --특정 부서의 사원 정보
END emp_info;

--2. Body 역할: 실제 구현
CREATE OR REPLACE PACKAGE BODY emp_info AS
-----------------------------------------------------------------
    -- 모든 사원의 사원 정보(사번, 이름, 입사일)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 사번,이름,입사일 
    -- 4. 기본적  EXCEPTION  처리 
    -----------------------------------------------------------------
    PROCEDURE all_emp_info     --모든 사원의 사원 정보
    IS
        CURSOR emp_cursor IS
            SELECT empno, ename, TO_CHAR(hiredate, 'YYYY/MM/DD') hiredate
            FROM emp
            ORDER BY hiredate;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR emp_list  IN emp_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('사번 : '||emp_list.empno);
            DBMS_OUTPUT.PUT_LINE('성명 : '||emp_list.ename);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||emp_list.hiredate);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
    END all_emp_info;
    
    -----------------------------------------------------------------------
    -- 모든 사원의 부서별 급여 정보
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 부서명 ,전체급여평균 , 최대급여금액 , 최소급여금액
   -----------------------------------------------------------------------
    PROCEDURE all_sal_info
    IS
        CURSOR empdept_cursor IS
            SELECT d.dname 부서명, ROUND(AVG(e.sal),3) avg_sal, MAX(e.sal) max_sal, MIN(e.sal) min_sal
            FROM dept d, emp e
            WHERE d.deptno = e.deptno
            GROUP BY d.dname;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR empdept IN empdept_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('부서명 : '||empdept.부서명);
            DBMS_OUTPUT.PUT_LINE('전체 급여 평균 : '||empdept.avg_sal);
            DBMS_OUTPUT.PUT_LINE('최대 급여 금액 : '||empdept.max_sal);
            DBMS_OUTPUT.PUT_LINE('최소 급여 금액 : '||empdept.min_sal);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
    END all_sal_info;

-----------------------------------------------------------------
    --특정 부서의 사원 정보
    -- 사번, 성명, 입사일
-----------------------------------------------------------------
    PROCEDURE dept_emp_info(p_deptno IN NUMBER)
    IS
        CURSOR dept_cursor IS
            SELECT empno, ename, TO_CHAR(hiredate,'YYYY/MM/DD') hiredate
            FROM emp
            WHERE deptno = p_deptno
            ORDER BY hiredate;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR empdept IN dept_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('사번 : '||empdept.empno);
            DBMS_OUTPUT.PUT_LINE('성명 : '||empdept.ename);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||empdept.hiredate);
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
    END dept_emp_info;
END emp_info;