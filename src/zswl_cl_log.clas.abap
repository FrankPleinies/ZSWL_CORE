CLASS zswl_cl_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPE-POOLS abap .

    CONSTANTS mc_context_field_ts TYPE strukname VALUE 'TIMESTAMP' ##NO_TEXT.
    CONSTANTS mc_context_struc_name TYPE tabname VALUE 'ZSWL_S_CONTEXT' ##NO_TEXT.
    CONSTANTS mc_fmtv_c TYPE zswl_de_format_option VALUE 3 ##NO_TEXT.
    CONSTANTS mc_fmtv_none TYPE zswl_de_format_option VALUE 4 ##NO_TEXT.
    CONSTANTS mc_fmtv_s0 TYPE zswl_de_format_option VALUE 2 ##NO_TEXT.
    CONSTANTS mc_fmtv_s0_c TYPE zswl_de_format_option VALUE 1 ##NO_TEXT.
    CONSTANTS mc_msgid TYPE symsgid VALUE 'ZSWL_LOG' ##NO_TEXT.
    CONSTANTS mc_msgty_abort TYPE bapi_mtype VALUE 'A' ##NO_TEXT.
    CONSTANTS mc_msgty_dump TYPE bapi_mtype VALUE 'X' ##NO_TEXT.
    CONSTANTS mc_msgty_error TYPE bapi_mtype VALUE 'E' ##NO_TEXT.
    CONSTANTS mc_msgty_information TYPE bapi_mtype VALUE 'I' ##NO_TEXT.
    CONSTANTS mc_msgty_status TYPE bapi_mtype VALUE 'S' ##NO_TEXT.
    CONSTANTS mc_msgty_warning TYPE bapi_mtype VALUE 'W' ##NO_TEXT.
    CONSTANTS mc_protlvl_default TYPE balprobcl VALUE 'D' ##NO_TEXT.
    CONSTANTS mc_protlvl_important TYPE balprobcl VALUE '2' ##NO_TEXT.
    CONSTANTS mc_protlvl_information TYPE balprobcl VALUE '4' ##NO_TEXT.
    CONSTANTS mc_protlvl_middle TYPE balprobcl VALUE '3' ##NO_TEXT.
    CONSTANTS mc_protlvl_status TYPE balprobcl VALUE ' ' ##NO_TEXT.
    CONSTANTS mc_protlvl_very_important TYPE balprobcl VALUE '1' ##NO_TEXT.
    CONSTANTS mc_time_high_value TYPE baltime VALUE '235959' ##NO_TEXT.
    CONSTANTS mc_time_low_value TYPE baltime VALUE '000000' ##NO_TEXT.
    CONSTANTS mc_wm_background TYPE zswl_de_writemode VALUE '4' ##NO_TEXT.
    CONSTANTS mc_wm_background_commit TYPE zswl_de_writemode VALUE '3' ##NO_TEXT.
    CONSTANTS mc_wm_new_task TYPE zswl_de_writemode VALUE '5' ##NO_TEXT.
    CONSTANTS mc_wm_synchron TYPE zswl_de_writemode VALUE '2' ##NO_TEXT.
    CONSTANTS mc_wm_synchron_commit TYPE zswl_de_writemode VALUE '1' ##NO_TEXT.
    CLASS-DATA mx_dummy_exception TYPE REF TO cx_root .
    CLASS-DATA m_dummy_msg TYPE zswl_de_logmsg .
    DATA ms_last_error TYPE bal_s_msg .

    CLASS-EVENTS evt_add
      EXPORTING
        VALUE(i_protlvl) TYPE balprobcl
        VALUE(i_msgty) TYPE symsgty OPTIONAL
        VALUE(i_msgid) TYPE symsgid OPTIONAL
        VALUE(i_msgno) TYPE symsgno OPTIONAL
        VALUE(i_msgv1) TYPE any OPTIONAL
        VALUE(i_msgv2) TYPE any OPTIONAL
        VALUE(i_msgv3) TYPE any OPTIONAL
        VALUE(i_msgv4) TYPE any OPTIONAL
        VALUE(i_msg) TYPE any OPTIONAL
        VALUE(i_syst) TYPE zswl_de_slg1_syst OPTIONAL
        VALUE(i_set_syst) TYPE xfeld DEFAULT abap_false
        VALUE(i_set_usrmsg) TYPE xfeld DEFAULT abap_false
        VALUE(i_istech) TYPE zswl_de_slg1_istech OPTIONAL
        VALUE(ix_exception) TYPE REF TO cx_root OPTIONAL
        VALUE(i_unitv1) TYPE meins OPTIONAL
        VALUE(i_unitv2) TYPE meins OPTIONAL
        VALUE(i_unitv3) TYPE meins OPTIONAL
        VALUE(i_unitv4) TYPE meins OPTIONAL
        VALUE(i_currv1) TYPE waers OPTIONAL
        VALUE(i_currv2) TYPE waers OPTIONAL
        VALUE(i_currv3) TYPE waers OPTIONAL
        VALUE(i_currv4) TYPE waers OPTIONAL
        VALUE(i_fmtv1) TYPE zswl_de_format_option OPTIONAL
        VALUE(i_fmtv2) TYPE zswl_de_format_option OPTIONAL
        VALUE(i_fmtv3) TYPE zswl_de_format_option OPTIONAL
        VALUE(i_fmtv4) TYPE zswl_de_format_option OPTIONAL
        VALUE(it_bapi_list) TYPE bapiret2_t OPTIONAL
        VALUE(it_bdc_list) TYPE ettcd_msg_tabtype OPTIONAL
        VALUE(io_log) TYPE REF TO zswl_cl_log OPTIONAL
        VALUE(is_context) TYPE zswl_s_context OPTIONAL .

    METHODS add
      IMPORTING
        !i_protlvl    TYPE balprobcl OPTIONAL
        !i_msgty      TYPE symsgty OPTIONAL
        !i_msgid      TYPE symsgid OPTIONAL
        !i_msgno      TYPE symsgno OPTIONAL
        !i_msgv1      TYPE any OPTIONAL
        !i_msgv2      TYPE any OPTIONAL
        !i_msgv3      TYPE any OPTIONAL
        !i_msgv4      TYPE any OPTIONAL
        !i_msg        TYPE any OPTIONAL
        !i_syst       TYPE zswl_de_slg1_syst OPTIONAL
        !i_set_syst   TYPE xfeld DEFAULT abap_false
        !i_set_usrmsg TYPE xfeld DEFAULT abap_false
        !i_istech     TYPE zswl_de_slg1_istech DEFAULT abap_false
        !ix_exception TYPE REF TO cx_root OPTIONAL
        !i_unitv1     TYPE meins OPTIONAL
        !i_unitv2     TYPE meins OPTIONAL
        !i_unitv3     TYPE meins OPTIONAL
        !i_unitv4     TYPE meins OPTIONAL
        !i_currv1     TYPE waers OPTIONAL
        !i_currv2     TYPE waers OPTIONAL
        !i_currv3     TYPE waers OPTIONAL
        !i_currv4     TYPE waers OPTIONAL
        !i_fmtv1      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv2      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv3      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv4      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fire_add   TYPE xfeld OPTIONAL
        !it_bapi_list TYPE bapiret2_t OPTIONAL
        !it_bdc_list  TYPE ettcd_msg_tabtype OPTIONAL
        !io_log       TYPE REF TO zswl_cl_log OPTIONAL
        !is_context   TYPE zswl_s_context OPTIONAL .
    METHODS add_balid
      IMPORTING
        !i_balid TYPE balnrext
      EXPORTING
        !e_added TYPE xfeld .
    METHODS add_filtersymbol
      IMPORTING
        !i_filtersymbol TYPE zswl_de_filtersymbol .
    METHODS add_log_to_log_handle
      IMPORTING
        !i_log_handle        TYPE balloghndl
        !i_context           TYPE any OPTIONAL
        !i_reload_log_handle TYPE xfeld OPTIONAL
        !i_save_log_handle   TYPE xfeld OPTIONAL
      EXCEPTIONS
        error_occured .
    CLASS-METHODS append_context_to_mess_fcat
      CHANGING
        !ct_mess_fcat TYPE bal_t_fcat .
    METHODS balid_available
      RETURNING
        VALUE(r_available) TYPE xfeld .
    METHODS clear_usrmsg .
    METHODS constructor
      IMPORTING
        !i_use_context TYPE xfeld OPTIONAL .
    METHODS display
      IMPORTING
        !i_title              TYPE c OPTIONAL
        !i_show_as_popup      TYPE xfeld DEFAULT abap_true
        !i_start_col          TYPE i DEFAULT 15
        !i_start_row          TYPE i DEFAULT 2
        !i_width              TYPE i DEFAULT 90
        !i_height             TYPE i DEFAULT 10
      RETURNING
        VALUE(e_exit_command) TYPE bal_s_excm
      EXCEPTIONS
        no_data
        error_creating_log
        error_display_log .
    METHODS display_db
      IMPORTING
        !i_title              TYPE c OPTIONAL
        !i_show_as_popup      TYPE xfeld DEFAULT abap_true
        !i_start_col          TYPE i DEFAULT 15
        !i_start_row          TYPE i DEFAULT 2
        !i_width              TYPE i DEFAULT 90
        !i_height             TYPE i DEFAULT 10
        !i_balobj             TYPE balobj_d
        !i_suffix             TYPE any OPTIONAL
        !i_balsubobj          TYPE balsubobj
        !i_balid              TYPE any
        !i_date_from          TYPE baldate OPTIONAL
        !i_time_from          TYPE baltime OPTIONAL
        !i_date_to            TYPE baldate OPTIONAL
        !i_time_to            TYPE baltime OPTIONAL
        !i_user               TYPE baluser OPTIONAL
        !i_only_last_entry    TYPE xfeld OPTIONAL
      RETURNING
        VALUE(e_exit_command) TYPE bal_s_excm
      EXCEPTIONS
        no_balobj
        no_subobj
        no_balid
        no_data
        error_searching_log
        error_display_log .
    METHODS display_usrmsg
      IMPORTING
        !i_like_msgty TYPE bapi_mtype DEFAULT mc_msgty_status .
    CLASS-METHODS fire_evt_add
      IMPORTING
        !i_protlvl    TYPE balprobcl OPTIONAL
        !i_msgty      TYPE symsgty OPTIONAL
        !i_msgid      TYPE symsgid OPTIONAL
        !i_msgno      TYPE symsgno OPTIONAL
        !i_msgv1      TYPE any OPTIONAL
        !i_msgv2      TYPE any OPTIONAL
        !i_msgv3      TYPE any OPTIONAL
        !i_msgv4      TYPE any OPTIONAL
        !i_msg        TYPE any OPTIONAL
        !i_syst       TYPE zswl_de_slg1_syst OPTIONAL
        !i_set_syst   TYPE xfeld DEFAULT abap_false
        !i_set_usrmsg TYPE xfeld DEFAULT abap_false
        !i_istech     TYPE zswl_de_slg1_istech OPTIONAL
        !ix_exception TYPE REF TO cx_root OPTIONAL
        !i_unitv1     TYPE meins OPTIONAL
        !i_unitv2     TYPE meins OPTIONAL
        !i_unitv3     TYPE meins OPTIONAL
        !i_unitv4     TYPE meins OPTIONAL
        !i_currv1     TYPE waers OPTIONAL
        !i_currv2     TYPE waers OPTIONAL
        !i_currv3     TYPE waers OPTIONAL
        !i_currv4     TYPE waers OPTIONAL
        !i_fmtv1      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv2      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv3      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !i_fmtv4      TYPE zswl_de_format_option DEFAULT mc_fmtv_s0_c
        !it_bapi_list TYPE bapiret2_t OPTIONAL
        !it_bdc_list  TYPE ettcd_msg_tabtype OPTIONAL
        !io_log       TYPE REF TO zswl_cl_log OPTIONAL
        !is_context   TYPE zswl_s_context OPTIONAL .
    METHODS free
      EXPORTING
        !e_haserror TYPE xfeld .
    METHODS get_defaultcontext
      RETURNING
        VALUE(rs_dcontext) TYPE zswl_s_context .
    METHODS get_last_error
      RETURNING
        VALUE(rs_last_error) TYPE bal_s_msg
      EXCEPTIONS
        error .
    METHODS get_messages
      IMPORTING
        !iv_protlvl            TYPE balprobcl OPTIONAL
      EXPORTING
        !et_messages_bal_s_msg TYPE zswl_tt_bal_msg
        !et_messages_bapiret2  TYPE bapiret2_t .
    METHODS get_usrmsg
      RETURNING
        VALUE(es_usrmsg) TYPE bal_s_msg .
    METHODS remove_balid
      IMPORTING
        !i_balid   TYPE balnrext
      EXPORTING
        !e_removed TYPE xfeld .
    METHODS set_defaultcontext
      IMPORTING
        !is_dcontext TYPE zswl_s_context .
    METHODS set_default_search_values
      IMPORTING
        !i_date_from TYPE baldate OPTIONAL
        !i_time_from TYPE baltime OPTIONAL
        !i_date_to   TYPE baldate OPTIONAL
        !i_time_to   TYPE baltime OPTIONAL
        !i_user      TYPE baluser OPTIONAL .
    METHODS set_logtimes
      IMPORTING
        !aldate TYPE baldate
        !altime TYPE baltime .
    METHODS set_messages
      IMPORTING
        !it_messages_bal_s_msg TYPE zswl_tt_bal_msg .
    CLASS-METHODS set_syerror
      IMPORTING
        !i_msgid TYPE symsgid DEFAULT zswl_cl_log=>mc_msgid
        !i_msgno TYPE symsgno
        !i_msgv1 TYPE any OPTIONAL
        !i_msgv2 TYPE any OPTIONAL
        !i_msgv3 TYPE any OPTIONAL
        !i_msgv4 TYPE any OPTIONAL .
    METHODS start_listen_to_evt_add .
    METHODS stop_listen_to_evt_add .
    METHODS write
      IMPORTING
        !i_balobj      TYPE balobj_d
        !i_suffix      TYPE any OPTIONAL
        !i_balsubobj   TYPE balsubobj
        !i_balid       TYPE any OPTIONAL
        !i_newlog      TYPE zswl_de_newlog DEFAULT abap_true
        !i_protlvl     TYPE balprobcl DEFAULT mc_protlvl_information
        !i_expire_days TYPE int4 OPTIONAL
        !i_write_mode  TYPE zswl_de_writemode DEFAULT mc_wm_background
      EXCEPTIONS
        no_balobj
        no_subobj
        no_balid
        illegal_protlvl
        error_creating_log
        inconsistent_parameters .
    METHODS write_fast
      IMPORTING
        !i_balobj      TYPE balobj_d
        !i_suffix      TYPE any OPTIONAL
        !i_balsubobj   TYPE balsubobj
        !i_balid       TYPE any OPTIONAL
        !i_protlvl     TYPE balprobcl DEFAULT mc_protlvl_information
        !i_expire_days TYPE int4 OPTIONAL
        !i_commit      TYPE xfeld DEFAULT abap_false
      EXCEPTIONS
        no_balobj
        no_subobj
        no_balid
        illegal_protlvl
        error_creating_log
        inconsistent_parameters .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mt_filtersymbols TYPE zswl_tt_filtersymbol .
    CONSTANTS mc_lock_argument_prefix TYPE char15 VALUE '_LOG_HANDLE_'. "#EC NOTEXT
    CONSTANTS mc_max_log_entries TYPE baldbcntal VALUE 1000. "#EC NOTEXT
    CLASS-DATA mt_cont_tsinfos TYPE zswl_tt_context_tsfieldinfo .
    DATA ms_defaultcontext TYPE zswl_s_context .
    DATA ms_usrmsg TYPE bal_s_msg .
    DATA mt_balids TYPE zswl_tt_balid .
    DATA mt_logs TYPE zswl_tt_bal_msg .
    DATA mt_log_handle TYPE bal_t_logh .
    DATA mt_log_handle_locked TYPE bal_t_logh .
    DATA m_aldate TYPE baldate .
    DATA m_altime TYPE baltime .
    DATA m_default_search_date_from TYPE baldate .
    DATA m_default_search_date_to TYPE baldate .
    DATA m_default_search_time_from TYPE baltime .
    DATA m_default_search_time_to TYPE baltime .
    DATA m_default_search_user TYPE baluser .
    DATA m_evt_add_active TYPE xfeld .
    DATA m_use_context TYPE xfeld .

    METHODS build_log_title
      IMPORTING
        !i_title       TYPE c DEFAULT space
      RETURNING
        VALUE(e_title) TYPE baltitle .
    METHODS create_balobj
      IMPORTING
        !i_balobj       TYPE balobj_d
        !i_suffix       TYPE any
      RETURNING
        VALUE(e_balobj) TYPE balobj_d .
    METHODS dequeue
      IMPORTING
        !i_argument TYPE progname .
    METHODS display_int
      IMPORTING
        !i_title              TYPE c OPTIONAL
        !i_show_as_popup      TYPE xfeld DEFAULT abap_true
        !i_start_col          TYPE i DEFAULT 15
        !i_start_row          TYPE i DEFAULT 2
        !i_width              TYPE i DEFAULT 90
        !i_height             TYPE i DEFAULT 10
        !it_log_handle        TYPE bal_t_logh
      RETURNING
        VALUE(e_exit_command) TYPE bal_s_excm
      EXCEPTIONS
        error_display_log
        no_data .
    METHODS enqueue
      IMPORTING
        !i_argument TYPE progname
        !i_wait     TYPE xfeld DEFAULT abap_false
      EXCEPTIONS
        already_locked
        lock_error .
    METHODS filter
      IMPORTING
        !i_balobj    TYPE balobj_d
        !i_suffix    TYPE any
        !i_balsubobj TYPE balsubobj
        !i_protlvl   TYPE balprobcl .
    CLASS-METHODS get_context_info
      IMPORTING
        !i_context       TYPE zswl_s_context
        !i_istech        TYPE zswl_de_slg1_istech OPTIONAL
        !i_timestamp     TYPE timestampl OPTIONAL
        !i_use_context   TYPE xfeld OPTIONAL
      EXPORTING
        !e_context_name  TYPE c
        !e_context_value TYPE balcval .
    METHODS get_log_handle_by_db_search
      IMPORTING
        !i_balobj          TYPE balobj_d
        !i_balsubobj       TYPE balsubobj
        !i_balid           TYPE balnrext OPTIONAL
        !i_date_from       TYPE baldate OPTIONAL
        !i_time_from       TYPE baltime OPTIONAL
        !i_date_to         TYPE baldate OPTIONAL
        !i_time_to         TYPE baltime OPTIONAL
        !i_user            TYPE baluser OPTIONAL
        !i_only_last_entry TYPE xfeld OPTIONAL
        !i_lock            TYPE xfeld OPTIONAL
      EXPORTING
        !et_log_handle     TYPE bal_t_logh
        !et_log_header     TYPE zswl_tt_balhdr
      EXCEPTIONS
        no_balobj
        no_subobj
        filter_create_error
        search_error
        no_data
        db_reload_error .
    METHODS get_log_handle_to_append
      IMPORTING
        !i_balobj           TYPE balobj_d
        !i_balsubobj        TYPE balsubobj
        !i_balid            TYPE balnrext OPTIONAL
      RETURNING
        VALUE(e_log_handle) TYPE balloghndl .
    METHODS get_message_available
      RETURNING
        VALUE(r_available) TYPE xfeld .
    CLASS-METHODS get_msgty_from_protlvl
      IMPORTING
        !i_protlvl     TYPE balprobcl
      RETURNING
        VALUE(r_msgty) TYPE symsgty .
    CLASS-METHODS get_protlvl_from_msgty
      IMPORTING
        !i_msgty         TYPE symsgty
      RETURNING
        VALUE(r_protlvl) TYPE balprobcl .
    METHODS lock_log_handle
      IMPORTING
        !i_log_handle TYPE balloghndl
      EXCEPTIONS
        error .
    METHODS on_add
          FOR EVENT evt_add OF zswl_cl_log
      IMPORTING
          !i_protlvl
          !i_msgty
          !i_msgid
          !i_msgno
          !i_msgv1
          !i_msgv2
          !i_msgv3
          !i_msgv4
          !i_msg
          !i_syst
          !i_set_syst
          !i_set_usrmsg
          !i_istech
          !ix_exception
          !i_unitv1
          !i_unitv2
          !i_unitv3
          !i_unitv4
          !i_currv1
          !i_currv2
          !i_currv3
          !i_currv4
          !i_fmtv1
          !i_fmtv2
          !i_fmtv3
          !i_fmtv4
          !it_bapi_list
          !it_bdc_list
          !io_log
          !is_context .
    METHODS save_msg_int
      IMPORTING
        !is_bal_msg   TYPE bal_s_msg
        !i_set_syst   TYPE xfeld
        !i_set_usrmsg TYPE xfeld
        !i_istech     TYPE zswl_de_slg1_istech OPTIONAL
        !i_timestamp  TYPE timestampl OPTIONAL
        !is_context   TYPE zswl_s_context OPTIONAL .
    METHODS transfer_msgv
      IMPORTING
        !i_msgv       TYPE any OPTIONAL
        !i_unit       TYPE meins OPTIONAL
        !i_curr       TYPE waers OPTIONAL
        !i_writetsmp  TYPE xfeld OPTIONAL
        !i_fmtv       TYPE zswl_de_format_option OPTIONAL
      RETURNING
        VALUE(r_msgv) TYPE symsgv .
    METHODS unlock_log_handles .
    METHODS write_prepare
      IMPORTING
        !i_balobj      TYPE balobj_d
        !i_suffix      TYPE any OPTIONAL
        !i_balsubobj   TYPE balsubobj
        !i_balid       TYPE any OPTIONAL
        !i_newlog      TYPE zswl_de_newlog DEFAULT abap_true
        !i_protlvl     TYPE balprobcl DEFAULT mc_protlvl_information
        !i_expire_days TYPE int4 OPTIONAL
        !i_write_mode  TYPE zswl_de_writemode DEFAULT mc_wm_background
        !i_fast        TYPE xfeld DEFAULT abap_false
      EXCEPTIONS
        no_balobj
        no_subobj
        no_balid
        illegal_protlvl
        error_creating_log
        inconsistent_parameters .
    METHODS write_single_balid
      IMPORTING
        !i_balobj      TYPE balobj_d
        !i_suffix      TYPE any OPTIONAL
        !i_balsubobj   TYPE balsubobj
        !i_balid       TYPE balhdr-extnumber
        !i_newlog      TYPE zswl_de_newlog DEFAULT abap_true
        !i_expire_days TYPE int4
        !i_fast        TYPE xfeld DEFAULT abap_false .
