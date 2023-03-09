*&---------------------------------------------------------------------*
*& Report zbd04_eventi_biglietti2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_eventi_biglietti2.

DATA: ls_evento TYPE zbdgc_eb_evento.
DATA: ls_delete TYPE zbdgc_eb_evento.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002.

  PARAMETERS: filtr_id TYPE zbdgc_eb_evento-id.

SELECTION-SCREEN END OF BLOCK b4.

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
*
*  PARAMETERS: f_titolo TYPE zbdgc_eb_evento-titolo DEFAULT 'sagra di paese',
*              f_descr  TYPE zbdgc_eb_evento-descrizione DEFAULT 'festa paesana con chiosco',
*              f_luogo  TYPE zbdgc_eb_evento-luogo DEFAULT 'conegliano',
*              f_prezzo TYPE zbdgc_eb_evento-prezzo DEFAULT 10,
*              f_data_i TYPE zbdgc_eb_evento-data_inizio DEFAULT sy-datum,
*              f_data_f TYPE zbdgc_eb_evento-data_fine DEFAULT '20230228',
*              f_ora_in TYPE zbdgc_eb_evento-ora_inizio,
*              f_ora_fi TYPE zbdgc_eb_evento-ora_fine,
*              f_catego TYPE zbdgc_eb_evento-categoria DEFAULT 3,
*              f_num_bi TYPE zbdgc_eb_evento-num_biglietti DEFAULT 500.
*
*SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_titolo TYPE zbdgc_eb_evento-titolo OBLIGATORY DEFAULT 'sagra di paese',
              p_descr  TYPE zbdgc_eb_evento-descrizione OBLIGATORY DEFAULT 'festa paesana con chiosco',
              p_luogo  TYPE zbdgc_eb_evento-luogo OBLIGATORY DEFAULT 'conegliano',
              p_prezzo TYPE zbdgc_eb_evento-prezzo OBLIGATORY DEFAULT 10,
              p_data_i TYPE zbdgc_eb_evento-data_inizio OBLIGATORY DEFAULT sy-datum,
              p_data_f TYPE zbdgc_eb_evento-data_fine OBLIGATORY DEFAULT '20230228',
              p_ora_in TYPE zbdgc_eb_evento-ora_inizio OBLIGATORY,
              p_ora_fi TYPE zbdgc_eb_evento-ora_fine OBLIGATORY,
              p_catego TYPE zbdgc_eb_evento-categoria OBLIGATORY DEFAULT 3,
              p_num_bi TYPE zbdgc_eb_evento-num_biglietti OBLIGATORY DEFAULT 500.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_ins  RADIOBUTTON GROUP rad DEFAULT 'X',
              p_del  RADIOBUTTON GROUP rad,
              p_mod  RADIOBUTTON GROUP rad,
              p_list RADIOBUTTON GROUP rad.

SELECTION-SCREEN END OF BLOCK b3.


START-OF-SELECTION."codice per iniziare il codice del programma

  CASE 'X'.
    WHEN p_ins. "inserimento nuovo evento

      ls_evento-titolo        = p_titolo.
      ls_evento-descrizione   = p_descr.
      ls_evento-luogo         = p_luogo.
      ls_evento-prezzo        = p_prezzo.
      ls_evento-data_inizio   = p_data_i.
      ls_evento-data_fine     = p_data_f.
      ls_evento-ora_inizio    = p_ora_in.
      ls_evento-ora_fine      = p_ora_fi.
      ls_evento-categoria     = p_catego.
      ls_evento-num_biglietti = p_num_bi.
      ls_evento-owner = sy-uname.

      SELECT MAX( id ) FROM zbdgc_eb_evento INTO ls_evento-id.
      ls_evento-id += 1.

      INSERT zbdgc_eb_evento FROM ls_evento.

      PERFORM visualizza.

    WHEN p_del. "cancellazione evento

      IF filtr_id <> ' '.

        SELECT id FROM zbdgc_eb_evento INTO ls_delete-id
          WHERE
          id = filtr_id.
        ENDSELECT.

*      ELSE.
*        SELECT id FROM zbdgc_eb_evento INTO ls_delete-id
*          WHERE
*          titolo LIKE '%f_titolo%' AND
*          descrizione LIKE '%f_descr%' AND
*          luogo like '%f_luogo%' AND
*          prezzo >= f_prezzo AND
*          data_inizio = f_data_i AND
*          data_fine = f_data_f AND
*          ora_inizio = f_ora_in AND
*          ora_fine = f_ora_fi AND
*          categoria = f_catego AND
*          num_biglietti = f_num_bi AND
*          owner = sy-uname.
*        ENDSELECT.

      ENDIF.

      IF ls_delete-id <> ' '.
        DELETE FROM zbdgc_eb_evento WHERE id = ls_delete-id .
        PERFORM visualizza.
      ELSE.
        WRITE: |evento da eliminare non trovato|.
      ENDIF.

    WHEN p_mod. "modifica evento

      IF filtr_id <> ' '.

        SELECT id FROM zbdgc_eb_evento INTO ls_delete-id
          WHERE
          id = filtr_id.
        ENDSELECT.

*      ELSE.
*        SELECT id FROM zbdgc_eb_evento INTO ls_delete-id
*          WHERE
*          titolo LIKE '%f_titolo%' AND
*          descrizione LIKE '%f_descr%' AND
*          luogo like '%f_luogo%' AND
*          prezzo >= f_prezzo AND
*          data_inizio = f_data_i AND
*          data_fine = f_data_f AND
*          ora_inizio = f_ora_in AND
*          ora_fine = f_ora_fi AND
*          categoria = f_catego AND
*          num_biglietti = f_num_bi AND
*          owner = sy-uname.
*        ENDSELECT.

      ENDIF.

      IF ls_delete-id <> ' '.

        DELETE FROM zbdgc_eb_evento WHERE id = ls_delete-id .

        ls_evento-titolo        = p_titolo.
        ls_evento-descrizione   = p_descr.
        ls_evento-luogo         = p_luogo.
        ls_evento-prezzo        = p_prezzo.
        ls_evento-data_inizio   = p_data_i.
        ls_evento-data_fine     = p_data_f.
        ls_evento-ora_inizio    = p_ora_in.
        ls_evento-ora_fine      = p_ora_fi.
        ls_evento-categoria     = p_catego.
        ls_evento-num_biglietti = p_num_bi.
        ls_evento-owner = sy-uname.
        ls_evento-id = ls_delete-id.

        INSERT zbdgc_eb_evento FROM ls_evento.
        PERFORM visualizza.

      ELSE.
        WRITE: |evento da modificare non trovato|.
      ENDIF.

    WHEN p_list. "visualizzo lista eventi

      PERFORM visualizza.

  ENDCASE.

FORM visualizza.

  SELECT * FROM zbdgc_eb_evento INTO TABLE @DATA(lt_eventi) WHERE owner = @sy-uname.

  cl_salv_table=>factory(
  IMPORTING
  r_salv_table = DATA(lo_alv)
  CHANGING
  t_table = lt_eventi ).
  lo_alv->get_functions( )->set_all( ).
  lo_alv->display( ).

ENDFORM.
