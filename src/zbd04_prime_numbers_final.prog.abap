*&---------------------------------------------------------------------*
*& Report zbd04_prime_numbers_final
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_prime_numbers_final.

PARAMETERS: p_max TYPE i.

DATA: result TYPE c.
DATA: gt_primes TYPE TABLE OF i.


DO p_max TIMES.

  DATA(numero) = sy-index.

  PERFORM is_prime USING numero CHANGING result.

  IF result IS INITIAL.
    WRITE: / |il numero { numero } è primo|.
    IF numero > 1.
      APPEND numero TO gt_primes.
    ENDIF.
  ENDIF.

  CLEAR result. "pulisce variabili globali
ENDDO.

cl_demo_output=>display( gt_primes ).

FORM is_prime USING numero_da_testare CHANGING non_primo.
  LOOP AT gt_primes INTO DATA(dividendo).
    "DO ( numero_da_testare - 1 ) TIMES.

    IF numero_da_testare MOD dividendo = 0 AND dividendo <= sqrt( numero_da_testare ).
      WRITE: / |il numero { numero_da_testare } è divisibile per:  |.
      PERFORM stampa_divisori USING numero_da_testare.
      non_primo = 'X'.
      EXIT.
    ENDIF.

  ENDLOOP.

ENDFORM.

FORM stampa_divisori USING numero_da_testare.
  LOOP AT gt_primes INTO DATA(dividendo).

    IF numero_da_testare MOD dividendo = 0 .
      WRITE: | " { dividendo } " |.
    ENDIF.

  ENDLOOP.
ENDFORM.
