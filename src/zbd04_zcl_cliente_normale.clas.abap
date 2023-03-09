CLASS zbd04_zcl_cliente_normale DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zbd04_zif_cliente_blocca.
    METHODS: constructor IMPORTING i_credito TYPE i,
      get_credito RETURNING VALUE(rv_credito) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: credito TYPE BETRG,
          codice  TYPE kunnr.

ENDCLASS.

CLASS zbd04_zcl_cliente_normale IMPLEMENTATION.

  METHOD zbd04_zif_cliente_blocca~blocca. "scrittura metodo blocca dell'interfaccia
    credito = 0.

    DATA: row TYPE zbdgc_clienti.
    row-kunnr = codice.
    row-importo_credito = credito.
    row-valuta = 'EUR'.
    row-vip = ''.
    row-bloccato = 'X'.

    "modifica riga per bloccarlo
    MODIFY zbdgc_clienti FROM @row.

  ENDMETHOD.

  METHOD zbd04_zif_cliente_blocca~sblocca."scrittura metodo sblocca dell'interfaccia
    credito = credito.

    DATA: row TYPE zbdgc_clienti.
    row-kunnr = codice.
    row-importo_credito = credito.
    row-valuta = 'EUR'.
    row-vip = ''.
    row-bloccato = ''.

    "modifica riga per sbloccarlo
    MODIFY zbdgc_clienti FROM @row.
  ENDMETHOD.

  METHOD zbd04_zif_cliente_blocca~get_cod. "get codice
    rv_cod = codice.
  ENDMETHOD.

  METHOD constructor. "costruttore
   credito = i_credito.
   codice = '1000011112'.

   DATA: row TYPE zbdgc_clienti.
   row-kunnr = codice.
   row-importo_credito = credito.
   row-valuta = 'EUR'.
   row-bloccato = ''.
   row-vip = ''.

   MODIFY zbdgc_clienti FROM @row.

  ENDMETHOD.

  METHOD get_credito. "get credito
    rv_credito = credito.
  ENDMETHOD.

ENDCLASS.
