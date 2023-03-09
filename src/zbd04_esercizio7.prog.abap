*&---------------------------------------------------------------------*
*& Report zbd04_esercizio7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_esercizio7.

PARAMETERS: p_testo TYPE string.

PARAMETERS: p_max   RADIOBUTTON GROUP rad DEFAULT 'X',
            p_min   RADIOBUTTON GROUP rad,
            p_media RADIOBUTTON GROUP rad. "determina la media

DATA: gt_string TYPE TABLE OF string,
      gt_numeri TYPE TABLE OF f.


IF NOT p_testo CO '0123456789,-.'.
  WRITE: / |input not valid | COLOR COL_NEGATIVE.
  EXIT.
ENDIF.

SPLIT p_testo AT ',' INTO TABLE gt_string.

IF lines( gt_string ) = 0.
  WRITE: / |non è stato trovato nessun valore da valutare | COLOR COL_NEGATIVE.
  EXIT.
ENDIF.

LOOP AT gt_string INTO DATA(numero).
  APPEND numero TO gt_numeri.
ENDLOOP.

CASE 'X'.
  WHEN p_max.
    WRITE: / |numeri inseriti: |.
    DATA(max) = gt_numeri[ 1 ] .
    LOOP AT gt_numeri INTO DATA(numeri).

      WRITE: |{ numeri }|.
      IF max < numeri.
        max = numeri.
      ENDIF.

    ENDLOOP.

    ULINE.

    WRITE: / |il numero massimo inserito è: { max } |.

  WHEN p_min.
    WRITE: / |numeri inseriti: |.
    DATA(min) = gt_numeri[ 1 ] .
    LOOP AT gt_numeri INTO DATA(numeri2).

      WRITE: |{ numeri2 }|.
      IF min > numeri2.
        min = numeri2.
      ENDIF.

    ENDLOOP.

    ULINE.

    WRITE: / |il numero minimo inserito è: { min } |.

   when p_media.

   WRITE: / |numeri inseriti: |.
    DATA(somma) = 0.
    LOOP AT gt_numeri INTO DATA(numeri3).

      WRITE: |{ numeri3 }|.
      somma = somma + numeri3.

    ENDLOOP.

    data(media) = somma / lines( gt_numeri ).

    ULINE.

    WRITE: / |la media inserita è: { media } |.

ENDCASE.
