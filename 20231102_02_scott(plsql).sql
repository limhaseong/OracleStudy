SELECT USER
FROM DUAL;
--==> SCOTT


-- 1. PL/SQL(Procedural Language extension to SQL) 은
--    프로그래밍 언어의 특성을 가지는 SQL의 확장이며
--    데이터 조작과 질의 문장은 PL/SQL의 절차적 코드 안에 포함된다.
--    또한, PL/SQL 을 사용하면SQL로 할 수 없는 절차적 작업이 가능하다.
--    여기에서 절차적 이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능.
--    참과 거짓을 구별할 수 있는 기능.
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

-- 3. PL/SQL은 블럭 구조로 되어 있으며,
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.

-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLARATIONS)
BEGIN
    -- 실행문(STATEMENTS)
    
    [EXCEPTION]
        -- 예외 처리문(EXCEPTION HANDLERS)
END;
*/

-- 5. 변수 선언
/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
END;
*/

--※ 블럭(영역)을 잡아(선택하여) 실행!!!!

--※ DBMS_OUTPUT.PUT_LINE() 을 통해
--   화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;
--==> 작업이 완료되었습니다.

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
/*-- 기본 순서
DECLARE
BEGIN
END;

- 자바 변수 선언 및 초기화
자료형 변수명;
INT COL1 = 10;

- 오라클 변수 선언  및 초기화
변수명 자료형;
COL1 NUMBER := 10;
(COL1 NUMBER <= 10;이라는 뜻)
*/

DECLARE
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- 실행부
    -- 자바에선 System.out.println(V1);
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 + 20;  -- 자바에선 NUM1 = NUM1 + 20; => NUM1 += 20; 이라고 하는데 오라클은 이런 거 없다.
    V2 := V2 || ' 정한울';
    V3 := V3 || ' World~';
    
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO 정한울
ORACLE World~


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ IF 문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE이면 THEN과 ELES 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE와 END IF; 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조
/*
IF 조건
    THEN 처리문;
END IF;
*/

/*
IF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;
*/

/*
IF 조건
    THEN 처리문;
ELSIF
    THEN 처리문;
ELSIF
    THEN 처리문;
ELSE
    처리문;
END IF;
*/

/*
컬럼명 데이터 타입
GRADE NUMBER;  -- 최대값(NUMBER에 길이를 명시하지 않으면 최대값을 반환)
GRADE CHAR;    -- 최소값(CHAR에 길이를 명시하지 않으면 최소값을 반환)
*/

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
    -- 선언부
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
    -- 선언부
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
    -- 선언부
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/


--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;
END CASE;
*/


