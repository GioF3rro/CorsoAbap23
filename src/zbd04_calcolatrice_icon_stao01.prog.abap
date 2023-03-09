*----------------------------------------------------------------------*
***INCLUDE ZBD04_CALCOLATRICE_ICON_STAO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  DATA: num1     TYPE int4.
  DATA: operazione     TYPE char1.
  DATA: risultato     TYPE int4.

  CASE sy-ucomm.
    WHEN 'BACK' OR '%EX' OR 'RW'.
      LEAVE PROGRAM.
    WHEN '+' OR '-' OR '*' OR '/'.
      num1 = numero.
      numero = 0.
      operazione = sy-ucomm.

    WHEN '=' .
      IF num1 <> 0.
        CASE operazione.
          WHEN '+'.
            risultato = numero + num1.
          WHEN '-'.
            risultato =  num1 - numero .
          WHEN '*'.
            risultato = numero * num1.
          WHEN '/'.
            risultato =  num1 / numero .
        ENDCASE.

        numero = risultato.
      ELSE.
        numero = 0.
      ENDIF.
      num1 = 0.
    WHEN OTHERS.
      numero = numero * 10 + sy-ucomm.
      risultato = 0.
  ENDCASE.
ENDMODULE.
