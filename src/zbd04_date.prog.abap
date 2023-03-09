*&---------------------------------------------------------------------*
*& Report zbd04_date
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_date.

PARAMETERS: p_date  TYPE dats DEFAULT sy-datum, "data
            p_date2 TYPE dats DEFAULT '20230515', "data
            p_day   TYPE i DEFAULT 7.

WRITE: | hai inserito come valore nella data { p_date  DATE = ISO } e il numero di giorni { p_day }|.
ULINE.
DATA(differenza) = p_date2 - p_date.
WRITE: | Mancano { differenza } giorni al { p_date DATE = ENVIRONMENT }|.

ULINE.

DATA(ultimogiorno) = p_date.
WRITE: / |Anno: { p_date(4) }|.
WRITE: / |Mese: { p_date+4(2) }|.
WRITE: / |Day: { p_date+6(2) }|.
SKIP.
DATA(mese) = ( p_date+4(2) + 1 ) MOD 12. "modulo 12 -> se 13 restituisce 1
ultimogiorno+4(2) = mese.
ultimogiorno+6(2) = '01'.
ultimogiorno = ultimogiorno - 1.

IF mese = 1.
    ultimogiorno(4) = ultimogiorno(4) + 1.
ENDIF.
WRITE: | Ultimo giorno del mese seguente alla data1 { p_date DATE = ENVIRONMENT } è { ultimogiorno DATE = ENVIRONMENT }|.
