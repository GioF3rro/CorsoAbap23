*&---------------------------------------------------------------------*
*& Report zbd04_business_partner
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zbd04_business_partner.

PARAMETERS: p_id TYPE but000-partner DEFAULT '0010000179'.

DATA: row TYPE but000.

SELECT SINGLE * FROM but000
INTO @row
WHERE partner = @p_id.

*IF sy-subrc <> 0.
*  "WRITE: |non sono presenti record da id -> { p_id }|.
*  exit.
*  RETURN. "fine programma anche se sei in una funzione
*ENDIF.

IF sy-subrc <> 0.
  "MESSAGE: |non sono presenti record da id -> { p_id }| TYPE 'E'. "error
  "MESSAGE: |non sono presenti record da id -> { p_id }| TYPE 'S'. "succes
  MESSAGE: |non sono presenti record da id -> { p_id }| TYPE 'W'. "warning
ENDIF.

PERFORM controllo USING row.

ULINE.

DATA: id  TYPE bu_partner VALUE '0010000179'.
"bup_but000_select_single
CALL FUNCTION 'BUP_BUT000_SELECT_SINGLE'
  EXPORTING
    i_partner      = id
  IMPORTING
    e_but000       = row
  EXCEPTIONS
    not_found      = 1
    internal_error = 2.



PERFORM controllo USING row.

FORM controllo USING row TYPE but000.

  IF row-type = 2 .
    WRITE: / |Nome business partner -> { row-name_org1 } , { row-name_org2 }|.
  ELSEIF row-type = 3 .
    WRITE: / |Nome business partner -> { row-name_grp1 } , { row-name_grp2 }|.

  ELSEIF row-type = 1 .
    WRITE: / |Nome business partner  -> { row-name_first } ,  { row-name_last }|.

  ELSE.
    WRITE: / | valore identificativo non valido -> { p_id }|.
  ENDIF.

ENDFORM.
