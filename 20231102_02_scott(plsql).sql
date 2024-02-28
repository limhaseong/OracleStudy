SELECT USER
FROM DUAL;
--==> SCOTT


-- 1. PL/SQL(Procedural Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL�� Ȯ���̸�
--    ������ ���۰� ���� ������ PL/SQL�� ������ �ڵ� �ȿ� ���Եȴ�.
--    ����, PL/SQL �� ����ϸ�SQL�� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� ������ �̶�� �ܾ ������ �ǹ̴�
--    � ���� � ������ ���� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.

-- 2. PL/SQL�� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���.
--    ���� ������ ������ �� �ִ� ���.
--    ���� �帧�� ��Ʈ���� �� �ִ� ��� ���� �����Ѵ�.

-- 3. PL/SQL�� �� ������ �Ǿ� ������,
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.

-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(DECLARATIONS)
BEGIN
    -- ���๮(STATEMENTS)
    
    [EXCEPTION]
        -- ���� ó����(EXCEPTION HANDLERS)
END;
*/

-- 5. ���� ����
/*
DECLARE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ;
BEGIN
END;
*/

--�� ��(����)�� ���(�����Ͽ�) ����!!!!

--�� DBMS_OUTPUT.PUT_LINE() �� ����
--   ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����
SET SERVEROUTPUT ON;
--==> �۾��� �Ϸ�Ǿ����ϴ�.

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
/*-- �⺻ ����
DECLARE
BEGIN
END;

- �ڹ� ���� ���� �� �ʱ�ȭ
�ڷ��� ������;
INT COL1 = 10;

- ����Ŭ ���� ����  �� �ʱ�ȭ
������ �ڷ���;
COL1 NUMBER := 10;
(COL1 NUMBER <= 10;�̶�� ��)
*/

DECLARE
    -- �����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- �����
    -- �ڹٿ��� System.out.println(V1);
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- �����
    -- (���� �� ó��)
    V1 := V1 + 20;  -- �ڹٿ��� NUM1 = NUM1 + 20; => NUM1 += 20; �̶�� �ϴµ� ����Ŭ�� �̷� �� ����.
    V2 := V2 || ' ���ѿ�';
    V3 := V3 || ' World~';
    
    -- (��� ���)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO ���ѿ�
ORACLE World~


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� IF ��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE�̸� THEN�� ELES ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE�� END IF; ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
IF ����
    THEN ó����;
END IF;
*/

/*
IF ����
    THEN ó����;
ELSE
    ó����;
END IF;
*/

/*
IF ����
    THEN ó����;
ELSIF
    THEN ó����;
ELSIF
    THEN ó����;
ELSE
    ó����;
END IF;
*/

/*
�÷��� ������ Ÿ��
GRADE NUMBER;  -- �ִ밪(NUMBER�� ���̸� ������� ������ �ִ밪�� ��ȯ)
GRADE CHAR;    -- �ּҰ�(CHAR�� ���̸� ������� ������ �ּҰ��� ��ȯ)
*/

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
FAIL


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
BEST


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
BEST


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
BEST


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

*/


--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮;
    WHEN ��2 THEN ���๮;
    ELSE ���๮;
END CASE;
*/


--�� ACCEPT ����(�ܺη� ���� ���� �޾ƿ��� �� - �ӽ� ��� - �ȳ��޼��� ��� - �޾ƿ��� ���� NUM�� �ְڴ�.
ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- �����
    -- (�ֿ� ���� ����)
    SEL NUMBER := &NUM;
    RESULT VARCHAR2(20) := 'Ȯ�κҰ�';                       -- �ڷ����� �����Ӱ� �����.
BEGIN
    -- �����
    -- (�׽�Ʈ)
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    -- System.out.println("sel : " + sel);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- (���� �� ó��)
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    */
    CASE SEL
        WHEN 1 THEN RESULT := '����';
        WHEN 2 THEN RESULT := '����';
        ELSE RESULT := 'Ȯ�κҰ�';
    END CASE;
    -- (��� ���)
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || '�Դϴ�.');
END;
/*
�����Դϴ�.


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
/*
ó�� ����� �����Դϴ�.


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
--> (&�ܺκ�����) ���·� �����ϰ� �ȴ�.

--�� ������ ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
-- ���� ��)
-- ù ��° ������ �Է��ϼ��� ->
-- �� ��° ������ �Է��ϼ��� -> 20
--==> 10 + 20 = 30

-- ����� ���1
ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���.';
ACCEPT N2 PROMPT 'ù ��° ������ �Է��ϼ���.';

DECLARE
    -- �ֿ� ���� ����
    NUM1 NUMBER := &N1;
    NUM2 NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    /*
    -- �׽�Ʈ
    DBMS_OUTPUT.PUT_LINE('NUM1 :  ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('NUM2 :  ' || NUM2);
    DBMS_OUTPUT.PUT_LINE('TOTAL :  ' || TOTAL);
    */
    
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    
    --��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;

-- ��� 2
ACCEPT NUM1 PROMPT 'ù ��° ������ �Է��ϼ���.';
ACCEPT NUM2 PROMPT 'ù ��° ������ �Է��ϼ���.';

DECLARE
    -- �����
    SEL1 NUMBER := &NUM1;
    SEL2 NUMBER := &NUM2;
    RESULT NUMBER := 0;
BEGIN
    RESULT := SEL1 + SEL2;
    -- �����
    DBMS_OUTPUT.PUT_LINE(SEL1 || '+' || SEL2 || '=' || RESULT);
END;
/*
10+20=30


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, �Է¿� ���� ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ -> �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/
-- ����� ���1
ACCEPT INPUT PROMPT '�ݾ� �Է�';
DECLARE
    -- �ֿ� ���� ����
    MONEY NUMBER := &INPUT;  -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2 NUMBER := &INPUT; -- ��� ����� ���� �Է°��� ��Ƶ� ����
                              -- (MONEY ������ ������ ó���ϴ� �������� ���� ���ϱ� ������...)
    
    M500 NUMBER;             -- 500�� ¥�� ������ ��Ƶ� ����
    M100 NUMBER;             -- 100�� ¥�� ������ ��Ƶ� ����
    M50  NUMBER;             --  50�� ¥�� ������ ��Ƶ� ����
    M10  NUMBER;             --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    -- ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������. -> 500���� ����
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�. -> 500���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� �ݾ����� MONEY�� ����
    MONEY := MOD(MONEY, 500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������. -> 100���� ����
    M100 := TRUNC(MONEY / 100);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ�. -> 100���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� �ݾ����� MONEY�� ����
    MONEY := MOD(MONEY, 100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. -> 50���� ����
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY �� 50���� ������ ���� ������ �������� ���Ѵ�. -> 50���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� �ݾ����� MONEY�� ����
    MONEY := MOD(MONEY, 50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������. -> 10���� ����
    M10 := TRUNC(MONEY / 10);
    
    -- ��� ���
    -- ���յ� ���(ȭ�� ������ ����)�� ���Ŀ� �°� ���� ����Ѵ�.
    -- DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY || '��'); --> ������ ������� MONEY�� ��µǱ⿡ MONEY2�� ��.
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || ', ���ʿ� ' || M50 || ', �ʿ� ' || M10);
END;

-- ���2
ACCEPT NUM PROMPT '�ݾ� �Է� : ';

DECLARE
    SEL NUMBER  := &NUM;
    OHBA NUMBER := TRUNC(SEL/500);
    BAEK NUMBER := TRUNC((MOD(SEL,500))/100);
    OHSH NUMBER := TRUNC(MOD((MOD(SEL,500)),100)/50);
    SHIP NUMBER := TRUNC(MOD(MOD((MOD(SEL,500)),100),50)/10);
BEGIN
    IF SEL < 1000
        THEN DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || SEL || '��' );
              DBMS_OUTPUT.PUT_LINE('ȭ����� : ' || ' ����� ' || OHBA || ',' || ' ��� ' || BAEK || ',' || ' ���ʿ� ' || OHSH || ',' || ' �ʿ� ' || SHIP);
    ELSE DBMS_OUTPUT.PUT_LINE('�ݾ��� �߸� �Է��߽��ϴ�.' );
    END IF;
END;
/*
�Է¹��� �ݾ� �Ѿ� : 780��
ȭ����� : ����� 1, ��� 2, ���ʿ� 1, �ʿ� 3


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

*/


--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    
    EXIT WHEN ����; --> ������ ���� ��� �ݺ����� ����������.
    
END LOOP;
*/

-- 1���� 10������ �� ���
DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N>=10;
        
        N := N+1; --> �ڹٿ��� N++;, N+=1;�� ����
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
*/

--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �ѹ��� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸�, �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP           --> ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

-- 1���� 10������ �� ��� (WHILE LOOP �� Ȱ��)
DECLARE
    N   NUMBER := 0;
BEGIN
    WHILE N<10 LOOP
    N := N+1;
    DBMS_OUTPUT.PUT_LINE(N);
    
    END LOOP;
END;

DECLARE
    N   NUMBER := 1;
BEGIN
    WHILE N<=10 LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N+1;
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. ���ۼ� ���� 1�� �����Ͽ�
--    ������ �� �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP              -- ī���� = ����
    -- ���๮;
END LOOP;
*/

-- 1���� 10������ �� ���(FOR LOOP �� Ȱ��)
DECLARE
    N NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ -> ���� �Է��ϼ��� : 2

2*1 = 2
    :
2*9 = 18
*/

-- 1. LOOP ���� ���
ACCEPT D PROMPT '���� �Է��ϼ���. : ';

DECLARE
    DAN   NUMBER := &D;
    I   NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || I || '=' ||DAN*I);
        
        EXIT WHEN I>=9;
        
        I := I+1;
    END LOOP;