ENDCLASS.



CLASS ZSWL_CL_LOG IMPLEMENTATION.


  METHOD add.
    DATA:
      l_addlog  TYPE xfeld VALUE abap_true,
      l_protlvl TYPE balprobcl,
      l_msgty   TYPE symsgty.

    IF i_protlvl IS NOT SUPPLIED OR
       i_protlvl = mc_protlvl_default.
* set default loglevel based on message-type if protlvl is not supplied
      l_msgty = i_msgty.
      IF i_syst = abap_true.
        l_msgty = sy-msgty.
      ENDIF.
      l_protlvl = zswl_cl_log=>get_protlvl_from_msgty(
*                 i_msgty   = i_msgty ).
                    i_msgty   = l_msgty ).
    ELSE.
      l_protlvl = i_protlvl.
    ENDIF.

* Check and throw fire_add - event
**********************************************************************
    IF ( i_fire_add = abap_true ).

      CALL METHOD zswl_cl_log=>fire_evt_add
        EXPORTING
          i_protlvl    = l_protlvl
          i_msgty      = i_msgty
          i_msgid      = i_msgid
          i_msgno      = i_msgno
          i_msgv1      = i_msgv1
          i_msgv2      = i_msgv2
          i_msgv3      = i_msgv3
          i_msgv4      = i_msgv4
          i_msg        = i_msg
          i_syst       = i_syst
          i_set_syst   = i_set_syst
          i_set_usrmsg = i_set_usrmsg
          ix_exception = ix_exception
          i_unitv1     = i_unitv1
          i_unitv2     = i_unitv2
          i_unitv3     = i_unitv3
          i_unitv4     = i_unitv4
          i_currv1     = i_currv1
          i_currv2     = i_currv2
          i_currv3     = i_currv3
          i_currv4     = i_currv4
          i_fmtv1      = i_fmtv1
          i_fmtv2      = i_fmtv2
          i_fmtv3      = i_fmtv3
          i_fmtv4      = i_fmtv4
          it_bapi_list = it_bapi_list
          it_bdc_list  = it_bdc_list
          io_log       = io_log
          is_context   = is_context.

      IF ( me->m_evt_add_active = abap_true ).

