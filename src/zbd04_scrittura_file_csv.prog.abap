*&---------------------------------------------------------------------*
*& Report zbd04_scrittura_file_csv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_scrittura_file_csv.

DATA: lt_academy TYPE TABLE OF zbd00_academy23.

PARAMETERS: nome TYPE string DEFAULT 'example2'.

PARAMETERS: percorso RADIOBUTTON GROUP rad,
            name     RADIOBUTTON GROUP rad DEFAULT 'X'.

SELECT * FROM zbd00_academy23 INTO TABLE lt_academy.

DATA: path TYPE string.
IF name = 'X'.
  path = 'C:\Users\candidato.VM-WIN11\Desktop\' && nome && '.csv'.
ELSE.
  path = nome.
ENDIF.

START-OF-SELECTION.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename = path
      WRITE_FIELD_SEPARATOR = 'X'
    TABLES
      data_tab = lt_academy.
