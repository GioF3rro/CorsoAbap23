*&---------------------------------------------------------------------*
*& Report zbd04_rc_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_rc_test.


data: results type table of tab512,
      opts type TABLE of rfc_db_opt,
      fields type table of rfc_db_fld.

CALL FUNCTION 'RFC_READ_TABLE'
  EXPORTING
    query_table                = 'T000'
*   DELIMITER                  = ' '
*   NO_DATA                    = ' '
*   ROWSKIPS                   = 0
*   ROWCOUNT                   = 0
  tables
    options                    = opts
    fields                     = fields
    data                       = results
* EXCEPTIONS
*   TABLE_NOT_AVAILABLE        = 1
*   TABLE_WITHOUT_DATA         = 2
*   OPTION_NOT_VALID           = 3
*   FIELD_NOT_VALID            = 4
*   NOT_AUTHORIZED             = 5
*   DATA_BUFFER_EXCEEDED       = 6
*   OTHERS                     = 7
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

cl_demo_output=>display( results ).
