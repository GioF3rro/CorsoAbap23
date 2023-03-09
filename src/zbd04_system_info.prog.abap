*&---------------------------------------------------------------------*
*& Report zbd04_system_info
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_system_info.

WRITE: / |utente corrente -> { sy-uname }|.
WRITE: / |data corrente -> { sy-datum DATE = ENVIRONMENT }|.
WRITE: / |ora corrente -> { sy-uzeit TIME = ENVIRONMENT }|.
WRITE: / |nome programma -> { sy-repid }|.
WRITE: / |transazione corrente -> { sy-tcode }|.
WRITE: / |sistem ID corrente -> { sy-sysid }|.
WRITE: / |mandante corrente -> { sy-mandt }|.
WRITE: / |fuso orario corrente -> { sy-tzone }|.
WRITE: / |lingua corrente -> { sy-langu }|.
WRITE: / |sistema operativo corrente -> { sy-opsys }|.
WRITE: / |alfabeto latino -> { sy-abcde }|.
WRITE: / |titolo programma corrente -> { sy-title }|.
WRITE: / |data locale -> { sy-datlo }|.
WRITE: / |ora locale -> { sy-timlo }|.
