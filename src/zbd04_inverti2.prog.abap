*&---------------------------------------------------------------------*
*& Report zbd04_inverti2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_inverti2.

PARAMETERS: p_testo TYPE string LOWER CASE DEFAULT 'hulk spacca il mondo'.

DATA: output    LIKE p_testo, "assegnare lo stesso tipo di variabile facendo riferimento ad un'altra variabile
      gt_parole TYPE TABLE OF string.

"struttura definita in un programma
DATA: BEGIN OF voce_elenco,
        nujmero   TYPE i,
        descrione TYPE string,
      END OF voce_elenco.

DATA(lunghezza) = strlen( p_testo ). " lunghezza stringa

WRITE: |stringa: { p_testo }|.
WRITE: |lunghezza stringa: { lunghezza }|.

DATA(lettera) = p_testo+10(1).  "lettera in posizione 10 con lunghezza 1

WRITE: / |lettera in posizione 10 ->  { lettera }|.

ULINE.

output = ''.
WRITE: / |parola in ordine: |.
DO lunghezza TIMES.
  DATA(indice) = sy-index - 1 ."calcolo indice partendo dalla prima lettera
  DATA(lettera2) = p_testo+indice(1). "prendo lettera
  WRITE: / | { lettera2 } |. "stampo lettera
  CONCATENATE output lettera2 INTO output SEPARATED BY space. "concatenazione stringa
ENDDO.

SKIP.

WRITE: / |stringa in ordine -> { output }|.

ULINE.

output = ''.
WRITE: / |parola in ordine contrario:|.
DO lunghezza TIMES.
  DATA(indice2) = lunghezza - sy-index . "calcolo indice artendo dall'ultima lettera
  DATA(lettera3) = p_testo+indice2(1). "prende lettera
  WRITE: / | { lettera3 } |.  "stampo lettera

  CONCATENATE output lettera3 INTO output SEPARATED BY space. "concatenazione stringa
  "output = lettera3 && output "equivalente alla riga sopra
ENDDO.

SKIP.

WRITE: / |stringa al contrario ->  { output }|.

ULINE.

output = ''.
WRITE: / |parola in ordine con coppia d lettere: |.
DO ( lunghezza - 1 ) TIMES. "tolgo uno se no mi da errore sulla prima coppia di lettere
  DATA(indice3) = sy-index - 1 ."calcolo indice partendo dalla prima lettera
  DATA(lettera4) = p_testo+indice3(2). "prendo 2 lettere
  WRITE: / | { lettera4 } |. "stampo lettera
  CONCATENATE output lettera4 INTO output SEPARATED BY space. "concatenazione stringa
ENDDO.

SKIP.

WRITE: / |stringa con coppie di lettere ->  { output }|.

ULINE.

output = ''.
WRITE: |inversione parole ma non frase: { p_testo }|.
SPLIT p_testo AT ' ' INTO TABLE gt_parole.

SKIP.

"ciclo per gli array
LOOP AT gt_parole INTO DATA(lv_parola).
  WRITE: / |parola prima di essere convertita -> { lv_parola }|.
  PERFORM inverti CHANGING lv_parola. "chiamata alla funzione con passaggio la cella dell'array
  WRITE: / |parola dopo essere convertita -> { lv_parola }|.
  CONCATENATE output lv_parola INTO output SEPARATED BY space. "concatenazione delle stringhe invertite
ENDLOOP.

SKIP.

WRITE: |inversione parole nella frase -> { output }|.

ULINE.

output = ''.
WRITE: |inversione parole ma non frase senza parola "spacca" e termina frase se contiene "vegeta": { p_testo }|.
SPLIT p_testo AT ' ' INTO TABLE gt_parole.

SKIP.

"ciclo per gli array
LOOP AT gt_parole INTO DATA(lv_parola2).
  WRITE: / |parola prima di essere convertita -> { lv_parola2 }|.

  IF lv_parola2 = 'spacca'.
    CONTINUE.
  ENDIF.

  IF lv_parola2 = 'vegeta'.
    EXIT.
  ENDIF.

  PERFORM inverti CHANGING lv_parola2. "chiamata alla funzione con passaggio la cella dell'array
  WRITE: / |parola dopo essere convertita -> { lv_parola2 }|.
  CONCATENATE output lv_parola2 INTO output SEPARATED BY space. "concatenazione delle stringhe invertite

ENDLOOP.

SKIP.

WRITE: |inversione parole nella frase -> { output }|.




FORM inverti CHANGING p_testo TYPE string.
  DATA output TYPE string.
  DATA(lunghezza) = strlen( p_testo ).
  DATA(indice) = 0.
  DATA(lettera) = ''.

  DO lunghezza TIMES.
    indice = lunghezza - sy-index.
    lettera = p_testo+indice(1).
    output = output && lettera.
*    CONCATENATE output lettera INTO output.
  ENDDO.
  "WRITE: |{ output }|.
  p_testo = output.
ENDFORM.
