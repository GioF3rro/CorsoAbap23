*&---------------------------------------------------------------------*
*& Report zbd04_read_scarr
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_read_scarr.

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"ROBA SCONIGLIATA ED è MEGLIO NON FARLA
TABLES: scarr.
"equivale a :
"DATA: scarr TYPE scarr.

SELECT * FROM scarr.
  WRITE: scarr-carrname, scarr-carrid.
ENDSELECT.
""""""""""""""""""""""""""""""""""""""""""""""""""

DATA: lt_scarr  TYPE TABLE OF scarr,
      ls_scarr2 LIKE LINE OF lt_scarr.

*DATA: BEGIN OF airline ovvurs 0,    occurs è vecchio e deprecato, non usarlo

DATA: BEGIN OF airline,
        carrid   TYPE s_carr_id,
        carrname TYPE scarr-carrname,
        currcode LIKE ls_scarr2-currcode,
*       url
      END OF airline.

SELECT-OPTIONS s_scarr FOR ls_scarr2-carrid.

"SELECT * FROM scarr INTO TABLE lt_scarr.
SELECT * FROM scarr WHERE carrid IN @s_scarr INTO TABLE @lt_scarr.

"inserimento nella tabella e stampa dei valori
*LOOP AT lt_scarr INTO DATA(ls_scarr).
*  MOVE-CORRESPONDING ls_scarr TO airline.
*  ls_scarr2 = ls_scarr.
*  WRITE: / |Codice compagnia { ls_scarr-carrid } - nome : { ls_scarr-carrname }|.
*ENDLOOP.

cl_demo_output=>display( lt_scarr ). "mostra quello che c'è all'interno di una tabella
