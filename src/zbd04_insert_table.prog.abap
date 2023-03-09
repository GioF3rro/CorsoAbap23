*&---------------------------------------------------------------------*
*& Report zbd04_insert_table
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_insert_table.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_nome TYPE zbd04_academy23-nome OBLIGATORY DEFAULT 'Mario'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_cogno TYPE zbd04_academy23-cognome OBLIGATORY DEFAULT 'Rossi'.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_p_nato TYPE zbd04_academy23-luogo_nascita OBLIGATORY DEFAULT 'Napoli' .

SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_d_nato TYPE zbd04_academy23-data_nascita OBLIGATORY .

SELECTION-SCREEN END OF BLOCK b4.

SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_sede TYPE zbd04_academy23-sede_vicina OBLIGATORY DEFAULT 'VE'.

SELECTION-SCREEN END OF BLOCK b5.

uline.

SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE TEXT-002.

  "parametri radiobutton gruppo rad
  PARAMETERS: p_insert RADIOBUTTON GROUP rad DEFAULT 'X',
              p_modify  RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b6.

DATA: gs_insert TYPE zbd04_academy23.

DATA: gs_select LIKE TABLE OF zbd04_academy23.


gs_insert-nome = p_nome.
gs_insert-cognome = p_cogno.
gs_insert-luogo_nascita = p_p_nato.
gs_insert-data_nascita = p_d_nato.
gs_insert-sede_vicina = p_sede.

*gs_insert-id_partecipante = '0002'.

SELECT * FROM zbd04_academy23 INTO TABLE gs_select.

DATA(chiave_nuova) = '0001'.
IF lines( gs_select ) > 0.
  chiave_nuova = gs_select[ 1 ]-id_partecipante + 1 .
ENDIF.

if chiave_nuova < 10.
    chiave_nuova = '000' && chiave_nuova.
ENDIF.

if chiave_nuova < 100 and chiave_nuova >= 10.
    chiave_nuova = '00' && chiave_nuova.
ENDIF.

if chiave_nuova < 1000 and chiave_nuova >= 100.
    chiave_nuova = '0' && chiave_nuova.
ENDIF.

gs_insert-id_partecipante = chiave_nuova.

case 'X'.
    when p_insert.
    INSERT INTO zbd04_academy23 VALUES gs_insert.

    when p_modify.
    MODIFY zbd04_academy23 from gs_insert.

ENDCASE.
