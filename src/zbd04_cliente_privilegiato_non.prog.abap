*&---------------------------------------------------------------------*
*& Report zbd04_cliente_privilegiato_non
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_cliente_privilegiato_non.

""""""""""""""""""""""codice classi Gianluca""""""""""""""""""""""""
PARAMETERS:
  p_disp   RADIOBUTTON GROUP rad,
  p_blocca RADIOBUTTON GROUP rad,
  p_sblocc RADIOBUTTON GROUP rad.

*PARAMETERS p_kunnr TYPE kna1-kunnr.

DATA: ls_zbdgc_clienti TYPE zbdgc_clienti.
SELECT-OPTIONS: so_kunnr FOR ls_zbdgc_clienti-kunnr.

START-OF-SELECTION.

  CASE 'X'.
    WHEN p_disp.
      WRITE: |VISUALIZZAZIONE CLIENTI| .

    WHEN p_blocca.
      WRITE: |BLOCCO CLIENTI| .

    WHEN p_sblocc.
      WRITE: |SBLOCCO CLIENTI| .

  ENDCASE.
  ULINE.

  "select tutte le righe
*      SELECT kunnr FROM zbdgc_clienti INTO TABLE @DATA(lT_kunnr).

  "select con componenti della select option
  SELECT kunnr FROM zbdgc_clienti INTO TABLE @DATA(lt_kunnr)
  WHERE kunnr IN @so_kunnr.

  "controllo se sono presenti componenti
  IF lines( lt_kunnr ) = 0.
    WRITE: |Non sono presenti righe con questo codice| .
  ELSE.
    LOOP AT lt_kunnr INTO DATA(ls_kunnr).
      DATA(lo_cliente) = zcl_bdgc_cliente_abs=>factory( lS_kunnr-kunnr ).

      CASE 'X'.
        WHEN p_disp.
          lo_cliente->display(  ). "Chiaining

        WHEN p_blocca.
          lo_cliente->blocca(  ).
          lo_cliente->save(  ).
          SKIP.

        WHEN p_sblocc.
          lo_cliente->sblocca(  ).
          lo_cliente->save(  ).
          SKIP.

      ENDCASE.

    ENDLOOP.
  ENDIF.

  """"""""""""""""""""""codice classi Giovanni""""""""""""""""""""""""

*PARAMETERS: p_cred_p TYPE betrg,
*            p_cred_n TYPE betrg.
*
*DATA: cliente_p   TYPE REF TO zbd04_zcl_cliente_privilegiato,
*      cliente_n   TYPE REF TO zbd04_zcl_cliente_normale,
*      valutazione TYPE REF TO zbd04_zcl_valuta_cliente.
*
*"creazione oggetti
*CREATE OBJECT cliente_p
*  EXPORTING
*    i_credito = 400.
*
*CREATE OBJECT cliente_n
*  EXPORTING
*    i_credito = 200.
*
*
*"dati tabella iniziali
*SELECT * FROM zbdgc_clienti INTO TABLE @DATA(lt_clienti) .
*cl_demo_output=>display( lt_clienti ).
*
*"blocca utenti
*CREATE OBJECT valutazione.
*valutazione->valuta_clinete( cliente_p ).
*valutazione->valuta_clinete( cliente_n ).
*
*"stampa risultati bloccaggi
*SELECT * FROM zbdgc_clienti INTO TABLE @DATA(lt_clienti2) .
*cl_demo_output=>display( lt_clienti2 ).
*
*"sblocca
*valutazione->valuta_clinete( cliente_p ).
*valutazione->valuta_clinete( cliente_n ).
*
*"stampa risultati sbloccaggio
*SELECT * FROM zbdgc_clienti INTO TABLE @DATA(lt_clienti3) .
*cl_demo_output=>display( lt_clienti3 ).
