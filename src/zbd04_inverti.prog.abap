*&---------------------------------------------------------------------*
*& Report zbd04_inverti
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_inverti.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  "parametri input
  PARAMETERS: testo TYPE string LOWER CASE OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

DATA: lt_parole TYPE TABLE OF string, "tabelle -> array
      testo2    TYPE string.

SPLIT testo AT '' INTO TABLE lt_parole. "split di una frase in base agli spazi

*DATA: v_lung  TYPE i,
*      lettera TYPE string,
*      v_inv   TYPE string.
*
*v_lung = strlen( testo ).
*WRITE: |Hai inserito la parola { testo } di lunghezza { v_lung }|.
*
*SKIP.
*
*DO v_lung TIMES.
*  DATA(posizione) = v_lung - sy-index.
*  lettera = testo+posizione(1).
*  v_inv =  v_inv &&  lettera .
*ENDDO.

"ciclo per gli array
LOOP AT lt_parole INTO DATA(lv_parola).
  PERFORM inverti_parola CHANGING lv_parola. "chiamata alla funzione con passaggio la cella dell'array
  CONCATENATE testo2 lv_parola INTO testo2 SEPARATED BY space. "concatenazione delle stringhe invertite
ENDLOOP.

ULINE.
WRITE: |il testo invertito è: { testo2 }|.

"metodo ch inverte le parole
FORM inverti_parola CHANGING parola TYPE string.

  DATA: v_lung  TYPE i,
        lettera TYPE string,
        v_inv   TYPE string.

  v_lung = strlen( parola )."lunghezza stringa
  "WRITE: |Hai inserito la parola { testo } di lunghezza { v_lung }|.

  SKIP.

  DO v_lung TIMES.
    DATA(posizione) = v_lung - sy-index.
    lettera = parola+posizione(1).
    v_inv =  v_inv &&  lettera .
  ENDDO.

  parola = v_inv.

ENDFORM.
