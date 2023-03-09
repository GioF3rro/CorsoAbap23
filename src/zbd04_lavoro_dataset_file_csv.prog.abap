*&---------------------------------------------------------------------*
*& Report zbd04_lavoro_dataset_file_csv
*&---------------------------------------------------------------------*
REPORT zbd04_lavoro_dataset_file_csv.
*&---------------------------------------------------------------------*
PARAMETERS: p_downl RADIOBUTTON GROUP rad,
            p_upl   RADIOBUTTON GROUP rad DEFAULT 'X'.

PARAMETERS p_alv AS CHECKBOX DEFAULT 'X'.

DATA:
  BEGIN OF struct,
    id      TYPE zbd04_academy23-id_partecipante,
    nome    TYPE zbd04_academy23-nome,
    cognome TYPE zbd04_academy23-cognome,
    luogo   TYPE zbd04_academy23-luogo_nascita,
    data    TYPE zbd04_academy23-data_nascita,
    ccelera TYPE zbd04_academy23-sede_vicina,
    icona   TYPE icon-id,
  END OF struct.

DATA: tabella_struttura LIKE TABLE OF struct,
      riga_struttura    LIKE LINE OF tabella_struttura.

START-OF-SELECTION.

  CASE 'X'. "caso da tabella a file

    WHEN p_upl.

      PERFORM upload.

    WHEN p_downl. "caso upload da file a tabella

      PERFORM download.

  ENDCASE.

  "PERFORM stampa.
  perform alv.

**********************************************************************
**********************************************************************

FORM alv.

  DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
        wa_fieldcat TYPE slis_fieldcat_alv.
** ALV
  REFRESH it_fieldcat. CLEAR it_fieldcat[].

  wa_fieldcat-fieldname  = 'id'.
  wa_fieldcat-seltext_m  = 'ID'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'nome'.
  wa_fieldcat-seltext_m  = 'Nome'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'cognome'.
  wa_fieldcat-seltext_m  = 'Cognome'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'luogo'.
  wa_fieldcat-seltext_m  = 'Luogo di Nascita'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'data'.
  wa_fieldcat-seltext_m  = 'Data di Nascita'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'ccelera'.
  wa_fieldcat-seltext_m  = 'Sede Vicina'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname  = 'icona'.
  wa_fieldcat-seltext_m  = 'ICONA'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

** Function module to display ALV list
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = it_fieldcat
    TABLES
      "t_outtab      = gt_sspr
      t_outtab      = tabella_struttura
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  "gestione errori
  IF sy-subrc <> 0.
    MESSAGE e009(zbd08_messaggi).
  ENDIF.


ENDFORM.

**********************************************************************
FORM presente_alv USING controllo_riga TYPE zbd04_academy23.

  riga_struttura-id = controllo_riga-id_partecipante.
  riga_struttura-nome = controllo_riga-nome.
  riga_struttura-cognome = controllo_riga-cognome.
  riga_struttura-luogo = controllo_riga-luogo_nascita.
  riga_struttura-data = controllo_riga-data_nascita.
  riga_struttura-ccelera = controllo_riga-sede_vicina.
  riga_struttura-icona = '@19@'.
  APPEND riga_struttura TO tabella_struttura.

ENDFORM.

**********************************************************************
FORM non_presente_alv USING controllo_riga TYPE zbd04_academy23.

  riga_struttura-id = controllo_riga-id_partecipante.
  riga_struttura-nome = controllo_riga-nome.
  riga_struttura-cognome = controllo_riga-cognome.
  riga_struttura-luogo = controllo_riga-luogo_nascita.
  riga_struttura-data = controllo_riga-data_nascita.
  riga_struttura-ccelera = controllo_riga-sede_vicina.
  riga_struttura-icona = '@19@'.
  APPEND riga_struttura TO tabella_struttura.

ENDFORM.


**********************************************************************

FORM stampa.

  SELECT * FROM zbd04_academy23 INTO TABLE @DATA(select).
  cl_demo_output=>display( select ).

ENDFORM.

**********************************************************************

FORM download.

  DATA: lv_data TYPE string.
  DATA: gv_file   TYPE rlgrap-filename.
  DATA: gt_spfli TYPE TABLE OF zbd04_academy23.

