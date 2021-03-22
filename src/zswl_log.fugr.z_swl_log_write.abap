FUNCTION Z_SWL_LOG_WRITE .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_BALOBJ) TYPE  BALOBJ_D
*"     VALUE(I_SUFFIX) TYPE  ZSWL_DE_BALOBJSUFFIX OPTIONAL
*"     VALUE(I_BALSUBOBJ) TYPE  BALSUBOBJ
*"     VALUE(IT_BALID) TYPE  ZSWL_TT_BALID
*"     VALUE(I_NEWLOG) TYPE  ZSWL_DE_NEWLOG OPTIONAL
*"     VALUE(I_PROTLVL) TYPE  BALPROBCL OPTIONAL
*"     VALUE(IT_MESSAGES_BAL_S_MSG) TYPE  ZSWL_TT_BAL_MSG
*"     VALUE(I_ALDATE) TYPE  BALDATE OPTIONAL
*"     VALUE(I_ALTIME) TYPE  BALTIME OPTIONAL
*"     VALUE(I_EXPIRE_DAYS) TYPE  INT4 OPTIONAL
*"  EXPORTING
*"     VALUE(E_WRITE_SUCCESS) TYPE  XFELD
*"----------------------------------------------------------------------

  DATA: lo_log        TYPE REF TO       zswl_cl_log,
        l_balid       LIKE LINE OF      it_balid.

* create new log-object
**********************************************************************
  CREATE OBJECT lo_log.

* write all available data to log-object
**********************************************************************

* apply balid =>
  LOOP AT it_balid INTO l_balid.

    CALL METHOD lo_log->add_balid
      EXPORTING
        i_balid = l_balid
*      IMPORTING
*        e_added =
        .

  ENDLOOP.

* apply messages =>
  CALL METHOD lo_log->set_messages
    EXPORTING
      it_messages_bal_s_msg = it_messages_bal_s_msg.

* apply date/time =>
  CALL METHOD lo_log->set_logtimes
    EXPORTING
      aldate = i_aldate
      altime = i_altime.

* force write to database
**********************************************************************
  CALL METHOD lo_log->write
    EXPORTING
      i_balobj           = i_balobj
      i_suffix           = i_suffix
      i_balsubobj        = i_balsubobj
*     i_balid            =
      i_newlog           = i_newlog
      i_protlvl          = i_protlvl
      i_expire_days      = i_expire_days
      i_write_mode       = zswl_cl_log=>mc_wm_synchron_commit
    EXCEPTIONS
      no_balobj          = 1
      no_subobj          = 2
      no_balid           = 3
      illegal_protlvl    = 4
      error_creating_log = 5
      OTHERS             = 6.
  IF sy-subrc <> 0.
*   no specified error-handling in this case!
    e_write_success = abap_true.
  ENDIF.

  lo_log->free( ).

  COMMIT WORK.

ENDFUNCTION.
