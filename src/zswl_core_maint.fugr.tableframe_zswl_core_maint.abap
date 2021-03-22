*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZSWL_CORE_MAINT
*   generation date: 10.02.2021 at 11:44:22
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZSWL_CORE_MAINT    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
