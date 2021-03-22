FUNCTION Z_SWL_BAL_DB_SAVE .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_T_LOG_HANDLE) TYPE  BAL_T_LOGH
*"  EXCEPTIONS
*"      LOG_NOT_FOUND
*"      SAVE_NOT_ALLOWED
*"      NUMBERING_ERROR
*"----------------------------------------------------------------------

  FIELD-SYMBOLS:
    <l_s_ldat>              TYPE bal_s_ldat.

  DATA:
    l_s_ldel                TYPE bal_s_ldel,
    l_s_msg_handle          TYPE balmsghndl,
    l_new_lognumber         TYPE bal_s_lgnm,
    l_t_log_handle          TYPE bal_t_logh,
    l_t_msg_handle          TYPE bal_t_msgh,
    l_log_handle            TYPE balloghndl,
    l_s_logs_to_delete      TYPE bal_s_lgnm,
    l_t_logs_to_delete      TYPE bal_t_lgnm,
    l_s_db_tables           TYPE bal_s_db,
    l_time_stamp            TYPE balhdr-tim_stmp,
    l_oncom                 TYPE i,
    l_inupd                 TYPE i.
*

  GET TIME STAMP FIELD l_time_stamp.

***********************************************************************
* give back the name of secondary database connection
***********************************************************************
*      e_second_connection = 'R/3*SAP_2TH_CONNECT_APPL_LOG'.

***********************************************************************
* point to global data of function group SBAL
***********************************************************************
  macro_access_data.

*********************************************************************
* check if function module for eCATT exists
*********************************************************************
  macro_function_exists const_funcname_save.

***********************************************************************
* find out which logs are to be saved
***********************************************************************
* { #001
*  LOOP AT <g>-t_ldat ASSIGNING <l_s_ldat>.
*    INSERT <l_s_ldat>-log_handle INTO TABLE l_t_log_handle.
*  ENDLOOP.
  LOOP AT i_t_log_handle INTO l_log_handle.
    READ TABLE <g>-t_ldat TRANSPORTING NO FIELDS
      WITH KEY log_handle = l_log_handle.
    IF sy-subrc = 0.
      INSERT l_log_handle INTO TABLE l_t_log_handle.
    ENDIF.
  ENDLOOP.
* } #001

  DELETE ADJACENT DUPLICATES FROM l_t_log_handle.
  CHECK NOT l_t_log_handle IS INITIAL.


  LOOP AT l_t_log_handle INTO l_log_handle.

***********************************************************************
*   find the log which is to be inserted or updated
***********************************************************************
    READ TABLE <g>-t_ldat ASSIGNING <l_s_ldat>
               WITH KEY log_handle = l_log_handle.
    IF sy-subrc NE 0.
      MESSAGE e207(bl) RAISING log_not_found.
    ENDIF.

***********************************************************************
*   there is nothing to do when log is saved and not changed
***********************************************************************
    IF <l_s_ldat>-admin-is_on_db = true AND
       <l_s_ldat>-admin-changed  = false.
      CONTINUE.
    ENDIF.

***********************************************************************
*   log can not be saved when it is only partially loaded
***********************************************************************
    IF <l_s_ldat>-admin-msgs_on_db = true.
      CONTINUE.
    ENDIF.

***********************************************************************
*   Saving is impossible when OBJECT/SUBOBJECT is missing
***********************************************************************
    IF <l_s_ldat>-log-object    IS INITIAL AND
       <l_s_ldat>-log-subobject IS INITIAL.
*   201(BL): Saving not allowed: Object/subobject is missing
      MESSAGE e201(bl) RAISING save_not_allowed.
    ENDIF.

***********************************************************************
*   derive lognumber
***********************************************************************
    IF <l_s_ldat>-admin-lnum_final = false.
*     get new lognumber
      CALL FUNCTION 'BAL_DB_LOGNUMBER_GET'
        EXPORTING
          i_client     = sy-mandt
          i_log_handle = <l_s_ldat>-log_handle
        EXCEPTIONS
          OTHERS       = 1.
      IF sy-subrc <> 0.
*       218(BL): 'Error when finding next number for log'
        MESSAGE e218(bl) RAISING numbering_error.
      ENDIF.
    ENDIF.

***********************************************************************
*   compress log data
***********************************************************************
    PERFORM log_compress
              USING
                l_time_stamp
              CHANGING
                <l_s_ldat>
                l_s_db_tables.

  ENDLOOP.

***********************************************************************
* now start update
***********************************************************************
  IF NOT l_s_db_tables IS INITIAL.

    DATA: ls_balhdr TYPE balhdr.

    FIELD-SYMBOLS:
      <l_s_balhdr>         TYPE balhdr.

    LOOP AT l_s_db_tables-balhdr_i ASSIGNING <l_s_balhdr>.
      <l_s_balhdr>-db_version = const_bal_db_ver_current.
    ENDLOOP.

    INSERT  baldat FROM TABLE l_s_db_tables-baldat_i.
    READ TABLE l_s_db_tables-balhdr_i INTO ls_balhdr INDEX 1.
*   INSERT balhdr FROM ls_balhdr.                                "#001
    INSERT  balhdr FROM TABLE l_s_db_tables-balhdr_i.            "#001

  ENDIF.

ENDFUNCTION.
