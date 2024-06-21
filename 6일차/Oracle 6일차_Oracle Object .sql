--  6���� ����Ŭ ��ü

--  == 1. view ==
/* 
    1.1 ����
    - ���� ���̺� �ٰ��� ������ ������ ���̺�
      (����ڿ��� �ϳ��� ���̺� ó�� ��� �����ϰ� ��)
    - SELECT ������ ���� ����� ȭ�鿡 ������ ������ ������ ���̺�
      (�������� �����͸� �����ϰ� ���� ������ �ϳ��� ���̺�ó�� ��� ������)
      
    1.2 ����
    1.2.1 Stored View ( ���� o ) - �̸��� �ٿ��� ������.
    1.2.2 InLine View ( ���� x ) - FROM�� �ڿ� ���� ��������
*/
--  1.2.1 Stored View (���� o ) - �̸��� �ٿ��� ������
    CREATE VIEW EMP_VIEW
    AS SELECT EMP_ID, DEPT_CODE, JOB_CODE, MANAGER_ID
    FROM EMPLOYEE;
--  ���� : VIEW ���鶧���� ������ �ʿ���, ���Ѹ� : CREATE VIEW
--  System�������� ���� �ο�
    GRANT CREATE VIEW TO KH;

--  View ��� Ȯ��
SELECT * FROM EMP_VIEW;

--  1.2.2 Inline View ( ���� x ) - FROM�� �ڿ� ���� ���� ����
SELECT * FROM (SELECT EMP_ID, DEPT_CODE, JOB_CODE, MANAGER_ID FROM EMPLOYEE);

/*
    1.3 Ư¡
    - ���̺� �ִ� �����͸� ������ ���̸�, ������ ��ü�� �����ϰ� �ִ� ���� �ƴ�.
    - ������ġ ���� ���������� �������� �ʰ� ���� ���̺�� �������.
    - �������� ���� ���̺���� ��ũ ������.
    - �÷��� ��������� �Ͽ��� VIEW ��������
    - JOIN�� Ȱ���� VIEW
    1.4 ����
    - ���� ���̺��� �ƴ� �並 ���� Ư�� �����͸� ���̵��� ��.
    - Ư�� ����ڰ� ���� ���̺� �����Ͽ� ��� �����͸� �����ϴ� ���� ������.
*/
--  ex) ���������� ������ �ִ� VIEW�� �����Ͻÿ�.(ANNUAL_SALARY_VIEW)
--  ���, �̸�, �޿�, ����
CREATE VIEW ANNUAL_SALARY_VIEW(���, �̸�, �޿�, ����)
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 FROM EMPLOYEE;

SELECT * FROM ANNUAL_SALARY_VIEW;
--  ex) ��ü ������ ����, �̸�, ���޸�, �μ���, �������� �� �� �մ� VIEW�� �����Ͻÿ�(ALL_INFO_ VIEW)
CREATE VIEW ALL_INFO_VIEW 
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

SELECT * FROM ALL_INFO_VIEW;

-- VIEW �����غ���
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;
-- �������� DEPT_CODE�� D8�� �ٲٴ� DML�� �ۼ��Ͻÿ�.
UPDATE EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';

SELECT * FROM EMPLOYEE;
-- VIEW�� ������ ��ũ�� �Ǿ� �־ VIEW ������ ������ ������.

--1.5 VIEW �ɼ�
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE;
-- ���� VIEW�� �÷��� �߰��Ͽ� ����� �ʹٸ�?
-- ����� �����
DROP VIEW V_EMPLOYEE;
-- View V_EMPLOYEE��(��) �����Ǿ����ϴ�.
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;

-- 1.5.1. OR REPLACE
-- �����ϱ�
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- 1.5.2 FORCE / NOFORCE
-- �⺻ ���̺��� �������� �ʴ��� �並 �����ϴ� �ɼ�
-- 1.5.3 WITH CHECK OPTION
-- WHERE ���ǿ� ����� �÷��� ���� �������� ���ϰ� �ϴ� �ɼ�
-- 1.5.4 WITH READ ONLY
-- VIEW�� ���� ��ȸ�� �����ϸ� DML �Ұ����ϰ� �ϴ� �ɼ�
CREATE OR REPLACE FORCE VIEW V_EMPLOYEE AS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE WITH READ ONLY;

