-- 3����
-- ����Ŭ �Լ��� ����
-- 1. ������ �Լ� - ����� ������
-- 2. ������ �Լ� - ����� 1��(�׷��Լ�)
SELECT SUM(SALARY) FROM EMPLOYEE;

-- a. ���� ó�� �Լ�
-- - ABS(���밪), MOD(������), TRUNC(�Ҽ��� ���� ����), FLOOR(����), ROUND(�ݿø�), CEIL(�ø�)
SELECT TRUNC(SYSDATE-HIRE_DATE,2) FROM EMPLOYEE;
-- �Լ��� ����� �׽�Ʈ�� �� �� �ְ� ���ִ� ������ ���̺� DUAL
SELECT MOD(35,3) FROM DUAL;
SELECT ABS(-1) FROM DUAL;
SELECT SYSDATE FROM DUAL;
-- b. ���� ó�� �Լ�

-- c. ��¥ ó�� �Լ�
-- ADD_MONTHS(), MONTH_BETWEEN(), LAST_DAY(), EXTRACT, SYSDATE
SELECT ADD_MONTHS(SYSDATE,2) FROM DUAL; -- 2���� �ڸ� �������
SELECT MONTHS_BETWEEN(SYSDATE,'24/05/07') FROM DUAL;


-- ex1) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�̸�", HIRE_DATE AS "�Ի���"
, ADD_MONTHS(HIRE_DATE, 3) FROM EMPLOYEE;

-- ex2) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�̸�", HIRE_DATE AS "�Ի���",
FLOOR((SYSDATE-HIRE_DATE)/30), FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) FROM EMPLOYEE;
SELECT EMP_NAME, HIRE_DATE,
FLOOR((SYSDATE-HIRE_DATE)/30),
FLOOR(MONTHS_bETWEEN(SYSDATE, HIRE_DATE)) FROM EMPLOYEE;
-- LAST_DAY() ������ ��¥�� ������
SELECT LAST_DAY(SYSDATE)+1 FROM DUAL;
SELECT LAST_DAY('24/02/23')+1 FROM DUAL;
-- ex3) EMPLOYEE ���̺��� ����̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���.
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEE;
-- EXTRACT �⵵, ��, �� ��������, DATE���� ��������
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
-- ex4) EMPLOYEE ���̺��� ����̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�̸�", EXTRACT(YEAR FROM HIRE_DATE)||'��'"�Ի� �⵵",EXTRACT(MONTH FROM HIRE_DATE)||'��'"�Ի� ��",
EXTRACT(DAY FROM HIRE_DATE)||'��' "�Ի� ��"
FROM EMPLOYEE;
COMMIT;