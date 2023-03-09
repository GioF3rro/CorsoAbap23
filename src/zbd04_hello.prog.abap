*&---------------------------------------------------------------------*
*& Report ZBD04_HELLO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_hello.

DATA gv_nome TYPE string.
DATA gv_cognome TYPE string.

gv_nome = 'Giovanni'. "definisco variabile
gv_cognome = 'Ferraro'. "definisco variabile

WRITE 'ciao'.
WRITE gv_nome.

SKIP.
ULINE.
WRITE: 'ciao ', / gv_nome.

SKIP.
DATA(gv_line) = 'Ciao ' && gv_nome. "assegnazione ad una variabile una concatenazione di stringhe
WRITE gv_line.

ULINE.
gv_line = |ciao Giovanni { gv_nome } { gv_cognome } !|.
WRITE gv_line.
ULINE.

SKIP.
*print hello word
WRITE 'hello word!'.
