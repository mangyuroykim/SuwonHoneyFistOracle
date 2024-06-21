-- 5일차 JOIN

-- @함수 종합실습 - 형변환 함수, 기타 함수
--10. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME AS 직원명 , JOB_CODE "직급코드", 
TO_CHAR(SALARY, 'L999,999,999') AS "연봉(원)"
FROM EMPLOYEE;


--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.

SELECT EMP_NAME "사원명",
    CASE
        WHEN DEPT_CODE = 'D5' THEN '총무부'
        WHEN DEPT_CODE = 'D6' THEN '기획부'
        WHEN DEPT_CODE = 'D9' THEN '영업부'
    END "부서명"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6' , 'D9')
ORDER BY DEPT_CODE ASC;

-- JOIN으로도 가능, JOIN으로 출력해보세요
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT
ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');

-- 12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.(JOIN아님)
SELECT DECODE(ENT_YN, 'N', '재직', '퇴직')"상태",COUNT(*) "인원수"
FROM EMPLOYEE
GROUP BY ENT_YN;

-- @JOIN 종합실습
--1. 주민번호가 1970년대 생이면서 성별이 여자이고,
-- 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE EMP_NO LIKE '7%-2%' AND EMP_NAME LIKE '전%';

-- 2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%형%';

-- 3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE LIKE '해외영업_부';

-- 4. 보너스 포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
-- 테이블의 순서를 신경써야 할 경우가 있다.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;
-- 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';
 // 시험 문제에 나올거같음 조인 로케이션이 디파츠먼트 온보다 위에있으면 에러뜸 missing expression
 
 -- 6. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
 -- (사원테이블과 급여등급테이블을 SAL_LEBEL컬럼 기준으로 조인할 것)
 -- 데이터 없음!
 SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*12, MAX_SAL
 FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE)
 JOIN SAL_GRADE USING(SAL_LEVEL)
 WHERE SALARY > MAX_SAL;
 
 SELECT * FROM SAL_GRADE;
 
 -- 7.한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
 SELECT EMP_NAME, 
 
 -- 8. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
 -- 단, join과 IN 사용할 것


-- 1. JOIN의 종류
-- 1.1 INNER JOIN : 교집합, 일반적으로 사용하는 조인
-- 1.2 OUTER JOIN : 합집합, 모두 출력하는 조인
-- ex) 사원명과 부서명을 출력하시오
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 21개임, 2개가 빠짐,
-- 2개는 왜 빠졌나? , DEPT_CODE가 NULL인 데이터를 빠짐
-- -> 이것을 INNER JOIN이라고 함.

SELECT COUNT(*) FROM EMPLOYEE; -- 23

--LEFT OUTER JOIN은 왼쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 23개임, 2개가 안빠짐,

--RIGHT OUTER JOIN은 오른쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 23개임, 2개가 안빠짐,

--FULL OUTER JOIN은 양쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문, JOIN  사용해보기
-- 1. INNER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
-- 2. LEFT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
-- 3. RIGHT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
-- 4. FULL OUTER JOIN