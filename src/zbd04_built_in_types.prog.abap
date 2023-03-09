*&---------------------------------------------------------------------*
*& Report zbd04_built_in_types
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_built_in_types.

DATA: v_int1  TYPE i VALUE 16, " intero
      v_int2  TYPE int4 VALUE 456, "intero a 4 byte
      v_num1  TYPE n LENGTH 10, "numerico di 10 caratteri
      v_num2  TYPE p LENGTH 10 DECIMALS 2, "numerico di 10 caratteri
      v_char1 TYPE c LENGTH 100.

v_num1 = v_int1 + v_int2 .
v_char1 = |La somma di v_int1 e v_int2 è : { v_num1 } |.
WRITE v_char1.

ULINE.

v_num1 = v_int1 * v_int2 .
v_char1 = |Il prodotto di v_int1 e v_int2 è : { v_num1 }|.
WRITE v_char1.

ULINE.

v_num2 = v_int1 * v_int2 .
v_char1 = |Il prodotto di v_int1 e v_int2 è : { v_num2 }|.
WRITE v_char1.

ULINE.

DO 10 TIMES.
  WRITE: / 'ciclo nr:', sy-index.
ENDDO.
