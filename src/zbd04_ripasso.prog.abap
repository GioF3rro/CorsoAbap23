*&---------------------------------------------------------------------*
*& Report zbd04_ripasso
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_ripasso.

DATA: lv_intero TYPE i.

DATA: lv_intero2 LIKE lv_intero.

DATA: BEGIN OF ls_contatto,
        nome     TYPE char20,
        cognome  TYPE char20,
        citta    TYPE char30,
        telefono TYPE char20,
        civico   TYPE i,
      END OF ls_contatto.

"creazione di un tipo -> un modello di dato, ma non è allocato in memoria e non posso usarlo direttamento per assegnare valori
TYPES: BEGIN OF ty_contatto,
         nome     TYPE char20,
         cognome  TYPE char20,
         citta    TYPE char30,
         telefono TYPE char12,
         civico   TYPE i,
       END OF ty_contatto.



DATA: lt_contatti LIKE TABLE OF ls_contatto.

DATA ls_contatto4 TYPE ty_contatto.

perform carica_dati_esempio.
PERFORM visualizza_alv.



form visualizza_alv.
cl_salv_table=>factory(
      IMPORTING
      r_salv_table = DATA(lo_alv)
      CHANGING
      t_table = lt_contatti ).
      lo_alv->get_functions( )->set_all( ).
      lo_alv->display( ).
ENDFORM.


FORM  carica_dati_esempio.

DATA: ls_contatto2 TYPE zbdgc_contatto. " è equivalente  quella sopra

ls_contatto2 = VALUE #( nome = 'giovanni'
                        cognome = 'ferraro'
                        citta = 'bassano'
                        telno = '123445667' ).
APPEND ls_contatto2 TO lt_contatti.

ENDFORM.
