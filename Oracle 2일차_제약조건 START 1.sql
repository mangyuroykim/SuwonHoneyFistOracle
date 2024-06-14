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
-- 1. NOI NULL : NULL�� ���� �ʰ���.
-- 2. UNIQUE : �ߺ��� ���� �ʰ���.
-- 3. PRIMARY KEY : �ߺ��� �ȵǰ� NULL�� ���� �ʵ��� ��.
-- 4. CHECK : ������ ���� ����ǵ��� ��.
-- 5. DEFAULT : ������ �Լ��� ǥ�������� ����ǵ��� ��.
-- 6. FOREIGN KEY(�ܷ�Ű)

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );
SELECT * FROM USER_GRADE;
--DELETE FROM USER_GRADE;
INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');
INSERT INTO USER_GRADE VALUES(40, 'VIPȸ��');
DELETE FROM USER_GRADE WHERE GRADE_CODE = 40;

CREATE TABLE USER_FOREIGN_KEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F,')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE,
    GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE CASCADE
    );
    DROP TABLE USER_FOREIGN_KEY;
    -- USER FOREIGN_KEY�� �ִ� GRADE_CODE�� USER_GRADE�� GRADE_CODE�� ������ �ִ�10, 20, 30�� ���� �� �־��
    -- 10, 20, 30�ܿ� 40�� �ȵſ� 50�� �ȵſ�
    SELECT * FROM USER_FOREIGN_KEY;
    DELETE FROM USER_FOREIGN_KEY;
    INSERT INTO USER_FOREIGN_KEY
    VALUES(1, 'khuser01', 'pass01', '�Ͽ���', 'M', null, null, DEFAULT, 10);
    INSERT INTO USER_FOREIGN_KEY
    VALUES(2, 'khuser02', 'pass02', '�̿���', 'M', null, null, DEFAULT, 20);
    INSERT INTO USER_FOREIGN_KEY
    VALUES(3, 'khuser03', 'pass03', '�����', 'M', null, null, DEFAULT, 30);
        INSERT INTO USER_FOREIGN_KEY
    VALUES(4, 'khuser04', 'pass04', '�����', 'M', null, null, DEFAULT, 40);
    UPDATE USER_FOREIGN_KEY
    SET GRADE_CODE = null WHERE  USER_ID = 'khuser04';
    --DELETE FROM USER FOREIGN_KEY WHERE GRADE_CODE = 40;
    DELETE FROM USER_GRADE WHERE GRADE_CODE = 40;
    
    -- ���̺�� : SHOP_MEMBER
    -- �����ؾ��� ������ : 1, khuser01, pass01, �Ͽ���, M, 01082829292, khuser01@gmail.com
    
    -- ���̺� �� : SHOP_BUY
    -- �����ؾ��� ������ : 1, khuser01, ��ȭ, 24/06/14
    
    CREATE TABLE SHOP_MEMBER (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);


INSERT INTO SHOP_MEMBER
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', 'M', ' 01082829292', 'khuser01@gmail.com');
INSERT INTO SHOP_MEMBER
VALUES(2, 'khuser02', 'pass02', '�̿���', 'M', ' 01082829292', 'khuser02@gmail.com');
SELECT * FROM SHOP_MEMBER;
DELETE FROM SHOP_MEMBER WHERE USER_ID = 'khuser01';
COMMIT;
-- ���̺� �� : SHOP_BUY
-- �����ؾ� �� ������ : 1. khuser01, ��ȭ, 24/06/14
SELECT * FROM SHOP_BUY;
CREATE TABLE SHOP_BUY(
    BUY_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE SET NULL,
    PRODUCT_NAME VARCHAR2(20),
    REG_DATE DATE DEFAULT SYSDATE
);
DROP TABLE SHOP_BUY;
-- SHOP_BUY�� USER_ID�� SHOP_MEMBER�� USER_ID�� ������ �ִ� khuser01, khuser02��..�� ���� �� �־��.
SELECT * FROM SHOP_BUY;
INSERT INTO SHOP_BUY
VALUES(1, 'khuser01', '��ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(2, 'khuser02', '�౸ȭ', DEFAULT); -- parent key not found

-- �ܷ�Ű FOREIGN KEY
-- �ڽ� ���̺��� �θ� ���̺��� ������ �ִ� �÷��� �ʵ尪���θ� INSERT�ϵ��� �ϴ� ��
-- ���� ���Ἲ�� �����ϴ� ����������.
-- �ܷ�Ű �������
-- �÷� ���� : REFERENCES �θ� ���̺�(�÷���) ���� �ɼ�(ON DELETE SET NULL, ON DELETE CASCADE)
-- �ܷ�Ű �����ɼ�
-- 1. �⺻ �ɼ� ON DELETE RESTRICTED
-- 2. ������ ��� �� ���� �ɼ� : ON DELETE CASCADE
-- 3. NULL�� ����� ���� �ɼ� : ON DELETE SET NULL
-- �θ����̺��� ������ ���� �õ��� �ڽ� ���̺��� �����͸� ó���ϴ� ���

