*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 31.03.2020 at 09:58:05
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSWL_V_SW_CRIT..................................*
TABLES: ZSWL_V_SW_CRIT, *ZSWL_V_SW_CRIT. "view work areas
CONTROLS: TCTRL_ZSWL_V_SW_CRIT
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZSWL_V_SW_CRIT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZSWL_V_SW_CRIT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZSWL_V_SW_CRIT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_SW_CRIT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_SW_CRIT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZSWL_V_SW_CRIT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_SW_CRIT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_SW_CRIT_TOTAL.

*.........table declarations:.................................*
TABLES: ZSWL_T_SW_CRIT                 .
