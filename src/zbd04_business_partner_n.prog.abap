*&---------------------------------------------------------------------*
*& Report zbd04_business_partner_n
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

* n codici

"range
"1 parameters diviso da un carattere
"più parameters

REPORT zbd04_business_partner_n.

*&---------------------------------------------------------------------*
*& Report zbd04_business_partner
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

"parameters range
PARAMETERS: p_id_s TYPE but000-partner DEFAULT '000100003000',
            p_id_e TYPE but000-partner DEFAULT '0001000039'.

"split
PARAMETERS: p_split TYPE string DEFAULT '9999999999-0001000039'.

"select option
DATA: ls_but000 TYPE but000.
SELECT-OPTIONS: so_bpid FOR ls_but000-partner.

"programma con range
SELECT DISTINCT * FROM but000
INTO TABLE @DATA(data_row)
WHERE partner >= @p_id_s AND partner <= @p_id_e .

IF sy-subrc <> 0.
  "WRITE: |non sono presenti record dal range di id inseriti|.
    message e201(zbd04).
  EXIT.
  RETURN. "fine programma anche se sei in una funzione
ENDIF.

LOOP AT data_row INTO DATA(row).

  SKIP.

  PERFORM controllo USING row.
ENDLOOP.

ULINE.

"programma con split

SPLIT p_split AT '-' INTO TABLE DATA(segment).

LOOP AT segment INTO DATA(id_segment).

  DATA: id_select TYPE but000-partner.

  id_select = id_segment.

  SELECT DISTINCT * FROM but000
  INTO @DATA(data_row2)
  WHERE partner = @id_select .
  ENDSELECT.

  IF sy-subrc <> 0.
    WRITE: |non sono presenti record con gli id inseriti tramite split|.
    message e201(zbd04).
    EXIT.
    RETURN. "fine programma anche se sei in una funzione
  ENDIF.

  SKIP.

  PERFORM controllo USING data_row2.
ENDLOOP.

ULINE.

"select option
DATA: lt_but000 TYPE TABLE OF but000. "tabella interna

SELECT * FROM but000 INTO TABLE lt_but000
WHERE partner IN so_bpid.

IF sy-subrc <> 0.
  WRITE: |non sono presenti record dal range di id inseriti|.
  EXIT.
  RETURN. "fine programma anche se sei in una funzione
ENDIF.

LOOP AT lt_but000 INTO DATA(row_but000).

  SKIP.
  PERFORM controllo USING row_but000.

ENDLOOP.

ULINE.

FORM controllo USING row TYPE but000.

  IF row-type = 2 .
    WRITE: / |(organizzazione) Nome business partner -> { row-name_org1 } , { row-name_org2 }|.
  ELSEIF row-type = 3 .
    WRITE: / |(gruppo) Nome business partner -> { row-name_grp1 } , { row-name_grp2 }|.
  ELSEIF row-type = 1 .
    WRITE: / |(persona)Nome business partner  -> { row-name_first } ,  { row-name_last }|.
  ENDIF.

ENDFORM.