--※ ACCEPT 구문(외부로 부터 값을 받아오는 것 - 임시 사용 - 안내메세지 출력 - 받아오는 값을 NUM에 넣겠다.
ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    -- 선언부
    -- (주요 변수 선언)
    SEL NUMBER := &NUM;
    RESULT VARCHAR2(20) := '확인불가';                       -- 자료형은 여유롭게 만들기.
BEGIN
    -- 실행부
    -- (테스트)
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    -- System.out.println("sel : " + sel);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- (연산 및 처리)
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    CASE SEL
        WHEN 1 THEN RESULT := '남자';
        WHEN 2 THEN RESULT := '여자';
        ELSE RESULT := '확인불가';
    END CASE;
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');
END;
/*
여자입니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
/*
처리 결과는 남자입니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
--> (&외부변수명) 형태로 접근하게 된다.

--○ 임의의 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.
-- 실행 예)
-- 첫 번째 정수를 입력하세요 ->
-- 두 번째 정수를 입력하세요 -> 20
--==> 10 + 20 = 30

-- 강사님 방법1
ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요.';
ACCEPT N2 PROMPT '첫 번째 정수를 입력하세요.';

DECLARE
    -- 주요 변수 선언
    NUM1 NUMBER := &N1;
    NUM2 NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    /*
    -- 테스트
    DBMS_OUTPUT.PUT_LINE('NUM1 :  ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('NUM2 :  ' || NUM2);
    DBMS_OUTPUT.PUT_LINE('TOTAL :  ' || TOTAL);
    */
    
    -- 연산 및 처리
    TOTAL := NUM1 + NUM2;
    
    --결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;

-- 방법 2
ACCEPT NUM1 PROMPT '첫 번째 정수를 입력하세요.';
ACCEPT NUM2 PROMPT '첫 번째 정수를 입력하세요.';

DECLARE
    -- 선언부
    SEL1 NUMBER := &NUM1;
    SEL2 NUMBER := &NUM2;
    RESULT NUMBER := 0;
BEGIN
    RESULT := SEL1 + SEL2;
    -- 실행부
    DBMS_OUTPUT.PUT_LINE(SEL1 || '+' || SEL2 || '=' || RESULT);
END;
/*
10+20=30


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 입력에 대한 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 -> 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/
-- 강사님 방법1
ACCEPT INPUT PROMPT '금액 입력';
DECLARE
    -- 주요 변수 선언
    MONEY NUMBER := &INPUT;  -- 연산을 위해 입력값을 담아둘 변수
    MONEY2 NUMBER := &INPUT; -- 결과 출력을 위해 입력값을 담아둘 변수
                              -- (MONEY 변수가 연산을 처리하는 과정에서 값이 변하기 때문에...)
    
    M500 NUMBER;             -- 500원 짜리 갯수를 담아둘 변수
    M100 NUMBER;             -- 100원 짜리 갯수를 담아둘 변수
    M50  NUMBER;             --  50원 짜리 갯수를 담아둘 변수
    M10  NUMBER;             --  10원 짜리 갯수를 담아둘 변수
BEGIN
    -- 연산 및 처리
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 버린다. -> 500원의 갯수
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY 를 500으로 나눠서 몫은 버리고 나머지를 취한다. -> 500원의 갯수 확인하고 남은 금액
    -- 이 금액으로 MONEY를 갱신
    MONEY := MOD(MONEY, 500);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. -> 100원의 갯수
    M100 := TRUNC(MONEY / 100);
    
    -- MONEY 를 100으로 나눠서 몫은 버리고 나머지를 취한다. -> 100원의 갯수 확인하고 남은 금액
    -- 이 금액으로 MONEY를 갱신
    MONEY := MOD(MONEY, 100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. -> 50원의 갯수
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY 를 50으로 나눠서 몫은 버리고 나머지를 취한다. -> 50원의 갯수 확인하고 남은 금액
    -- 이 금액으로 MONEY를 갱신
    MONEY := MOD(MONEY, 50);
    
    -- MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. -> 10원의 갯수
    M10 := TRUNC(MONEY / 10);
    
    -- 결과 출력
    -- 취합된 결과(화폐 단위별 갯수)를 형식에 맞게 최종 출력한다.
    -- DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY || '원'); --> 마지막 계산결과인 MONEY로 출력되기에 MONEY2를 씀.
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;

-- 방법2
ACCEPT NUM PROMPT '금액 입력 : ';

DECLARE
    SEL NUMBER  := &NUM;
    OHBA NUMBER := TRUNC(SEL/500);
    BAEK NUMBER := TRUNC((MOD(SEL,500))/100);
    OHSH NUMBER := TRUNC(MOD((MOD(SEL,500)),100)/50);
    SHIP NUMBER := TRUNC(MOD(MOD((MOD(SEL,500)),100),50)/10);
BEGIN
    IF SEL < 1000
        THEN DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || SEL || '원' );
              DBMS_OUTPUT.PUT_LINE('화폐단위 : ' || ' 오백원 ' || OHBA || ',' || ' 백원 ' || BAEK || ',' || ' 오십원 ' || OHSH || ',' || ' 십원 ' || SHIP);
    ELSE DBMS_OUTPUT.PUT_LINE('금액을 잘못 입력했습니다.' );
    END IF;
END;
/*
입력받은 금액 총액 : 780원
화폐단위 : 오백원 1, 백원 2, 오십원 1, 십원 3


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/


--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    
    EXIT WHEN 조건; --> 조건이 참인 경우 반복문을 빠져나간다.
    
END LOOP;
*/

-- 1부터 10까지의 수 출력
DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N>=10;
        
        N := N+1; --> 자바에선 N++;, N+=1;과 같음
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

--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면, 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP           --> 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/

-- 1부터 10까지의 수 출력 (WHILE LOOP 문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 시작수 에서 1씩 증가하여
--    끝냄수 가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP              -- 카운터 = 변수
    -- 실행문;
END LOOP;
*/

-- 1부터 10까지의 수 출력(FOR LOOP 문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 -> 단을 입력하세요 : 2

2*1 = 2
    :
2*9 = 18
*/

-- 1. LOOP 문의 경우
ACCEPT D PROMPT '단을 입력하세요. : ';

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
--강사님 방법
ACCEPT NUM PROMPT '단을 입력하세요';
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

-- 2. WHILE LOOP 문의 경우
ACCEPT D PROMPT '단을 입력하세요. : ';
DECLARE
    DAN   NUMBER := &D;
    I   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || I || '=' ||DAN*I);
    I := I+1;
    END LOOP;
END;
--강사님 방법
ACCEPT NUM PROMPT '단을 입력하세요';
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

-- 3. FOR LOOP 문의 경우
ACCEPT D PROMPT '단을 입력하세요. : ';
DECLARE
    DAN   NUMBER := &D;
    I   NUMBER := 1;
BEGIN
    FOR I IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || I || '=' ||DAN*I);
    END LOOP;
END;
-- 강사님 방법
ACCEPT NUM PROMPT '단을 입력하세요. : ';
DECLARE
    DAN   NUMBER := &NUM;
    N   NUMBER := 1;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' ||DAN*N);
    END LOOP;
END;


--○ 구구단 전체(2단~9단)를 출력하는 PL/SQL 구문을 작성한다.
--   단, 이중 반복문(반복문의 중첩) 구문을 활용한다.
/*
실행 예)

==[2단]==
2 * 1 = 2
    :
==[3단]==
3 * 1 = 3
    :
9 * 9 = 81
*/

/*
-- WHILE 반복문 + FOR 반복문
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '단]==');
        FOR J IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
        END LOOP;
    I := I+1;
    END LOOP;
END;

-- WHILE 반복문 + LOOP 반복문
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    WHILE I<=9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '단]==');
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
            EXIT WHEN J>=9;
            J := J+1;
        END LOOP;
    I := I+1;
    J := 1;
    END LOOP;
END;

-- FOR문 + 기본반복문
DECLARE
    I   NUMBER := 1;
    J   NUMBER := 1;
BEGIN
    FOR I IN 2 .. 9 LOOP
    DBMS_OUTPUT.PUT_LINE('==[' || I || '단]==');
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' ||I*J);
            EXIT WHEN J>=9;
            J := J+1;
        END LOOP;
    J := 1;
    END LOOP;
END;
*/
-- 강사님 방법
DECLARE
    N NUMBER;
    M NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[' || N || '단]==');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' ||N*M);
        END LOOP;
    END LOOP;
END;