*     If instance is listening to the event itself, do not add
*     the log entry in this case.
*     Event already forced the instance to add the log-entry.

        l_addlog = abap_false.

      ENDIF.

    ENDIF.


    IF l_addlog = abap_true.

*   finally, add log-entry to item-list
**********************************************************************
      me->on_add(
        i_protlvl            = l_protlvl
        i_msgty              = i_msgty
        i_msgid              = i_msgid
        i_msgno              = i_msgno
        i_msgv1              = i_msgv1
        i_msgv2              = i_msgv2
        i_msgv3              = i_msgv3
        i_msgv4              = i_msgv4
        i_msg                = i_msg
        i_syst               = i_syst
        i_set_syst           = i_set_syst
        i_set_usrmsg         = i_set_usrmsg
        ix_exception         = ix_exception
        i_unitv1             = i_unitv1
        i_unitv2             = i_unitv2
        i_unitv3             = i_unitv3
        i_unitv4             = i_unitv4
        i_currv1             = i_currv1
        i_currv2             = i_currv2
        i_currv3             = i_currv3
        i_currv4             = i_currv4
        i_fmtv1              = i_fmtv1
        i_fmtv2              = i_fmtv2
        i_fmtv3              = i_fmtv3
        i_fmtv4              = i_fmtv4
        it_bapi_list         = it_bapi_list
        it_bdc_list          = it_bdc_list
        io_log               = io_log
        is_context           = is_context
        ).

    ENDIF.

  ENDMETHOD.


  METHOD add_balid.

    DATA:
      l_balid  TYPE  balhdr-extnumber.

    CLEAR e_added.

    IF i_balid IS NOT INITIAL.

      WRITE i_balid TO l_balid.

      READ TABLE mt_balids TRANSPORTING NO FIELDS
                           WITH TABLE KEY table_line = l_balid.
      IF sy-subrc = 0.
        e_added = abap_false.
      ELSE.

        INSERT l_balid INTO TABLE mt_balids.
        IF sy-subrc = 0.
          e_added = abap_true.
        ELSE.
*       No error-handling in this case!
          e_added = abap_false.
        ENDIF.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD add_filtersymbol.

    COLLECT i_filtersymbol INTO mt_filtersymbols.

  ENDMETHOD.


  METHOD add_log_to_log_handle.

*|----------------------------------------------------------------------
*| add log-messages to given log-handle!
*|----------------------------------------------------------------------

    DATA:
      ls_prot              TYPE bal_s_msg,

      l_filtermsg(10)      TYPE c,
      l_filtersymbol       LIKE LINE OF mt_filtersymbols,

      l_context_name(30)   TYPE c,
      l_context_value(256) TYPE c,

      lt_log_handle        TYPE bal_t_logh.

* Reload the log handle if supplied!
    IF i_reload_log_handle = abap_true.

      APPEND i_log_handle TO lt_log_handle.
      CALL FUNCTION 'BAL_DB_RELOAD'
        EXPORTING
          i_t_log_handle    = lt_log_handle
        EXCEPTIONS
          no_logs_specified = 1
          log_not_found     = 2
          OTHERS            = 3.

      IF ( sy-subrc <> 0 ).
*     Error on reloading bal-log
        zswl_cl_log=>set_syerror( i_msgno = '010' ).
        RAISE error_occured.
      ENDIF.
    ENDIF.

    IF lines( me->mt_logs ) > 0.

      COLLECT space INTO mt_filtersymbols.
      LOOP AT mt_filtersymbols INTO l_filtersymbol.
        CONCATENATE l_filtermsg
                    l_filtersymbol
               INTO l_filtermsg.
      ENDLOOP.

      LOOP AT me->mt_logs INTO ls_prot.


        IF ls_prot-msgid = mc_msgid
          AND ls_prot-msgno = '000'.

          IF ls_prot-msgv1 CO l_filtermsg.
            CLEAR ls_prot-msgv1.
          ENDIF.
          IF ls_prot-msgv2 CO l_filtermsg.
            CLEAR ls_prot-msgv2.
          ENDIF.
          IF ls_prot-msgv3 CO l_filtermsg.
            CLEAR ls_prot-msgv3.
          ENDIF.
          IF ls_prot-msgv4 CO l_filtermsg.
            CLEAR ls_prot-msgv4.
          ENDIF.
          IF ls_prot-msgv1 IS INITIAL
            AND ls_prot-msgv2 IS INITIAL
            AND ls_prot-msgv3 IS INITIAL
            AND ls_prot-msgv4 IS INITIAL.

*         Nachricht quasi leer -> nicht hinzufügen
            CONTINUE.

          ENDIF.

        ENDIF.

        IF NOT l_context_name IS INITIAL.
          ls_prot-context-tabname = l_context_name.
          ls_prot-context-value   = l_context_value.
        ENDIF.

        CALL FUNCTION 'BAL_LOG_MSG_ADD'
          EXPORTING
            i_log_handle     = i_log_handle
            i_s_msg          = ls_prot
          EXCEPTIONS
            log_not_found    = 1
            msg_inconsistent = 2
            log_is_full      = 3
            OTHERS           = 4.

        IF sy-subrc <> 0.
          sy-msgid = zswl_cl_log=>mc_msgid.
          sy-msgty = zswl_cl_log=>mc_msgty_error.

          CASE sy-subrc.
            WHEN 1.
*           Error while adding log-data: logging not found
              sy-msgno = '001'.
            WHEN 2.
*           Error while adding log-data: data inconsistent
              sy-msgno = '002'.
            WHEN 3.
*           Error while adding log-data: log is full
              sy-msgno = '003'.
            WHEN 4.
*           Unknown error while adding log-data
              sy-msgno = '004'.
          ENDCASE.

          RAISE error_occured.

        ENDIF.
      ENDLOOP.
    ENDIF.

    IF i_save_log_handle = abap_true.

* finally, write to batabase!!!
      REFRESH:
        lt_log_handle.

      APPEND i_log_handle TO lt_log_handle.

      TRY.
          CALL FUNCTION 'BAL_DB_SAVE'
            EXPORTING
              i_client         = sy-mandt
              i_in_update_task = ' '
              i_save_all       = abap_false
              i_t_log_handle   = lt_log_handle
            EXCEPTIONS
              log_not_found    = 1
              save_not_allowed = 2
              numbering_error  = 3
              OTHERS           = 4.

          IF ( sy-subrc <> 0 ).
            RAISE error_occured.
          ENDIF.

        CATCH cx_root.                                   "#EC CATCH_ALL
          RAISE error_occured.
      ENDTRY.
    ENDIF.

  ENDMETHOD.


  METHOD append_context_to_mess_fcat.

    DATA:
      lo_ref_type  TYPE REF TO cl_abap_structdescr,
      lt_fieldlist TYPE ddfields,
      ls_field     LIKE LINE OF lt_fieldlist,
      ls_fcat      LIKE LINE OF ct_mess_fcat,
      l_highpos    TYPE bal_s_fcat-col_pos.

**********************************************************************
* analyze context-structure
**********************************************************************
    TRY.
        lo_ref_type ?= cl_abap_typedescr=>describe_by_name(
                                  zswl_cl_log=>mc_context_struc_name ).

        lo_ref_type->get_ddic_field_list(
          RECEIVING
            p_field_list             = lt_fieldlist
          EXCEPTIONS
            not_found                = 1
            no_ddic_type             = 2
            OTHERS                   = 3
               ).

        IF sy-subrc <> 0.
          CLEAR lt_fieldlist.
        ENDIF.

      CATCH cx_root.
*     structure not set or something wrong... -> ignore using context
        CLEAR lt_fieldlist.
    ENDTRY.

    CLEAR ls_fcat.

* add possible context-fields
    ls_fcat-ref_table = zswl_cl_log=>mc_context_struc_name.

* start context-columns at position 100 (only use very high value)
* to append at the end of table
    l_highpos = 100.

    LOOP AT lt_fieldlist INTO ls_field.
      ls_fcat-ref_field = ls_field-fieldname.
      ls_fcat-coltext   = ls_field-scrtext_s.
      ls_fcat-outputlen = ls_field-outputlen.

      IF ls_field-fieldname = zswl_cl_log=>mc_context_field_ts.
*     set timestamp at the beginning of the table
        ls_fcat-col_pos = 0.
      ELSE.
        ls_fcat-col_pos = l_highpos.
        l_highpos = l_highpos + 1.
      ENDIF.

      APPEND ls_fcat TO ct_mess_fcat.
    ENDLOOP.

  ENDMETHOD.


  METHOD balid_available.

    IF lines( mt_balids ) > 0.
      r_available = abap_true.
    ELSE.
      r_available = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD build_log_title.

    DATA:
      l_txt_date(10) TYPE c,
      l_txt_time(10) TYPE c,
      l_title(256)   TYPE c.

    WRITE sy-datum TO l_txt_date.
    WRITE sy-uzeit TO l_txt_time.

* if no title was given, a default title is used (-> from message class)
    IF ( i_title IS INITIAL ).
      MESSAGE ID mc_msgid
            TYPE mc_msgty_information
          NUMBER '016'
            INTO l_title.
    ELSE.
      l_title = i_title.
    ENDIF.

    e_title = l_txt_date.

    CONCATENATE:
      e_title l_txt_time INTO e_title SEPARATED BY ',',
      e_title l_title    INTO e_title SEPARATED BY space.

  ENDMETHOD.


  METHOD clear_usrmsg.

    CLEAR:
      ms_usrmsg.

  ENDMETHOD.


  METHOD constructor.

* Set default values für searching logs from DB

    me->set_default_search_values(
      EXPORTING
        i_date_from = sy-datum
        i_time_from = mc_time_low_value
        i_date_to   = sy-datum
        i_time_to   = mc_time_high_value
*     i_user      =
       ).

    m_use_context = i_use_context.

  ENDMETHOD.


  METHOD create_balobj.

    CLEAR e_balobj.

    IF i_suffix IS NOT INITIAL.
      CONCATENATE i_balobj '_' i_suffix INTO e_balobj.
    ELSE.
      e_balobj = i_balobj.
    ENDIF.

  ENDMETHOD.


  METHOD dequeue.

    DATA:
      l_argument                    TYPE progname.

    CONCATENATE sy-mandt
                i_argument
           INTO l_argument.

    CALL FUNCTION 'DEQUEUE_ESRDIRE'
      EXPORTING
        mode_trdir = 'E'
        name       = l_argument
*       X_NAME     = ' '
        _scope     = '3'
        _synchron  = abap_true
*       _COLLECT   = ' '
      .

  ENDMETHOD.


  METHOD display.

    DATA:
      lt_log_handle TYPE bal_t_logh,
      l_log_handle  TYPE balloghndl,
      ls_loghdr     TYPE bal_s_log.

* clear exporting/returning parameters
    CLEAR:
      e_exit_command.

