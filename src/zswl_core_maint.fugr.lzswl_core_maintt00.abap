*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 10.02.2021 at 11:44:22
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSWL_T_WORKS....................................*
DATA:  BEGIN OF STATUS_ZSWL_T_WORKS                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSWL_T_WORKS                  .
CONTROLS: TCTRL_ZSWL_T_WORKS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZSWL_T_WORKS                  .
TABLES: ZSWL_T_WORKS                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
