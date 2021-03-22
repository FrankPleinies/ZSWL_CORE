class ZSWL_CL_STORAGE_BIN definition
  public
  inheriting from ZSWL_CL_OBJECT
  final
  create public .

public section.
  type-pools ABAP .

  interfaces ZIF_SWLBC_OBJECT .

  class-methods GET_REFERENCE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_LGPLA type /SCWM/DE_LGPLA
      !I_DB type XFELD default ABAP_FALSE
      !I_SEL_LAGPS type ABAP_BOOL default ABAP_FALSE
      !I_SEL_STATUS type ABAP_BOOL default ABAP_FALSE
    exporting
      !EO_BIN type ref to ZSWL_CL_STORAGE_BIN
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_STORAGE_BINS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !IT_LGBER type /SCWM/TT_LGBER optional
      !IT_LPTYP type /SCWM/TT_LPTYP optional
      !I_EMPTY type /SCWM/LAGP_KZLER optional
      !I_PUTAWAY_BLOCKED type /SCWM/LAGP_SKZUE optional
      !I_PICK_BLOCKED type /SCWM/LAGP_SKZUA optional
      !I_INVENT_BLOCKED type /SCWM/LAGP_SKZSI optional
      !I_BUILD_OBJECTS type XFELD default ABAP_TRUE
    exporting
      !ET_BINS type ZSWL_TT_STORAGE_BIN_REF
      !ET_LAGP type /SCWM/TT_LAGP
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods BLOCK_INVENT_BIN
    importing
      !I_BLOCK type /SCWM/LAGP_SKZSI
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods BLOCK_PICK_BIN
    importing
      !I_BLOCK type /SCWM/LAGP_SKZUA
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods BLOCK_PUTAWAY_BIN
    importing
      !I_BLOCK type /SCWM/LAGP_SKZUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_LGPLA type /SCWM/DE_LGPLA optional
      !IS_LAGP type /SCWM/LAGP optional
      !I_SEL_LAGPS type ABAP_BOOL default ABAP_FALSE
      !I_SEL_STATUS type ABAP_BOOL default ABAP_FALSE
      !I_STSMA type CRM_J_STSMA optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_GUID
    returning
      value(R_GUID) type /LIME/GUID_LOC .
  methods GET_HUS_ON_BIN
    importing
      !IV_SORT_BY_NEWEST type BOOLEAN default ABAP_TRUE
    returning
      value(RT_HU_OBJECTS) type ZSWL_TT_HU_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_HUS_ON_BIN_MULTI
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_LGPLA type /SCWM/TT_LGPLA
    exporting
      value(ET_HU_OBJECTS) type ZSWL_TT_HU_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_LAGP
    returning
      value(RS_LAGP) type /SCWM/LAGP .
  methods GET_LAGPS
    importing
      !I_ACTIVITY type /SCWM/DE_ACTTY optional
    returning
      value(RT_LAGPS) type /SCWM/TT_LAGPS
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_LGBER
    returning
      value(R_LGBER) type /SCWM/DE_LGBER .
  methods GET_LGPLA
    returning
      value(R_LGPLA) type /SCWM/DE_LGPLA .
  methods GET_LGTYP
    returning
      value(R_LGTYP) type /SCWM/DE_LGTYP .
  methods GET_USER_STATE
    importing
      !I_STSMA type CRM_J_STSMA
    returning
      value(R_USER_STATE) type J_ATEXT .
  methods IS_ACTIVE_USER_STATE
    returning
      value(R_IS_ACTIVE) type XFELD .
  methods RESET_USER_STATE
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_USER_STATE type J_TXT04
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_USER_STATE
    importing
      !I_USER_STATE type J_TXT04
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods IS_BLOCKED_BY_INVENT
    returning
      value(R_BLOCKED) type /SCWM/LAGP_SKZSI .
protected section.

  data MS_LAGP type /SCWM/LAGP .
  data MT_LAGPS type /SCWM/TT_LAGPS .
  data MT_STATUS type ZSWL_TT_CRM_JEST .
  data M_USER_STATE_ACTIVE type XFELD .

  methods CHECK_STATUS_MODE
    importing
      !I_STSMA type CRM_J_STSMA
    returning
      value(R_IS_ACTIVE) type XFELD
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods READ_STATUS_RECORDS
    importing
      !I_GUID_LOC type /SCWM/GUID_LOC
    returning
      value(RT_STATUS) type ZSWL_TT_CRM_JEST
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_LAGPS
    importing
      !I_LGPLA type /SCWM/LGPLA
    returning
      value(RT_LAGPS) type /SCWM/TT_LAGPS
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_SINGLE_LAGP
    importing
      !I_LGPLA type /SCWM/LGPLA
    returning
      value(RS_LAGP) type /SCWM/LAGP
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  class-data ST_STORAGE_BIN_REF type ZSWL_TT_STORAGE_BIN_REF .

  methods CHANGE_USER_STATE
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_USER_STATE type J_TXT04
      !I_SET_INACTIVE type XFELD
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_STAT_FOR_STSMA
    importing
      !I_STSMA type J_STSMA
    returning
      value(RT_STAT) type BU_TJ30T_T .
ENDCLASS.



CLASS ZSWL_CL_STORAGE_BIN IMPLEMENTATION.


METHOD block_invent_bin.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Block the storage bin for inventory
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF i_block = abap_true.

*     Log message
      MESSAGE i016
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSE.

*     Log message
      MESSAGE i017
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

*   Block/Unblock the storage bin
    CALL FUNCTION '/SCWM/BIN_BLOCK_INT'
      EXPORTING
        iv_lgnum    = m_lgnum
        iv_lgpla    = ms_lagp-lgpla
*       IV_GUID_LOC =
*       iv_skzua    =
        iv_skzue    = i_block
*       IV_SKZSI    =
        iv_commit   = abap_false
      EXCEPTIONS
        wrong_input = 1
        not_locked  = 2
        OTHERS      = 3.

    IF sy-subrc <> 0.

      IF i_commit = abap_true.
        mo_log->add( i_syst = abap_true ).

*       Error while setting the block status on storage bin
        MESSAGE e018
           WITH ms_lagp-lgpla
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

        me->rollback( ).

        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD block_pick_bin.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Block the storage bin for picking
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF i_block = abap_true.

*     Log message
      MESSAGE i019
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSE.

      MESSAGE i020
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

*   Block/Unblock the storage bin for picking
    CALL FUNCTION '/SCWM/BIN_BLOCK_INT'
      EXPORTING
        iv_lgnum    = m_lgnum
        iv_lgpla    = ms_lagp-lgpla
*       IV_GUID_LOC =
        iv_skzua    = i_block
*       iv_skzue    =
*       IV_SKZSI    =
        iv_commit   = abap_false
      EXCEPTIONS
        wrong_input = 1
        not_locked  = 2
        OTHERS      = 3.

    IF sy-subrc <> 0.

      IF i_commit = abap_true.
        mo_log->add( i_syst = abap_true ).

        MESSAGE e021
           WITH ms_lagp-lgpla
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

        me->rollback( ).

        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD block_putaway_bin.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Block the storage bin for putaway
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF i_block = abap_true.

*     Log message
      MESSAGE i022
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSE.

*    Log message
      MESSAGE i023
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

*   Block/Unblock the storage bin for putaway
    CALL FUNCTION '/SCWM/BIN_BLOCK_INT'
      EXPORTING
        iv_lgnum    = m_lgnum
        iv_lgpla    = ms_lagp-lgpla
*       IV_GUID_LOC =
*       iv_skzua    =
        iv_skzue    = i_block
*       IV_SKZSI    =
        iv_commit   = abap_false
      EXCEPTIONS
        wrong_input = 1
        not_locked  = 2
        OTHERS      = 3.

    IF sy-subrc <> 0.

      IF i_commit = abap_true.
        mo_log->add( i_syst = abap_true ).

        MESSAGE e024
           WITH ms_lagp-lgpla
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

        me->rollback( ).

        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD change_user_state.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Change the user status.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_tj30t TYPE tj30t,
      l_objnr  TYPE crm_jsto-objnr.


* Check incoming parameter
    IF i_user_state IS INITIAL.
      MESSAGE e011
          INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.


    SELECT SINGLE *
      FROM tj30t
      INTO ls_tj30t
     WHERE spras = sy-langu
       AND txt04 = i_user_state.
    IF sy-subrc <> 0.
      MESSAGE e012 WITH i_user_state
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst      = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

* First refresh all
    CALL FUNCTION '/SCWM/BIN_STATUS_REFRESH'.

    CALL FUNCTION 'CRM_STATUS_BUFFER_REFRESH'.

* Fill buffer
    l_objnr = ms_lagp-guid_loc.

    CALL FUNCTION '/SCWM/BIN_STAT_BUFFER_FILL'
      EXPORTING
        iv_guid_loc = l_objnr
      EXCEPTIONS
        error       = 1
        OTHERS      = 2.

    IF sy-subrc <> 0.
      MESSAGE e013
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst  = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

