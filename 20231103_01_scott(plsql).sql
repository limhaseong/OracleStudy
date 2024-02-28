SELECT USER
FROM DUAL;
--==> SCOTT

--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (-> ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ���� �� �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[( �Ű�������1 �ڷ���
 , �Ű�������2 �ڷ���
)]
RETURN ������Ÿ��
IS
    -- �ֿ� ���� ����
BEGIN
    -- ���๮;
    ...
    RETURN(��);
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

-- �� ����� ���� �Լ�(��Ʈ��� �Լ�)��
--    IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--    �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--    FUNCTION�� �ݵ�� ���� ���� ��ȯ�Ѵ�.

--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
--   --------------------
--   �Ű����� ����(����)�� '771212-1022432' �̷� ���·� �Ѱܹްڴٴ� �� -> 'YYMMDD-NNNNNNN' �� ���·� �ްڴ�.(�ٸ� �������� �� �� �ְԲ�)
-- �Լ��� : FN_GENDER()
--                   �� �ֹε�Ϲ�ȣ -> '771212-1022432'

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)  -- �Ű����� : �ڸ���(����) ���� ����.     --V_SSN VARCHAR2 ���� ���������� �������� ; �Ⱥ���
RETURN VARCHAR2                                         -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����.
IS
    -- ����� -> �ֿ� ���� ���� �� �ʱ�ȭ
    V_RESULT VARCHAR2(20);
BEGIN
    -- ����� -> ���� �� ó��(�׸��� ����� ��ȯ)
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '����';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ����� ��ȯ (�� ����ߵ�)
    RETURN V_RESULT;
END;


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� -> (A,B)
--   A�� B���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ���Ͽ� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10,3)
FROM DUAL;
--==> 1000
*/
--���1
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    C NUMBER;
    RESULT NUMBER :=1;
BEGIN
    FOR C IN 1..B LOOP
    RESULT := (RESULT * A);
    
    END LOOP;
    RETURN RESULT;
END;

--����� ���
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_NUM NUMBER;           -- ��������
    V_RESULT NUMBER := 1;   -- ��ȯ ����� ���� -> 1�� �ʱ�ȭ (������)
BEGIN
    -- �ݺ��� ����
    FOR V_NUM IN 1..B LOOP
        V_RESULT := V_RESULT * A;  --> �ڹٿ����� V_RESULT *= A
    END LOOP;
    -- ���� ����� ��ȯ
    RETURN V_RESULT;
END;

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� �⺻��*12+���� ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)
-- ���1
CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER, V_SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := (V_BASICPAY*12)+V_SUDANG;
    
    RETURN V_RESULT;
END;

--����� ��� 2
CREATE OR REPLACE FUNCTION FN_PAY(VBASICPAY NUMBER, VSUDANG NUMBER)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    VRESULT NUMBER;
BEGIN
    -- ���� �� ó��
    VRESULT := (NVL(VBASICPAY,0)*12)+ NVL(VSUDANG,0); -- NULL�� �ִٸ� �װ͵� ����ؼ� �Լ��� ¥�ߵ�
    
    --���� ����� ��ȯ
    RETURN VRESULT;
END;

--�� TBL_INSA ���̺���
--   �Ի����� �������� ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)
-- ���1
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VYEAR NUMBER;
    VMONTH NUMBER;
    VRESULT VARCHAR2(30);
BEGIN
    VYEAR := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) /12);
    VMONTH := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE)) - TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) /12) *12;
    
    IF VMONTH = 0
        THEN VRESULT := VYEAR || '��';
    ELSE
        VRESULT := VYEAR || '��' || ' ' || VMONTH || '����';
    END IF;
    
    RETURN VRESULT;
END;

-- ����� ���2
--1
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD')) / 12 "RESULT"
FROM DUAL;
--==> 25.06313380500796495420151334129828753483

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD'))/12)||'��'
    || TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD')), 12)) || '����'
FROM DUAL;
--==> 25��0����


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR2(30);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE)/12)||'��'
    || TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '����';
    
    RETURN VRESULT;
END;

---------------------------------------------------------------------------------

--�� ����

