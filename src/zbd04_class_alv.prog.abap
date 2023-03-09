*&---------------------------------------------------------------------*
*& Report zbd04_class_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_class_alv.

DATA: ls_scarr TYPE scarr.

CLASS lcl_handle_events DEFINITION.
  PUBLIC SECTION.
    METHODS:
      on_user_command FOR EVENT added_function OF cl_salv_events
        IMPORTING e_salv_function,
      on_before_user_command FOR EVENT before_salv_function OF cl_salv_events
        IMPORTING e_salv_function,
      on_after_user_command FOR EVENT after_salv_function OF cl_salv_events
        IMPORTING e_salv_function.
ENDCLASS.

SELECT-OPTIONS s_scarr FOR ls_scarr-carrid.

START-OF-SELECTION.

  "select date
  SELECT * FROM scarr
  WHERE carrid IN @s_scarr
  INTO TABLE @DATA(lt_scarr).

  "creazione oggetto alv
  cl_salv_table=>factory( IMPORTING
  r_salv_table = DATA(lo_alv)
  CHANGING t_table = lt_scarr ).

  "attiva le funzioni standard
  lo_alv->set_screen_status(
      pfstatus      =  'SALV_STANDARD'
      report        =  sy-repid
      set_functions = lo_alv->c_functions_all ).
*  lo_alv->get_functions( )->set_all( ).

  TRY.
      lo_alv->get_functions( )->add_function( EXPORTING
      icon = 'ICON_OK'
      name = 'SELEZIONA'
      text = 'ICON_COMPLETE'
      tooltip = 'Visualizza righe selezionate'
      position = if_salv_c_function_position=>right_of_salv_functions
      ).
    CATCH cx_salv_existing cx_salv_wrong_call.
  ENDTRY.

  "nasconde la colonna mandante
  lo_alv->get_columns( )->get_column( 'MANDT' )->set_technical( 'X' ).

  "dopo una certa lunghezza il nome della colonna carrid cambia in cod_comp
  lo_alv->get_columns( )->get_column( 'CARRID' )->set_short_text( 'COD_COMP' ).


*... §5 object for handling the events of cl_salv_table
  data: lr_events type ref to lcl_handle_events.
  CREATE OBJECT lr_events.

  set HANDLER lr_events->on_user_command for  lo_alv->get_event( ).

  "mostra alv
  lo_alv->display( ).


*---------------------------------------------------------------------*
*       CLASS lcl_handle_events IMPLEMENTATION
*---------------------------------------------------------------------*
* §5.2 implement the events for handling the events of cl_salv_table
*---------------------------------------------------------------------*
CLASS lcl_handle_events IMPLEMENTATION.
  METHOD on_user_command.
    DATA: l_string TYPE string.
    CONCATENATE 'Hai cliccato sulla funzione: ' e_salv_function INTO l_string SEPARATED BY space.
    MESSAGE i000(0k) WITH l_string.
  ENDMETHOD.                    "on_user_command

  METHOD on_before_user_command.
*    perform show_function_info using e_salv_function text-i09.
  ENDMETHOD.                    "on_before_user_command

  METHOD on_after_user_command.
*    perform show_function_info using e_salv_function text-i10.
  ENDMETHOD.                    "on_after_user_command

ENDCLASS.                    "lcl_handle_events IMPLEMENTATION
