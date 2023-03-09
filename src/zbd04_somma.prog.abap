*&---------------------------------------------------------------------*
*& Report zbd04_somma
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_somma.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001. "riquadro con titolo

"parametri input
PARAMETERS: v_num1 TYPE i DEFAULT 10 OBLIGATORY, "intero default 10, se cancellato ti avvisa
            v_num2 TYPE i DEFAULT 20. "intero default 20

SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN SKIP.

"parametri radiobutton gruppo rad
PARAMETERS: p_pari    RADIOBUTTON GROUP rad,
            p_disp    RADIOBUTTON GROUP rad,
            p_tutti   RADIOBUTTON GROUP rad DEFAULT 'X',
            p_niente RADIOBUTTON GROUP rad.

"checkbox
PARAMETERS: c_check as CHECKBOX.

"definizione variabili
DATA: v_diff     TYPE i, "intero
      v_somma    TYPE i, "intero
      v_prossimo TYPE i.


*----------------------------------------------------
*stampa somma numeri dispari in una range, stampa tutti i valori, utilizzo di radiobutton

v_diff = v_num2 - v_num1 + 1 . "differenza

v_prossimo = v_num1.

DO v_diff TIMES."ciclo ch decido io quante volteesegiore il ciclo

  CASE 'X'. "case radiogroup selezionato

    WHEN p_disp. "caso dispari
      IF v_prossimo MOD 2 = 1."if numero dispari fa
        WRITE: / |sommo: { v_prossimo } e : { v_somma } |."print
        WRITE: / 'somma dispari:', v_somma."print
        v_somma = v_somma + v_prossimo."sommma
      ELSE.
        WRITE: / 'scarto:', v_prossimo."print
      ENDIF.

    WHEN p_pari. "caso pari
      IF v_prossimo MOD 2 = 0."if numero dispari fa
        WRITE: / |sommo: { v_prossimo } e : { v_somma } |."print
        WRITE: / 'somma pari:', v_somma."print
        v_somma = v_somma + v_prossimo."sommma
      ELSE.
        WRITE: / 'scarto:', v_prossimo."print
      ENDIF.

    WHEN p_tutti."caso tutti
      WRITE: / |sommo: { v_prossimo } e : { v_somma } |."print
      WRITE: / 'somma dispari:', v_somma."print
      v_somma = v_somma + v_prossimo."sommma

  ENDCASE.
  v_prossimo = v_prossimo + 1.

ENDDO."fine ciclo

SKIP.
WRITE: 'somma finale: ', v_somma.

*----------------------------------------------------
ULINE.
*----------------------------------------------------
*stampa somma numeri in una range con aggiunta di if valori pari e dispari, stampa tutti i valori

v_diff = v_num2 - v_num1 . "differenza
v_somma = v_num1. "assegnazione

WRITE: / |parto da: { v_num1 } e arrivo a : { v_num2 } somme|."print
WRITE: / |effetuo { v_diff } somme|."print

SKIP."salta una riga

v_prossimo = v_num1 + 1.
IF v_prossimo MOD 2 = 1."if numero dispari fa
  WRITE: 'somma dispari:', v_somma. "print
ENDIF.
DO v_diff TIMES."ciclo ch decido io quante volteesegiore il ciclo
  v_prossimo = v_num1 + sy-index.
  IF v_prossimo MOD 2 = 1."if numero dispari fa
    v_somma = v_somma + v_num1 + sy-index."sommma
    WRITE: / 'somma dispari:', v_somma."print
  ELSE."else
    v_somma = v_somma + v_num1 + sy-index."sommma
    WRITE: / 'somma pari:', v_somma."print
  ENDIF.
ENDDO."fine ciclo

*----------------------------------------------------
ULINE."output linea

*----------------------------------------------------
*stampa somma in una range, stampa tutti i valori

v_diff = v_num2 - v_num1 . "differenza
v_somma = v_num1. "assegnazione

WRITE: / |parto da: { v_num1 } e arrivo a : { v_num2 } somme|."print
WRITE: / |effetuo { v_diff } somme|."print

SKIP."salta una riga

WRITE: 'somma :', v_somma. "print
DO v_diff TIMES."ciclo ch decido io quante volteesegiore il ciclo
  v_somma = v_somma + v_num1 + sy-index."sommma
  WRITE: / 'somma :', v_somma."print
ENDDO."fine ciclo

*----------------------------------------------------
ULINE."output linea
*----------------------------------------------------

*stampa somma in una range, stampa solo valore finale

v_diff = v_num2 - v_num1 . "differenza
v_somma = v_num1. "assegnazione

*WRITE: / |parto da: { v_num1 } e arrivo a : { v_num2 } somme|."print
*WRITE: / |effetuo { v_diff } somme|."print

*skip."salta una riga

DO v_diff TIMES. "ciclo che decido io quante volteeseguire il ciclo
  v_somma = v_somma + v_num1 + sy-index."somma
ENDDO."fine ciclo
WRITE: / 'somma :', v_somma."print
