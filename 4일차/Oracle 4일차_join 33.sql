-- 4일차 오라클 조인
-- 1. JOIN
--    - 두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을
--      따로 분류하여 새로운 가상의 테이블을 만듦
--      -> 여러 테이블의 레코드를 조합하여 하나의 레코드로 만듦
-- ANSI 표준 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;

-- ANSI 표준 구문
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME FROM EMPLOYEE JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 테이블에 별칭 부여
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;
-- 조인하는 컬럼이 같을때 USING 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, JOB_CODE FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE);

-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME FROM EMPLOYEE, JOB WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- @실습문제1
-- 부서명과 지역명을 출력하세요.
SELECT * FROM DEPARTMENT;

SELECT * FROM LOCATION;

SELECT DEPT_TITLE, NATIONAL_CODE FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