* Delete user status
    CALL FUNCTION 'CRM_STATUS_CHANGE_EXTERN'
      EXPORTING
        objnr               = l_objnr
        user_status         = ls_tj30t-estat
        set_inact           = i_set_inactive
        no_check            = abap_true
*   IMPORTING
*       STONR               =
      EXCEPTIONS
        object_not_found    = 1
        status_inconsistent = 2
        status_not_allowed  = 3
*       error_message       = zif_ewmbbc_constants=>mc_error_message
        OTHERS              = 4.
    IF sy-subrc <> 0.

      mo_log->add( i_syst = abap_true ).

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

      CALL FUNCTION '/SCWM/BIN_STATUS_SAVE'.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD check_status_mode.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return if the user state is active or inactive
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      lt_alert_stat TYPE crmt_jest_buf_tab,
      lt_stat       TYPE bu_tj30t_t,
      l_objnr       TYPE crm_jsto-objnr.


    FIELD-SYMBOLS:
      <ls_alert_stat> TYPE crmt_jest_buf.
* End declarations
**********************************************************************

    r_is_active = abap_false.


* First refresh all
    CALL FUNCTION '/SCWM/BIN_STATUS_REFRESH'.

    CALL FUNCTION 'CRM_STATUS_BUFFER_REFRESH'.

* Fill buffer
    l_objnr = ms_lagp-guid_loc.

    CALL FUNCTION '/SCWM/BIN_STAT_BUFFER_FILL'
      EXPORTING
        iv_guid_loc = l_objnr
      EXCEPTIONS
        error       = 1
        OTHERS      = 2.

    IF sy-subrc <> 0.
      MESSAGE e013
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst  = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

* Determine all user states of the storage bin
    CALL FUNCTION 'CRM_STATUS_READ'
      EXPORTING
        client           = sy-mandt
        objnr            = l_objnr
*       only_active      = abap_true
      IMPORTING
*       OBTYP            =
*       STSMA            =
*       STONR            =
        et_jest_buf      = lt_alert_stat
*   TABLES
*       STATUS           =
      EXCEPTIONS
        object_not_found = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
      clear lt_alert_stat.
    ENDIF.

* Determine all errors for the given scheme
    lt_stat = me->select_stat_for_stsma( i_stsma = i_stsma ).

* Check, if an active user state exist.
    LOOP AT lt_alert_stat ASSIGNING <ls_alert_stat> WHERE stsma = i_stsma.

      READ TABLE lt_stat WITH KEY stsma = i_stsma
                                  estat = <ls_alert_stat>-stat
                                  TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.

*     IF we found an acitve user status the whole status is active
        IF <ls_alert_stat>-inact = abap_true.
          r_is_active = abap_false.

        ENDIF.

        IF <ls_alert_stat>-inact = abap_false.
          r_is_active = abap_true.
          EXIT.

        ENDIF.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


METHOD constructor.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Constructor
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    super->constructor(
      EXPORTING
        i_lgnum     = i_lgnum
        io_log      = io_log ).

    IF i_lgpla IS INITIAL AND
       is_lagp IS INITIAL.

*     No storage bin given
      MESSAGE e028
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF i_lgpla IS NOT INITIAL.
      ms_lagp = me->select_single_lagp( i_lgpla = i_lgpla ).
    ELSEIF is_lagp IS NOT INITIAL.
      ms_lagp = is_lagp.
    ENDIF.

*   Select activities/areas for the storage bin
    IF i_sel_lagps = abap_true.
      mt_lagps = me->select_lagps( i_lgpla = i_lgpla ).
    ENDIF.

