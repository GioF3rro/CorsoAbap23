*----------------------------------------------------------------------*
***INCLUDE ZBD04_NUMBER_GUESS_USER_COMI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK' OR '%EX' OR 'RW'.
      LEAVE PROGRAM.
    WHEN 'TRY'.
      IF lv_disp_num = secret_num.
        "hai vinto
        d_testo = 'Hai vinto'.
      ELSE.
        "no
      ENDIF.
  ENDCASE.

ENDMODULE.
