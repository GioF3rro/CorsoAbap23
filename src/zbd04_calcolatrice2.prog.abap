*&---------------------------------------------------------------------*
*& Report zbd04_calcolatrice2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_calcolatrice2.


WRITE: |CALCOLATRICE|.
ULINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  "parametri input
  PARAMETERS: v_num1 TYPE int4 DEFAULT 0 OBLIGATORY, "intero
              v_oper TYPE string DEFAULT '+' OBLIGATORY, "intero
              v_num2 TYPE int4 DEFAULT 0 OBLIGATORY. "intero

SELECTION-SCREEN END OF BLOCK b1.

"definizione variabili
DATA: v_result TYPE int4, "intero
      v_cont   TYPE i.


*----------------------------------------------------

CASE v_oper. "case radiogroup selezionato

  WHEN '+' . "caso somma
    WRITE: |Operazione scelta: Somma|.
    ULINE.
    WRITE: |Somma tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } + { v_num2 }|.
    v_result = v_num1 + v_num2.
    v_cont = v_cont + 1.

  WHEN '-'. "caso differenza
    WRITE: |Operazione scelta: Sotrazione|.
    ULINE.
    WRITE: |Sotrazione tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } - { v_num2 }|.
    v_result = v_num1 - v_num2.
    v_cont = v_cont + 1.

  WHEN '*'."caso moltiplicazione
    WRITE: |Operazione scelta: Moltiplicazione|.
    ULINE.
    WRITE: |Moltiplicazione tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } * { v_num2 }|.
    v_result = v_num1 * v_num2.
    v_cont = v_cont + 1.

  WHEN '/'."caso divisione
    WRITE: |Operazione scelta: Divisione|.
    ULINE.
    WRITE: |Divisione tra { v_num1 } e { v_num2 }|.
    SKIP.
    IF v_num2 <> 0.
      WRITE: |Risultato = { v_num1 } / { v_num2 }|.
      v_result = v_num1 / v_num2.
      v_cont = v_cont + 1.
    ELSE.
      WRITE: |ERRORE: Il denominatore non può essere uguale a 0|.
    ENDIF.

ENDCASE.

v_num1 = 0.
v_num2 = 0.

IF v_cont = 0.
  WRITE: |ERRORE: operatore inserito non valido|.
ENDIF.

v_cont = v_cont + 1.

ULINE.
WRITE: |Risultato Finale: { v_result }| .