* Move complete path to filename
  gv_file = '/tmp/AcademyOutput_csv.csv'.

* Open the file in output mode
  OPEN DATASET gv_file FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc NE 0.
    MESSAGE 'Unable to create file' TYPE 'I'.
    EXIT.
  ENDIF.

  SELECT * FROM zbd04_academy23 INTO TABLE @gt_spfli.

  LOOP AT gt_spfli INTO DATA(gwa_spfli).
    CONCATENATE gwa_spfli-id_partecipante
                gwa_spfli-nome
                gwa_spfli-cognome
                gwa_spfli-luogo_nascita
                gwa_spfli-data_nascita
                gwa_spfli-sede_vicina
     INTO lv_data
     SEPARATED BY ';'.

*   TRANSFER moves the above fields from workarea to file  with comma
*   delimited format
    TRANSFER lv_data TO gv_file.
    CLEAR: gwa_spfli.

  ENDLOOP.

*     close the file
  CLOSE DATASET gv_file.

ENDFORM.

**********************************************************************

FORM upload.
*------------------------------------------------------------------------------*
*          internal table declaration
*------------------------------------------------------------------------------*
  DATA: BEGIN OF it_final OCCURS 0,
          id      TYPE zbd04_academy23-id_partecipante,
          nome    TYPE zbd04_academy23-nome,
          cognome TYPE zbd04_academy23-cognome,
          data    TYPE zbd04_academy23-data_nascita,
          luogo   TYPE zbd04_academy23-luogo_nascita,
          ccelera TYPE zbd04_academy23-sede_vicina,
          "icona   TYPE icon-id,
        END OF it_final.

*--- work area for the internal table
  DATA wa_it_final LIKE LINE OF it_final.
  DATA: lv_string TYPE string.

*------------------------------------------------------------------------------*
*                    variable  declaration
*------------------------------------------------------------------------------*
  DATA: v_excel_string(2000) TYPE c,
        v_file               LIKE v_excel_string VALUE '/tmp/Academy_csv.csv',     " name of the file
        delimiter            TYPE c VALUE ' '.                                     " delimiter with default value space

*------------------------------------------------------------------------------*
*      read the file from the application server
*------------------------------------------------------------------------------*
  OPEN DATASET v_file FOR INPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc NE 0.
    WRITE:/ 'error opening file'.
  ELSE.
    "finchè lv_string non è inizializata oppure non ci sono stati ancora errori con l'apertura di open dataset
    WHILE lv_string IS NOT INITIAL OR sy-subrc EQ 0.

      READ DATASET v_file INTO lv_string.
      IF NOT lv_string IS INITIAL.
**      Replace new line -> toglie # di  uova riga
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>newline IN lv_string WITH space.

        "split ;
        SPLIT lv_string AT ';' INTO wa_it_final-id wa_it_final-nome wa_it_final-cognome wa_it_final-data wa_it_final-luogo wa_it_final-ccelera.

        APPEND wa_it_final TO it_final.
        CLEAR wa_it_final.

      ENDIF.
    ENDWHILE.
  ENDIF.
  CLOSE DATASET v_file.

* insert data from internal table to database table
  DATA: row_academy TYPE zbd04_academy23.
  LOOP AT it_final INTO DATA(final_row).

    row_academy-id_partecipante = final_row-id.
    row_academy-nome = final_row-nome.
    row_academy-cognome = final_row-cognome.
    row_academy-luogo_nascita = final_row-luogo.
    row_academy-data_nascita = final_row-data.
    row_academy-sede_vicina = final_row-ccelera.

*    data(controllo) = 0.
*    perform controllo_id using row_academy-id_partecipante changing controllo.
    perform controllo_id using row_academy-id_partecipante .

    MODIFY zbd04_academy23 FROM @row_academy.
    CLEAR row_academy.

  ENDLOOP.

ENDFORM.

**********************************************************************

FORM controllo_id USING id TYPE zbd04_academy23-id_partecipante.

    data: tabella_select type zbd04_academy23.
  SELECT single * FROM zbd04_academy23 where id_partecipante = @id INTO @tabella_select.

  IF tabella_select-id_partecipante = id.
    perform presente_alv using tabella_select.
  ELSE.
    perform non_presente_alv using tabella_select.
  ENDIF.

ENDFORM.
