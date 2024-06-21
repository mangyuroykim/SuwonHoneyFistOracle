-- 6일차 오라클 객체

-- == 1. view ==
/*  
    - 실제 테이블에 근거한 논리적인 가상의 테이블(사용자에게 하나의 테이블 처럼
    사용 가능하게 함)
    - SELECT 쿼리의 실행 결과를 화면에 저장한 논리적인 가상의 테이블(실질적인
    데이터를 저장하고 있지 않지만 하나의 테이블처럼 사용 가능함)
    
    1.2 종류
    1.2.1 Stored View(저장o) - 이름을 붙여서 저장함.
    1.2.2 Inline View(저장x) - FROM절 뒤에 적는 서브쿼리
    */
    
    CREATE VIEW EMP_VIEW
    AS SELECT EMP_ID, DEPT_CODE, JOB_CODE, MANAGER_ID
    FROM EMPLOYEE;
    -- 주의 : VIEW 만들때에는 권한이 필요함, 권한명 : CREATE VIEW
    -- System계정으로 권한 부여
    GRANT CREATE VIEW TO KH;
    --View 결과 확인
        SELECT * FROM EMP_VIEW;
    -- 1.2.2 Inline View(저장X) - FROM절 뒤에 적는 서브쿼리
        SELECT * FROM (SELECT EMP_ID, DEPT_CODE, JOB_CODE, MANAGER_ID
        FROM EMPLOYEE);
    
/*
    1.3 특징
    - 테이블에 있는 데이터를 보여줄 뿐이며, 데이터 자체를 포함하고 있는 것은 아님
    - 저장장치 내에 물리적으로 존재하지 않고 가상 테이블로 만들어짐
    - 물리적인 실제 테이블과의 링크 개념임.
    - 컬럼에 산술연산을 하여도 VIEW 생성가능
    - JOIN을 활용한 VIEW 생성가능
    1.4 목적
    - 원본 테이블이 아닌 뷰를 통해 특정 데이터만 보이도록 함.
    - 특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게하는 것을 방지함.
    
*/
-- ex) 연봉정보를 가지고 있는 VIEW를 생성하시오. (ANNUAL_SALARY_VIEW)
-- 사번, 이름, 급여, 연봉
CREATE VIEW ANNUAL_SALARY_VIEW(사번, 이름, 급여, 연봉)
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 FROM EMPLOYEE;

SELECT * FROM ANNUAL_SALARY_VIEW;
-- ex) 전체 직원의 사번, 이름, 직급명, 부서명, 지역명을 볼 수 있는 VIEW를 생성하시오(ALL_INFO_VIEW)
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

SELECT * FROM ALL_INFO_VIEW;

-- VIEW 수정해보기
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_EMPLOYEE;
-- 선동일의 DEPT_CODE를 D8로 바꾸는 DML을 작성하시오.
UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';

SELECT * FROM EMPLOYEE;
-- VIEW와 원본은 링크가 되어 있어서 VIEW 수정시 원본도 수정됨.
-- 확인했으면 ROLLBACK!
ROLLBACK;

-- VIEW 옵션
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE;
-- 기존 VIEW에 컬럼을 추가하여 만들고 시다면?
-- 지우고 만들기
DROP VIEW V_EMPLOYEE;
-- View V_EMPLOYEE이(가) 삭제되었습니다.
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;
-- 1.5.1 OR REPLACE
-- 수정하기
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
-- 1.5.2 FORCE/NOFORCE
-- 기본 테이블이 존재하지 않더라도 뷰를 생성하는 옵션
-- 1.5.3 WITH CHECK OPTION
-- WHERE 조건에 사용한 컬럼의 값을 수정하지 못하게 하는 옵션
-- 1.5.4 WITH READ ONLY
-- VIEW에 대해 조회만 가능하며 DML 불가능하게 하는 옵션
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE WITH READ ONLY;

UPDATE V_EMPLOYEE
SET EMP_NAME = '선동열'
WHERE EMP_ID = '200';
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only 42399.0000 - "cannot perform a DML operation on a read-only view

-- @실습예제1
-- KH계정 소유의 한 EMPLOYEE, JOB, DEPARTMENT 테이블의 일부 정보를 사용자에게 공개하려고 한다.
-- 사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일의 컬럼정보를 뷰(V_EMP_INFO)를 (읽기 전용으로)
-- 생성하여라.
CREATE OR REPLACE VIEW V_EMP_INFO(사원아이디,사원명,직급명,부서명,관리자명,입사일)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME, NVL(DEPT_TITLE, '미정'),(SELECT * FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID),'없음', HIRE_DATE
FROM EMPLOYEE E
LEFT OUTER JOIN JOB USING(JOB_CODE)
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WITH READ ONLY;
SELECT * FROM V_EMP_INFO;
-- 관리자명 어떻게 구하지?
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '송종기';