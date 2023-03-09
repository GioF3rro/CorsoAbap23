*&---------------------------------------------------------------------*
*& Report zbd04_smart_form_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_smart_form_test.

  parameters p_titolo type string DEFAULT 'PARTECIPANTI AL CORSO' OBLIGATORY.

  DATA: formname                TYPE tdsfname,
        lv_function_module_name TYPE rs38l_fnam,
        l_devtype               TYPE rspoptype,
        ls_output_options       TYPE ssfcompop,
        ls_control_parameters   TYPE ssfctrlop,
        ls_output_data          TYPE ssfcrescl,
        lt_partecipanti         type table of zbd00_academy23,
        lt_ids                  type zbd00_academy23-id_partecipante.

 ls_control_parameters-langu = sy-langu.
 ls_control_parameters-no_dialog = ''.
 ls_control_parameters-preview   = 'X'. " togliere se si vuole vedere la popup
 ls_control_parameters-getotf    = 'X'.

  ls_output_options-tdprinter = l_devtype.
  ls_output_options-xdfcmode = 'X'.
  ls_output_options-xsfcmode = 'X'.

 formname = 'ZBD_ACADEMY_PARTECIPANTI'. "Senza spazi ovviamente
* select id_partecipante from zbd00_academy23 into table lt_ids.

 select-OPTIONS sel_ids for lt_ids.

 select * from zbd00_academy23 where id_partecipante in @sel_ids into table @lt_partecipanti.
 if sy-subrc <> 0.
    message a009(ZBD02_MESSAGGI).
 endif.
*-----------------------------------------------------------------------
* Get name of generated function module
*-----------------------------------------------------------------------
  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = formname
    IMPORTING
      fm_name            = lv_function_module_name
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.

  CALL FUNCTION 'SSF_GET_DEVICE_TYPE'
    EXPORTING
      i_language             = sy-langu
    IMPORTING
      e_devtype              = l_devtype
    EXCEPTIONS
      no_language            = 1
      language_not_installed = 2
      no_devtype_found       = 3
      system_error           = 4
      OTHERS                 = 5.

  CALL FUNCTION lv_function_module_name
    EXPORTING
*      *control_parameters = ls_control_parameters
*      *output_options     = ls_output_options
*      *** parametri di ingresso IN ORDINE
    IV_TITOLO = p_titolo
    IT_PARTECIPANTI = lt_partecipanti
    IMPORTING
      job_output_info    = ls_output_data
    EXCEPTIONS
      formatting_error   = 1
      internal_error     = 2
      send_error         = 3
      user_canceled      = 4
      OTHERS             = 5.

IF sy-subrc NE 0.
   message 'ERRORE' TYPE 'E'.
ENDIF.
