*&---------------------------------------------------------------------*
*& Report zbd04_eventi_biglietti
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_eventi_biglietti.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.

  "parametri radiobutton gruppo rad
  PARAMETERS: p_crea   RADIOBUTTON GROUP rad DEFAULT 'X',
              p_compra RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_id TYPE zbd04_events-id_evento .

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b8 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_titolo TYPE zbd04_events-titolo .

SELECTION-SCREEN END OF BLOCK b8.

SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_desc TYPE zbd04_events-descrizione .

SELECTION-SCREEN END OF BLOCK b5.

SELECTION-SCREEN BEGIN OF BLOCK b7 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_tipo TYPE zbd04_events-categoria .

SELECTION-SCREEN END OF BLOCK b7.

SELECTION-SCREEN BEGIN OF BLOCK b9 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_capo TYPE zbd04_events-organizzatore .

SELECTION-SCREEN END OF BLOCK b9.

SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_luogo TYPE zbd04_events-luogo .

SELECTION-SCREEN END OF BLOCK b6.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_dt_ini TYPE zbd04_events-data_inizio .

SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_dt_fin TYPE zbd04_events-data_fine .

SELECTION-SCREEN END OF BLOCK b4.

SELECTION-SCREEN BEGIN OF BLOCK b10 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_ora_i TYPE zbd04_events-orario_inizio .

SELECTION-SCREEN END OF BLOCK b10.

SELECTION-SCREEN BEGIN OF BLOCK b11 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_ora_f TYPE zbd04_events-orario_fine .

SELECTION-SCREEN END OF BLOCK b11.

SELECTION-SCREEN BEGIN OF BLOCK b12 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_numero TYPE zbd04_events-numero_max .

SELECTION-SCREEN END OF BLOCK b12.

SELECTION-SCREEN BEGIN OF BLOCK b13 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_prezzo TYPE zbd04_events-prezzo .

SELECTION-SCREEN END OF BLOCK b13.


DATA: gs_eventi LIKE TABLE OF zbd04_events.
DATA: gs_insert TYPE zbd04_events.

DATA: gs_tickets LIKE TABLE OF zbd04_ticket.
DATA: gs_insert2 TYPE zbd04_ticket.

IF p_compra = 'X'.
  SELECT * FROM zbd04_events WHERE id_evento = @p_id INTO TABLE @gs_eventi.

  IF lines( gs_eventi ) > 0 .
    gs_insert2-id_evento = p_id.
    gs_insert2-data_acquisto = sy-datum .
    gs_insert2-utente_acquisto = sy-uname.

    SELECT * FROM zbd04_ticket where id_evento = @p_id ORDER BY id_biglietto DESCENDING INTO TABLE @gs_tickets .

    data(chiave) = gs_tickets[ 1 ]-id_biglietto.
    chiave = chiave + 1.

    gs_insert2-id_biglietto = chiave.

    INSERT INTO zbd04_ticket VALUES gs_insert2.

  ELSE.
    EXIT.
  ENDIF.



ELSE.

  SELECT * FROM zbd04_events INTO TABLE gs_eventi ORDER BY id_evento DESCENDING.

  data(chiave2) = gs_eventi[ 1 ]-id_evento.
  chiave2 = chiave2 + 1.

  gs_insert-id_evento = chiave2.
  gs_insert-titolo = p_titolo.
  gs_insert-descrizione = p_desc.
  gs_insert-categoria = p_tipo.
  gs_insert-organizzatore = sy-uname.
  gs_insert-luogo = p_luogo.
  gs_insert-data_inizio = p_dt_ini.
  gs_insert-data_fine = p_dt_fin.
  gs_insert-orario_inizio = p_ora_i.
  gs_insert-orario_fine = p_ora_f.
  gs_insert-numero_max = p_numero.
  gs_insert-prezzo = p_prezzo.


  INSERT INTO zbd04_events VALUES gs_insert.

ENDIF.