END;
--����� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���';
DECLARE
    DAN   NUMBER := &NUM;
    N   NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' ||DAN*N);
        EXIT WHEN N>=9;
        
        N := N+1;
    END LOOP;
END;

-- 2. WHILE LOOP ���� ���
ACCEPT D PROMPT '���� �Է��ϼ���. : ';
DECLARE
    DAN   NUMBER := &D;
    I   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || I || '=' ||DAN*I);
    I := I+1;
    END LOOP;
END;
--����� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���';
DECLARE
    DAN   NUMBER := &NUM;
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<9 LOOP
    N := N+1;
    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' ||DAN*N);
    END LOOP;
END;

-- 3. FOR LOOP ���� ���
ACCEPT D PROMPT '���� �Է��ϼ���. : ';
DECLARE
    DAN   NUMBER := &D;
    I   NUMBER := 1;
BEGIN
    FOR I IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || I || '=' ||DAN*I);
    END LOOP;
END;
-- ����� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���. : ';
DECLARE
    DAN   NUMBER := &NUM;
    N   NUMBER := 1;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' ||DAN*N);
    END LOOP;
END;


--�� ������ ��ü(2��~9��)�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ���Ѵ�.
/*
���� ��)

==[2��]==
2 * 1 = 2
    :
==[3��]==
3 * 1 = 3
    :
9 * 9 = 81
*/

/*
-- WHILE �ݺ��� + FOR �ݺ���
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '��]==');
        FOR J IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
        END LOOP;
    I := I+1;
    END LOOP;
END;

-- WHILE �ݺ��� + LOOP �ݺ���
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '��]==');
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
            EXIT WHEN J>=9;
            J := J+1;
        END LOOP;
    I := I+1;
    J := 1;
    END LOOP;
END;

-- FOR�� + �⺻�ݺ���
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    FOR I IN 2 .. 9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '��]==');
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
            EXIT WHEN J>=9;
            J := J+1;
        END LOOP;
    J := 1;
    END LOOP;
END;
*/
-- ����� ���
DECLARE
    N NUMBER;
    M NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[' || N || '��]==');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' ||N*M);
        END LOOP;
    END LOOP;
END;