* if no messages in log -> display not possible
    IF lines( me->mt_logs ) <= 0.
      zswl_cl_log=>set_syerror( i_msgno = '015' ).
      RAISE no_data.
    ENDIF.

* now we create a temporarily log handle
    CLEAR ls_loghdr.
    ls_loghdr-aluser     = sy-uname.
    ls_loghdr-alprog     = sy-repid.
    ls_loghdr-extnumber  = 'temporarily log for display'.   "#EC NOTEXT

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = ls_loghdr
      IMPORTING
        e_log_handle            = l_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.

    IF ( sy-subrc <> 0 ).
*     Error creating log-header
      zswl_cl_log=>set_syerror( i_msgno = '013'  ).
      RAISE error_creating_log.
    ENDIF.

* add all available messages to new temporarily log handle
    me->add_log_to_log_handle(
      EXPORTING
        i_log_handle  = l_log_handle
      EXCEPTIONS
        error_occured = 1
        OTHERS        = 2
           ).
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.

    APPEND l_log_handle TO lt_log_handle.

    me->display_int(
      EXPORTING
         i_title           = i_title
         i_show_as_popup   = i_show_as_popup
         i_start_col       = i_start_col
         i_start_row       = i_start_row
         i_width           = i_width
         i_height          = i_height
         it_log_handle     = lt_log_handle
      RECEIVING
        e_exit_command    = e_exit_command
      EXCEPTIONS
        error_display_log = 1
        no_data           = 2
        OTHERS            = 3 ).

    IF sy-subrc <> 0.
      RAISE error_display_log.
    ENDIF.

* refresh memory for temporarily log handle
    CALL FUNCTION 'BAL_LOG_REFRESH'
      EXPORTING
        i_log_handle  = l_log_handle
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.

* error handling not necessary!
    IF sy-subrc <> 0.
    ENDIF.

  ENDMETHOD.


  METHOD display_db.

    DATA:
      lt_log_handle TYPE bal_t_logh,
      l_log_handle  TYPE balloghndl,
      l_balobj      TYPE balobj_d.

* clear exporting/returning parameters
    CLEAR:
      e_exit_command.

* parameter-check
**********************************************************************
    IF ( i_balobj IS INITIAL ).
*   No bal-object given
      zswl_cl_log=>set_syerror( i_msgno = '005' ).
      RAISE no_balobj.
    ENDIF.

    IF ( i_balsubobj IS INITIAL ).
*   No bal-subobject given
      zswl_cl_log=>set_syerror( i_msgno = '006' ).
      RAISE no_subobj.
    ENDIF.

    IF i_balid IS INITIAL.
*   No bal-ID available
      zswl_cl_log=>set_syerror( i_msgno = '012' ).
      RAISE no_balid.
    ENDIF.


* get log handles for given selection criteria
**********************************************************************
    l_balobj = me->create_balobj(
      i_balobj = i_balobj
      i_suffix = i_suffix ).

    me->get_log_handle_by_db_search(
      EXPORTING
        i_balobj            = l_balobj
        i_balsubobj         = i_balsubobj
        i_balid             = i_balid
        i_date_from         = i_date_from
        i_time_from         = i_time_from
        i_date_to           = i_date_to
        i_time_to           = i_time_to
        i_user              = i_user
        i_only_last_entry   = i_only_last_entry
        i_lock              = abap_false
      IMPORTING
        et_log_handle       = lt_log_handle[]
      EXCEPTIONS
        no_balobj           = 1
        no_subobj           = 2
        filter_create_error = 3
        search_error        = 4
        no_data             = 5
        db_reload_error     = 6
        OTHERS              = 7 ).

    IF sy-subrc = 5.
      RAISE no_data.
    ENDIF.
    IF sy-subrc <> 0.
      RAISE error_searching_log.
    ENDIF.


* show the messages for selected log handles on screen
**********************************************************************
    me->display_int(
      EXPORTING
        i_title           = i_title
        i_show_as_popup   = i_show_as_popup
        i_start_col       = i_start_col
        i_start_row       = i_start_row
        i_width           = i_width
        i_height          = i_height
        it_log_handle     = lt_log_handle
      RECEIVING
        e_exit_command    = e_exit_command
      EXCEPTIONS
        error_display_log = 1
        no_data           = 2
        OTHERS            = 3 ).

    IF sy-subrc <> 0.
      RAISE error_display_log.
    ENDIF.

* refresh memory for loaded/created log handles
**********************************************************************
    LOOP AT lt_log_handle INTO l_log_handle.
      CALL FUNCTION 'BAL_LOG_REFRESH'
        EXPORTING
          i_log_handle  = l_log_handle
        EXCEPTIONS
          log_not_found = 1
          OTHERS        = 2.                                  "#EC *

* error handling not necessary!
      IF sy-subrc <> 0.                                     "#EC NEEDED
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD display_int.

    DATA:
      ls_log_profile                TYPE bal_s_prof.

* clear exporting/returning parameters
    CLEAR:
      e_exit_command.

* if no log handles given -> display not possible
    IF lines( it_log_handle ) <= 0.
      zswl_cl_log=>set_syerror( i_msgno = '017' ).
      RAISE no_data.
    ENDIF.

* create profile for display, depending on whether the log should show
* in a PopUp or not

    IF ( i_show_as_popup = abap_true ).
      CALL FUNCTION 'BAL_DSP_PROFILE_POPUP_GET'
        IMPORTING
          e_s_display_profile = ls_log_profile.

      ls_log_profile-start_col = i_start_col.
      ls_log_profile-start_row = i_start_row.

      IF i_width IS NOT INITIAL.
        ls_log_profile-end_col   = i_start_col + i_width.
      ENDIF.

      IF i_height IS NOT INITIAL.
        ls_log_profile-end_row   = i_start_row + i_height.
      ENDIF.

      IF i_width  IS NOT INITIAL OR
         i_height IS NOT INITIAL.
        ls_log_profile-pop_adjst = abap_false.
      ENDIF.

    ELSE.

      CALL FUNCTION 'BAL_DSP_PROFILE_NO_TREE_GET'
        IMPORTING
          e_s_display_profile = ls_log_profile.

    ENDIF.

* we use always a grid
    ls_log_profile-use_grid = abap_true.

* the column-width will be optimized
    ls_log_profile-cwidth_opt = abap_true.

* build log title
    ls_log_profile-title = me->build_log_title( i_title ).

* append fields of contextstructure to message fieldcatalog
    zswl_cl_log=>append_context_to_mess_fcat(
      CHANGING
        ct_mess_fcat = ls_log_profile-mess_fcat[] ).

* show the log on screen
    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING
        i_t_log_handle      = it_log_handle
*       i_t_log_context_filter =
        i_s_display_profile = ls_log_profile
      IMPORTING
        e_s_exit_command    = e_exit_command
      EXCEPTIONS
        error_message       = 99
        OTHERS              = 1.

    IF sy-subrc <> 0.
      RAISE error_display_log.
    ENDIF.

  ENDMETHOD.


  METHOD display_usrmsg.

* if no user message is available -> returning without output
    IF ms_usrmsg IS INITIAL.
      RETURN.
    ENDIF.

    MESSAGE ID ms_usrmsg-msgid
          TYPE i_like_msgty
        NUMBER ms_usrmsg-msgno
       DISPLAY LIKE ms_usrmsg-msgty
          WITH ms_usrmsg-msgv1
               ms_usrmsg-msgv2
               ms_usrmsg-msgv3
               ms_usrmsg-msgv4.

* when user message was display -> it will be cleared!
    me->clear_usrmsg( ).

  ENDMETHOD.


  METHOD enqueue.

    DATA:
      l_argument                    TYPE progname.

    CONCATENATE sy-mandt
                i_argument
           INTO l_argument.

    CALL FUNCTION 'ENQUEUE_ESRDIRE'
      EXPORTING
        mode_trdir     = 'E'
        name           = l_argument
        x_name         = ' '
        _scope         = '1'
        _wait          = i_wait
        _collect       = ' '
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.

    IF sy-subrc = 1.
      RAISE already_locked.
    ELSEIF sy-subrc > 0.
      RAISE lock_error.
    ENDIF.

  ENDMETHOD.


  METHOD filter.

    DATA: l_dofilter TYPE        xfeld,
          l_found    TYPE        xfeld,
          l_protlvl  LIKE        i_protlvl.


    l_dofilter = abap_true.
    l_protlvl = i_protlvl.

* when protlvl:status => no furhter checks necessary, as
* everything will be logged
    IF l_protlvl = mc_protlvl_status.
      l_dofilter = abap_false.
    ENDIF.

* check, if any dump/abort-message exists
    LOOP AT me->mt_logs TRANSPORTING NO FIELDS
                            WHERE msgty = mc_msgty_dump
                               OR msgty = mc_msgty_abort.
      l_dofilter = abap_false.
      EXIT.
    ENDLOOP.


    IF l_dofilter = abap_true.

*   filter messages
**********************************************************************

*   check, if any entry with at least current protlevel exists!
      l_found = abap_false.
      LOOP AT me->mt_logs TRANSPORTING NO FIELDS
        WHERE probclass <= l_protlvl
          AND probclass IS NOT INITIAL.
        l_found = abap_true.
        EXIT.
      ENDLOOP.

      IF l_found = abap_false.
*     no valid item with protlevel found -> delete all logging!
        CLEAR me->mt_logs.
      ENDIF.

    ENDIF.


  ENDMETHOD.


  METHOD fire_evt_add.

    DATA:
      l_protlvl                     TYPE balprobcl.

    IF i_protlvl IS NOT SUPPLIED OR
       i_protlvl = mc_protlvl_default.
* set default loglevel based on message-type if protlvl is not supplied
      l_protlvl = zswl_cl_log=>get_protlvl_from_msgty(
                    i_msgty   = i_msgty ).
    ELSE.
      l_protlvl = i_protlvl.
    ENDIF.

    RAISE EVENT evt_add
      EXPORTING
        i_protlvl            = l_protlvl
        i_msgty              = i_msgty
        i_msgid              = i_msgid
        i_msgno              = i_msgno
        i_msgv1              = i_msgv1
        i_msgv2              = i_msgv2
        i_msgv3              = i_msgv3
        i_msgv4              = i_msgv4
        i_msg                = i_msg
        i_syst               = i_syst
        i_set_syst           = i_set_syst
        i_set_usrmsg         = i_set_usrmsg
        ix_exception         = ix_exception
        i_unitv1             = i_unitv1
        i_unitv2             = i_unitv2
        i_unitv3             = i_unitv3
        i_unitv4             = i_unitv4
        i_currv1             = i_currv1
        i_currv2             = i_currv2
        i_currv3             = i_currv3
        i_currv4             = i_currv4
        i_fmtv1              = i_fmtv1
        i_fmtv2              = i_fmtv2
        i_fmtv3              = i_fmtv3
        i_fmtv4              = i_fmtv4
        it_bapi_list         = it_bapi_list
        it_bdc_list          = it_bdc_list
        io_log               = io_log
        is_context           = is_context.

  ENDMETHOD.


  METHOD free.

    DATA:
      ls_log_handle         LIKE LINE OF me->mt_log_handle.

    CLEAR:
      e_haserror.

* remove possibly loaded log-handles
**********************************************************************
    LOOP AT me->mt_log_handle INTO ls_log_handle.

      CALL FUNCTION 'BAL_LOG_REFRESH'
        EXPORTING
          i_log_handle  = ls_log_handle
        EXCEPTIONS
          log_not_found = 1
          error_message = 99
          OTHERS        = 2.

*   no specific error-handling in this case!
      IF sy-subrc <> 0.
        e_haserror = abap_true.
      ENDIF.
                                                            "#EC *
    ENDLOOP.

* clear data
**********************************************************************
    CLEAR:
      mt_balids,
      mt_logs,
      mt_log_handle,
      m_aldate,
      m_altime,
      ms_last_error.

    me->clear_usrmsg( ).

* unlock all locked log handles
    me->unlock_log_handles( ).

