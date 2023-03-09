*&---------------------------------------------------------------------*
*& Report zbd04_funzione
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_funzione.

DATA: numero1 TYPE int1 VALUE 4,
      numero2 TYPE int1 VALUE 6,
      numero3 TYPE int1 VALUE 8,
      numero4 TYPE LINE OF zbd04_tabella_numeri VALUE 2.

DATA: lv_somma TYPE /srmsmc/target_score.

DATA: lv_numeri TYPE zbd04_tabella_numeri.

*CALL FUNCTION 'ZBD04_MOLTIPLICAZIONE'
*  EXPORTING
*    iv_fattore1 = 7
*    iv_fattore2 = 1
*  IMPORTING
*    iv_fattore  = lv_PRODOTTO.
*
*WRITE: lv_prodotto.

APPEND numero1 TO lv_numeri.
APPEND numero2 TO lv_numeri.
APPEND numero3 TO lv_numeri.
APPEND numero4 TO lv_numeri.
*
*CALL FUNCTION 'ZBD04_SOMMAN'
*  EXPORTING
*    iv_tabella = lv_numeri
*
*  IMPORTING
*    ev_somma   = lv_somma.
*
*WRITE: 'somma: ',lv_somma.

ULINE.

DATA: media TYPE feh_pe_test_decfloat16.
CALL FUNCTION 'ZBD04_MEDIAN'
  EXPORTING
    iv_numeri = lv_numeri
  IMPORTING
    ev_media  = media.

WRITE: 'media: ',media.

uline.

DATA: soglia TYPE int1 VALUE 50.
DATA: soglia_t TYPE c LENGTH 10.

CALL FUNCTION 'ZBD00_SET_SOGLIA'
  EXPORTING
    iv_soglia = soglia.


CALL FUNCTION 'ZBD04_SOMMAN'
  EXPORTING
    iv_tabella = lv_numeri
    iv_soglia  = soglia
  IMPORTING
    ev_somma   = lv_somma
    ev_soglia  = soglia_t.

WRITE: 'somma: ',lv_somma.

if soglia_t = 'Basso'.
write: / 'nil numero è abastanza grande'.
else.
write: / 'non è abbastanza grande il numero'.
ENDIF.
