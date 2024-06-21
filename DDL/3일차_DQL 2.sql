DESC EMPLOYEE;

-- �����͸� ��ȸ�� ����� Result SET �̶�� ��
-- ResultSet : SELECT ������ ���� ��ȯ�� ����� ����
-- ResultSet�� 0�� �̻��� ���� ���Ե� �� ����.
-- ResultSet�� Ư���� ���ؿ� ���� ���ĵ� �� ����.
-- Ư�� �÷��̳� Ư�� ���� ��ȸ�� �� ����
SELECT * FROM EMPLOYEE
--WHERE EMP_ID = '200';
ORDER BY EMP_ID DESC;


DESC EMPLOYEE;
-- SELECT �ǽ� ����
-- 1.EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����),
--       �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))�� ��µǵ��� �Ͻÿ�.

SELECT EMP_NAME "�̸�", SALARY*12 AS ����,
SALARY*12+SALARY*NVL(BONUS,0) "�Ѽ��ɾ�"
, (SALARY*12+SALARY*NVL(BONUS,0)) -(SALARY*0.03) AS �Ǽ��ɾ�
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�.
-- (SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME AS �̸�, HIRE_DATE "�Ի���", SYSDATE AS "����", ROUND(SYSDATE - HIRE_DATE) "�ٹ��ϼ�"
FROM EMPLOYEE;
--    (SYSDATE�� ����ϸ� ���� �ð� ���)
-- 3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ��� ����Ͻÿ�
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE WHERE ROUND(SYSDATE - HIRE_DATE) >= 7300; 
-- 20 * 365 = 7300

-- 1.EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME FROM EMPLOYEE
-- WHERE EMP_NAME�� ������ ������ �͵鸸 ��ȸ;
WHERE EMP_NAME LIKE '%��';

-- 2.EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� 
-- ����� �̸�, ��ȭ��ȣ�� ����Ͻÿ�
SELECT EMP_NAME, PHONE FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 3.EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, 
-- DEPT_CODE�� D9 �Ǵ� D6�̰� 
-- ������� 90/01/01 ~ 00/12/01�̸鼭, 
-- ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '%s%'
--AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND (DEPT_CODE IN ('D9','D6'))
-- AND (HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/12/01')
AND HIRE_DATE BETWEEN '90/01/01' AND'01/12/01'
AND SALARY >= 2700000;



-- ���� �ǽ� ����
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,
-- �ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
--SELECT * FROM EMPLOYEE 
--WHERE ROUND(SYSDATE - HIRE_DATE) >= 1825; AND 
SELECT EMP_NAME "�̸�", EMP_NO "�ֹι�ȣ",
 SALARY "�޿�", HIRE_DATE "�Ի���"
 FROM EMPLOYEE
 WHERE ROUND(SYSDATE-HIRE_DATE) >=1825 AND ROUND(SYSDATE-HIRE_DATE) <= 3650;

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ,
-- �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME "�̸�", DEPT_CODE "�μ��ڵ�", HIRE_DATE "�����",ENT_YN "��翩��"
,(ENT_DATE - HIRE_DATE) AS "�ٹ��Ⱓ"
FROM EMPLOYEE WHERE ENT_DATE IS NOT NULL;



-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� 
-- �ټӳ���� ������������ �����Ͽ� ����϶�
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME "�̸�", SALARY * 1.5 "�޿�", FLOOR((SYSDATE-HIRE_DATE)/365) "�ټӳ��"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 >= 10
ORDER BY 1 ASC;

-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 
-- 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME AS "�̸�", 
       EMP_NO AS "�ֹι�ȣ", 
       EMAIL AS "�̸���", 
       PHONE AS "����ȣ", 
       SALARY AS "�޿�"
FROM EMPLOYEE
WHERE HIRE_DATE >= DATE '1999-01-01'
AND HIRE_DATE <= DATE '2010-01-01'
AND SALARY <= 2000000;



-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� 
-- �˻��Ͽ� �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE, '����') "DEPT_CODE"
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
AND EMP_NO LIKE '__04__-2%'
ORDER BY EMP_NO DESC;

-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) �����
-- ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME,SALARY 
,FLOOR(FLOOR(SYSDATE -HIRE_DATE)/1000)*SALARY*0.1 "Ư�����ʽ�"
FROM EMPLOYEE
WHERE (EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%')
AND BONUS IS NULL
ORDER BY 1 ASC;


-- extra1
-- EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';






-- extra2
-- EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____\_%@%';


-- �ǽ�1
-- ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ����  
-- ������ �̸� ��ȸ�Ͻÿ�
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- �ǽ�2
-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;