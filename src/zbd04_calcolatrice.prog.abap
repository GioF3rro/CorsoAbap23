*&---------------------------------------------------------------------*
*& Report zbd04_calcolatrice
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_calcolatrice.


WRITE: |CALCOLATRICE|.
ULINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  "parametri input
  PARAMETERS: v_num1 TYPE int4 DEFAULT 0 OBLIGATORY, "intero
              v_num2 TYPE int4 DEFAULT 0 OBLIGATORY. "intero

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  "parametri radiobutton gruppo rad
  PARAMETERS: p_somma RADIOBUTTON GROUP rad DEFAULT 'X',
              p_diff  RADIOBUTTON GROUP rad,
              p_molt  RADIOBUTTON GROUP rad,
              p_div   RADIOBUTTON GROUP rad,
              p_poten RADIOBUTTON GROUP rad,
              p_segno RADIOBUTTON GROUP rad,
              p_fatt  RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b2.

"definizione variabili
DATA: v_result TYPE int4, "risultato
      v_count  TYPE i, "contatore
      v_fatt   TYPE int4. "variabile ausiliaria per il fattoriale


*----------------------------------------------------

CASE 'X'. "case radiogroup selezionato

  WHEN p_somma. "caso somma
    WRITE: |Operazione scelta: Somma|.
    ULINE.
    WRITE: |Somma tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } + { v_num2 }|.
    v_result = v_num1 + v_num2.

  WHEN p_diff. "caso differenza
    WRITE: |Operazione scelta: Sotrazione|.
    ULINE.
    WRITE: |Sotrazione tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } - { v_num2 }|.
    v_result = v_num1 - v_num2.

  WHEN p_molt."caso moltiplicazione
    WRITE: |Operazione scelta: Moltiplicazione|.
    ULINE.
    WRITE: |Moltiplicazione tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } * { v_num2 }|.
    v_result = v_num1 * v_num2.

  WHEN p_div."caso divisione
    WRITE: |Operazione scelta: Divisione|.
    ULINE.
    WRITE: |Divisione tra { v_num1 } e { v_num2 }|.
    SKIP.
    IF v_num2 <> 0.
      WRITE: |Risultato = { v_num1 } / { v_num2 }|.
      v_result = v_num1 / v_num2.
    ELSE.
      WRITE: |ERRORE: Il denominatore non può essere uguale a 0|.
    ENDIF.

  WHEN p_poten."caso potenza
    WRITE: |Operazione scelta: Potenza|.
    ULINE.
    WRITE: |Potenza tra { v_num1 } e { v_num2 }|.
    SKIP.
    WRITE: |Risultato = { v_num1 } ^ { v_num2 }|.
    v_result = v_num1 ** v_num2.

  WHEN p_segno."caso cambio segno
    WRITE: |Operazione scelta: Cambio Segno|.
    ULINE.
    WRITE: |Cambio segno di { v_num1 }|.
    SKIP.
    v_result = v_num1 * -1.
    WRITE: |Risultato = { v_num1 } * -1|.

  WHEN p_fatt."caso fattoriale
    WRITE: |Operazione scelta: Fattoriale|.
    ULINE.
    WRITE: |Fattoriale di { v_num1 } |.
    SKIP.
    WRITE: |Risultato = { v_num1 } |.
    v_count = v_num1 - 1.
    DO v_count TIMES.
      v_fatt = p_fatt - sy-index.
      v_result = v_result * v_fatt.
      WRITE: |* { v_fatt } |.
    ENDDO.

ENDCASE.

v_num1 = 0.
v_num2 = 0.

ULINE.
WRITE: |Risultato Finale: { v_result }| .
