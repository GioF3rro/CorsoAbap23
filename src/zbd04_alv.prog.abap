*&---------------------------------------------------------------------*
*& Report zbd04_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_alv.

DATA: gt_sspr TYPE TABLE OF zbd04_academy23.

SELECT * FROM zbd04_academy23 INTO TABLE @gt_sspr.

DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv.

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