UPDATE V_EMPLOYEE
SET EMP_NAME = '������'
WHERE EMP_ID = '200';

-- �ǽ����� 1
-- KH���� ������ �� EMPLOYEE, JOB, DEPARTMENT ���̺��� �Ϻ� ������ ����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� 
-- ��(V_EMP_INFO)�� (�б� ��������)
-- �����Ͽ���.

CREATE OR REPLACE VIEW V_EMP_INFO (������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի���) 
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME, NVL(DEPT_TITLE, '����'), NVL((SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID), '����'), HIRE_DATE
FROM EMPLOYEE E
LEFT OUTER JOIN JOB USING(JOB_CODE)
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WITH READ ONLY;
-- �����ڸ� ��� ������?
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = ���߱��� �Ŵ���ID);

-- == ������ ��ųʸ�( DD, Data Dictionary)
-- -> DBMS ��ġ�� �� �ڵ����� ��������� �ڿ��� ȿ�������� �����ϱ� ����
--    �پ��� ������ ������ �ý��� ���̺�
-- -> ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
--    �۾��� �� �� �����ͺ��̽� ����(����Ŭ)�� ���� �ڵ����� ���ŵǴ� ���̺���.
--    ����ڴ� ������ ��ųʸ��� ������ ���� �����ϰų� ������ �� ����.
--    ������ ��ųʸ� �ȿ��� �߿��� ������ ���� �ֱ� ������ ����ڴ� �̸� Ȱ���ϱ�
--    ���ؼ��� ������ ��ųʸ� �並 ����ϰ� ��.
--    ������ ��ųʸ� ���� ����
--    1. USER_XXX : ������ ������ ������ ��ü � ���� ������ ��ȸ��.
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;
--    2. ALL_XXX : ������ ������ ���Ѻο� ���� �Ͱ� ������ ��� �Ϳ� ���� ������ ��ȸ��
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
--    3. DBA_XXX : �����ͺ��̽� �����ڸ� ������ ������ ��ü ���� ���� ��ȸ
SELECT * FROM DBA_TABLES; -- System�������� ����


-- 2. Sequence ��ü
SELECT * FROM USER_TCL;
-- USER_NO �÷��� ����Ǵ� �����ʹ� 1���� �����Ͽ� 1�� ������
-- �Ͽ����� ���� 1, �̿����� ���� 2, ...
-- USER_NO �÷��� ���� �����ʹ� ������ ����ϰ� �־�� ��.
-- ������ ��ȣ�� ����̾����� � �����ؼ� �����ϴ����� ����ϰ� �־����.
-- �׷� ������ �ϴ� ���� �ٷιٷ� Sequence��

-- 2.1 ����
-- - ���������� ���� ���� �ڵ����� �����ϴ� ��ü, �ڵ� ��ȣ �߻���(ä����)��
--   ������ ��
-- - ���� : CREATE SEQUENCE [��������]; -> �⺻������ ���� (1���� 1�� ����)
-- 2.2 Sequence �ɼ�
-- 2.2.1 MINVALUE : �߻���ų �ּҰ� ����
-- 2.2.2 MAXVALUE : �߻���ų �ִ밪 ����
-- 2.2.3 START WITH : ó�� �߻���ų ���۰� ����, �⺻�� 1
-- 2.2.4 INCREMENT BY : ���� ���� ���� ����ġ, �⺻�� 1
-- 2.2.5 NOCYCLE : ���������� �ִ밪���� ������ �Ϸ��ϸ� CYCLE�� START WITH�� �ٽ� ������
-- 2.2.6 NOCACHE : �޸� �󿡼� ������ ���� ����, �⺻�� 20, NOCACHE�� ���ϸ� ���ڱ� ������ ���� �����ϰ� ��
CREATE SEQUENCE SEQ_KH_USER_NO;
MINVALUE 1
MAXVALUE 100000
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
DROP SEQUENCE SEQ_KH_USER_NO;

SELECT * FROM SUER_SEQENCES;

-- 2.3 ������ �����
-- 2.3.1 ����
-- CREATE SEQUENCE ��������
-- MINVALUE 1
-- MAXVALUE 100000
-- STRAT WITH 1
-- INCREMENT BY 1
-- NOCYCLE
-- NOCACHE;