* Set default values für searching logs from DB
    me->set_default_search_values(
      EXPORTING
        i_date_from = sy-datum
        i_time_from = mc_time_low_value
        i_date_to   = sy-datum
        i_time_to   = mc_time_high_value
*     i_user      =
       ).

* deregister event
    CALL METHOD me->stop_listen_to_evt_add.

  ENDMETHOD.


  METHOD get_context_info.

    STATICS so_ref_type TYPE REF TO cl_abap_structdescr.

    DATA: "lo_ref_type      TYPE REF TO  cl_abap_structdescr,
      l_name(30)     TYPE         c,
      l_ok           TYPE         xfeld,
      l_usetimestamp TYPE         xfeld,
      l_timestamp    TYPE         timestampl,
      lt_fieldlist   TYPE         ddfields,
      ls_field       LIKE LINE OF lt_fieldlist,
      l_offset       TYPE         doffset,

      l_nano_secs    TYPE         p DECIMALS 3,
      l_date         TYPE         d,                        "#EC NEEDED
      l_time         TYPE         t,
      ls_context     TYPE         zswl_s_context,           "#EC NEEDED
      l_timechar(16) TYPE         c,

      ls_tsfield     TYPE         zswl_s_context_tsfieldinfo.

    CLEAR:
      e_context_name, e_context_value.

    ls_context = i_context.
    ls_context-istech = i_istech.

    IF i_use_context = abap_false.

      e_context_name = zswl_cl_log=>mc_context_struc_name.

      IF i_timestamp IS SUPPLIED
              AND i_timestamp IS NOT INITIAL.
        l_timestamp = i_timestamp.
      ELSE.
        GET TIME STAMP FIELD l_timestamp.
      ENDIF.

      l_nano_secs = frac( l_timestamp ).
      CONVERT TIME STAMP l_timestamp TIME ZONE sy-zonlo
              INTO DATE l_date TIME l_time.

* => only write time and milliseconds for now!
      WRITE: l_time       TO l_timechar,
             l_nano_secs  TO l_timechar+8(4).

      l_offset = ls_tsfield-field_offset.

* => write data to timestamp-position of structure!
      WRITE l_timechar TO ls_context-timestamp.
      e_context_value = ls_context.

    ELSE.

      l_ok = abap_true.

      MOVE i_context TO e_context_value.


* get field-information of context-structure (name, ...)
**********************************************************************
      IF l_ok = abap_true.
        IF so_ref_type IS BOUND.
          e_context_name = zswl_cl_log=>mc_context_struc_name.
        ELSE.
          TRY.
              so_ref_type ?= cl_abap_typedescr=>describe_by_name(
               zswl_cl_log=>mc_context_struc_name ).

              e_context_name = zswl_cl_log=>mc_context_struc_name.
            CATCH cx_root.                               "#EC CATCH_ALL
*       structure not set or something wrong... -> ignore using context
              CLEAR: e_context_name, e_context_value.
              l_ok   = abap_false.
          ENDTRY.
        ENDIF.
      ENDIF.

      IF l_ok = abap_true.
*   try to get information about timestamp-field!
*   => try to use buffered information
        READ TABLE mt_cont_tsinfos
              INTO ls_tsfield
              WITH TABLE KEY
                tabname   = l_name
                fieldname = zswl_cl_log=>mc_context_field_ts.

        IF sy-subrc = 0.
*     => buffered information available, use it
          IF ls_tsfield-has_field = abap_true.
*       use timestamp!
            l_usetimestamp = abap_true.
          ELSE.
            CLEAR ls_tsfield.
          ENDIF.

        ELSE.
*     => current structure not analyzed, yet!
          TRY.
              so_ref_type->get_ddic_field_list(
*          EXPORTING
*            p_langu                  = SY-LANGU
*            p_including_substructres = ABAP_FALSE
                RECEIVING
                  p_field_list             = lt_fieldlist
                EXCEPTIONS
                  not_found                = 1
                  no_ddic_type             = 2
                  OTHERS                   = 3
                     ).
              IF sy-subrc = 0.
*         look for timestamp-field and buffer result!
                CLEAR ls_tsfield.
                ls_tsfield-tabname    = l_name.
                ls_tsfield-fieldname  = zswl_cl_log=>mc_context_field_ts.

                READ TABLE lt_fieldlist
                  INTO ls_field
                  WITH KEY fieldname = zswl_cl_log=>mc_context_field_ts.
                IF sy-subrc = 0.
                  ls_tsfield-has_field    = abap_true.
                  ls_tsfield-field_offset = ls_field-offset.
                  ls_tsfield-field_leng   = ls_field-leng.

                  IF cl_abap_char_utilities=>charsize > 1.
*               on unicode, offset is doubled!
                    ls_tsfield-field_offset = ls_tsfield-field_offset / 2.
                  ENDIF.

                  l_usetimestamp          = abap_true.
                ELSE.
                  ls_tsfield-has_field = abap_false.
                ENDIF.

                INSERT ls_tsfield INTO TABLE mt_cont_tsinfos.

              ENDIF.

            CATCH cx_root.                               "#EC CATCH_ALL
              l_ok = abap_false.

          ENDTRY.

        ENDIF.

      ENDIF.

* write timestamp
**********************************************************************
      IF l_ok = abap_true
        AND l_usetimestamp = abap_true.

        IF i_timestamp IS SUPPLIED
          AND i_timestamp IS NOT INITIAL.
          l_timestamp = i_timestamp.
        ELSE.
          GET TIME STAMP FIELD l_timestamp.
        ENDIF.

        l_nano_secs = frac( l_timestamp ).
        CONVERT TIME STAMP l_timestamp TIME ZONE sy-zonlo
                INTO DATE l_date TIME l_time.

* => only write time and milliseconds for now!
        WRITE: l_time       TO l_timechar,
               l_nano_secs  TO l_timechar+8(4).

        l_offset = ls_tsfield-field_offset.

* => write data to timestamp-position of structure!
        WRITE l_timechar TO
          e_context_value+l_offset(ls_tsfield-field_leng).

      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_defaultcontext.

    rs_dcontext = ms_defaultcontext.

  ENDMETHOD.


  METHOD get_last_error.

    rs_last_error = ms_last_error.

  ENDMETHOD.


  METHOD get_log_handle_by_db_search.

    DATA:
      ls_log_filter        TYPE  bal_s_lfil,

      lt_log_header_sorted TYPE balhdr_t,
      lt_log_header        TYPE zswl_tt_balhdr,
      ls_log_header        LIKE LINE OF lt_log_header,

      lt_log_handle        TYPE bal_t_logh,
      l_log_handle         TYPE balloghndl,

      l_date_from          TYPE baldate,
      l_time_from          TYPE baltime,
      l_date_to            TYPE baldate,
      l_time_to            TYPE baltime,
      l_user               TYPE baluser.

* refreshing the exporting parameters
    REFRESH:
      et_log_handle.

    l_date_from = i_date_from.
    l_time_from = i_time_from.
    l_date_to   = i_date_to.
    l_time_to   = i_time_to.
    l_user      = i_user.

* when all select-criterias are initial, use the default values
    IF l_date_from IS INITIAL AND
       l_time_from IS INITIAL AND
       l_date_to   IS INITIAL AND
       l_time_to   IS INITIAL AND
       l_user      IS INITIAL.

      l_date_from = m_default_search_date_from.
      l_time_from = m_default_search_time_from.
      l_date_to   = m_default_search_date_to.
      l_time_to   = m_default_search_time_to.
      l_user      = m_default_search_user.

    ENDIF.

* creating the filter structure
    CALL FUNCTION 'BAL_FILTER_CREATE'
      EXPORTING
        i_object       = i_balobj
        i_subobject    = i_balsubobj
        i_extnumber    = i_balid
        i_aldate_from  = l_date_from
        i_aldate_to    = l_date_to
        i_altime_from  = l_time_from
        i_altime_to    = l_time_to
        i_aluser       = l_user
      IMPORTING
        e_s_log_filter = ls_log_filter
      EXCEPTIONS
        error_message  = 99
        OTHERS         = 1.

    IF sy-subrc <> 0.
*   Error creating log-filter
      zswl_cl_log=>set_syerror( i_msgno = '007'  ).
      RAISE filter_create_error.
    ENDIF.

    CALL FUNCTION 'BAL_DB_SEARCH'
      EXPORTING
*       I_CLIENT           = SY-MANDT
        i_s_log_filter     = ls_log_filter
      IMPORTING
        e_t_log_header     = lt_log_header_sorted
      EXCEPTIONS
        log_not_found      = 1
        no_filter_criteria = 2
        error_message      = 99
        OTHERS             = 3.

* raise exceptions when an error occured or no data were found
    IF sy-subrc <> 0 AND sy-subrc <> 1.
*   Error while searching log-data
      zswl_cl_log=>set_syerror( i_msgno = '008'  ).
      RAISE search_error.

    ELSEIF lines( lt_log_header_sorted ) = 0 OR sy-subrc = 1.
*   No log-data found
      zswl_cl_log=>set_syerror( i_msgno = '009'  ).
      RAISE no_data.
    ENDIF.

    lt_log_header[] = lt_log_header_sorted[].

    IF i_only_last_entry = abap_true.
*   only use last entry -> use item after sorting descending
      SORT lt_log_header DESCENDING BY aldate altime lognumber.
      READ TABLE lt_log_header INTO ls_log_header
        INDEX 1.
      IF sy-subrc = 0.
        APPEND ls_log_header-log_handle TO lt_log_handle.
        DELETE lt_log_header
          WHERE log_handle <> ls_log_header-log_handle .
      ELSE.
*     normally, could not happen!
*     No log-data found
        zswl_cl_log=>set_syerror( i_msgno = '009'  ).
        RAISE no_data.
      ENDIF.

    ELSE.
      SORT lt_log_header BY log_handle.
      LOOP AT lt_log_header INTO ls_log_header.
        APPEND ls_log_header-log_handle TO lt_log_handle.
      ENDLOOP.

    ENDIF.

* load data from memory
**********************************************************************
    CALL FUNCTION 'BAL_DB_RELOAD'
      EXPORTING
        i_t_log_handle    = lt_log_handle
      EXCEPTIONS
        no_logs_specified = 1
        log_not_found     = 2
        OTHERS            = 3.

    IF ( sy-subrc <> 0 ).
*   Error on reloading bal-log
      zswl_cl_log=>set_syerror( i_msgno = '010'  ).
      RAISE db_reload_error.
    ENDIF.

* the required log handles are correctly read, then we can now
* fill the returning parameter
    et_log_handle[] = lt_log_handle[].
    et_log_header[] = lt_log_header[].

* is a lock required?
    IF i_lock = abap_true.
      LOOP AT et_log_handle INTO l_log_handle.

        me->lock_log_handle(
          EXPORTING
            i_log_handle = l_log_handle
          EXCEPTIONS
            error        = 1
            OTHERS       = 2 ).

* when we can't lock the log handle, we remove it from the exporting
* table!
        IF sy-subrc <> 0.
          DELETE et_log_handle.
          DELETE et_log_header
           WHERE log_handle = l_log_handle.
        ENDIF.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_log_handle_to_append.

    DATA:
      lt_log_header TYPE zswl_tt_balhdr,
      ls_log_header LIKE LINE OF lt_log_header,

      ls_loghdr     TYPE bal_s_log,

      l_log_handle  TYPE balloghndl,
      lt_log_handle TYPE bal_t_logh.

    CLEAR:
      e_log_handle.

    CALL METHOD me->get_log_handle_by_db_search
      EXPORTING
        i_balobj            = i_balobj
        i_balsubobj         = i_balsubobj
        i_balid             = i_balid
        i_only_last_entry   = abap_true
        i_lock              = abap_false
      IMPORTING
        et_log_handle       = lt_log_handle
        et_log_header       = lt_log_header
      EXCEPTIONS
        no_balobj           = 1
        no_subobj           = 2
        filter_create_error = 3
        search_error        = 4
        no_data             = 5
        db_reload_error     = 6
        OTHERS              = 7.

