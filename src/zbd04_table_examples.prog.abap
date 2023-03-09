*&---------------------------------------------------------------------*
*& Report zbd04_table_examples
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_table_examples.

"struttura definita in un programma -> dictionary
DATA: BEGIN OF gs_voce_elenco,
        id      TYPE i,
        nome    TYPE string,
        cognome TYPE string,
        numero  TYPE string,
      END OF gs_voce_elenco.

DATA: gs_voce2 LIKE gs_voce_elenco. "global structure

DATA: gt_rubrica LIKE TABLE OF gs_voce_elenco. "tabella globale facendo diferimento alla truttura

gs_voce_elenco-id = 1.
gs_voce_elenco-nome = 'Giovanni'.
gs_voce_elenco-cognome = 'Ferraro'.
gs_voce_elenco-numero = '(+39) 3248030681'.

"cl_demo_output=>display( gs_voce_elenco ).

APPEND gs_voce_elenco TO gt_rubrica.

gs_voce2-id = 2.
gs_voce2-nome = 'Anna'.
gs_voce2-cognome = 'Osimen'.
gs_voce2-numero = '(+39) 3248030681'.

APPEND gs_voce2 TO gt_rubrica.


gs_voce2-id = 3.
gs_voce2-nome = 'Martina'.
gs_voce2-cognome = 'Ferraro'.
gs_voce2-numero = '(+39) 3248030681'.

APPEND gs_voce2 TO gt_rubrica.


gs_voce2-id = 4.
gs_voce2-nome = 'Eros'.
gs_voce2-cognome = 'Ferraro'.
gs_voce2-numero = '(+39) 3248030681'.

APPEND gs_voce2 TO gt_rubrica.

gs_voce2-id = 5.
gs_voce2-nome = 'Angelo'.
gs_voce2-cognome = 'Ferraro'.
gs_voce2-numero = '(+39) 3248030681'.

APPEND gs_voce2 TO gt_rubrica.

gs_voce2-id = 6.
gs_voce2-nome = 'obama'.
gs_voce2-cognome = 'Ferraro'.
gs_voce2-numero = '(+39) 3248030681'.

APPEND gs_voce2 TO gt_rubrica.

"aggiunta riga senza creare una variabile
append VALUE #( id = 1
                    nome = 'roberta'
                    cognome = 'rossi'
                    numero = '1234435254673' ) to gt_rubrica.

cl_demo_output=>write( gt_rubrica ).

*"leggo una riga della tabella modo vecchio
*READ TABLE gt_rubrica INDEX 2 INTO gs_voce_elenco.
*IF sy-subrc = 0.
*  cl_demo_output=>write( gs_voce_elenco ).
*ELSE.
*  cl_demo_output=>write( 'risultato non trovato' ).
*ENDIF.
*
*cl_demo_output=>write( gs_voce_elenco ).
*
*"legog una riga della tabella modo nuovo
*cl_demo_output=>write( gt_rubrica[ 1 ] ).
*
*TRY.
*    cl_demo_output=>write( gt_rubrica[ 8 ] ).
*  CATCH cx_sy_itab_line_not_found INTO DATA(ex).
*    cl_demo_output=>write( 'gt_rubrica index minore rispetto al elemento selezionato' ).
*ENDTRY.


"calcellazione riga
DELETE gt_rubrica INDEX 2.
cl_demo_output=>write( 'delete gt_rubrica index 2' ).

cl_demo_output=>write( gt_rubrica ).

"inserimento riga in un indice e sposta di uno tutti quelli dopo
INSERT gs_voce2 INTO gt_rubrica INDEX 2.
cl_demo_output=>write( gt_rubrica ).
cl_demo_output=>write( 'inserimento riga al index 2' ).
cl_demo_output=>write( gt_rubrica ).

"ordinamento per il primo campo crescente
SORT gt_rubrica.
cl_demo_output=>write( 'ordinamento crescente in base al id' ).
cl_demo_output=>write( gt_rubrica ).

"ordinamento per ordine alfabetico per cognome decrescente
SORT gt_rubrica BY cognome DESCENDING.
cl_demo_output=>write( 'ordinnamento decrescente tramite cognome' ).
cl_demo_output=>write( gt_rubrica ).

**************************************************
** accessi con chiave
** leggo in modo vecchio
cl_demo_output=>begin_section( 'accessi con chiave' ).

READ TABLE gt_rubrica WITH KEY  nome = 'Paola' INTO gs_voce_elenco.
IF sy-subrc = 0.
  cl_demo_output=>write( gs_voce_elenco-cognome ).
ELSE.
  cl_demo_output=>write( 'risultato nome = Paola non trovsto' ).
ENDIF.

TRY.
    cl_demo_output=>write( ' cognome della riga con nome Giovanni -> ' && gt_rubrica[ nome = 'Giovanni' ]-cognome ).
  CATCH cx_sy_itab_line_not_found INTO DATA(ex1).
    cl_demo_output=>write( 'gs_voce_elenco: risultato non trovato con riga nome = Giovani' ).
ENDTRY.

**loop con condizione
LOOP AT gt_rubrica INTO gs_voce2 WHERE id > 3 AND cognome = 'Osimen'.
  cl_demo_output=>write( 'riga con id maggiore di 3 e cognome = Osimen' ).
  cl_demo_output=>write( gs_voce2 ).
ENDLOOP.



cl_demo_output=>display(  ).
