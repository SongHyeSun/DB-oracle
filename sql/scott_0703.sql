--1.scott에 있는 student TBL에 Read 권한 usertest04 주세요
GRANT SELECT ON scott.student TO usertest04;

--.현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
GRANT SELECT ON scott.emp TO usertest02 WITH GRANT OPTION;

GRANT SELECT ON scott.stud_101 TO usertest02;

GRANT SELECT ON scott.JOB3 TO usertest02 WITH GRANT OPTION;
REVOKE SELECT ON scott.job3 FROM usertest02; --최초에 권한 준

-- 전용 동의어 -> scott계정에서 동의어 생성해서, scott계정에서만 사용 가능하다
--Scott에서 전용동의어를 만들었지만, scott만 사용 가능
CREATE SYNONYM privateTBL FOR system.privateTBL;
SELECT * FROM privateTBL;

--------------------------------------------------------------------
----------  PL/SQL
--------------------------------------------------------------------
------------------------------------------------------------------------
---    PL/SQL의 개념
---   1. Oracle에서 지원하는 프로그래밍 언어의 특성을 수용한 SQL의 확장
---   2. PL/SQL Block내에서 SQL의 DML(데이터 조작어)문과 Query(검색어)문, 
---      그리고 절차형 언어(IF, LOOP) 등을 사용하여 절차적으로 프로그래밍을 가능하게 
---      한 강력한  트랜잭션 언어
---
---   1) 장점 
---      프로그램 개발의 모듈화 : 복잡한 프로그램을 의미있고 잘 정의된 작은 Block 분해
---      변수선언  : 테이블과 칼럼의 데이터 타입을 기반으로 하는 유동적인 변수를 선언
---      에러처리  : Exception 처리 루틴을 사용하여 Oracle 서버 에러를 처리
---      이식성    : Oracle과 PL/SQL을 지원하는어떤 호스트로도 프로그램 이동 가능
---      성능 향상 : 응용 프로그램의 성능을 향상
 
------------------------------------------------------------------------
--[예제1] 특정한 수에 세금을 7%로 계산하는 Function tax을 작성
create or replace FUNCTION TAX
 (p_num in number)  --parameter 선언
 RETURN number
IS
    v_tax number;
BEGIN
    v_tax := p_num*0.07;
    RETURN(v_tax);
End;

SELECT tax(100)
FROM dual
;
---------------------------------------------------------------------
--현장 WORK 02
--1) PROCEDURE INSERT_EMP
--2) PARAMETER(In) -> p_empno, p_ename, p_job, p_mgr, p_sal, p_deptno
--3) 변수명 v_comm
--4) 로직
--    1 p_job MANAGER -> v_comm(1000)
--    2 p_job ELSE    -> v_comm(150)
--    3 emp TBL insert (hiredate->현재일자)
CREATE OR REPLACE PROCEDURE insert_emp
( p_empno  IN emp.empno%Type, 
  p_ename  IN emp.ename%Type, 
  p_job    IN emp.job%Type,
  p_mgr    IN emp.mgr%Type,
  p_sal    IN emp.sal%Type,
  p_deptno IN emp.deptno%TYPE
)
IS
    --%Type 데이터형 변수 선언   변수 선언인 것을 알아보기 위해 써둔 것
    v_comm emp.comm%TYPE;
BEGIN
    IF p_job='MANAGER' THEN
         v_comm :=1000;
    ELSE v_comm :=150;
    END IF;
    
    INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES (p_empno, p_ename, p_job, p_mgr, SYSDATE, p_sal, v_comm, p_deptno);
    COMMIT;
END;