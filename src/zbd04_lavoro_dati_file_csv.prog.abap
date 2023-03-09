*&---------------------------------------------------------------------*
*& Report zbd04_lavoro_dati_file_csv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_lavoro_dati_file_csv.

"PARAMETERS: p_path TYPE string DEFAULT 'C:\Users\candidato.VM-WIN11\Desktop\dati_academy2.csv'.

PARAMETERS: up_file TYPE localfile.

PARAMETERS: p_downl RADIOBUTTON GROUP rad DEFAULT 'X',
            p_upl   RADIOBUTTON GROUP rad.

PARAMETERS p_alv AS CHECKBOX DEFAULT 'X'.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR up_file.
  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
      static    = 'X'
    CHANGING
      file_name = up_file.

  "gestione errori
  IF sy-subrc <> 0.
    MESSAGE e009(zbd08_messaggi).
  ENDIF.



START-OF-SELECTION.
  "  BREAK-POINT.

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
*
*  SELECT id FROM  icon WHERE name = 'ICON_OKAY' INTO @DATA(nuova_riga). ENDSELECT.
*  SELECT id FROM  icon WHERE name = 'ICON_MESSAGE_INFORMATION' INTO @DATA(esiste_riga). ENDSELECT.

  DATA: p_path TYPE string.
  p_path = up_file.

  IF p_path = ''.
    MESSAGE e009(zbd08_messaggi).
  ENDIF.

  CASE 'X'. "caso da tabella a file

    WHEN p_downl.

      SELECT * FROM zbd04_academy23 INTO TABLE @DATA(lt_academy).

      DATA: lt_string TYPE TABLE OF string.
      LOOP AT lt_academy INTO DATA(lt_riga).

        DATA: riga TYPE string.
        riga = lt_riga-id_partecipante && ';' && lt_riga-nome && ';' && lt_riga-cognome && ';' && lt_riga-luogo_nascita && ';' && lt_riga-data_nascita && ';' && lt_riga-sede_vicina.

        APPEND riga TO lt_string.
        CLEAR riga.

      ENDLOOP.

      "chiamo funzione gui dowload
      CALL FUNCTION 'GUI_DOWNLOAD'
        EXPORTING
          filename              = p_path
          write_field_separator = 'X'
        TABLES
          data_tab              = lt_string.

      "gestione errori
      IF sy-subrc <> 0.
        MESSAGE e009(zbd08_messaggi).
      ENDIF.


    WHEN p_upl. "caso upload da file a tabella


      DATA: lt_raw_data     TYPE  truxs_t_text_data,
            lv_dataset_line TYPE string,
            ref_wa          TYPE REF TO data.

      DATA: tab_academy TYPE TABLE OF zbd04_academy23.

      FIELD-SYMBOLS: <fs_itab> TYPE ANY TABLE,
                     <fs_wa>   TYPE any.

      "delimitatori
      DATA(im_delimiter) = ' '.
      DATA(im_field_separator) = ' '.
      DATA(lo_csv_converter) =  cl_rsda_csv_converter=>create( i_delimiter = im_delimiter i_separator = im_field_separator ).

      "CREATE A DYNAMIC TABLE WITH THE SAME STRUCTURE AS TARGETED TABLE
      ASSIGN tab_academy TO <fs_itab>.

      "CREATE A DYNAMIC STRUCTURE
      CREATE DATA ref_wa LIKE LINE OF <fs_itab>.
      ASSIGN ref_wa->* TO <fs_wa>.

      "UPLOAD CSV FILE
      CALL FUNCTION 'GUI_UPLOAD'
        EXPORTING
          filename = p_path
          filetype = 'ASC'
        TABLES
          data_tab = lt_raw_data.

      "gestione errori
      IF sy-subrc <> 0.
        MESSAGE e009(zbd08_messaggi).
      ENDIF.

      DATA: ls_string TYPE TABLE OF string, "split da file per i singoli campi
            ls_value  LIKE zbd04_academy23. "riga tabella inserimento

      "SEPARATE VALUES AND APPEND THEM INTO TARGET TABLE
      LOOP AT lt_raw_data INTO DATA(ls_csv_line).

        SPLIT ls_csv_line AT ';' INTO TABLE DATA(segments)."split per olonne del file csv

        "inserimetno valore colonna per campo split
        ls_value-id_partecipante = segments[ 1 ].
        ls_value-nome = segments[ 2 ].
        ls_value-cognome = segments[ 3 ].
        ls_value-luogo_nascita = segments[ 4 ].
        ls_value-data_nascita = segments[ 5 ].
        ls_value-sede_vicina = segments[ 6 ].

        SELECT * FROM zbd04_academy23 WHERE id_partecipante = @ls_value-id_partecipante INTO TABLE @DATA(controllo_riga).

        IF lines( controllo_riga ) > 0.
          DATA(popup_return) = 'value'.
          CALL FUNCTION 'POPUP_TO_CONFIRM'
            EXPORTING
              titlebar              = 'Confirmation '
              text_question         = 'Row Exist with this ID. Do you want to Overwrite'
              text_button_1         = 'Yes'
              text_button_2         = 'No'
              default_button        = '2'
              display_cancel_button = 'X'
            IMPORTING
              answer                = popup_return " to hold the FM's return value
            EXCEPTIONS
              text_not_found        = 1
              OTHERS                = 2.
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.

          IF popup_return EQ '1'.
            riga_struttura-id = controllo_riga[ 1 ]-id_partecipante.
            riga_struttura-nome = controllo_riga[ 1 ]-nome.
            riga_struttura-cognome = controllo_riga[ 1 ]-cognome.
            riga_struttura-luogo = controllo_riga[ 1 ]-luogo_nascita.
            riga_struttura-data = controllo_riga[ 1 ]-data_nascita.
            riga_struttura-ccelera = controllo_riga[ 1 ]-sede_vicina.
            riga_struttura-icona = '@19@'.
            APPEND riga_struttura TO tabella_struttura.
            MODIFY zbd04_academy23 FROM @ls_value.
          ELSE.

            riga_struttura-id = controllo_riga[ 1 ]-id_partecipante.
            riga_struttura-nome = controllo_riga[ 1 ]-nome.
            riga_struttura-cognome = controllo_riga[ 1 ]-cognome.
            riga_struttura-luogo = controllo_riga[ 1 ]-luogo_nascita.
            riga_struttura-data = controllo_riga[ 1 ]-data_nascita.
            riga_struttura-ccelera = controllo_riga[ 1 ]-sede_vicina.
            riga_struttura-icona = '@19@'.
            APPEND riga_struttura TO tabella_struttura.

            CONTINUE.
          ENDIF.

        ELSE.
          riga_struttura-id = ls_value-id_partecipante.
          riga_struttura-nome = ls_value-nome.
          riga_struttura-cognome = ls_value-cognome.
          riga_struttura-luogo = ls_value-luogo_nascita.
          riga_struttura-data = ls_value-data_nascita.
          riga_struttura-ccelera = ls_value-sede_vicina.
          riga_struttura-icona = '@0V@'.
          APPEND riga_struttura TO tabella_struttura.

          "INSERT INTO zbd04_academy23 VALUES ls_value.
          MODIFY zbd04_academy23 FROM @ls_value.
        ENDIF.

        "pulizia variabili
        CLEAR segments.
        CLEAR ls_value.
        CLEAR controllo_riga.
        CLEAR riga_struttura.

      ENDLOOP.

      cl_demo_output=>display( tabella_struttura ).

  ENDCASE.


    DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
          wa_fieldcat TYPE slis_fieldcat_alv.

  IF p_alv = 'X' and p_upl = 'X'.

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

  elseIF p_alv = 'X' and p_downl = 'X'.

    DATA: gt_sspr TYPE TABLE OF zbd04_academy23.

    SELECT * FROM zbd04_academy23 ORDER BY id_partecipante INTO TABLE @gt_sspr.

