*&---------------------------------------------------------------------*
*& Report zbd04_voli_final
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_voli_final.

PARAMETERS: p_from TYPE spfli-cityfrom DEFAULT 'Rome',
            p_to   TYPE spfli-cityto DEFAULT 'New York'.

START-OF-SELECTION.

***********    voli diretti    ****************
  "select con partenza dati di iserimento
  SELECT * FROM spfli
  WHERE cityfrom = @p_from AND cityto = @p_to
  INTO TABLE @DATA(lt_diretti).
  "cl_demo_output=>display( lt_spfli ).

  WRITE: / 'voli diretti: '.
  IF lines( lt_diretti ) > 0.
    LOOP AT lt_diretti INTO DATA(ls_diretto).
      WRITE: / |{ ls_diretto-cityfrom } - { ls_diretto-cityto }|.
    ENDLOOP.
  ELSE.
    WRITE: |non ci sono voli diretti da --{ p_from }-- verso --{ p_to }-- |.
  ENDIF.

  ULINE.

***********    voli uno scalo    ****************
  "select righe con partenza p_from e inserisco nella tabella
  SELECT * FROM spfli
  WHERE cityfrom = @p_from
  INTO TABLE @DATA(lt_voli_daroma).

  "loop per le righe con voli partenza p_from
  LOOP AT lt_voli_daroma INTO DATA(lt_volodaroma).

    "select con destinazione p_to e partenza righe della tabella
    SELECT * FROM spfli
    WHERE cityfrom = @lt_volodaroma-cityto AND cityto = @p_to
    INTO TABLE @DATA(lt_voli1scalo).

    "stampa voli con 1 scalo
    WRITE: / 'voli 1 scalo: '.
    IF lines( lt_voli1scalo ) > 0.
      LOOP AT lt_voli1scalo INTO DATA(ls_volo1scalo).
        WRITE: / p_from, ' - ', ls_volo1scalo-cityfrom, ' - ', ls_volo1scalo-cityto.
      ENDLOOP.
    ELSE.
      WRITE: |non ci sono voli con 1 scalo passante per --{ lt_volodaroma-cityto }-- verso --{ p_to }--|.
    ENDIF.

  ENDLOOP.


  ULINE.

  DATA: t_paesi TYPE TABLE OF spfli-cityfrom.
***********    voli n scali    ****************

  APPEND p_from TO t_paesi.

  DATA(controllo) = abap_false.

  WHILE NOT controllo = abap_true.
    SELECT * FROM spfli
    INTO TABLE @DATA(ls_spfli)
                       FOR ALL ENTRIES IN @t_paesi
                       WHERE cityfrom = @t_paesi-table_line.
    "ENDSELECT.
    DATA(esiste) = abap_false.
    LOOP AT ls_spfli INTO DATA(ls_voli).
      esiste = abap_false.
      LOOP AT t_paesi INTO DATA(t_paese).
        IF t_paese = ls_voli-cityfrom.
          esiste = abap_true.
        ENDIF.

      ENDLOOP.

      IF esiste = abap_false.

        APPEND ls_voli-cityto TO t_paesi.

      ENDIF.

      WRITE: / |{ ls_voli-cityfrom } - { ls_voli-cityto }|.

    ENDLOOP.

  ENDWHILE.



*  "riprendo tabella con partenza roma
*  "loop per le righe con voli partenza p_from
*  LOOP AT lt_voli_daroma INTO DATA(lt_volodaroma2).
*
*    "select con partenza righe della tabella
*    SELECT * FROM spfli
*    WHERE cityfrom = @lt_volodaroma2-cityto
*    INTO TABLE @DATA(lt_voliprimoscalo).
*
*    "stampa voli con 1 scalo
*    WRITE: / | voli { sy-index } scalo: |.
*    IF lines( lt_voliprimoscalo ) > 0.
*      LOOP AT lt_voliprimoscalo INTO DATA(ls_voloprimoscalo).
*        WRITE: / p_from, ' - ', ls_voloprimoscalo-cityfrom, ' - ', ls_voloprimoscalo-cityto.
*      ENDLOOP.
*    ELSE.
*      WRITE: |non ci sono voli con partenze da --{ lt_volodaroma2-cityto }--|.
*    ENDIF.
*
*  ENDLOOP.
