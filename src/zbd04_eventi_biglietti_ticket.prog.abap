*&---------------------------------------------------------------------*
*& Report zbd04_tickets_biglietti_ticket
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_tickets_biglietti_ticket.


DATA: ls_ticket TYPE zbdgc_eb_ticket.
DATA: ls_delete TYPE zbdgc_eb_ticket.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002.

  PARAMETERS: filtr_id TYPE zbdgc_eb_ticket-id_ticket.

SELECTION-SCREEN END OF BLOCK b4.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_evento TYPE zbdgc_eb_ticket-id_evento OBLIGATORY DEFAULT 1.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_ins  RADIOBUTTON GROUP rad DEFAULT 'X',
              p_del  RADIOBUTTON GROUP rad,
              p_list RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b3.


START-OF-SELECTION."codice per iniziare il codice del programma

  CASE 'X'.
    WHEN p_ins. "inserimento nuovo ticket

      ls_ticket-id_evento        = p_evento.
      ls_ticket-data_acquisto   = sy-datum.
      ls_ticket-partecipante = sy-uname.

      SELECT MAX( id_ticket ) FROM zbdgc_eb_ticket INTO ls_ticket-id_ticket.
      ls_ticket-id_ticket += 1.

      INSERT zbdgc_eb_ticket FROM ls_ticket.

      PERFORM visualizza_dati.

    WHEN p_del. "cancellazione ticket

      IF filtr_id <> ' '.

        SELECT id_ticket FROM zbdgc_eb_ticket INTO ls_delete-id_ticket
          WHERE
 id_ticket = filtr_id.
        ENDSELECT.

      ENDIF.

      IF ls_delete-id_ticket <> ' '.
        DELETE FROM zbdgc_eb_ticket WHERE id_ticket = ls_delete-id_ticket .
        PERFORM visualizza_dati.
      ELSE.
        WRITE: |ticket da eliminare non trovato|.
      ENDIF.

    WHEN p_list. "visualizzo lista tickets

      PERFORM visualizza_dati.

  ENDCASE.

FORM visualizza_dati.
  DATA BEGIN OF ls_output.
       INCLUDE TYPE zbdgc_eb_ticket.
  DATA titolo TYPE zbdgc_eb_evento-titolo.
  DATA END OF ls_output.
  DATA lt_output LIKE TABLE OF ls_output.

  "seleziono tutti i ticket della mia utenza
  SELECT * FROM zbdgc_eb_ticket
           INTO TABLE @DATA(lt_ticket)
           WHERE partecipante = @sy-uname.

  LOOP AT lt_ticket INTO DATA(ls_ticket).
    MOVE-CORRESPONDING ls_ticket TO ls_output.
    SELECT SINGLE titolo FROM zbdgc_eb_evento
                          INTO   ls_output-titolo
                          WHERE id = ls_output-id_evento.
    APPEND ls_output TO lt_output.
  ENDLOOP.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table = DATA(lo_alv)
    CHANGING
      t_table      = lt_output ).
  "Display the ALV Grid
  "Enable default ALV toolbar functions
  lo_alv->get_functions( )->set_all( ).
  lo_alv->display( ).
ENDFORM.