* no error handling necessary - when we can't read a log from database,
* we create a new one!
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    READ TABLE lt_log_handle INTO l_log_handle INDEX 1.
    IF sy-subrc = 0.

      READ TABLE lt_log_header INTO ls_log_header
        WITH KEY log_handle = l_log_handle.
      IF sy-subrc = 0 AND
         ls_log_header-msg_cnt_al < mc_max_log_entries.

        MOVE-CORRESPONDING ls_log_header TO ls_loghdr.
        ls_loghdr-aluser = sy-uname.
        ls_loghdr-aldate = me->m_aldate.
        ls_loghdr-altime = me->m_altime.

* when we can reload a existing log handle, we update the date/time
* of the log to actual values
        CALL FUNCTION 'BAL_LOG_HDR_CHANGE'
          EXPORTING
            i_log_handle            = l_log_handle
            i_s_log                 = ls_loghdr
          EXCEPTIONS
            log_not_found           = 1
            log_header_inconsistent = 2
            OTHERS                  = 3.

        IF sy-subrc = 0.

* now, all is correct! We lock the handle and return it!
          me->lock_log_handle(
            EXPORTING
              i_log_handle = l_log_handle
            EXCEPTIONS
              error        = 1
              OTHERS       = 2 ).

          IF sy-subrc = 0.
            e_log_handle  = l_log_handle.
          ENDIF.

        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_messages.

    DATA:
      ls_bapi_list LIKE LINE OF et_messages_bapiret2,
      ls_log       LIKE LINE OF me->mt_logs,
      lv_found     TYPE xfeld.

    CLEAR:
      et_messages_bal_s_msg[], et_messages_bapiret2[].

* Comparison with lesser than only works if protocol level is numeric
* Works like filter method:
* If protocol level is reached: return all entries
* else: return no entry
**********************************************************************

    IF   iv_protlvl = mc_protlvl_very_important
      OR iv_protlvl = mc_protlvl_important
      OR iv_protlvl = mc_protlvl_middle
      OR iv_protlvl = mc_protlvl_information.

      LOOP AT mt_logs TRANSPORTING NO FIELDS
        WHERE probclass <= iv_protlvl.
        lv_found = abap_true.
        EXIT.
      ENDLOOP.

      IF lv_found = abap_false.
        RETURN.
      ENDIF.
    ENDIF.



* returns available log-data in bapiret-2 structure!
**********************************************************************
    IF et_messages_bapiret2 IS SUPPLIED.
      LOOP AT me->mt_logs INTO ls_log.

        CLEAR ls_bapi_list.
        ls_bapi_list-type       = ls_log-msgty.
        ls_bapi_list-id         = ls_log-msgid.
        ls_bapi_list-number     = ls_log-msgno.
        ls_bapi_list-message_v1 = ls_log-msgv1.
        ls_bapi_list-message_v2 = ls_log-msgv2.
        ls_bapi_list-message_v3 = ls_log-msgv3.
        ls_bapi_list-message_v4 = ls_log-msgv4.

        MESSAGE ID ls_bapi_list-id
              TYPE ls_bapi_list-type
            NUMBER ls_bapi_list-number
              WITH ls_bapi_list-message_v1
                   ls_bapi_list-message_v2
                   ls_bapi_list-message_v3
                   ls_bapi_list-message_v4
              INTO ls_bapi_list-message.

        APPEND ls_bapi_list TO et_messages_bapiret2.

      ENDLOOP.
    ENDIF.

* returns available log-data directly
**********************************************************************
    et_messages_bal_s_msg = me->mt_logs.

  ENDMETHOD.


  METHOD get_message_available.

    IF lines( mt_logs ) > 0.
      r_available = abap_true.
    ELSE.
      r_available = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD get_msgty_from_protlvl.

    CLEAR:
      r_msgty.

    CASE i_protlvl.
      WHEN mc_protlvl_very_important.
        r_msgty = mc_msgty_abort.

      WHEN mc_protlvl_important.
        r_msgty = mc_msgty_error.

      WHEN mc_protlvl_middle.
        r_msgty = mc_msgty_warning.

      WHEN mc_protlvl_information.
        r_msgty = mc_msgty_information.

      WHEN mc_protlvl_status.
        r_msgty = mc_msgty_status.

    ENDCASE.

  ENDMETHOD.


  METHOD get_protlvl_from_msgty.

    CLEAR:
      r_protlvl.

    CASE i_msgty.
      WHEN mc_msgty_dump.
        r_protlvl = mc_protlvl_very_important.
      WHEN mc_msgty_abort.
        r_protlvl = mc_protlvl_important.
      WHEN mc_msgty_error.
        r_protlvl = mc_protlvl_important.
      WHEN mc_msgty_warning.
        r_protlvl = mc_protlvl_middle.
      WHEN mc_msgty_information.
        r_protlvl = mc_protlvl_information.
      WHEN mc_msgty_status.
        r_protlvl = mc_protlvl_status.
    ENDCASE.

  ENDMETHOD.


  METHOD get_usrmsg.

    es_usrmsg = ms_usrmsg.

  ENDMETHOD.


  METHOD lock_log_handle.

    DATA:
      l_lock_argument               TYPE progname.

* already locked?
    READ TABLE mt_log_handle_locked TRANSPORTING NO FIELDS
      WITH KEY table_line = i_log_handle.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    l_lock_argument = i_log_handle.
    CONCATENATE mc_lock_argument_prefix
                l_lock_argument
           INTO l_lock_argument.

    CALL METHOD me->enqueue
      EXPORTING
        i_argument     = l_lock_argument
        i_wait         = abap_true
      EXCEPTIONS
        already_locked = 1
        lock_error     = 2
        OTHERS         = 3.

    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

* we must add this entry by insert, because mt_log_handle_locked is a
* sorted table!!
    INSERT i_log_handle INTO TABLE mt_log_handle_locked.

  ENDMETHOD.


  METHOD on_add.

    DATA:
      l_timestamp TYPE timestampl,
      l_protlvl   TYPE balprobcl,
      l_msg       TYPE string, "#001
      l_msg_len   TYPE i,      "#001
      ls_eintrag  TYPE bal_s_msg,
      ls_msgv1234 TYPE zswl_s_msgv1234,
      lt_messages TYPE zswl_tt_bal_msg.

    FIELD-SYMBOLS:
      <ls_bapi> TYPE bapiret2,
      <ls_bdc>  TYPE bdcmsgcoll.

* handle loglevel
    l_protlvl = i_protlvl.
    IF (     l_protlvl <> mc_protlvl_very_important
         AND l_protlvl <> mc_protlvl_important
         AND l_protlvl <> mc_protlvl_middle
         AND l_protlvl <> mc_protlvl_information ).
*   l_protlvl = mc_protlvl_default.
      l_protlvl = mc_protlvl_information.
    ENDIF.

* get time-stamp once and use this all the time!
    GET TIME STAMP FIELD l_timestamp.

* get timestamp first log entry
    me->m_aldate = sy-datum.
    me->m_altime = sy-uzeit.

* add to logging table
    IF ( i_msgid IS NOT INITIAL ).

      CLEAR: ls_eintrag.
      ls_eintrag-time_stmp = l_timestamp.
      ls_eintrag-probclass = l_protlvl.

* build header
      ls_eintrag-msgid = i_msgid.
      ls_eintrag-msgty = i_msgty.
      ls_eintrag-msgno = i_msgno.

* msgv1
      ls_eintrag-msgv1 = me->transfer_msgv(
        i_msgv            = i_msgv1
        i_unit            = i_unitv1
        i_curr            = i_currv1
        i_fmtv            = i_fmtv1 ).

* msgv2
      ls_eintrag-msgv2 = me->transfer_msgv(
         i_msgv            = i_msgv2
         i_unit            = i_unitv2
         i_curr            = i_currv2
         i_fmtv            = i_fmtv2 ).

* msgv3
      ls_eintrag-msgv3 = me->transfer_msgv(
        i_msgv            = i_msgv3
        i_unit            = i_unitv3
        i_curr            = i_currv3
        i_fmtv            = i_fmtv3 ).

* msgv4
      ls_eintrag-msgv4 = me->transfer_msgv(
        i_msgv            = i_msgv4
        i_unit            = i_unitv4
        i_curr            = i_currv4
        i_fmtv            = i_fmtv4 ).

* save log
      me->save_msg_int(
        is_bal_msg           = ls_eintrag
        i_set_syst           = i_set_syst
        i_set_usrmsg         = i_set_usrmsg
        i_istech             = i_istech
        i_timestamp          = l_timestamp
        is_context           = is_context ).

    ENDIF.


* add single messages
    IF ( i_msg IS NOT INITIAL ).

      l_msg = i_msg.
      l_msg_len = strlen( l_msg ).
*   Bei überlangen Telegrammen müssen diese weiter zerteilt werden.
      WHILE l_msg_len > 0.

        CLEAR: ls_msgv1234, ls_eintrag.

        ls_eintrag-context = is_context.
        ls_eintrag-time_stmp = l_timestamp.
        ls_eintrag-probclass = l_protlvl.

        ls_eintrag-msgid = mc_msgid.
        ls_eintrag-msgty = i_msgty.
        ls_eintrag-msgno = '000'.

        IF l_msg_len > 200.
          MOVE l_msg(200) TO ls_msgv1234.
          SHIFT l_msg BY 200 PLACES.
        ELSE.
          MOVE l_msg(l_msg_len) TO ls_msgv1234.
          SHIFT l_msg BY l_msg_len PLACES.
        ENDIF.

        ls_eintrag-msgv1 = ls_msgv1234-msgv1.
        ls_eintrag-msgv2 = ls_msgv1234-msgv2.
        ls_eintrag-msgv3 = ls_msgv1234-msgv3.
        ls_eintrag-msgv4 = ls_msgv1234-msgv4.

* save log
        me->save_msg_int(
          is_bal_msg           = ls_eintrag
          i_set_syst           = i_set_syst
          i_set_usrmsg         = i_set_usrmsg
          i_istech             = i_istech
          i_timestamp          = l_timestamp
          is_context           = is_context ).

        l_msg_len = strlen( l_msg ).
      ENDWHILE.

    ENDIF.

    IF i_syst = abap_true AND
       sy-msgid IS NOT INITIAL.                             "MST20120327

      CLEAR: ls_eintrag.
      ls_eintrag-context = is_context.
      ls_eintrag-probclass = l_protlvl.
      ls_eintrag-time_stmp = l_timestamp.

* build header
      ls_eintrag-msgid = sy-msgid.
      IF i_msgty IS INITIAL.
        ls_eintrag-msgty = sy-msgty.
      ELSE.
        ls_eintrag-msgty = i_msgty.
      ENDIF.
      ls_eintrag-msgno = sy-msgno.

* build msgvar
      ls_eintrag-msgv1 = sy-msgv1.
      ls_eintrag-msgv2 = sy-msgv2.
      ls_eintrag-msgv3 = sy-msgv3.
      ls_eintrag-msgv4 = sy-msgv4.

* save log
      me->save_msg_int(
        is_bal_msg           = ls_eintrag
        i_set_syst           = i_set_syst
        i_set_usrmsg         = i_set_usrmsg
        i_istech             = i_istech
        i_timestamp          = l_timestamp
        is_context           = is_context ).

    ENDIF.

* log exception data
    IF ( ix_exception IS BOUND ).

      CLEAR: ls_eintrag.
      ls_eintrag-context   = is_context.
      ls_eintrag-probclass = l_protlvl.
      ls_eintrag-time_stmp = l_timestamp.

      TRY.
          CALL METHOD cl_message_helper=>set_msg_vars_for_if_msg
            EXPORTING
              text = ix_exception.

          ls_eintrag-msgid = sy-msgid.
          ls_eintrag-msgno = sy-msgno.
          ls_eintrag-msgty = i_msgty.
          ls_eintrag-msgv1 = sy-msgv1.
          ls_eintrag-msgv2 = sy-msgv2.
          ls_eintrag-msgv3 = sy-msgv3.
          ls_eintrag-msgv4 = sy-msgv4.

        CATCH cx_sy_message_illegal_text.

