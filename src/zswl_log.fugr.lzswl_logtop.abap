FUNCTION-POOL ZSWL_LOG.                      "MESSAGE-ID ..

TYPE-POOLS: abap.


SET EXTENDED CHECK OFF.
INCLUDE:
  sbal_boolean,                "TRUE and FALSE
  sbal_constants,              "constants for application log
  sbaltype,                    "internal type definitions
  sbal_access,                 "internal access data
  sbalmacr,                    "Macros
  sbal_function_exist.         "check if function module exists
SET EXTENDED CHECK ON.
* INCLUDE LZSWLBLOUXX.
********************************************************************
**   User-defined Include-files (if necessary).                    *
********************************************************************
** INCLUDE LZSCEBLOF...                       " Subprograms
** INCLUDE LZSCEBLOO...                       " PBO-Modules
** INCLUDE LZSCEBLOI...                       " PAI-Modules
*
INCLUDE ZSWLBLOF03.