-- 2.3.2 ����
-- ��������.NEXTVAL �Ǵ� TLZNJSTMAUD.CURRVAL��
-- SELECT�� �� �Ǵ� INSERT INTO VALUES�� ���ް����� �ۼ�
SELECT SEQ_KH_USER_NO.NEXTVAL FROM DUAL; -- ù NEXTVAL�� �������� ������. �ʼ�����
SELECT SEQ_KH_USER_NO.CURRVAL FROM DUAL; -- NEXTVAL�� ������ �� ���� ������ �� ��ȸ

SELECT * FROM USER_TCL;
DELETE FROM USER_TCL;
COMMIT;

INSERT INTO USER_TCL
VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser01', '�Ͽ���');
INSERT INTO USER_TCL
VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser02', '�̿���');
INSERT INTO USER_TCL
VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser03', '�����');

-- �ǽ�����1
-- ���� ��ǰ�ֹ��� ����� ���̺� ORDER_TBL�� �����, ������ ���� �÷��� �����ϼ���.
-- ORDER_NO(�ֹ�NO) : NUMBER, PK
-- USER_ID(�����̵�) : VARCHAR2(40)
-- PRODUCT_ID(�ֹ���ǰ ���̵�) : VARCHAR2(40)
-- PRODUCT_CNT(�ֹ�����) : NUMBER
-- ORDER_DATE : DATE, DEFAULT SYSDATE

CREATE TABLE ORDER_TBL 
(
    ORDER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(40),
    PRODUCT_ID VARCHAR2(40),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE
    );
COMMENT ON COLUMN ORDER_TBL.ORDER_NO IS '�ֹ���ȣ';
COMMENT ON COLUMN ORDER_TBL.USER_ID IS '�����̵�';
COMMENT ON COLUMN ORDER_TBL.PRODUCT_ID IS '�ֹ���ǰ ���̵�';
COMMENT ON COLUMN ORDER_TBL.PRODUCT_CNT IS '�ֹ�����';
COMMENT ON COLUMN ORDER_TBL.ORDER_DATE IS '�ֹ�����';

SELECT * FROM ORDER_TBL;
DESC ORDER_TBL;
DROP TABLE ORDER_TBL;

-- SEQ_ORDER_NO �������� �����Ͽ� ������ �����͸� �߰��ϼ���.
-- * kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- * gam���� gamjakkang��ǰ�� 30�� �ֹ��ϼ̽��ϴ�.
-- * ring���� onionring��ǰ�� 50�� �ֹ��ϼ̽��ϴ�.

-- 1. ������ ����
CREATE SEQUENCE SEQ_ORDER_NO;
 
-- 2. ������ ���

INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);
SELECT * FROM ORDER_TBL;

COMMIT;

-- �ǽ�����2
-- KH_MEMBER ���̺��� �����ϼ���.
-- �÷� : MEMBER_ID, MEMBER_NAME, MEMBER_AGE, MEMBER_JOIN_COM
-- �ڷ��� : NUMBER, VARCHAR2(20), NUMBER, NUMBER
CREATE TABLE KH_MEMBER 
(
    MEMBER_ID NUMBER,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
    );

-- ID ���� 500������ �����Ͽ� 10�� �����Ͽ� ����
-- JOIN_COM���� 1������ �����Ͽ� 1�� �����Ͽ� ����

CREATE SEQUENCE SEQ_MEMBER_ID;
START WITH 500
INCREMENT BY 10
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_MEMBER_JOIN_COM;
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBER_ID.NEXTVAL, 'ȫ�浿', 20, SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBER_ID.NEXTVAL, 'û�浿', 30, SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBER_ID.NEXTVAL, '�ܱ浿', 40, SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBER_ID.NEXTVAL, '��浿', 50, SEQ_MEMBER_JOIN_COM.NEXTVAL);

SELECT * FROM KH_MEMBER;

COMMIT;

-- 2.4������ ����
-- ALTER�� �̿��ؼ� �ɼǵ��� �����ϸ� ��
ALTER SEQUENCE SEQ_MEMBER_ID
-- START WITH ����Ұ� -> ���� �� �ٽ� ����
INCREMENT BY 1
MAXVALUE 100000;

SELECT * FROM USER_SEQUENCES;