*   Select attributes for storage bin status
    IF i_sel_status = abap_true.
      mt_status = me->read_status_records(
        i_guid_loc = ms_lagp-guid_loc ).

      IF i_stsma IS NOT INITIAL.
        m_user_state_active = me->check_status_mode(
                                       i_stsma = i_stsma ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


METHOD get_guid.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the GUID of the actual storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_guid = ms_lagp-guid_loc.

  ENDMETHOD.


METHOD get_hus_on_bin.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all HU's on the actual storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      lrt_lgpla      TYPE rseloption,
      lrt_vhi        TYPE rseloption,
      ls_lgpla_range LIKE LINE OF lrt_lgpla,
      ls_vhi_range   LIKE LINE OF lrt_vhi,
      lt_huhdr       TYPE /scwm/tt_huhdr_int,
      lt_huitm       TYPE /scwm/tt_huitm_int,
      lt_huref       TYPE /scwm/tt_huref_int,
      lt_hutree      TYPE /scwm/tt_hutree.

* End declarations
**********************************************************************

    ls_lgpla_range-low    = ms_lagp-lgpla.
    ls_lgpla_range-sign   = wmegc_sign_inclusive.
    ls_lgpla_range-option = wmegc_option_eq.
    APPEND ls_lgpla_range TO lrt_lgpla.

    ls_vhi_range-low    = wmegc_vhi_real.
    ls_vhi_range-sign   = wmegc_sign_inclusive.
    ls_vhi_range-option = wmegc_option_eq.
    APPEND ls_vhi_range TO lrt_vhi.

    CALL FUNCTION '/SCWM/HU_SELECT_GEN'
      EXPORTING
        iv_lgnum     = m_lgnum
        ir_lgpla     = lrt_lgpla
        ir_vhi       = lrt_vhi
      IMPORTING
*       ET_BAPIRET   =
        et_huhdr     = lt_huhdr
        et_huitm     = lt_huitm
        et_huref     = lt_huref
        et_hutree    = lt_hutree
      EXCEPTIONS
        wrong_input  = 1
        not_possible = 2
        error        = 3
        OTHERS       = 4.

    IF sy-subrc <> 0.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

    IF iv_sort_by_newest = abap_true.
      SORT lt_huhdr BY changed_at DESCENDING.
    ENDIF.

    CALL METHOD zswl_cl_hu=>build_objects
      EXPORTING
        i_lgnum   = m_lgnum
        it_huhdr  = lt_huhdr
        it_huitm  = lt_huitm
        it_huref  = lt_huref
        it_hutree = lt_hutree
      IMPORTING
        et_hu_ref = rt_hu_objects
      CHANGING
        co_log    = mo_log.

  ENDMETHOD.


METHOD get_hus_on_bin_multi.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all HU's for the incoming storage bins
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA:
      lrt_lgpla      TYPE rseloption,
      lrt_vhi        TYPE rseloption,
      ls_lgpla_range LIKE LINE OF lrt_lgpla,
      ls_vhi_range   LIKE LINE OF lrt_vhi,
      lt_huhdr       TYPE /scwm/tt_huhdr_int,
      lt_huitm       TYPE /scwm/tt_huitm_int,
      lt_huref       TYPE /scwm/tt_huref_int,
      lt_hutree      TYPE /scwm/tt_hutree.

    FIELD-SYMBOLS:
      <l_lgpla>                   TYPE /scwm/lgpla.
* End declarations
**********************************************************************

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.

    ENDIF.

    IF i_lgnum IS INITIAL.
*   No warehouse no. were given
      MESSAGE e026(zswl_ca)
        INTO zswl_cl_log=>m_dummy_msg.

      co_log->add( i_syst = abap_true ).
    ENDIF.

    IF lines( it_lgpla ) = 0.
      RETURN.
    ENDIF.

    LOOP AT it_lgpla ASSIGNING <l_lgpla>.
      ls_lgpla_range-low    = <l_lgpla>.
      ls_lgpla_range-sign   = wmegc_sign_inclusive.
      ls_lgpla_range-option = wmegc_option_eq.
      APPEND ls_lgpla_range TO lrt_lgpla.
    ENDLOOP.

    ls_vhi_range-low    = wmegc_vhi_real.
    ls_vhi_range-sign   = wmegc_sign_inclusive.
    ls_vhi_range-option = wmegc_option_eq.
    APPEND ls_vhi_range TO lrt_vhi.

    CALL FUNCTION '/SCWM/HU_SELECT_GEN'
      EXPORTING
        iv_lgnum     = i_lgnum
        ir_lgpla     = lrt_lgpla
        ir_vhi       = lrt_vhi
      IMPORTING
*       ET_BAPIRET   =
        et_huhdr     = lt_huhdr
        et_huitm     = lt_huitm
        et_huref     = lt_huref
        et_hutree    = lt_hutree
      EXCEPTIONS
        wrong_input  = 1
        not_possible = 2
        error        = 3
        OTHERS       = 4.

    IF sy-subrc <> 0.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

    CALL METHOD zswl_cl_hu=>build_objects
      EXPORTING
        i_lgnum   = i_lgnum
        it_huhdr  = lt_huhdr
        it_huitm  = lt_huitm
        it_huref  = lt_huref
        it_hutree = lt_hutree
      IMPORTING
        et_hu_ref = et_hu_objects
      CHANGING
        co_log    = co_log.

  ENDMETHOD.


METHOD get_lagp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the header data for the acutal storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rs_lagp = ms_lagp.

  ENDMETHOD.


METHOD get_lagps.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all related storage bins for the acutal
*               storage bin where are linked to an activity.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    FIELD-SYMBOLS:
      <ls_lagps>                TYPE /scwm/lagps.

    CLEAR rt_lagps[].

    IF lines( mt_lagps ) = 0.
      mt_lagps = me->select_lagps( i_lgpla = ms_lagp-lgpla ).
    ENDIF.

    IF i_activity IS NOT INITIAL.
      LOOP AT mt_lagps ASSIGNING <ls_lagps>
        WHERE act_type = i_activity.
        APPEND <ls_lagps> TO rt_lagps.
      ENDLOOP.
    ELSE.
      rt_lagps[] = mt_lagps[].
    ENDIF.

  ENDMETHOD.


METHOD get_lgber.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the area for the actual storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_lgber = ms_lagp-lgber.

  ENDMETHOD.


METHOD get_lgpla.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the storage bin no. from the actual storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_lgpla = ms_lagp-lgpla.

  ENDMETHOD.


METHOD get_lgtyp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the storage typ from the acutal bin.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_lgtyp = ms_lagp-lgtyp.

  ENDMETHOD.


METHOD get_reference.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Create and return an instance of this class for the
*               incoming parameter.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_storage_bin>          TYPE zswl_s_storage_bin_ref.

    DATA:
      ls_bin_ref                TYPE zswl_s_storage_bin_ref.
* End declarations
**********************************************************************

    CLEAR eo_bin.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     No warehouse no. were given
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF i_lgpla IS INITIAL.

*     No storage bin were given
      MESSAGE e014
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF i_db = abap_false.

      READ TABLE st_storage_bin_ref ASSIGNING <ls_storage_bin>
        WITH KEY lgnum = i_lgnum
                 lgpla = i_lgpla.

      IF sy-subrc = 0.

        IF <ls_storage_bin>-o_bin IS BOUND.

          eo_bin = <ls_storage_bin>-o_bin.
          RETURN.

        ENDIF.

      ENDIF.

    ENDIF.

    CREATE OBJECT eo_bin
      EXPORTING
        i_lgnum      = i_lgnum
        i_lgpla      = i_lgpla
*       is_lagp      =
        io_log       = co_log
        i_sel_lagps  = i_sel_lagps
        i_sel_status = i_sel_status.

    CLEAR ls_bin_ref.
    ls_bin_ref-lgnum = i_lgnum.
    ls_bin_ref-lgpla = eo_bin->get_lgpla( ).
    ls_bin_ref-o_bin = eo_bin.
    APPEND ls_bin_ref TO st_storage_bin_ref.

  ENDMETHOD.


METHOD get_user_state.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the user state for the incoming parameters.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA:
      lt_stat      TYPE bu_tj30t_t,
*      l_error      TYPE j_txt04,
      l_user_state TYPE j_atext.

    FIELD-SYMBOLS:
      <ls_status> TYPE crm_jest,
      <ls_stat>   TYPE tj30t.
* End declarations
**********************************************************************

    CLEAR: r_user_state.

* Determine all errors
    lt_stat = me->select_stat_for_stsma( i_stsma = i_stsma ).

    LOOP AT mt_status ASSIGNING <ls_status> WHERE inact = abap_false.

      READ TABLE lt_stat ASSIGNING <ls_stat>
        WITH KEY stsma = i_stsma
                    estat = <ls_status>-stat.
      IF sy-subrc = 0.
        IF l_user_state IS INITIAL.
          l_user_state = <ls_stat>-txt04.

        ELSE.
          CONCATENATE l_user_state <ls_stat>-txt04
          INTO l_user_state
          SEPARATED BY space.

        ENDIF.

      ENDIF.

    ENDLOOP.

    r_user_state = l_user_state.

  ENDMETHOD.


METHOD is_active_user_state.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the user state
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_is_active = m_user_state_active.

  ENDMETHOD.


METHOD is_blocked_by_invent.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return if the actual storage bin is blocked by inventory
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************


    r_blocked = ms_lagp-skzsi.

  ENDMETHOD.


METHOD read_status_records.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all status
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_objnr TYPE /scwm/s_guid_loc,
      lt_objnr TYPE /scwm/tt_guid_loc,
      lt_stat  TYPE STANDARD TABLE OF crm_jest.

    CLEAR ls_objnr.
    ls_objnr-guid_loc = i_guid_loc.
    APPEND ls_objnr TO lt_objnr.

*   refresh buffer data
    CALL FUNCTION '/SCWM/BIN_STATUS_REFRESH'.
    CALL FUNCTION 'CRM_STATUS_BUFFER_REFRESH'.

*   fill status management buffer
    CALL FUNCTION '/SCWM/BIN_STAT_BUFFER_FILL'
      EXPORTING
        it_guid_loc = lt_objnr
      EXCEPTIONS
        error       = 1
        OTHERS      = 2.

    IF sy-subrc <> 0.

      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   read status of the storage bin
    CALL FUNCTION 'CRM_STATUS_READ_MULTI'
      EXPORTING
        client    = sy-mandt
*       ONLY_ACTIVE          = ' '
*       ALL_IN_BUFFER        = ' '
*       GET_CHANGE_DOCUMENTS = ' '
*       NO_BUFFER_FILL       = ' '
      TABLES
        objnr_tab = lt_objnr
        status    = lt_stat
*       jsto_tab  =
*       jcdo_tab  =
*       jcds_tab  =
      .

    IF lines( lt_stat ) = 0.

      MESSAGE e027
         WITH ms_lagp-lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    rt_status = lt_stat.

  ENDMETHOD.


METHOD read_storage_bins.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all storage bins for the incoming parameter.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    FIELD-SYMBOLS:
      <ls_lagp>      TYPE /scwm/lagp,
      <l_lgtyp>      TYPE /scwm/lgtyp,
      <l_lgber>      TYPE /scwm/lgber,
      <l_lgpla>      TYPE /scwm/lgpla,
      <l_lptyp>      TYPE /scwm/lvs_lptyp.

    DATA:
      ls_lagp_ref TYPE zswl_s_storage_bin_ref,
      lt_lagp     TYPE /scwm/tt_lagp.

*   Structures for Range-Tables
    DATA:
      lrs_lgpla TYPE /scwm/s_lgpla_r,
      lrs_lgtyp TYPE /scwm/s_lgtyp_r,
      lrs_lptyp TYPE /scwm/s_lptyp_r,
      lrs_lgber TYPE /scwm/s_lgber_r.
*      lrs_aisle TYPE /scwm/s_aisle_r,
*      lrs_stack TYPE /scwm/s_stack_r,
*      lrs_level TYPE /scwm/s_level_r,
*      lrs_empty TYPE rsdsselopt,
*      lrs_skzue TYPE rsdsselopt,
*      lrs_skzua TYPE rsdsselopt,
*      lrs_skzsi TYPE rsdsselopt.

*   Range-Tables
    DATA:
      lrt_lgpla      TYPE /scwm/tt_lgpla_r,
      lrt_lgtyp      TYPE /scwm/tt_lgtyp_r,
      lrt_lptyp      TYPE /scwm/tt_lptyp_r,
      lrt_lgber      TYPE /scwm/tt_lgber_r,
      lrt_aisle      TYPE /scwm/tt_aisle_r,
      lrt_stack      TYPE /scwm/tt_stack_r,
      lrt_level      TYPE /scwm/tt_level_r,
      lrt_lgber_lgst TYPE RANGE OF /scwm/de_lgber_lgst.
* End declarations
**********************************************************************

    CLEAR: et_bins[],
           et_lagp[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     No warehouse no. were given
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Build Range-Tables with incoming parameters
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   for storage bin
    LOOP AT it_lgpla ASSIGNING <l_lgpla>.

      IF <l_lgpla> IS INITIAL.
        CONTINUE.
      ENDIF.

      READ TABLE lrt_lgpla TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgpla>.

      IF sy-subrc <> 0.
        CLEAR lrs_lgpla.
        lrs_lgpla-option    = wmegc_option_eq.
        lrs_lgpla-sign      = wmegc_sign_inclusive.
        lrs_lgpla-low       = <l_lgpla>.
        APPEND lrs_lgpla TO lrt_lgpla.
      ENDIF.

    ENDLOOP.

*   for storage type
    LOOP AT it_lgtyp ASSIGNING <l_lgtyp>.

      IF <l_lgtyp> IS INITIAL.
        CONTINUE.
      ENDIF.

      READ TABLE lrt_lgtyp TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgtyp>.

      IF sy-subrc <> 0.
        CLEAR lrs_lgtyp.
        lrs_lgtyp-option    = wmegc_option_eq.
        lrs_lgtyp-sign      = wmegc_sign_inclusive.
        lrs_lgtyp-low       = <l_lgtyp>.
        APPEND lrs_lgtyp TO lrt_lgtyp.
      ENDIF.

    ENDLOOP.

*   for storage area
    LOOP AT it_lgber ASSIGNING <l_lgber>.

      IF <l_lgber> IS INITIAL.
        CONTINUE.
      ENDIF.

      READ TABLE lrt_lgber TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgber>.

      IF sy-subrc <> 0.
        CLEAR lrs_lgber.
        lrs_lgber-option    = wmegc_option_eq.
        lrs_lgber-sign      = wmegc_sign_inclusive.
        lrs_lgber-low       = <l_lgber>.
        APPEND lrs_lgber TO lrt_lgber.
      ENDIF.

    ENDLOOP.

*   for storage bin type
    LOOP AT it_lptyp ASSIGNING <l_lptyp>.

      IF <l_lptyp> IS INITIAL.
        CONTINUE.
      ENDIF.

      READ TABLE lrt_lptyp TRANSPORTING NO FIELDS
        WITH KEY low = <l_lptyp>.

      IF sy-subrc <> 0.
        CLEAR lrs_lptyp.
        lrs_lptyp-option    = wmegc_option_eq.
        lrs_lptyp-sign      = wmegc_sign_inclusive.
        lrs_lptyp-low       = <l_lptyp>.
        APPEND lrs_lptyp TO lrt_lptyp.
      ENDIF.

    ENDLOOP.

**   für Lagerungsgruppe
*    LOOP AT it_lgber_lgst ASSIGNING <l_lgber_lgst>.
*
*      IF <l_lgber_lgst> IS INITIAL.
*        CONTINUE.
*      ENDIF.
*
*      READ TABLE lrt_lgber_lgst TRANSPORTING NO FIELDS
*        WITH KEY low = <l_lgber_lgst>.
*
*      IF sy-subrc <> 0.
*        CLEAR lrs_lgber_lgst.
*        lrs_lgber_lgst-option    = wmegc_option_eq.
*        lrs_lgber_lgst-sign      = wmegc_sign_inclusive.
*        lrs_lgber_lgst-low       = <l_lgber_lgst>.
*        APPEND lrs_lgber_lgst TO lrt_lgber_lgst.
*      ENDIF.
*
*    ENDLOOP.

**   für Gasse/Säule/Ebene
*    LOOP AT it_aistlv ASSIGNING <ls_aistlv>.
*
*      IF <ls_aistlv>-aisle IS NOT INITIAL.
*
*        READ TABLE lrt_aisle TRANSPORTING NO FIELDS
*          WITH KEY low = <ls_aistlv>-aisle.
*
*        IF sy-subrc <> 0.
*          CLEAR lrs_aisle.
*          l_aisle = <ls_aistlv>-aisle.
*          SHIFT l_aisle  RIGHT DELETING TRAILING space.
*          lrs_aisle-option    = wmegc_option_eq.
*          lrs_aisle-sign      = wmegc_sign_inclusive.
*          lrs_aisle-low       = l_aisle.
*          APPEND lrs_aisle TO lrt_aisle.
*        ENDIF.
*      ENDIF.


*      IF <ls_aistlv>-stack IS NOT INITIAL.
*
*        READ TABLE lrt_stack TRANSPORTING NO FIELDS
*          WITH KEY low = <ls_aistlv>-stack.
*
*        IF sy-subrc <> 0.
*          CLEAR lrs_stack.
*          l_stack = <ls_aistlv>-stack.
*          SHIFT l_stack RIGHT DELETING TRAILING space.
*          lrs_stack-option    = wmegc_option_eq.
*          lrs_stack-sign      = wmegc_sign_inclusive.
*          lrs_stack-low       = l_stack.
*          APPEND lrs_stack TO lrt_stack.
*        ENDIF.
*      ENDIF.
*
*      IF <ls_aistlv>-lvl_v IS NOT INITIAL.
*
*        READ TABLE lrt_level TRANSPORTING NO FIELDS
*          WITH KEY low = <ls_aistlv>-lvl_v.
*
*        IF sy-subrc <> 0.
*          CLEAR lrs_level.
*          l_level = <ls_aistlv>-lvl_v.
*          SHIFT l_level RIGHT DELETING TRAILING space.
*          lrs_level-option    = wmegc_option_eq.
*          lrs_level-sign      = wmegc_sign_inclusive.
*          lrs_level-low       = l_level.
*          APPEND lrs_level TO lrt_level.
*        ENDIF.
*
*      ENDIF.
*
*    ENDLOOP.

    MESSAGE i029
       INTO zswl_cl_log=>m_dummy_msg.
    co_log->add( i_syst = abap_true ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Select storage bins
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    SELECT *
      FROM /scwm/lagp
      INTO TABLE lt_lagp
     WHERE lgnum      = i_lgnum
       AND lgtyp      IN lrt_lgtyp
       AND lgber      IN lrt_lgber
       AND lgpla      IN lrt_lgpla
       AND lptyp      IN lrt_lptyp
       AND aisle      IN lrt_aisle
       AND stack      IN lrt_stack
       AND lvl_v      IN lrt_level
*      AND kzler      IN lrt_empty                   "#001/RKU/24.10.2014
*      AND skzua      IN lrt_skzua                   "#002/RKU/26.11.2014
*      AND skzue      IN lrt_skzue                   "#002/RKU/26.11.2014
*      AND skzsi      IN lrt_skzsi                   "#002/RKU/26.11.2014
       AND lgber_lgst IN lrt_lgber_lgst.

    IF sy-subrc <> 0.

*     No storage bin found
      MESSAGE e015
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   if flag 'I_EMPTY' is set
    IF i_empty IS SUPPLIED.

*     Delete all empty storage bin from the result list
      MESSAGE i030
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

      DELETE lt_lagp WHERE kzler <> i_empty.

    ENDIF.

*   for flag 'I_PUTAWAY_BLOCKED'
    IF i_putaway_blocked IS SUPPLIED.

      DELETE lt_lagp WHERE skzue <> i_putaway_blocked.

    ENDIF.

*   for flag 'I_PICK_BLOCKED'
    IF i_pick_blocked IS SUPPLIED.

      DELETE lt_lagp WHERE skzua <> i_pick_blocked.

    ENDIF.

*   for flag 'I_INVENT_BLOCKED'
    IF i_invent_blocked IS SUPPLIED.

      DELETE lt_lagp WHERE skzsi <> i_invent_blocked.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Create object references
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_build_objects = abap_true.

      LOOP AT lt_lagp ASSIGNING <ls_lagp>.

        CLEAR ls_lagp_ref.
        ls_lagp_ref-lgnum   = <ls_lagp>-lgnum.
        ls_lagp_ref-lgpla   = <ls_lagp>-lgpla.

        CREATE OBJECT ls_lagp_ref-o_bin
          EXPORTING
            i_lgnum      = <ls_lagp>-lgnum
            io_log       = co_log
            is_lagp      = <ls_lagp>
*           i_lgpla      =
            i_sel_lagps  = abap_false
            i_sel_status = abap_false.

        APPEND ls_lagp_ref TO et_bins.

      ENDLOOP.

    ENDIF.

    IF et_lagp IS REQUESTED.
      et_lagp[] = lt_lagp[].
    ENDIF.

  ENDMETHOD.


METHOD reset_user_state.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Reset the user state
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    TRY.
        CALL METHOD me->change_user_state
          EXPORTING
            i_commit       = abap_true
            i_wait         = abap_true
            i_user_state   = i_user_state
            i_set_inactive = abap_true.
      CATCH zcx_ewm_general_exception .
        zcx_ewm_general_exception=>raise_system_exception( ).

    ENDTRY.



  ENDMETHOD.


METHOD select_lagps.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select and return all storage bins for the incoming parameter.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rt_lagps[].

    SELECT *
      FROM /scwm/lagps
      INTO TABLE rt_lagps
     WHERE lgnum  = m_lgnum
       AND lgpla  = i_lgpla.

    IF sy-subrc <> 0.

      MESSAGE e026
         WITH i_lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_single_lagp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the storage bins for the incoming parameter.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rs_lagp.

    SELECT SINGLE *
      FROM /scwm/lagp
      INTO rs_lagp
     WHERE lgnum    = m_lgnum
       AND lgpla    = i_lgpla.

    IF sy-subrc <> 0.

*     No storage bin were found
      MESSAGE e025
         WITH i_lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_stat_for_stsma.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the actual status for the incoming scheme.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT *
      FROM tj30t
      INTO TABLE rt_stat
      WHERE stsma = i_stsma.

    IF sy-subrc <> 0.
      RETURN.

    ENDIF.

  ENDMETHOD.


METHOD set_user_state.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the user state
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    TRY.
        CALL METHOD me->change_user_state
          EXPORTING
            i_commit       = abap_true
            i_wait         = abap_true
            i_user_state   = i_user_state
            i_set_inactive = abap_false.
      CATCH zcx_ewm_general_exception .
        zcx_ewm_general_exception=>raise_system_exception( ).

    ENDTRY.


  ENDMETHOD.


METHOD zif_swlbc_object~cleanup.
    CLEAR st_storage_bin_ref[].
  ENDMETHOD.


METHOD zif_swlbc_object~free.
  ENDMETHOD.
ENDCLASS.
