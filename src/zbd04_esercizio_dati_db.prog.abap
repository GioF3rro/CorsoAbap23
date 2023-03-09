*&---------------------------------------------------------------------*
*& Report zbd04_esercizio_dati_db
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_esercizio_dati_db.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_id TYPE zbd04_academy23-id_partecipante OBLIGATORY DEFAULT 'BD01'.

SELECTION-SCREEN END OF BLOCK b1.

DATA: gs_select LIKE TABLE OF zbd00_academy23.
DATA: gs_select_venezia LIKE TABLE OF zbd00_academy23.
DATA: gs_select_roma LIKE TABLE OF zbd00_academy23.
DATA: gs_select_milano LIKE TABLE OF zbd00_academy23.
DATA: gs_select_eta_media LIKE TABLE OF zbd00_academy23.

SELECT * FROM zbd00_academy23 WHERE id_partecipante = @p_id INTO TABLE @gs_select .

IF lines( gs_select ) > 0.
  WRITE: / |nome: { gs_select[ 1 ]-nome } e cognome { gs_select[ 1 ]-cognome }| .
ELSE.
  WRITE: / | non sono stati trovate persone con questo id |.
ENDIF.

ULINE.

IF lines( gs_select ) > 0.

  DATA(differenzaA) = sy-datum(4) - gs_select[ 1 ]-data_di_nascita(4) .

  WRITE: / |nato il: { gs_select[ 1 ]-data_di_nascita DATE = ENVIRONMENT } | .
  WRITE: / |Età: { differenzaA }|.

ELSE.
  WRITE: / | non sono stati trovate persone con questo id |.
ENDIF.

ULINE.

SELECT * FROM zbd00_academy23 WHERE ccelera = 'VE' INTO TABLE @gs_select_venezia .
WRITE: / | partecipanti Venezia: { lines( gs_select_venezia ) } |.

SELECT * FROM zbd00_academy23 WHERE ccelera = 'RM' INTO TABLE @gs_select_roma .
WRITE: / | partecipanti Roma : { lines( gs_select_roma ) } |.

SELECT * FROM zbd00_academy23 WHERE ccelera = 'MI' INTO TABLE @gs_select_milano .
WRITE: / | partecipanti Milano: { lines( gs_select_milano ) } |.

ULINE.

SELECT * FROM zbd00_academy23 INTO TABLE @gs_select_eta_media .

data(media) = 0.
LOOP AT gs_select_eta_media INTO data(gs_riga) .
  media = media + ( sy-datum(4) - gs_riga-data_di_nascita(4) ).
ENDLOOP.
media = media / ( lines( gs_select_eta_media ) ).

write: / | età media è: { media } |.
