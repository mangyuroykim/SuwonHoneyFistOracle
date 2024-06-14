SHOW USER;

CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
-- 1. �÷��� ������ Ÿ�Ծ��� ���̺� �����Ͽ� ������
-- -> ������Ÿ�� �ۼ�
-- 2. ���ѵ� ���� ���̺��� �����Ͽ� ������
-- -> System_�������� RESOURCE ���� �ο�
-- 3. �������� �� ����, ���ο� ��ũ��Ʈ ���� ���� ��ũ��Ʈ���� ������ �����Ͽ�
-- ��ɾ� �����

INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�Ͽ���', 'T1', 'D1' , 33  );
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�̿���', 'T2', 'D1', 44);
INSERT INTO EMPLOYEE
VALUES('�����', 'T1', 'D2', 32);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�Ͽ���', 'T2', 'D1' , 43  );

DROP TABLE EMPLOYEE; --���̺� ������ �����°�

DELETE FROM EMPLOYEE WHERE NAME = '�Ͽ���';
UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '�Ͽ���';

SELECT NAME , T_CODE, D_CODE, AGE FROM EMPLOYEE
WHERE NAME = '�Ͽ���';


SELECT * FROM EMPLOYEE;

-- �̸��� STUDENT_TBL�� ���̺��� ���弼��.
-- �̸�, ����, �г�, �ּҸ� ������ �� �ֵ��� �Ͽ�
-- �Ͽ��ڸ� ����ڷ� �ٲ��ּ���.
-- �����͸� �����ϴ� �������� �ۼ��ϰ� ������ Ȯ���Ͻð�
-- �����͸� �����ϴ� �������� �ۼ��Ͽ� ���̺��� ����� ���� Ȯ���ϼ���.
CREATE TABLE STUDENT_TBL (
    NAME VARCHAR2(20),
    AGE NUMBER,
    GRADE VARCHAR2(10),
    ADDRESS VARCHAR2(200)
    );
SELECT * FROM STUDENT_TBL;
ROLLBACK;
INSERT INTO STUDENT_TBL 
VALUES('�Ͽ���', 21, '1', ' ����� �߱�');
COMMIT;
INSERT INTO STUDENT_TBL
VALUES('�̿���', 22, '2', '����� �߱�');
COMMIT;
UPDATE STUDENT_TBL
SET NAME = '�����'
WHERE AGE = 21;

DELETE FROM STUDENT_TBL;
SELECT * FROM STUDENT_TBL;
DROP TABLE STUDENT_TBL;
SELECT * FROM STUDENT_TBL;

-- ���̵� KHUSER02 ��й�ȣ�� KHUSER02�� ������ �����ϰ�
-- ������ �ǵ����ϰ� ���̺� ���� �� �ֵ��� �ϼ���.
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