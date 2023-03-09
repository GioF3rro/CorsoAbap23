*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZBD04_ACADEMY23
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZBD04_ACADEMY23    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