** ALV
    REFRESH it_fieldcat. CLEAR it_fieldcat[].

    wa_fieldcat-fieldname  = 'id_partecipante'.
    wa_fieldcat-seltext_m  = 'Partner'.
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

    wa_fieldcat-fieldname  = 'luogo_nascita'.
    wa_fieldcat-seltext_m  = 'Luogo di Nascita'.
    APPEND wa_fieldcat TO it_fieldcat.
    CLEAR wa_fieldcat.

    wa_fieldcat-fieldname  = 'data_nascita'.
    wa_fieldcat-seltext_m  = 'Data di Nascita'.
    APPEND wa_fieldcat TO it_fieldcat.
    CLEAR wa_fieldcat.

    wa_fieldcat-fieldname  = 'sede_vicina'.
    wa_fieldcat-seltext_m  = 'Sede Vicina'.
    APPEND wa_fieldcat TO it_fieldcat.
    CLEAR wa_fieldcat.

** Function module to display ALV list
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        it_fieldcat   = it_fieldcat
      TABLES
        t_outtab      = gt_sspr
      EXCEPTIONS
        program_error = 1
        OTHERS        = 2.

    "gestione errori
    IF sy-subrc <> 0.
      MESSAGE e009(zbd08_messaggi).
    ENDIF.

  ELSE.
    MESSAGE a001(zbd04).
  ENDIF.