*   // &&&&
          ls_eintrag-msgid = mc_msgid.
          ls_eintrag-msgty = i_msgty.
          ls_eintrag-msgno = '000'.

          ls_msgv1234 = ix_exception->get_text( ).
          ls_eintrag-msgv1 = ls_msgv1234-msgv1.
          ls_eintrag-msgv2 = ls_msgv1234-msgv2.
          ls_eintrag-msgv3 = ls_msgv1234-msgv3.
          ls_eintrag-msgv4 = ls_msgv1234-msgv4.

      ENDTRY.                                                      "#002

* save log
      me->save_msg_int(
        is_bal_msg           = ls_eintrag
        i_set_syst           = i_set_syst
        i_set_usrmsg         = i_set_usrmsg
        i_istech             = i_istech
        i_timestamp          = l_timestamp
        is_context           = is_context ).

    ENDIF.

* log bapiret
    IF lines( it_bapi_list ) > 0.

      LOOP AT it_bapi_list ASSIGNING <ls_bapi>.

        CLEAR: ls_eintrag.
        ls_eintrag-context = is_context.
        ls_eintrag-probclass = i_protlvl.
        ls_eintrag-time_stmp = l_timestamp.

        IF <ls_bapi>-id IS NOT INITIAL.                       "MST20120327

          ls_eintrag-msgty = <ls_bapi>-type.
          ls_eintrag-msgid = <ls_bapi>-id.
          ls_eintrag-msgno = <ls_bapi>-number.

          ls_eintrag-msgv1 = <ls_bapi>-message_v1.
          ls_eintrag-msgv2 = <ls_bapi>-message_v2.
          ls_eintrag-msgv3 = <ls_bapi>-message_v3.
          ls_eintrag-msgv4 = <ls_bapi>-message_v4.

          CONDENSE ls_eintrag-msgv1.
          CONDENSE ls_eintrag-msgv2.
          CONDENSE ls_eintrag-msgv3.
          CONDENSE ls_eintrag-msgv4.


        ELSEIF <ls_bapi>-message IS NOT INITIAL.              "MST20120327

*   // &&&&
          ls_eintrag-msgid = mc_msgid.
          ls_eintrag-msgty = i_msgty.
          ls_eintrag-msgno = '000'.

          ls_msgv1234 = <ls_bapi>-message.
          ls_eintrag-msgv1 = ls_msgv1234-msgv1.
          ls_eintrag-msgv2 = ls_msgv1234-msgv2.
          ls_eintrag-msgv3 = ls_msgv1234-msgv3.
          ls_eintrag-msgv4 = ls_msgv1234-msgv4.

        ELSE.
          CONTINUE.
        ENDIF.

* save log
        me->save_msg_int(
          is_bal_msg           = ls_eintrag
          i_set_syst           = i_set_syst
          i_set_usrmsg         = i_set_usrmsg
          i_istech             = i_istech
          i_timestamp          = l_timestamp
          is_context           = is_context ).

      ENDLOOP.
    ENDIF.


* log batch input table
    IF lines( it_bdc_list ) > 0.

      LOOP AT it_bdc_list ASSIGNING <ls_bdc>.

        IF <ls_bdc>-msgid IS INITIAL.                        "MST20120327
          CONTINUE.
        ENDIF.

        CLEAR: ls_eintrag.
        ls_eintrag-context = is_context.
        ls_eintrag-probclass = i_protlvl.
        ls_eintrag-time_stmp = l_timestamp.

        ls_eintrag-msgty = <ls_bdc>-msgtyp.
        ls_eintrag-msgid = <ls_bdc>-msgid.
        ls_eintrag-msgno = <ls_bdc>-msgnr.

        ls_eintrag-msgv1 = <ls_bdc>-msgv1.
        ls_eintrag-msgv2 = <ls_bdc>-msgv2.
        ls_eintrag-msgv3 = <ls_bdc>-msgv3.
        ls_eintrag-msgv4 = <ls_bdc>-msgv4.

        CONDENSE ls_eintrag-msgv1.
        CONDENSE ls_eintrag-msgv2.
        CONDENSE ls_eintrag-msgv3.
        CONDENSE ls_eintrag-msgv4.

* save log
        me->save_msg_int(
          is_bal_msg           = ls_eintrag
          i_set_syst           = i_set_syst
          i_set_usrmsg         = i_set_usrmsg
          i_istech             = i_istech
          i_timestamp          = l_timestamp
          is_context           = is_context ).


      ENDLOOP.

    ENDIF.

* add import messages
    IF io_log IS BOUND.

      CHECK:
        io_log <> me.

      CALL METHOD io_log->get_messages
        IMPORTING
          et_messages_bal_s_msg = lt_messages
*         et_messages_bapiret2  =
        .

      APPEND LINES OF lt_messages TO  me->mt_logs.

    ENDIF.

  ENDMETHOD.


  METHOD remove_balid.

    DELETE mt_balids WHERE table_line = i_balid.
    IF sy-subrc = 0.
      e_removed = abap_true.
    ELSE.
*   No error-handling in this case!
      e_removed = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD save_msg_int.

    DATA: ls_bal_msg  TYPE         bal_s_msg,

          ls_contdata TYPE         bal_s_cont.

    ls_bal_msg = is_bal_msg.

* msgtype is obligatory; when space => set to 'status'
    IF ls_bal_msg-msgty IS INITIAL.
      ls_bal_msg-msgty = zswl_cl_log=>mc_msgty_status.
    ENDIF.

* handle context-structure
**********************************************************************

    zswl_cl_log=>get_context_info(
     EXPORTING
       i_context       = is_context
       i_istech        = i_istech
       i_timestamp     = i_timestamp
       i_use_context   = m_use_context "#002
     IMPORTING
       e_context_name  = ls_contdata-tabname
       e_context_value = ls_contdata-value
       ).

    ls_bal_msg-context = ls_contdata.



* finally, add message
**********************************************************************

    APPEND ls_bal_msg TO me->mt_logs.

    IF i_set_syst = abap_true.
      sy-msgid = ls_bal_msg-msgid.
      sy-msgty = ls_bal_msg-msgty.
      sy-msgno = ls_bal_msg-msgno.
      sy-msgv1 = ls_bal_msg-msgv1.
      sy-msgv2 = ls_bal_msg-msgv2.
      sy-msgv3 = ls_bal_msg-msgv3.
      sy-msgv4 = ls_bal_msg-msgv4.

    ENDIF.

    IF i_set_usrmsg = abap_true.
      ms_usrmsg = ls_bal_msg.
    ENDIF.


* notice the last error message!
    IF ls_bal_msg-msgty = mc_msgty_dump    OR
       ls_bal_msg-msgty = mc_msgty_error   OR
       ls_bal_msg-msgty = mc_msgty_abort.
**     ls_bal_msg-msgty = mc_msgty_warning.   #001
      ms_last_error = ls_bal_msg.
    ENDIF.

  ENDMETHOD.


  METHOD set_defaultcontext.

    ms_defaultcontext = is_dcontext.

  ENDMETHOD.


  METHOD set_default_search_values.

    m_default_search_date_from  = i_date_from.
    m_default_search_time_from  = i_time_from.
    m_default_search_date_to    = i_date_to.
    m_default_search_time_to    = i_time_to.
    m_default_search_user       = i_user.

  ENDMETHOD.


  METHOD set_logtimes.

    me->m_aldate = aldate.
    me->m_altime = altime.

  ENDMETHOD.


  METHOD set_messages.

    me->mt_logs = it_messages_bal_s_msg.

  ENDMETHOD.


  METHOD set_syerror.

    CLEAR: sy-msgv1, sy-msgv2, sy-msgv3, sy-msgv4.

    IF i_msgid IS NOT INITIAL.
      sy-msgid = i_msgid.
    ELSE.
      sy-msgid = zswl_cl_log=>mc_msgid.
    ENDIF.

    sy-msgty = zswl_cl_log=>mc_msgty_error.
    sy-msgno = i_msgno.
    sy-msgv1 = i_msgv1.
    sy-msgv2 = i_msgv2.
    sy-msgv3 = i_msgv3.
    sy-msgv4 = i_msgv4.

  ENDMETHOD.


  METHOD start_listen_to_evt_add.

    SET HANDLER me->on_add ACTIVATION abap_true.

    me->m_evt_add_active = abap_true.

  ENDMETHOD.


  METHOD stop_listen_to_evt_add.

    SET HANDLER me->on_add ACTIVATION abap_false.

    me->m_evt_add_active = abap_false.

  ENDMETHOD.


  METHOD transfer_msgv.

    DATA:
      l_timestamp                   TYPE timestampl.

    CLEAR:
      r_msgv.

* build message-variable with given parameter
**********************************************************************

* handle currency
    IF ( i_curr IS NOT INITIAL ).
      WRITE i_msgv TO r_msgv CURRENCY i_curr.
      CONDENSE r_msgv.
      CONCATENATE r_msgv i_curr
             INTO r_msgv
        SEPARATED BY space.

* Wurde eine (Mengen-)Einheit angegeben?
    ELSEIF ( i_unit IS NOT INITIAL ).
      WRITE i_msgv TO r_msgv UNIT i_unit.
      CONDENSE r_msgv.
      CONCATENATE r_msgv i_unit
             INTO r_msgv
        SEPARATED BY space.

* Wurde ein Timestamp angefordert ?
    ELSEIF ( i_writetsmp = abap_true ).
      IF ( i_msgv IS NOT INITIAL ).
        l_timestamp = i_msgv.
      ELSE.
        GET TIME STAMP FIELD l_timestamp.
      ENDIF.
      WRITE l_timestamp TIME ZONE sy-zonlo TO r_msgv.

* Keine Formatierungsoption -> dann einfach Wert übertragen!
    ELSE.
      MOVE i_msgv TO r_msgv.                                "#EC *
    ENDIF.


* formating option
**********************************************************************
    IF i_fmtv = mc_fmtv_s0
      OR i_fmtv = mc_fmtv_s0_c.
      SHIFT r_msgv LEFT DELETING LEADING '0'.
    ENDIF.

    IF i_fmtv = mc_fmtv_c
      OR i_fmtv = mc_fmtv_s0_c.
      CONDENSE r_msgv.
    ENDIF.

  ENDMETHOD.


  METHOD unlock_log_handles.

    DATA:
      l_log_handle    TYPE balloghndl,
      l_lock_argument TYPE progname.

    LOOP AT mt_log_handle_locked INTO l_log_handle.

      l_lock_argument = l_log_handle.
      CONCATENATE mc_lock_argument_prefix
                  l_lock_argument
             INTO l_lock_argument.

      CALL METHOD me->dequeue
        EXPORTING
          i_argument = l_lock_argument.

      DELETE mt_log_handle_locked .

    ENDLOOP.

  ENDMETHOD.


  METHOD write.

    me->write_prepare(
      EXPORTING
        i_balobj                = i_balobj
        i_suffix                = i_suffix
        i_balsubobj             = i_balsubobj
        i_balid                 = i_balid
        i_newlog                = i_newlog
        i_protlvl               = i_protlvl
        i_expire_days           = i_expire_days
        i_write_mode            = i_write_mode
        i_fast                  = abap_false
      EXCEPTIONS
        no_balobj               = 1
        no_subobj               = 2
        no_balid                = 3
        illegal_protlvl         = 4
        error_creating_log      = 5
        inconsistent_parameters = 6
        OTHERS                  = 7 ).

    CASE sy-subrc.
      WHEN '0'.
      WHEN '1'.
        RAISE no_balobj.
      WHEN '2'.
        RAISE no_subobj.
      WHEN '3'.
        RAISE no_balid.
      WHEN '4'.
        RAISE illegal_protlvl.
      WHEN '5'.
        RAISE error_creating_log.
      WHEN OTHERS.
        RAISE inconsistent_parameters.
    ENDCASE.

  ENDMETHOD.


  METHOD write_fast.

