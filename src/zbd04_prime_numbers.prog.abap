*&---------------------------------------------------------------------*
*& Report zbd04_prime_numbers
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_prime_numbers.

PARAMETERS: p_max TYPE i.

DATA: output    TYPE string, "assegnare lo stesso tipo di variabile facendo riferimento ad un'altra variabile
      gt_primi TYPE TABLE OF i.



DATA: modulo   TYPE i,
      numprimo TYPE i.

DATA(contatore) = 0.
DATA(controllo) = 0.

DO ( p_max - 1 ) TIMES.
  IF ( p_max > sy-index OR sy-index > 1 ) .
    controllo = sy-index .
    PERFORM primi CHANGING controllo.
    IF controllo = 1.
      "WRITE | { sy-index } , |.
      append sy-index to gt_primi.
    ENDIF.

  ENDIF.

ENDDO.

WRITE: |lista numeri primi di { p_max } --> |.
"ciclo per gli array
LOOP AT gt_primi INTO DATA(lv_primo).
  WRITE: / |-> { lv_primo }|.
ENDLOOP.



FORM primi CHANGING n TYPE i.
  DATA(j) = 2.
  data(var) = n.
  DO n TIMES.

    DATA(quadrato) = j * j.

    IF ( quadrato <= n ).

      IF ( n MOD j = 0 ).
        n = 0 .
        EXIT.
      ENDIF.

      j = j + 1.

    ENDIF.
  ENDDO.

  IF n <> 0.
    "PERFORM primi CHANGING var.
    n = 1 .
  ENDIF.

ENDFORM.
