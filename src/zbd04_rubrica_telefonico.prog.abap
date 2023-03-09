*&---------------------------------------------------------------------*
*& Report zbd04_rubrica_telefonico
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_rubrica_telefonico.

"struttura definita in un programma -> dictionary
DATA: BEGIN OF voce_elenco,
        id      TYPE i,
        nome    TYPE string,
        cognome TYPE string,
        numero  TYPE string,
      END OF voce_elenco.

DATA: voce_2 LIKE voce_elenco. "struttura con caratteristiche di voce_elenco

DATA: elenco LIKE TABLE OF voce_elenco. "tabella facendo diferimento alla truttura

voce_elenco-id = 1.
voce_elenco-nome = 'Giovanni'.
voce_elenco-cognome = 'Ferraro'.
voce_elenco-numero = '(+39) 3248030681'.

WRITE: voce_elenco-id, voce_elenco-nome, voce_elenco-cognome , voce_elenco-numero.
append voce_elenco to elenco.

voce_2-id = 1.
voce_2-nome = 'Gio'.
voce_2-cognome = 'Ferro'.
voce_2-numero = '(+39) 3248030681'.

WRITE: voce_2-id, voce_2-nome, voce_2-cognome , voce_2-numero.
append voce_2 to elenco.
