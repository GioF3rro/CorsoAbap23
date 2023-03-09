*&---------------------------------------------------------------------*
*& Report zbd04_report_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_report_test.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_numero TYPE i OBLIGATORY DEFAULT 100.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  "parametri radiobutton gruppo rad
  PARAMETERS: p_tutti RADIOBUTTON GROUP rad DEFAULT 'X',
              p_pari  RADIOBUTTON GROUP rad,
              p_mult5 RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b2.

*write: |Stampa numeri da 1 a { p_numero }| .
*do p_numero TIMES.
*    write: / | -> { sy-index } <-| .
*ENDDO.
*
*uline.
*
*data(n) = 1.
*write: / |Stampa numeri da 1 a { p_numero }| .
*while n <= p_numero.
*    write: / | <- { sy-index } ->| .
*    n = n + 1.
*ENDWHILE.

*DATA(n) = 1.
*CASE 'X'.
*
*  WHEN p_tutti.
*    WRITE: / |Stampa numeri da 1 a { p_numero }| .
*    WHILE n <= p_numero.
*      WRITE: / | <- { sy-index } ->| .
*      n = n + 1.
*    ENDWHILE.
*
*  WHEN p_pari.
*    WRITE: / |Stampa numeri pari da 1 a { p_numero }| .
*    WHILE n <= p_numero.
*      IF sy-index MOD 2 = 0.
*        WRITE: / | <- { sy-index } ->| .
*      ENDIF.
*      n = n + 1.
*    ENDWHILE.
*
*  WHEN p_mult5.
*    WRITE: / |Stampa numeri multipli di 5 da 1 a { p_numero }| .
*    WHILE n <= p_numero.
*      IF sy-index MOD 5 = 0.
*        WRITE: / | <- { sy-index } ->| .
*      ENDIF.
*      n = n + 1.
*    ENDWHILE.
*
*ENDCASE.


DATA(n) = 1.

CASE 'X'.

  WHEN p_tutti.
    WRITE: / |Stampa numeri da 1 a { p_numero }| .

  WHEN p_pari.
    WRITE: / |Stampa numeri pari da 1 a { p_numero }| .

  WHEN p_mult5.
    WRITE: / |Stampa numeri multipli di 5 da 1 a { p_numero }| .

ENDCASE.


WHILE n <= p_numero.

  CASE 'X'.

    WHEN p_tutti.
      WRITE: / | <- { sy-index } ->| .

    WHEN p_pari.
      IF sy-index MOD 2 = 0.
        WRITE: / | <- { sy-index } ->| .
      ENDIF.

    WHEN p_mult5.
      IF sy-index MOD 5 = 0.
        WRITE: / | <- { sy-index } ->| .
      ENDIF.

  ENDCASE.

  n = n + 1.

ENDWHILE.
