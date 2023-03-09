*&---------------------------------------------------------------------*
*& Report zbd04_8regine
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_8regine.

PARAMETERS: n_regine TYPE i DEFAULT 4.

DATA: v_regine TYPE TABLE OF i,
      v_controllo type bool value abap_false.

DO n_regine TIMES.
  APPEND 0 TO v_regine.
ENDDO.

v_regine[ 1 ] = 'Q'. "posiziono la prima regina in posizione 2 della prima riga
"n_regine = n_regine - 1.

LOOP AT v_regine INTO DATA(posizione).
  WRITE: | { posizione } |.
ENDLOOP.

ULINE.

PERFORM controllo CHANGING v_regine.

FORM controllo CHANGING gt_scacchiera LIKE v_regine.
  DATA(n_regine) = 4.
  DATA(contatore) = 1.
  LOOP AT v_regine INTO DATA(posizione).

    DATA(numero) = posizione.
    IF numero = contatore.
      contatore = contatore + 1.
      CONTINUE.
    ENDIF.

    DO n_regine TIMES.

      DATA(count) = sy-index.
      DATA(maggiore) = contatore + ( 1 * count ).
      DATA(minore) = contatore - ( 1 * count ).

      IF ( numero = maggiore ) OR ( numero = minore ) .
        contatore = contatore + 1.
        CONTINUE.
      ENDIF.

    ENDDO.



  ENDLOOP.
ENDFORM.
