*&---------------------------------------------------------------------*
*& Report zbd04_delete_table
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_delete_table.

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

SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_id TYPE zbd04_academy23-id_partecipante OBLIGATORY DEFAULT '0001'.

SELECTION-SCREEN END OF BLOCK b6.

DATA: gs_insert TYPE zbd04_academy23.

DATA: gs_select LIKE TABLE OF zbd04_academy23.


gs_insert-nome = p_nome.
gs_insert-cognome = p_cogno.
gs_insert-luogo_nascita = p_p_nato.
gs_insert-data_nascita = p_d_nato.
gs_insert-sede_vicina = p_sede.

gs_insert-id_partecipante = p_id.

delete FROM zbd04_academy23 where id_partecipante = gs_insert-id_partecipante and nome = gs_insert-nome and cognome = gs_insert-cognome and luogo_nascita = gs_insert-luogo_nascita and data_nascita = gs_insert-luogo_nascita.
