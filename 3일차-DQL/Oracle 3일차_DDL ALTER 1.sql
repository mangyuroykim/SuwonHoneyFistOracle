-- 3����
-- DDL, Data Definition Language        ������ ���Ǿ�
-- CREATE, ALTER, DROP                  DDL�� ����
-- CREATE USER, CREATE TABLE, ... ����
-- DROP TABLE, ...
-- ALTER�� �� �� �־��� ��
-- �÷��߰�, �÷�����, �÷�����(������Ÿ��, �÷���), ���̺�� ���� 2����

-- �������� �߰�, ����, ����
-- ���������� �߰��ϸ� �̸��� ����, �̸��� �˾ƾ� ���� ����

-- �������� ����
-- 1. �����ϰ�
ALTER TABLE USER_TBL
DROP CONSTRAINT SYS_C007169;
-- 2. �����ϸ� ROW�� ����
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';

-- �������� �߰�
-- CONSTRAINT FK_GRADE_CODE �̸� ���̴°�
-- NOT NULL �߰��� �� �ٸ�! MODIFY ���
-- �������� ���� ���� ������ ����.
ALTER TABLE USER_TBL
MODIFY USER_ID NOT NULL;
-- USER_ID      VARCHAR2(20)    -> USER_ID NOT NULL VARCHAR2(20)
ALTER TABLE USER_TBL
MODIFY REG_DATE DEFAULT SYSDATE;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';

DESC USER_TBL;

ALTER TABLE USER_TBL 
ADD CONSTRAINT FK_GRADE_CODE

-- �������� �ܷ�Ű �߰��ϴ� ��
FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE);
-- Table USER_TBL��(��) ����Ǿ����ϴ�.
-- 1. �����ϸ� ROW�� 1�� ����
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';
-- 2. CONSTRAINT_NAME�� FK_GRADE_CODE�� �� Ȯ��

-- ex) USER_GRADE�� ������ �ִ� �������� ��ȸ�Ͽ� ���� �� ���� �̸����� �����
-- �������� ������ �����ϰ� �߰��ϴ� ��, �� �̸��� �ٲ� �� ����
ALTER TABLE USER_GRADE
RENAME CONSTRAINT PK_GRADE_CODE TO PRIMARYKEY_GR_CODE;
-- ��ȸ
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_GRADE';
-- ����
ALTER TABLE USER_GRADE
DROP CONSTRAINT PK_GRADE_CODE;
-- �����
ALTER TABLE USER_GRADE
ADD CONSTRAINT PK_GRADE_CODE PRIMARY KEY(GRADE_CODE);

-- �������� Ȱ��ȭ/��Ȱ��ȭ(���ǰ�� - STATUS���� Ȯ�� ����)
ALTER TABLE USER_TBL
DISABLE CONSTRAINT FK_GRADE_CODE;
ALTER TABLE USER_TBL
ENABLE CONSTRAINT FK_GRADE_CODE;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';