* Der Unterschied der write_fast-Methode zur "normalen" write-Methode
* liegt "nur" darin
* - dass nur synchron geschrieben werden kann (Kein Background; kein
*   new Tast, etc.)
* - Der SAP-Standard-Baustein zum endgültigen Schreiben des Logs
*   (BAL_DB_SAVE) wurde in den Z-Namensraum kopiert und vollständig
*   "entschlackt" bzw. optimiert (sämliche MODIFYs eleminiert, ...)
* Diese "Umstruktuierungsmaßnahmen" haben einen Performancegewinn von
* ca. 25% der Laufzeit gebracht!

    DATA:
      l_write_mode                  TYPE zswl_de_writemode.

* Anhand des Commit-Flags wird der Write-Mode festgelegt!
    IF i_commit = abap_true.
      l_write_mode = mc_wm_synchron_commit.
    ELSE.
      l_write_mode = mc_wm_synchron.
    ENDIF.

    me->write_prepare(
      EXPORTING
        i_balobj                = i_balobj
        i_suffix                = i_suffix
        i_balsubobj             = i_balsubobj
        i_balid                 = i_balid
        i_newlog                = abap_true
        i_protlvl               = i_protlvl
        i_expire_days           = i_expire_days
        i_write_mode            = l_write_mode
        i_fast                  = abap_true
      EXCEPTIONS
        no_balobj               = 1
        no_subobj               = 2
        no_balid                = 3
        illegal_protlvl         = 4
        error_creating_log      = 5
        inconsistent_parameters = 6
        OTHERS                  = 7 ).

    CASE sy-subrc.
      WHEN '0'.
      WHEN '1'.
        RAISE no_balobj.
      WHEN '2'.
        RAISE no_subobj.
      WHEN '3'.
        RAISE no_balid.
      WHEN '4'.
        RAISE illegal_protlvl.
      WHEN '5'.
        RAISE error_creating_log.
      WHEN OTHERS.
        RAISE inconsistent_parameters.
    ENDCASE.

  ENDMETHOD.


  METHOD write_prepare.

    DATA: l_balid   TYPE          balhdr-extnumber,
          l_suffix  TYPE          zswl_de_balobjsuffix,

          lt_balids TYPE          zswl_tt_balid,
          lt_logs   TYPE          zswl_tt_bal_msg,
          l_aldate  TYPE          baldate,
          l_altime  TYPE          baltime,

          lv_msgty  LIKE          sy-msgty,
          lv_msgid  LIKE          sy-msgid,
          lv_msgno  LIKE          sy-msgno,
          lv_msgv1  LIKE          sy-msgv1,
          lv_msgv2  LIKE          sy-msgv2,
          lv_msgv3  LIKE          sy-msgv3,
          lv_msgv4  LIKE          sy-msgv4.

* SY-Werte sichern
**********************************************************************
    lv_msgty = sy-msgty.
    lv_msgid = sy-msgid.
    lv_msgno = sy-msgno.
    lv_msgv1 = sy-msgv1.
    lv_msgv2 = sy-msgv2.
    lv_msgv3 = sy-msgv3.
    lv_msgv4 = sy-msgv4.

* parameter-check
**********************************************************************

* when no new log should be createt, a immediate commit is required!
    IF i_newlog = abap_false AND
       i_write_mode = mc_wm_synchron.

*   inconsistent parameters
      zswl_cl_log=>set_syerror( i_msgno = '018' ).
      RAISE inconsistent_parameters.
    ENDIF.

    IF ( i_balobj IS INITIAL ).

*   No bal-object given
      zswl_cl_log=>set_syerror( i_msgno = '005' ).
      RAISE no_balobj.
    ENDIF.

    IF ( i_balsubobj IS INITIAL ).
*   No bal-subobject given
      zswl_cl_log=>set_syerror( i_msgno = '006' ).
      RAISE no_subobj.
    ENDIF.

    IF (     i_protlvl <> mc_protlvl_very_important
         AND i_protlvl <> mc_protlvl_important
         AND i_protlvl <> mc_protlvl_middle
         AND i_protlvl <> mc_protlvl_information
         AND i_protlvl <> mc_protlvl_status
      ).

*   Illegal protocol-level
      zswl_cl_log=>set_syerror( i_msgno = '011' ).
      RAISE illegal_protlvl.

    ENDIF.

* handle new balid
**********************************************************************
    IF i_balid IS SUPPLIED
      AND i_balid IS NOT INITIAL.

      MOVE i_balid TO l_balid.

      CALL METHOD me->add_balid
        EXPORTING
          i_balid = l_balid
*     IMPORTING
*         e_added =
        .
    ENDIF.

    IF lines( me->mt_balids ) = 0.
*   No bal-ID available
      zswl_cl_log=>set_syerror( i_msgno = '012' ).
      RAISE no_balid.
    ENDIF.

* filter for protlvl
**********************************************************************
    CALL METHOD me->filter
      EXPORTING
        i_balobj    = i_balobj
        i_suffix    = i_suffix
        i_balsubobj = i_balsubobj
        i_protlvl   = i_protlvl.

    IF me->get_message_available( ) = abap_false.
*   Exit -> no log available
      RETURN.
    ENDIF.


* trigger writing log
**********************************************************************
    l_suffix = i_suffix.

    IF i_write_mode = mc_wm_background
      OR i_write_mode = mc_wm_background_commit.

**********************************************************************
*   BACKGROUND
**********************************************************************

      lt_balids[] = me->mt_balids[].
      lt_logs[]   = me->mt_logs[].
      l_aldate    = me->m_aldate.
      l_altime    = me->m_altime.

      CALL FUNCTION 'Z_SWL_LOG_WRITE' IN BACKGROUND TASK
        EXPORTING
          i_balobj              = i_balobj
          i_suffix              = l_suffix
          i_balsubobj           = i_balsubobj
          it_balid              = lt_balids
          i_newlog              = i_newlog
          i_protlvl             = i_protlvl
          it_messages_bal_s_msg = lt_logs
          i_aldate              = l_aldate
          i_altime              = l_altime
          i_expire_days         = i_expire_days.


    ELSEIF i_write_mode = mc_wm_new_task.

**********************************************************************
*   NEW TASK
**********************************************************************

      lt_balids[] = me->mt_balids[].
      lt_logs[]   = me->mt_logs[].
      l_aldate    = me->m_aldate.
      l_altime    = me->m_altime.

      CALL FUNCTION 'Z_SWL_LOG_WRITE' STARTING NEW TASK 'log'
        EXPORTING
          i_balobj              = i_balobj
          i_suffix              = l_suffix
          i_balsubobj           = i_balsubobj
          it_balid              = lt_balids
          i_newlog              = i_newlog
          i_protlvl             = i_protlvl
          it_messages_bal_s_msg = lt_logs
          i_aldate              = l_aldate
          i_altime              = l_altime
          i_expire_days         = i_expire_days.

    ELSEIF i_write_mode = mc_wm_synchron
      OR i_write_mode = mc_wm_synchron_commit.

**********************************************************************
*   DIRECTLY
**********************************************************************

      LOOP AT me->mt_balids INTO l_balid.

        CALL METHOD me->write_single_balid
          EXPORTING
            i_balobj      = i_balobj
            i_suffix      = i_suffix
            i_balsubobj   = i_balsubobj
            i_balid       = l_balid
            i_newlog      = i_newlog
            i_expire_days = i_expire_days
            i_fast        = i_fast.

      ENDLOOP.

    ENDIF.


    IF i_write_mode = mc_wm_background_commit
      OR i_write_mode = mc_wm_synchron_commit.

*   COMMIT WORK AND WAIT.                                         "#001
      COMMIT WORK.                                                  "#001

*   unlock all log handles
      me->unlock_log_handles( ).

    ENDIF.

* SY-Werte wiederherstellen
**********************************************************************
    sy-msgty = lv_msgty.
    sy-msgid = lv_msgid.
    sy-msgno = lv_msgno.
    sy-msgv1 = lv_msgv1.
    sy-msgv2 = lv_msgv2.
    sy-msgv3 = lv_msgv3.
    sy-msgv4 = lv_msgv4.

  ENDMETHOD.


  METHOD write_single_balid.

    DATA: l_balobj      LIKE     i_balobj,
          l_log_handle  TYPE     balloghndl,

          ls_loghdr     TYPE     bal_s_log,
          lt_bal_t_logh TYPE     bal_t_logh.

    IF lines( me->mt_logs ) > 0.

* build balobj
**********************************************************************
      l_balobj = me->create_balobj(
        i_balobj = i_balobj
        i_suffix = i_suffix ).

* when no new log should be created, we try to get a existing log
* handle from the database!
      IF i_newlog <> abap_true.

        l_log_handle = me->get_log_handle_to_append(
                            i_balobj            = l_balobj
                            i_balsubobj         = i_balsubobj
                            i_balid             = i_balid ).
      ENDIF.

* build new log-handle
**********************************************************************
      IF l_log_handle IS INITIAL.

        ls_loghdr-aluser     = sy-uname.
        ls_loghdr-alprog     = sy-repid.
        ls_loghdr-object     = l_balobj.
        ls_loghdr-subobject  = i_balsubobj.
        ls_loghdr-extnumber  = i_balid.
        ls_loghdr-aldate     = me->m_aldate.
        ls_loghdr-altime     = me->m_altime.
        ls_loghdr-aldate_del = sy-datum + i_expire_days.
        ls_loghdr-del_before = abap_false.

        CALL FUNCTION 'BAL_LOG_CREATE'
          EXPORTING
            i_s_log                 = ls_loghdr
          IMPORTING
            e_log_handle            = l_log_handle
          EXCEPTIONS
            log_header_inconsistent = 1
            OTHERS                  = 2.

        IF ( sy-subrc <> 0 ).
*       Error creating log-header
          ASSERT 1 = 0.
        ENDIF.

      ENDIF.

      APPEND l_log_handle TO lt_bal_t_logh.

      me->add_log_to_log_handle(
        EXPORTING
          i_log_handle  = l_log_handle
        EXCEPTIONS
          error_occured = 1
          OTHERS        = 2
             ).
      IF sy-subrc <> 0.
        ASSERT 1 = 0.
      ENDIF.

* finally, write to batabase!!!
**********************************************************************
      TRY.

          IF i_fast = abap_false.   "#001

            CALL FUNCTION 'BAL_DB_SAVE'
              EXPORTING
                i_client         = sy-mandt
                i_in_update_task = abap_false
                i_save_all       = abap_false
                i_t_log_handle   = lt_bal_t_logh
              EXCEPTIONS
                log_not_found    = 1
                save_not_allowed = 2
                numbering_error  = 3
                OTHERS           = 4.

            IF ( sy-subrc <> 0 ).
              ASSERT 1 = 0.
            ENDIF.

          ELSE.

            CALL FUNCTION 'Z_SCEBLO_BAL_DB_SAVE'
              EXPORTING
                i_t_log_handle   = lt_bal_t_logh
              EXCEPTIONS
                log_not_found    = 1
                save_not_allowed = 2
                numbering_error  = 3
                OTHERS           = 4.

            IF ( sy-subrc <> 0 ).
              ASSERT 1 = 0.
            ENDIF.

          ENDIF.

*       clear logging-memory
          LOOP AT lt_bal_t_logh INTO l_log_handle.

            CALL FUNCTION 'BAL_LOG_REFRESH'
              EXPORTING
                i_log_handle  = l_log_handle
              EXCEPTIONS
                log_not_found = 1
                OTHERS        = 2.
            IF sy-subrc <> 0.
*           no problem, when error occured
              CLEAR sy-subrc.
            ENDIF.

          ENDLOOP.

        CATCH cx_root.                                   "#EC CATCH_ALL
          ASSERT 1 = 0.
      ENDTRY.

      me->mt_log_handle[] = lt_bal_t_logh[].

    ENDIF.

  ENDMETHOD.
ENDCLASS.
