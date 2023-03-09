*&---------------------------------------------------------------------*
*& Report ZBD04_CALCOLATRICE_ICON
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_calcolatrice_icon.

DATA: numero TYPE char40.

CALL   SCREEN 200.

INITIALIZATION.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  DATA: num1     TYPE int4.
  DATA: num2     TYPE int4.
  DATA: operazione     TYPE char1.
  DATA: risultato     TYPE int4.
  DATA: pulisci     TYPE int4.
  data: mode(4) type n value '0210'.

  CASE sy-ucomm.
    WHEN 'BACK' OR '%EX' OR 'RW'.
      LEAVE PROGRAM.
    WHEN '+' OR '-' OR '*' OR '/' or '%' or '^'.
      IF operazione = ''.
        num1 = numero.
        numero = ''.
        operazione = sy-ucomm.
        pulisci += 1 .
      ENDIF.

    WHEN '=' .
      IF num1 <> 0.
        num2 = numero.
        CASE operazione.
          WHEN '+'.
            risultato = num2  + num1.
          WHEN '-'.
            risultato =  num1 - num2  .
          WHEN '*'.
            risultato = num2  * num1.
          WHEN '/'.
            risultato =  num1 / num2  .
         WHEN '%'.
            risultato =  num1 / 100  .
            risultato =  risultato * num2  .
         WHEN '^'.
            risultato =  num1 ** num2  .
        ENDCASE.

        numero = '' && risultato.
        operazione = ''.
        num1 = 0.
        num2 = 0.
        pulisci = 0.
      ELSE.
        numero = '' .
      ENDIF.
      num1 = 0.

    when 'SC'.
      "bla

    WHEN OTHERS.
      IF pulisci <> 0.
        numero = numero && sy-ucomm.
        risultato = 0.
      ELSE.
        numero = '' && sy-ucomm.
      ENDIF.
      pulisci += 1.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0210  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0210 INPUT.

ENDMODULE.
