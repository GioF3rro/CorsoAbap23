CLASS zbd04_zcl_valuta_cliente DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: valuta_clinete IMPORTING i_cliete TYPE REF TO zbd04_zif_cliente_blocca.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zbd04_zcl_valuta_cliente IMPLEMENTATION.

  METHOD valuta_clinete.

    DATA(id) = i_cliete->get_cod(  ).

    SELECT * FROM zbdgc_clienti
    WHERE kunnr = @id
    INTO @DATA(cliente).
    ENDSELECT.

    IF NOT cliente IS INITIAL.
        IF cliente-bloccato = ''. "non bloccato
            i_cliete->blocca( ).
        ELSE."bloccato
            i_cliete->sblocca( ).
        ENDIF.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
