*&---------------------------------------------------------------------*
*& Report zbd04_classe_conto
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_classe_conto.

PARAMETERS: p_saldo TYPE p LENGTH 16 DECIMALS 2.
PARAMETERS: p_operaz TYPE p LENGTH 16 DECIMALS 2.

PARAMETERS: p_prel RADIOBUTTON GROUP rad DEFAULT 'X',
            p_dep  RADIOBUTTON GROUP rad.

START-OF-SELECTION.

  DATA(paolo) = zbd04_singleton_banck_account=>get_instance( ).
  DATA: mario TYPE REF TO zbd04_back_account.
  CREATE OBJECT mario
    EXPORTING
      I_saldo = p_saldo.

  IF p_dep = 'X'.
*
*    CALL METHOD mario->deposito
*      EXPORTING
*        i_deposito = p_operaz.

    DATA(deposito) = mario->deposito( p_operaz ).

    WRITE: / 'DEPOSITO DI € ', p_operaz ,' EFFETTUATO PER MARIO'.
    WRITE: / 'SALDO ATTUALE -> ', deposito.

    SKIP.
*
*    CALL METHOD paolo->deposito
*      EXPORTING
*        i_deposito = p_operaz.

    deposito = paolo->deposito( p_operaz ).

    WRITE: / 'DEPOSITO DI € ', p_operaz ,' EFFETTUATO PER PAOLO'.
    WRITE: / 'SALDO ATTUALE -> ', deposito.

    SKIP.

  ELSE.

*  CALL METHOD mario->prelievo
*    EXPORTING
*      i_prelievo = p_operaz.

    DATA(prelievo) = mario->prelievo( p_operaz ).

    IF prelievo < 0.
      WRITE: / 'PRELIEVO MAGGIORE DEL SALDO DISPONIBILE PER PAOLO'.
      WRITE: / 'PRELIEVO DI € ', p_operaz ,' NON EFFETTUATO'.
      WRITE: / 'SALDO ATTUALE -> ', mario->get_saldo( ).
    ELSE.
      WRITE: / 'PRELIEVO DI € ', p_operaz ,' EFFETTUATO PER PAOLO'.
      WRITE: / 'SALDO ATTUALE -> ', prelievo.

    ENDIF.

    SKIP.

    prelievo = paolo->prelievo( p_operaz ).

    IF prelievo < 0.
      WRITE: / 'PRELIEVO MAGGIORE DEL SALDO DISPONIBILE PER PAOLO'.
      WRITE: / 'PRELIEVO DI € ', p_operaz ,' NON EFFETTUATO'.
      WRITE: / 'SALDO ATTUALE -> ', paolo->get_saldo( ).
    ELSE.
      WRITE: / 'PRELIEVO DI € ', p_operaz ,' EFFETTUATO PER PAOLO'.
      WRITE: / 'SALDO ATTUALE -> ', prelievo.

    ENDIF.

    SKIP.

  ENDIF.
