SHOW USER;

CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
-- 1. 컬럼의 데이터 타입없이 테이블 생성하여 오류남
-- -> 데이터타입 작성
-- 2. 권한도 없이 테이블을 생성하여 오류남
-- -> System_계정에서 RESOURCE 권한 부여
-- 3. 접속해제 후 접속, 새로운 워크시트 말고 기존 워크시트에서 접속을 선택하여
-- 명령어 재실행

INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T1', 'D1' , 33  );
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('이용자', 'T2', 'D1', 44);
INSERT INTO EMPLOYEE
VALUES('삼용자', 'T1', 'D2', 32);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T2', 'D1' , 43  );

DROP TABLE EMPLOYEE; --테이블 통으로 날리는거

DELETE FROM EMPLOYEE WHERE NAME = '일용자';
UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '일용자';

SELECT NAME , T_CODE, D_CODE, AGE FROM EMPLOYEE
WHERE NAME = '일용자';


SELECT * FROM EMPLOYEE;

-- 이름이 STUDENT_TBL인 테이블을 만드세요.
-- 이름, 나이, 학년, 주소를 저장할 수 있도록 하여
-- 일용자를 사용자로 바꿔주세요.
-- 데이터를 삭제하는 쿼리문을 작성하고 삭제를 확인하시고
-- 데이터를 삭제하는 쿼리문을 작성하여 테이블이 사라진 것을 확인하세요.
CREATE TABLE STUDENT_TBL (
    NAME VARCHAR2(20),
    AGE NUMBER,
    GRADE VARCHAR2(10),
    ADDRESS VARCHAR2(200)
    );
SELECT * FROM STUDENT_TBL;
ROLLBACK;
INSERT INTO STUDENT_TBL 
VALUES('일용자', 21, '1', ' 서울시 중구');
COMMIT;
INSERT INTO STUDENT_TBL
VALUES('이용자', 22, '2', '서울시 중구');
COMMIT;
UPDATE STUDENT_TBL
SET NAME = '사용자'
WHERE AGE = 21;

DELETE FROM STUDENT_TBL;
SELECT * FROM STUDENT_TBL;
DROP TABLE STUDENT_TBL;
SELECT * FROM STUDENT_TBL;

-- 아이디가 KHUSER02 비밀번호가 KHUSER02인 계정을 생성하고
-- 접속이 되도록하고 테이블도 만들 수 있도록 하세요.
CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;
SHOW USER;
-- KHUSER02 PINK
CREATE TABLE ACCOUNT (
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20)
    );
    SELECT * FROM ACCOUNT;
    INSERT INTO ACCOUNT
    VALUES('KHUSER02','KHUSER02');
    GRANT CONNECT TO KHUSER02;
    --System red