--1. INSERT, UPDATE, DELETE, (MERGE)
--==> DML(Data Manipulation Language
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

--2. CREATE, DROP, ALTER, (TRUNCATE)
--==> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

--3. GRANT, REVOKE
--==> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

--4. COMMIT, ROLLBACK
--==> TCL(Transaction Control Language)

-- ���� pl/sql�� -> DML��, TCL���� ��� �����ϴ�.
-- ���� pl/sql�� -> DML��, DCL��, TCL�� ��� �����ϴ�.

---------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����-

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [--�ֿ� ���� ����]
BEGIN
    --���౸��;
    ...
    
    [EXCEPTION
        --���� ó�� ����;]
END;
*/

--�� FUNCTION �� ������ �� (RETURN ��ȯ�ڷ���) �κ��� �������� ������
--   RETURN �� ��ü�� �������� �ʰ�,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--   IN(�Է�), OUT(���), INOUT(�����)���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXE[CUTE] ���ν�����[(�μ�1, �μ�2, ...)]
*/

--�� ���ν��� �ǽ��� ���� ���̺� ������...
--   20231103_02_scott.sql ���� ����~

--�� ���ν��� ����
-- ���ν����� : PRC_STUDENT_INSERT(���̵�, �н�����, �̸�, ��ȭ, �ּ�)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT 
( ���̵�
, �н�����
, �̸�
, ��ȭ
, �ּ�
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT 
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է� -> INSERT
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է� -> INSERT
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
END;
--==> Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.


--�� ���ν��� �ǽ��� ���� ���̺� ������...
--   20231103_02_scott.sql ���� ����~

--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν����� : PRC_SUNGJUK_INSERT()
/*
���� �ν�)
���� TBL_SUNGJUK ���̺���
HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE        
(�й�, �̸�, ��������, ��������, ��������, ����, ���, ���)
�÷����� �����Ǿ� �ִ�.
�� ���̺��� ������� Ư�� �׸�(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
�߰� �׸�(����, ���, ���)�� �˾Ƽ� ó���� �� �ֵ��� ���ν����� �����϶�� ���̴�.

���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '��ٽ�', 90, 80, 70);
-> �̿� ���� ���ν��� ȣ��� ó���� ���

�й�   �̸�   ��������  ��������  ��������   ����   ���    ���
1,   '��ٽ�',  90,         80,      70      240     80       B
*/
-- ���1
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT 
( VHAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, VNAME        IN TBL_SUNGJUK.NAME%TYPE
, VKOR         IN TBL_SUNGJUK.KOR%TYPE
, VENG         IN TBL_SUNGJUK.ENG%TYPE
, VMAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE := (VKOR+VENG+VMAT);
    VAVG TBL_SUNGJUK.AVG%TYPE := (VKOR+VENG+VMAT)/3;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    IF VAVG >=90 THEN VGRADE := 'A';
    ELSIF VAVG >=80 THEN VGRADE := 'B';
    ELSIF VAVG >=70 THEN VGRADE := 'C';
    ELSIF VAVG >=60 THEN VGRADE := 'D';
    ELSIF VAVG >=50 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END IF;
    
    -- TBL_SUNGJUK ���̺� ������ �Է� -> INSERT
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(VHAKBUN, VNAME, VKOR, VENG, VMAT, VTOT, VAVG, VGRADE);
    
    -- Ŀ��
    COMMIT;
END;
--==> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.

--����� ���
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT 
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE  --> �Է¸Ű�����
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE    -->  �Է¸Ű�����
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE     -->  �Է¸Ű�����
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE     -->  �Է¸Ű�����
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE     --> �Է¸Ű�����
)
IS
    -- �����
    -- INSERT �������� �����ϱ� ���� �ʿ��� �߰� ���� ����
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- ����ο� �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + VMAT;
    V_AVG := V_TOT/3;
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- TBL_SUNGJUK ���̺� ������ �Է� -> INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- Ŀ��
    COMMIT;
END;

--�� TBL_SUNGJUK ���̺��� Ư�� �л��� ����
--   (�й�, ��������, ��������, ��������) ������ ���� ��
--   ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
--   ���ν����� : PRC_SUNGJUK_UPDATE
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

-> �̿� ���� ���ν��� ȣ��� ó���� ���

�й�   �̸�   ��������  ��������  ��������   ����   ���    ���
1,   '��ٽ�',  90,         80,      70      240     80       B
2,   '������',  50,         50,      50      150     50       F
*/
--���1
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE  --> �Է¸Ű�����
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE     -->  �Է¸Ű�����
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE     -->  �Է¸Ű�����
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE     --> �Է¸Ű�����
)
IS
    -- �����
    -- INSERT �������� �����ϱ� ���� �ʿ��� �߰� ���� ����
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- ����ο� �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE���� INSERT ���� ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT=V_TOT, AVG = V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;

--����� ���2
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- UPDATE �������� �����ϱ� ���� �ʿ��� �߰� ���� ����
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET  KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT=V_TOT, AVG = V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;


--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν����� : PRC_STUDENT_UPDATE()
/*
���� ��)
EXEC PRC_STUDENT_UPDATE('moon', 'java000$', '010-9999-9999', '������ Ⱦ��');
--==> ������ ���� X

EXEC PRC_STUDENT_UPDATE('moon', 'java006$', '010-9999-9999', '������ Ⱦ��');
--==> ������ ���� O
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- UPDATE ������ ����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = (SELECT PW
                                 FROM TBL_IDPW
                                 WHERE ID =V_ID);
    -- Ŀ��
    COMMIT;
END;












































