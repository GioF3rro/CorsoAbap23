*&---------------------------------------------------------------------*
*& Report zbd04_voli
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_voli.

PARAMETERS: p_from TYPE spfli-cityfrom DEFAULT 'Rome',
            p_to   TYPE spfli-cityto DEFAULT 'New York'.
*
*DATA: lt_scarr  TYPE TABLE OF scarr,
*      ls_scarr2 LIKE LINE OF lt_scarr.
*
*DATA: lt_spfli  TYPE TABLE OF spfli,
*      ls_spfli2 LIKE LINE OF lt_spfli.

"SELECT-OPTIONS s_scarr FOR ls_scarr2-carrid.

"SELECT * FROM scarr WHERE carrid IN @s_scarr INTO TABLE @lt_scarr.

START-OF-SELECTION.

*SELECT * FROM spfli WHERE cityfrom = @p_from AND cityto = @p_to INTO TABLE @lt_spfli.
*
*LOOP AT lt_spfli INTO DATA(t_percorso).
*
*        data(ora1) = t_percorso-arrtime+0(2).
*        data(ora2) = t_percorso-deptime+0(2).
*
*        data(minuti1) = t_percorso-arrtime+2(2).
*        data(minuti2) = t_percorso-deptime+2(2).
*
*        data(ore) = ora1 - ora2 .
*        data(minuti) = minuti1 - minuti2 .
*        write: / |compagnia aerea: { t_percorso-CARRID }|.
*        write: / |orario partenza: { t_percorso-deptime }|.
*        write: / |orario arrivo: { t_percorso-arrtime }|.
*        write: / |durata volo: { ore } ore e { minuti } minuti|.
*    ENDLOOP.

  DATA(found) = abap_false.
  DATA: t_nodes TYPE TABLE OF spfli-cityto.

  APPEND p_from TO t_nodes.

  WHILE NOT found = abap_true.

*    SELECT cityto FROM spfli
*    FOR ALL ENTRIES IN @t_nodes
*    WHERE cityfrom = @t_nodes-table_line
*    APPENDING TABLE @t_nodes
*    .

    DATA: lt_spfli TYPE TABLE OF spfli.
    DATA(esiste) = abap_false.

    SELECT * FROM spfli
                   INTO @DATA(ls_spfli)
                     FOR ALL ENTRIES IN @t_nodes
                     WHERE cityfrom = @t_nodes-table_line.

*      esiste = abap_false.
*      LOOP AT lt_spfli INTO DATA(ls_nodi).
*
*        IF ls_spfli-cityto = ls_nodi-cityfrom.
*          esiste = abap_true.
*          EXIT.
*        ENDIF.
*
*      ENDLOOP.
*
*      IF ls_spfli-cityto <> p_from AND esiste = abap_false.
*
*        APPEND ls_spfli-cityto TO t_nodes.
*        APPEND ls_spfli TO lt_spfli.
*        continue.
*
*      ENDIF.
*
*      DELETE ADJACENT DUPLICATES FROM lt_spfli.

    ENDSELECT.

    READ TABLE t_nodes WITH KEY table_line = p_to TRANSPORTING NO FIELDS." evito di portarmi dietro
    IF sy-subrc = 0.
      found = abap_true.
      EXIT.
    ENDIF.

  ENDWHILE.


  SORT t_nodes.
  DELETE ADJACENT DUPLICATES FROM t_nodes.


  cl_demo_output=>display( lt_spfli ).
  cl_demo_output=>display( t_nodes ).
