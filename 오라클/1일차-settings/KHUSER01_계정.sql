SELECT * FROM EMPLOYEE;
SELECT * FROM STUDENT_TBL;
CREATE TABLE USER_NO_CONSTRAINT (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
    );
DROP TABLE USER_NO_CONSTRAINT;
SELECT * FROM USER_NO_CONSTRAINT;
-- 1. khuser01, pass01, �Ͽ���, ��, 01028227373, khuser01@gmail.com
INSERT INTO USER_NO_CONSTRAINT
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', '��', '01028227373', 'khuser01@gmail.com' );
ROLLBACK;
COMMIT;
--��������
INSERT INTO USER_NO_CONSTRAINT
VALUES(2, 'khuser02',' ', null, null, null, null);

CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
    );
    INSERT INTO USER_NOTNULL
    VALUES(1, 'khuser01', 'pass01' ,'�Ͽ���',null,null,null);
    SELECT * FROM USER_NOTNULL;
    
    CREATE TABLE USER_UNIQUE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
    );
    INSERT INTO USER_UNIQUE
    VALUES(1, 'khuser01', 'pass01' ,'�Ͽ���',null,null,null);
        INSERT INTO USER_UNIQUE
    VALUES(1, null, 'pass01' ,'�Ͽ���',null,null,null);
    -- UNIQUE ������������ �ߺ��� �������� NULL�� ���� ����
    SELECT * FROM USER_UNIQUE;
    

SQL���� ���̺��� ������ ��, PRIMARY KEY ���� ������ �ùٸ��� �����ؾ� �մϴ�. PRIMARY KEY ���� ������ ������ ���� �ùٸ��� �ۼ��ؾ� �մϴ�:

sql
�ڵ� ����
CREATE TABLE USER_PRIMARY_KEY (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) PRIMARY KEY, -- UNIQUE, NOT NULL�� ���Ե�
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
    DROP TABLE USER_PRIMARY_KEY;
     INSERT INTO USER_PRIMARY_KEY
    VALUES(1, 'khuser01', 'pass01' ,'�Ͽ���',null,null,null);
     INSERT INTO USER_PRIMARY_KEY
    VALUES(2, 'khuser02', 'pass02' ,'�̿���',null,null,null);
    SELECT * FROM USER_PRIMARY_KEY;
    COMMIT;
    
CREATE TABLE USER_CHECK (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY, -- UNIQUE, NOT NULL�� ���Ե�
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10), CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
DROP TABLE USER_CHECK;
     INSERT INTO USER_CHECK
    VALUES(1, 'khuser01', 'pass01' ,'�Ͽ���','M',null,null);
         INSERT INTO USER_CHECK
    VALUES(2, 'khuser02', 'pass02' ,'�̿���','����',null,null);
             INSERT INTO USER_CHECK
    VALUES(3, 'khuser03', 'pass03' ,'�����','Male',null,null);
    SELECT * FROM USER_CHECK;
    COMMIT;
    -- ���ݱ��� ��� ��������
    -- NOT NULL : NULL�� ��������.
    -- UNIQUE : �ߺ��� �ȵǰ� ��, NULL�� ����
    -- PRIMARY KEY : �ߺ��� �ȵǰ� NULL�� �ȵ�, ������ ��
    -- CHECK, CHECK(  �÷��� IN ( ��1, ��2 ) ) : ������ ���� ���� ��.
    
CREATE TABLE USER_DEFAULT (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY, -- UNIQUE, NOT NULL�� ���Ե�
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10), CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE
);
DROP TABLE USER_DEFAULT;
INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '�Ͽ���' , 'M' , '01082829292', 'khuser01@naver.com', '24/06/14');
INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '�Ͽ���' , 'M' , '01082829292', 'khuser01@naver.com', DEFAULT);
INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '�Ͽ���' , 'M' , '01082829292', 'khuser01@naver.com', SYSDATE);
SELECT * FROM USER_DEFAULT;
-- ��������
-- 1.