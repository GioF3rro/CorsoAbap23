CLASS zbd04_zcl_cliente_privilegiato DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zbd04_zif_cliente_blocca.
    METHODS: constructor IMPORTING i_credito TYPE i,
      get_credito RETURNING VALUE(rv_credito) TYPE BETRG,
      get_credito_prec RETURNING VALUE(rv_credito) TYPE BETRG.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: codice             TYPE kunnr,
          credito            TYPE BETRG,
          credito_precedente TYPE BETRG.
ENDCLASS.

CLASS zbd04_zcl_cliente_privilegiato IMPLEMENTATION.

  METHOD zbd04_zif_cliente_blocca~blocca. "metodo blocca dell'interfaccia
    credito_precedente = credito.
    credito = 0.

    DATA: row TYPE zbdgc_clienti.
    row-kunnr = codice.
    row-importo_credito = credito.
    row-valuta = 'EUR'.
    row-vip = 'X'.
    row-bloccato = 'X'.

    MODIFY zbdgc_clienti FROM @row.

  ENDMETHOD.

  METHOD zbd04_zif_cliente_blocca~sblocca. "metodo sblocca dell'interfaccia
    credito = credito_precedente.
    credito_precedente = 0.

    DATA: row TYPE zbdgc_clienti.
    row-kunnr = codice.
    row-importo_credito = credito.
    row-valuta = 'EUR'.
    row-vip = 'X'.
    row-bloccato = ''.

    MODIFY zbdgc_clienti FROM @row.
  ENDMETHOD.

  METHOD zbd04_zif_cliente_blocca~get_cod. "get codice dell'interfaccia
    rv_cod = codice.
  ENDMETHOD.

  METHOD constructor. "costruttore
    credito = i_credito.
    credito_precedente = 0.
    codice = '1000011111'.

    DATA: row TYPE zbdgc_clienti.
    row-kunnr = codice.
    row-importo_credito = credito.
    row-valuta = 'EUR'.
    row-bloccato = ''.
    row-vip = 'X'.

    MODIFY zbdgc_clienti FROM @row.

  ENDMETHOD.

  METHOD get_credito. "get credito
    rv_credito = credito.
  ENDMETHOD.

  METHOD get_credito_prec. "get credito precedente
    rv_credito = credito_precedente.
  ENDMETHOD.

ENDCLASS.
