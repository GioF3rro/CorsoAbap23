*&---------------------------------------------------------------------*
*& Report zbd04_sator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_sator.


PARAMETERS: p_file TYPE ibipparms-path DEFAULT 'C:\Users\candidato.VM-WIN11\Desktop\280000_parole_italiane.txt'.

DATA: filename                TYPE string,
      t_dizionario            TYPE TABLE OF string,
      t_5lettere              TYPE TABLE OF string,
      t_parole_palindrome     TYPE TABLE OF string,
      t_parole_sensate        TYPE TABLE OF string,
      t_parole_sensate_dritte TYPE TABLE OF string.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'F4_FILENAME'
*  EXPORTING
*    program_name  = SYST-CPROG
*    dynpro_number = SYST-DYNNR
*    field_name    = space
    IMPORTING
      file_name = p_file.

START-OF-SELECTION.
* Carico il file in una tabella di stringhe
  filename = p_file.
  cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename                = filename
    CHANGING
      data_tab                = t_dizionario
  ).

  " cl_demo_output=>display( t_dizionario ).

*inserisco solo parole con lunghezza 5
  LOOP AT t_dizionario INTO DATA(t_parola).
    IF strlen( t_parola ) = 5.
      APPEND t_parola TO t_5lettere.
    ENDIF.
  ENDLOOP.

  "cl_demo_output=>display( t_5lettere ).

*parole palindrome
  DATA(len) = 5.
  DATA(len2) = len - 1.
  DATA(index) = 0.
  DATA(pal) = 0.

  LOOP AT t_5lettere INTO DATA(t_palindroma).

    len = 5.
    len2 = len - 1.
    index = 0.
    pal = 0.

    DO 5 TIMES.
      IF t_palindroma+index(1) = t_palindroma+len2(1).
        pal = 1.
      ELSE.
        pal = 0.
        EXIT.
      ENDIF.

      len2 = len2 - 1.
      index = index + 1.

    ENDDO.

* inserisco se è palindroma
    IF pal = 1.
      APPEND t_palindroma TO t_parole_palindrome.
    ENDIF.

  ENDLOOP.

  "controllo parole sensate
  DATA: output  TYPE string,
        lettera TYPE string.

  DATA(indice) = 0.
  LOOP AT t_5lettere INTO DATA(t_contrario).
    DO 5 TIMES.
      indice = 5 - sy-index.
      lettera = t_contrario+indice(1).
      IF sy-index = 1.
        output = lettera.
      ELSE.
        output = output && lettera.
      ENDIF.

    ENDDO.

    LOOP AT t_5lettere INTO DATA(t_dritto).
      IF output = t_dritto.
        APPEND output TO t_parole_sensate.
        APPEND t_dritto TO t_parole_sensate_dritte.
      ENDIF.
    ENDLOOP.

  ENDLOOP.

  " cl_demo_output=>display( t_parole_palindrome ).

*  DATA(contatore1) = 1.
*  LOOP AT t_parole_palindrome INTO DATA(prima).
*
*    DATA(contatore2) = 1.
*    LOOP AT t_parole_palindrome INTO DATA(seconda).
*
*      IF prima+contatore1(1) = seconda+contatore2(1).
*
*      ENDIF.
*
*    ENDLOOP.
*
*  ENDLOOP.
  DATA: opzioni_palindrome TYPE TABLE OF string,
        opzioni_contrario  TYPE TABLE OF string,
        opzioni_dritte     TYPE TABLE OF string,
        errore             TYPE i.

  LOOP AT t_parole_palindrome INTO DATA(centro).
    "cl_demo_output=>write( centro ).
    errore = 0.

    LOOP AT t_parole_sensate INTO DATA(parola).
      IF parola+2(1) = centro+0(1).
        "APPEND parola TO opzioni_contrario.

        IF parola+2(1) = centro+2(1).
          "APPEND parola TO opzioni_contrario.
        ELSE.
          errore += 1.
          EXIT.
        ENDIF.

      ELSE.
        errore += 1.
        EXIT.
      ENDIF.
    ENDLOOP.

    LOOP AT t_parole_sensate_dritte INTO DATA(dritta).
      IF dritta+2(1) = centro+4(1) AND errore = 0.
        APPEND dritta TO opzioni_contrario.
      ELSE.
        errore += 1.
        EXIT.
      ENDIF.
    ENDLOOP.

  ENDLOOP.

  cl_demo_output=>write( opzioni_palindrome ).
  cl_demo_output=>write( opzioni_contrario ).
  cl_demo_output=>write( opzioni_dritte ).

  cl_demo_output=>display( ).

FORM assegnazione CHANGING tabella.



ENDFORM.
