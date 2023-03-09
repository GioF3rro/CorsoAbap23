*&---------------------------------------------------------------------*
*& Report ZBD04_NUMBER_GUESS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd04_number_guess.

DATA lv_disp_num TYPE int4.
DATA secret_num TYPE int4.
DATA d_testo TYPE char40.

CALL SCREEN 100.

INITIALIZATION.
  PERFORM random CHANGING secret_num.
  d_testo = 'Indovina il numero'.
*  lv_disp_num = secret_num.

FORM random CHANGING p_num TYPE int4.
  " Create instance with factory
  DATA(lo_rand) = cl_abap_random=>create( ).
  " Random number from 1 till 100 (integer)
  p_num = lo_rand->intinrange( low = 1 high = 100 ).
ENDFORM.

INCLUDE zbd04_number_guess_user_comi01.

INCLUDE zbd04_number_guess_status_0o01.
