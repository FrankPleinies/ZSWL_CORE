*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 31.03.2020 at 09:55:30
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSWL_V_SW_ACT...................................*
TABLES: ZSWL_V_SW_ACT, *ZSWL_V_SW_ACT. "view work areas
CONTROLS: TCTRL_ZSWL_V_SW_ACT
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZSWL_V_SW_ACT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZSWL_V_SW_ACT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZSWL_V_SW_ACT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_SW_ACT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_SW_ACT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZSWL_V_SW_ACT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_SW_ACT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_SW_ACT_TOTAL.

*.........table declarations:.................................*
TABLES: ZSWL_T_SW_ACT                  .
