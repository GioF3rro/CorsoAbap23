*&---------------------------------------------------------------------*
*& Report zbd04_upload_file_csv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_upload_file_csv.

DATA: lt_raw_data     TYPE  truxs_t_text_data,
      lv_dataset_line TYPE string,
      ref_wa          TYPE REF TO data.

DATA: tab_academy TYPE TABLE OF zbd04_academy23.

FIELD-SYMBOLS: <fs_itab> TYPE ANY TABLE,
               <fs_wa>   TYPE any.

DATA(im_delimiter) = ' '.
DATA(im_field_separator) = ' '.
DATA(lo_csv_converter) =  cl_rsda_csv_converter=>create( i_delimiter = im_delimiter i_separator = im_field_separator ).

"CREATE A DYNAMIC TABLE WITH THE SAME STRUCTURE AS TARGETED TABLE
ASSIGN tab_academy TO <fs_itab>.

"CREATE A DYNAMIC STRUCTURE
CREATE DATA ref_wa LIKE LINE OF <fs_itab>.
ASSIGN ref_wa->* TO <fs_wa>.

DATA: im_filepath TYPE string VALUE 'C:\Users\candidato.VM-WIN11\Desktop\dati_academy2.csv'.

START-OF-SELECTION.

  "UPLOAD CSV FILE
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename = im_filepath
      filetype = 'ASC'
    TABLES
      data_tab = lt_raw_data.

  DATA: ls_string TYPE TABLE OF string, "split da file per i singoli campi
        ls_value  LIKE zbd04_academy23. "riga tabella inserimento

  "SEPARATE VALUES AND APPEND THEM INTO TARGET TABLE
  LOOP AT lt_raw_data INTO DATA(ls_csv_line).

    SPLIT ls_csv_line AT ';' INTO TABLE DATA(segments).
    ls_value-id_partecipante = segments[ 1 ].
    ls_value-nome = segments[ 2 ].
    ls_value-cognome = segments[ 3 ].
    ls_value-luogo_nascita = segments[ 4 ].
    ls_value-data_nascita = segments[ 5 ].
    ls_value-sede_vicina = segments[ 6 ].

    "INSERT INTO zbd04_academy23 VALUES ls_value.
    MODIFY zbd04_academy23 from @ls_value.

    CLEAR segments.
    CLEAR ls_value.

  ENDLOOP.

  SELECT * FROM zbd04_academy23 INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
