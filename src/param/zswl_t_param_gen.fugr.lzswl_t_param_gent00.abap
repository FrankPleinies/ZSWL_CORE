*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 06.11.2020 at 12:51:54
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSWL_V_PARC.....................................*
TABLES: ZSWL_V_PARC, *ZSWL_V_PARC. "view work areas
CONTROLS: TCTRL_ZSWL_V_PARC
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_ZSWL_V_PARC. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZSWL_V_PARC.
* Table for entries selected to show on screen
DATA: BEGIN OF ZSWL_V_PARC_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARC_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZSWL_V_PARC_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARC_TOTAL.

*...processing: ZSWL_V_PARDF....................................*
TABLES: ZSWL_V_PARDF, *ZSWL_V_PARDF. "view work areas
CONTROLS: TCTRL_ZSWL_V_PARDF
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZSWL_V_PARDF. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZSWL_V_PARDF.
* Table for entries selected to show on screen
DATA: BEGIN OF ZSWL_V_PARDF_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARDF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARDF_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZSWL_V_PARDF_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARDF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARDF_TOTAL.

*...processing: ZSWL_V_PARMD....................................*
TABLES: ZSWL_V_PARMD, *ZSWL_V_PARMD. "view work areas
CONTROLS: TCTRL_ZSWL_V_PARMD
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZSWL_V_PARMD. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZSWL_V_PARMD.
* Table for entries selected to show on screen
DATA: BEGIN OF ZSWL_V_PARMD_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARMD.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARMD_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZSWL_V_PARMD_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZSWL_V_PARMD.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZSWL_V_PARMD_TOTAL.

*.........table declarations:.................................*
TABLES: ZSWL_T_PARC                    .
TABLES: ZSWL_T_PARDF                   .
TABLES: ZSWL_T_PARMD                   .
