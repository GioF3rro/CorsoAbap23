*&---------------------------------------------------------------------*
*& Report zbd04_codice_fiscale
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_codice_fiscale.


PARAMETERS: p_cf TYPE string DEFAULT 'FRRGNN03B23A703K'.

PARAMETERS: man   RADIOBUTTON GROUP rad DEFAULT 'X',
            woman RADIOBUTTON GROUP rad.

START-OF-SELECTION.
  DATA: controllo TYPE INT1,
        sesso     TYPE c LENGTH 1.

  IF man = 'X'.
    sesso = 'M'.
  ELSE.
    sesso = 'W'.
  ENDIF.

  "PERFORM controllo USING p_cf CHANGING controllo sesso.

  CALL FUNCTION 'ZBD04_CONTROLLO_DF'
      EXPORTING
        IV_CF = p_cf
        iv_sesso = sesso
      IMPORTING
        ev_ERRORE  = controllo.

  IF controllo = 0.
    WRITE: / |codice fiscale inserito correttamente|.
  ELSEIF controllo = 1.
    WRITE: / |errore numero caratteri diverso da 16|.
  ELSEif controllo = 2.
    WRITE: |errore inserimento valori in posizioni errate|.
  elseIF CONTROLLO = 3.
    WRITE: |errore inserimento codice fiscale dell'altro sesso|.
    ELSE.
    WRITE: |BUON COMPLEANNO|.
  ENDIF.

FORM controllo USING codice CHANGING controllo TYPE i sesso TYPE i.

      DATA: oref   TYPE REF TO cx_root.

      DATA: cognome TYPE string,
            nome    TYPE string,
            anno    TYPE i,
            citta   TYPE string,
            giorno  TYPE i,
            lettera TYPE c LENGTH 1,
            numeri  TYPE i,
            finale  TYPE c LENGTH 1.

      "controllo se ci sono lettere dove dovrebbero andare numeri
      TRY.
          cognome = codice+0(3).
          nome = codice+3(3).
          anno = codice+6(2).
          citta = codice+8(1).
          giorno = codice+9(2).
          lettera = codice+11(1).
          numeri = codice+12(3).
          finale = codice+15(1).
        CATCH cx_root INTO oref.
          controllo = 1.
          EXIT.
      ENDTRY.

      IF NOT ( cognome CO sy-abcde ).
        controllo = 1.
      ELSEIF NOT nome CO sy-abcde.
        controllo = 1.
      ELSEIF NOT citta CO sy-abcde.
        controllo = 1.
      ELSEIF NOT lettera CO sy-abcde.
        controllo = 1.
      ELSEIF NOT finale CO sy-abcde.
        controllo = 1.
      ENDIF.

  IF controllo = 0.
    IF giorno > 30 AND sesso = 1.
      controllo = 2.
    ENDIF.
  ENDIF.

ENDFORM.
