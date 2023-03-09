*&---------------------------------------------------------------------*
*& Report zbd04_stampa_numeri
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_stampa_numeri.

PARAMETERS: p_numero TYPE i DEFAULT 100.

write: |Stampa numeri da 1 a { p_numero }| .
do p_numero TIMES.
    write: / | -> { sy-index } <-| .
ENDDO.
