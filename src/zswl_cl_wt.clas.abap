class ZSWL_CL_WT definition
  public
  inheriting from ZSWL_CL_OBJECT
  create public .

public section.
  type-pools ABAP .

  interfaces ZIF_SWLBC_OBJECT .

  methods CANCEL
    importing
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CLEAR_EXCCODE .
  methods CONFIRM
    importing
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_USE_SMQ2 type XFELD default ABAP_FALSE
    returning
      value(RT_LTAP_VB) type /SCWM/TT_LTAP_VB
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_TANUM type /SCWM/TANUM optional
      !I_ONLY_OPEN type XFELD default ABAP_TRUE
      !IS_ORDIM_O type /SCWM/ORDIM_O optional
      !IS_WT_CREA type ZSWL_S_TO_CREA_HU optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_QNAME type UNAME default SY-UNAME
      !I_SUBST type /SCWM/RL03TSUBST default SPACE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_NEXT_PAPOS
    returning
      value(R_PAPOS) type /SCWM/LTAP_HU_PAPOS .
  methods GET_ORDIM_O
    returning
      value(RS_ORDIM_O) type /SCWM/ORDIM_O .
  methods GET_TANUM
    returning
      value(R_TANUM) type /SCWM/TANUM .
  methods READ_BUSCON
    importing
      !I_TRART type /SCWM/LVS_TRART
    returning
      value(R_BUSCON) type /SCWM/DE_BUSCON
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_CONF_QUANTITY
    importing
      !I_CONF_QUAN type /SCWM/LTAP_NISTA
      !I_CONF_UOM type /SCWM/DE_AUNIT
      !I_PARTI type /SCWM/LTAP_CONF_PARTI optional
      !I_EXCCODE type /SCWM/DE_EXCCODE optional
      !I_EXEC_STEP type /SCWM/DE_EXEC_STEP optional
      !I_SEQNO type BAPI_LINE optional
      !I_EXEC_NO_PROC type /SCWM/DE_EXEC_NO_PROC optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods ADD_SERID
    importing
      !IS_SERID type /SCWM/S_CONF_SERID
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_DESTINATION
    importing
      !I_NLPLA type /SCWM/DE_LGPLA optional
      !I_NLENR type /SCWM/DE_HUIDENT optional
      !I_CLEAR_NLENR type XFELD default ABAP_FALSE
      !I_DRSRC type /SCWM/DE_DRSRC optional
      !I_DTU_NUM type /SCWM/DE_DTU_NUM optional
      !I_PAPOS type /SCWM/LTAP_HU_PAPOS optional
      !I_EXCCODE type /SCWM/DE_EXCCODE optional
      !I_EXEC_STEP type /SCWM/DE_EXEC_STEP optional
      !I_SEQNO type BAPI_LINE optional
      !I_EXEC_NO_PROC type /SCWM/DE_EXEC_NO_PROC optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_EXCCODE
    importing
      !I_PAPOS type /SCWM/LTAP_HU_PAPOS
      !I_EXCCODE type /SCWM/DE_EXCCODE
      !I_EXEC_STEP type /SCWM/DE_EXEC_STEP
      !I_SEQNO type BAPI_LINE optional
      !I_EXEC_NO_PROC type /SCWM/DE_EXEC_NO_PROC optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_PROCTY
    importing
      !I_PROCTY type /SCWM/DE_PROCTY .
  methods SET_QNAME
    importing
      !I_QNAME type UNAME .
  methods SET_SOURCE
    importing
      !I_VLENR type /SCWM/DE_HUIDENT optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_WTCODE
    importing
      !I_WTCODE type /SCWM/DE_WTCODE .
  methods UPDATE_OPEN_WT
    importing
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UPDATE_KZSUB
    importing
      !IV_KZSUB type /SCWM/LTAP_KZSUB
      !IV_COMMIT type BOOLEAN default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_SERIALS
    returning
      value(RT_SERIALS) type /SCWM/TT_ORDIM_OS .
  methods REMOVE_ASSIGNMENTID
    importing
      !IV_COMMIT type BOOLEAN default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UPDATE_ASTASKNO
    importing
      !IV_ASTASKNO type ZSWL_DE_AS_TASK_ID
      !IV_COMMIT type BOOLEAN default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.

  data MS_MFS_INFO type /SCWM/S_MFS_CONF .
  data MS_ORDIM_C type /SCWM/ORDIM_C .
  data MS_ORDIM_O type /SCWM/ORDIM_O .
  data MT_CONF_QUAN type ZSWL_TT_WT_CONF_QUAN .
  data MT_CONF_SERID type /SCWM/TT_CONF_SERID .
  data MT_EXCCODE type /SCWM/TT_CONF_EXC .
  data M_CRETO type /SCWM/DE_CRETO .
  data M_HUENT type /SCWM/LTAP_HU_HUENT .
  data M_PROC_DET type /SCWM/DE_CONFIRM_RF .
  data M_QNAME type UNAME .
  data M_STATUS type /SCWM/DE_TOSTAT .
  data M_SUBST type /SCWM/RL03TSUBST .
  data M_TANUM type /SCWM/TANUM .
  data M_WHO_PRINT type XFELD .
  data M_WRITE_STANDARD_LOG type XFELD .
  data M_WTCODE type /SCWM/DE_WTCODE .
  data M_NLENR_CHANGED type XFELD .

  methods BUILD_CONF_DATA
    returning
      value(RT_CONF) type /SCWM/TO_CONF_TT .
  methods CHECK_INPUT_CREA_HU_WT
    importing
      !IS_HU_WT type /SCWM/S_TO_CREA_HU_INT
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CHECK_INPUT_CREA_PROD_WT
    importing
      !IS_PROD_WT type /SCWM/S_TO_CREATE_INT
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CREATE_HU_WT
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !IS_HU_WT type /SCWM/S_TO_CREA_HU_INT
      !I_UPDATE_TASK type /SCWM/RL03AVERBU default ABAP_TRUE
      !I_WTCODE type /SCWM/DE_WTCODE optional
      !IS_RFC_QUEUE type /SCWM/S_RFC_QUEUE optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CREATE_PROD_WT
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !IS_PROD_WT type /SCWM/S_TO_CREATE_INT optional
      !I_UPDATE_TASK type /SCWM/RL03AVERBU default ABAP_TRUE
      !I_WTCODE type /SCWM/DE_WTCODE optional
      !IS_RFC_QUEUE type /SCWM/S_RFC_QUEUE optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CREATE_WT
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !IS_WT_CREA type ZSWL_S_TO_CREA_HU
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods FILL_ATTRIBUTES_AFTER_CREATION
    importing
      !I_TANUM type /SCWM/TANUM optional
      !IT_LTAP type /SCWM/TT_LTAP_VB optional .
  methods SELECT_ORDIM_C
    importing
      !I_TANUM type /SCWM/TANUM
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_ORDIM_O
    importing
      !I_TANUM type /SCWM/TANUM
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods TO_CONFIRM
    importing
      !I_UPD_TASK type /SCWM/RL03AVERBU default ABAP_TRUE
      !I_COMMIT type /SCWM/RL03ACOMIT default ABAP_TRUE
      !IT_CONF type /SCWM/TO_CONF_TT optional
      !I_USE_SMQ2 type XFELD default ABAP_FALSE
    exporting
      !ET_LTAP_VB type /SCWM/TT_LTAP_VB
      !ET_BAPIRET type BAPIRETTAB
      !E_SEVERITY type BAPI_MTYPE
      !E_SER_ERR type XFELD
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  constants MC_DFLT_PAPOS type /SCWM/LTAP_HU_PAPOS value '1' ##NO_TEXT.

  methods DETERMINE_QUANS
    importing
      !I_CONF_QUAN type /SCWM/LTAP_NISTA
      !I_UOM type /SCWM/DE_AUNIT
    returning
      value(RS_REMAINING_QTY) type /SCWM/S_QUAN .
  methods SELECT_ORDIM
    importing
      !I_TANUM type /SCWM/TANUM
      !I_ONLY_OPEN type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods WRITE_STD_LOG
    importing
      !I_SEVERITY type BAPI_MTYPE
      !IT_BAPIRET type BAPIRETTAB
    returning
      value(R_LOGNR) type BALOGNR .
ENDCLASS.



CLASS ZSWL_CL_WT IMPLEMENTATION.


METHOD add_serid.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set a serial number for warehouse task confirmation
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_serid TYPE /scwm/s_conf_serid.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    READ TABLE mt_conf_serid WITH KEY serid = is_serid-serid TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
*      l_papos = me->get_next_papos( ).

      ls_serid = is_serid.
      ls_serid-tanum = ms_ordim_o-tanum.
      ls_serid-papos = '0001'."l_papos.

      APPEND ls_serid TO mt_conf_serid.

    ENDIF.

  ENDMETHOD.


METHOD build_conf_data.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Complete all the data for confirmation
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    FIELD-SYMBOLS:
      <ls_conf_quan>            TYPE zswl_s_wt_conf_quan.

    DATA:
      ls_conf                   TYPE /scwm/to_conf.

    CLEAR rt_conf[].
    CLEAR ls_conf.

    ls_conf-tanum   = m_tanum.
    ls_conf-batchid = ms_ordim_o-batchid.
    ls_conf-vlenr   = ms_ordim_o-vlenr.
    ls_conf-huent   = m_huent.
    ls_conf-nlpla   = ms_ordim_o-nlpla.
    IF ms_ordim_o-nlenr IS NOT INITIAL.
      ls_conf-nlenr = ms_ordim_o-nlenr.
    ELSE.
      IF ms_ordim_o-flghuto = abap_true.
        ls_conf-nlenr = ls_conf-vlenr.
      ENDIF.
    ENDIF.
    IF m_nlenr_changed = abap_true.
      ls_conf-d_chg = abap_true.
    ELSE.
      ls_conf-d_chg = abap_false.
    ENDIF.

    ls_conf-drsrc   = ms_ordim_o-drsrc.
    ls_conf-dtu_num = ms_ordim_o-dtu_num.
    ls_conf-error   = ms_mfs_info-error.
    ls_conf-plc     = ms_mfs_info-plc.
    ls_conf-cp      = ms_mfs_info-cp.

    IF ms_ordim_o-flghuto = abap_false.

      IF lines( mt_conf_quan ) = 0.

        ls_conf-papos = mc_dflt_papos.
        ls_conf-nista = ms_ordim_o-vsolm.
        ls_conf-altme = ms_ordim_o-meins.
        ls_conf-ndifa = 0.
        ls_conf-resta = 0.
        APPEND ls_conf TO rt_conf.

      ELSE.

        LOOP AT mt_conf_quan ASSIGNING <ls_conf_quan>.

          CLEAR: ls_conf-papos,
                 ls_conf-nista,
                 ls_conf-altme,
                 ls_conf-ndifa,
                 ls_conf-resta.

          ls_conf-papos = <ls_conf_quan>-papos.
          ls_conf-nista = <ls_conf_quan>-conf_qty.
          ls_conf-altme = <ls_conf_quan>-altme.
          ls_conf-parti = <ls_conf_quan>-parti.
          ls_conf-ndifa = <ls_conf_quan>-diff_qty.
          ls_conf-resta = <ls_conf_quan>-rema_qty.
          APPEND ls_conf TO rt_conf.

        ENDLOOP.

      ENDIF.

    ELSE.

      ls_conf-papos = mc_dflt_papos.
      APPEND ls_conf TO rt_conf.

    ENDIF.

  ENDMETHOD.


METHOD cancel.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Cancel the actual warehouse task.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      lt_cancel  TYPE /scwm/tt_cancl,
      lt_bapiret TYPE bapirettab,
      ls_cancel  TYPE /scwm/cancl,
      l_severity TYPE bapi_mtype.

    IF ms_ordim_o IS INITIAL.

*     No open wt found
      MESSAGE e038
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Cancel wt
    MESSAGE e039
       WITH ms_ordim_o-tanum
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    CLEAR ls_cancel.
    ls_cancel-tanum = ms_ordim_o-tanum.
    ls_cancel-subst = m_subst.
    APPEND ls_cancel TO lt_cancel.

    CALL FUNCTION '/SCWM/TO_CANCEL'
      EXPORTING
        iv_lgnum       = m_lgnum
        iv_subst       = m_subst
        iv_qname       = m_qname
*       IV_HUMI        = ' '
        iv_update_task = i_upd_task
        iv_commit_work = abap_false
        it_cancl       = lt_cancel
        it_cancl_exc   = mt_exccode
      IMPORTING
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF me->handle_error(
              EXPORTING
                i_commit    = i_commit
                i_wait      = i_wait
                i_severity  = l_severity
                it_bapiret  = lt_bapiret ) = abap_true.

*     WT couldn`t be canceled
      MESSAGE e040
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     WT successfully canceled
      MESSAGE e041
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.


  ENDMETHOD.


METHOD check_input_crea_hu_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Check method, if the process type is filled
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF is_hu_wt-procty IS INITIAL.

*     Log error
      MESSAGE e020
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD check_input_crea_prod_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Check method if process type is filled
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF is_prod_wt-procty IS INITIAL.

*     Log error
      MESSAGE e020
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD clear_exccode.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Clear the attribute for exception codes
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR mt_exccode[].

  ENDMETHOD.


METHOD confirm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Confirm the actual WT direct or in background task
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
      lt_bapiret TYPE bapirettab,
      lt_conf    TYPE /scwm/to_conf_tt,
      l_severity TYPE bapi_mtype.
* End declarations
**********************************************************************

    IF ms_ordim_o IS INITIAL.

*     WT is not open - Confirmation not possible
      MESSAGE e035
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    lt_conf = me->build_conf_data( ).

*   Confirm WT
    CALL METHOD me->to_confirm
      EXPORTING
        i_upd_task = i_upd_task
        i_commit   = i_commit
        it_conf    = lt_conf
        i_use_smq2 = i_use_smq2
      IMPORTING
        et_ltap_vb = rt_ltap_vb
        et_bapiret = lt_bapiret
        e_severity = l_severity
*       e_ser_err  =
      .

    IF me->handle_error(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          i_severity  = l_severity
          it_bapiret  = lt_bapiret ) = abap_true.


      "Log specific error message
      LOOP AT lt_bapiret INTO DATA(ls_bapiret)
              WHERE type CA wmegc_severity_eax.
        EXIT.
      ENDLOOP.

      IF ls_bapiret IS NOT INITIAL.
*     Log error
        MESSAGE ID ls_bapiret-id
                TYPE ls_bapiret-type
                NUMBER ls_bapiret-number
                WITH ls_bapiret-message_v1 ls_bapiret-message_v2 ls_bapiret-message_v3 ls_bapiret-message_v4
                INTO zswl_cl_log=>m_dummy_msg.

      ELSE.
*     Log error
        MESSAGE e036
           WITH m_tanum
           INTO zswl_cl_log=>m_dummy_msg.
      ENDIF.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     Log message
      MESSAGE i037
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

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
        i_lgnum   = i_lgnum
        io_log    = io_log ).

    IF i_tanum IS SUPPLIED.

      IF i_tanum    IS INITIAL AND
         is_ordim_o IS INITIAL.

*       No TANUM/WT were given
        MESSAGE e026(zswl_ca)
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

      IF is_ordim_o IS NOT INITIAL.
        ms_ordim_o  = is_ordim_o.
        m_tanum     = is_ordim_o-tanum.
        m_status    = is_ordim_o-tostat.
      ELSE.

        me->select_ordim( i_tanum     = i_tanum
                          i_only_open = i_only_open ).

      ENDIF.

    ELSEIF is_wt_crea IS SUPPLIED.

      me->create_wt(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          is_wt_crea  = is_wt_crea ).

    ELSE.

*     Wrong parameters
      MESSAGE e022
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CLEAR: m_wtcode,
           ms_mfs_info,
           mt_exccode[].

    m_qname     = i_qname.
    m_subst     = i_subst.
    m_huent     = abap_false.
    m_who_print = abap_undefined.
    m_creto     = abap_false.
    m_proc_det  = abap_false.

  ENDMETHOD.


METHOD create_hu_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Create a HU warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_destination TYPE string,
      l_tanum       TYPE /scwm/tanum,
      l_severity    TYPE bapi_mtype,
      lt_bapiret    TYPE bapirettab,
      lt_created    TYPE /scwm/tt_ltap_vb,
      lt_create_hu  TYPE /scwm/tt_to_crea_hu.
* End declarations
**********************************************************************

    CLEAR lt_create_hu[].
    APPEND is_hu_wt TO lt_create_hu.

    CLEAR l_destination.
    IF is_hu_wt-nlpla IS NOT INITIAL.
      MOVE is_hu_wt-nlpla TO l_destination.
    ELSEIF is_hu_wt-nltyp IS NOT INITIAL.
      MOVE is_hu_wt-nltyp TO l_destination.
    ELSEIF is_hu_wt-drsrc IS NOT INITIAL.
      MOVE is_hu_wt-drsrc  TO l_destination.
    ELSEIF is_hu_wt-dtu_num_ext IS NOT INITIAL.
      MOVE is_hu_wt-dtu_num_ext TO l_destination.
    ELSEIF is_hu_wt-dtu_num IS NOT INITIAL.
      MOVE is_hu_wt-dtu_num TO l_destination.
    ENDIF.

    MESSAGE i045
       WITH is_hu_wt-huident
            is_hu_wt-procty
            l_destination
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Create HU-WT
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    CALL FUNCTION '/SCWM/TO_CREATE_MOVE_HU'
      EXPORTING
        iv_lgnum       = m_lgnum
        iv_update_task = i_update_task
        iv_commit_work = abap_false
        iv_wtcode      = i_wtcode
        iv_bname       = sy-uname
        is_rfc_queue   = is_rfc_queue
        it_create_hu   = lt_create_hu
*       IV_PROCESSOR_DET       = ' '
      IMPORTING
        ev_tanum       = l_tanum
        et_ltap_vb     = lt_created
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF me->handle_error(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          i_severity  = l_severity
          it_bapiret  = lt_bapiret ) = abap_true.

*     Log error
      MESSAGE e029
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Fill attributes
    me->fill_attributes_after_creation(
      EXPORTING
        i_tanum   = l_tanum
        it_ltap   = lt_created ).

  ENDMETHOD.


METHOD create_prod_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Create a product warehouse task.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_severity TYPE bapi_mtype,
      l_tanum    TYPE /scwm/tanum,
      lt_create  TYPE /scwm/tt_to_create_int,
      lt_bapiret TYPE bapirettab,
      lt_ltap    TYPE /scwm/tt_ltap_vb.
* End declarations
**********************************************************************

    CLEAR lt_create[].
    APPEND is_prod_wt TO lt_create.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Create Product-WT
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    CALL FUNCTION '/SCWM/TO_CREATE'
      EXPORTING
        iv_lgnum       = m_lgnum
        iv_update_task = i_update_task
        iv_commit_work = i_commit
        iv_wtcode      = i_wtcode
        iv_bname       = sy-uname
        is_rfc_queue   = is_rfc_queue
        it_create      = lt_create
*       IT_CREATE_EXC  =
*       IV_PROCESSOR_DET       = ' '
      IMPORTING
        ev_tanum       = l_tanum
        et_ltap_vb     = lt_ltap
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF me->handle_error(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          i_severity  = l_severity
          it_bapiret  = lt_bapiret ) = abap_true.

*     Log error
      MESSAGE e029
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Fill attributes
    me->fill_attributes_after_creation(
      EXPORTING
        i_tanum   = l_tanum
        it_ltap   = lt_ltap ).

  ENDMETHOD.


METHOD create_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Create a warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

*   Log message
    MESSAGE i027
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    IF is_wt_crea-s_hu_wt IS NOT INITIAL.

*     Check params
      me->check_input_crea_hu_wt( is_hu_wt = is_wt_crea-s_hu_wt ).

*     Create a HU-WT
      me->create_hu_wt(
        EXPORTING
          i_commit      = i_commit
          i_wait        = i_wait
          is_hu_wt      = is_wt_crea-s_hu_wt
          i_update_task = is_wt_crea-update_task
          i_wtcode      = is_wt_crea-wtcode
          is_rfc_queue  = is_wt_crea-s_rfc_queue ).

    ELSEIF is_wt_crea-s_prod_wt IS NOT INITIAL.

*     Check params
      me->check_input_crea_prod_wt( is_prod_wt = is_wt_crea-s_prod_wt ).

*     Create a Product-WT
      me->create_prod_wt(
        EXPORTING
          i_commit      = i_commit
          i_wait        = i_wait
          is_prod_wt    = is_wt_crea-s_prod_wt
          i_update_task = is_wt_crea-update_task
          i_wtcode      = is_wt_crea-wtcode
          is_rfc_queue  = is_wt_crea-s_rfc_queue ).

    ELSE.

*     Log error
      MESSAGE e028
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD determine_quans.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Calculate the correct quantities
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    FIELD-SYMBOLS:
      <ls_conf_quan>            TYPE zswl_s_wt_conf_quan.

    DATA:
      lx_md           TYPE REF TO /scwm/cx_md,
      l_qty           TYPE /scwm/de_quantity,
      l_qty_conv      TYPE /scwm/de_quantity,
      l_confirmed_qty TYPE /scwm/de_quantity.
* End declarations
**********************************************************************
    CLEAR rs_remaining_qty.

    IF lines( mt_conf_quan ) = 0.
*     Sollten noch keine Mengen gesetzt sein kann die Menge mit der
*     original LB-Menge verglichen und berechnet werden

      l_confirmed_qty = 0.

    ELSE.
*     Wurden bereits Mengen gesetzt müssen wir die aktuell noch zu
*     quittierende Menge aus den bereits übergebenen Mengen berechnen.

      l_confirmed_qty = 0.

      LOOP AT mt_conf_quan ASSIGNING <ls_conf_quan>.

        CLEAR l_qty_conv.

        IF <ls_conf_quan>-altme <> i_uom.

          TRY.
              CALL METHOD zswl_cl_services_conv=>quan_unit_to_unit
                EXPORTING
                  i_matid    = ms_ordim_o-matid
                  i_quan     = i_conf_quan
                  i_uom_from = i_uom
                  i_uom_to   = ms_ordim_o-altme
                  i_batchid  = ms_ordim_o-batchid
                RECEIVING
                  r_quantity = l_qty_conv.
            CATCH /scwm/cx_md INTO lx_md.
              mo_log->add( ix_exception = lx_md ).
          ENDTRY.

        ELSE.

          l_qty_conv = <ls_conf_quan>-conf_qty.

        ENDIF.

        l_confirmed_qty = l_confirmed_qty + l_qty_conv.

      ENDLOOP.

    ENDIF.

    IF i_uom = ms_ordim_o-meins.

*     Mengeneinheit = Basismengeneinheit
      rs_remaining_qty-quan = ms_ordim_o-vsolm - l_confirmed_qty - i_conf_quan.
      rs_remaining_qty-unit = ms_ordim_o-meins.

    ELSEIF i_uom = ms_ordim_o-altme.

*     Mengeneinheit ist alternative Mengeneinheit
      rs_remaining_qty-quan = ms_ordim_o-vsola - l_confirmed_qty - i_conf_quan.
      rs_remaining_qty-unit = ms_ordim_o-altme.

    ELSE.

      CLEAR l_qty_conv.

*     Konvertiere bereits quittierte Menge zu alternative Mengeneinheit
      TRY.
          CALL METHOD zswl_cl_services_conv=>quan_unit_to_unit
            EXPORTING
              i_matid    = ms_ordim_o-matid
              i_quan     = l_confirmed_qty
              i_uom_from = i_uom
              i_uom_to   = ms_ordim_o-altme
              i_batchid  = ms_ordim_o-batchid
            RECEIVING
              r_quantity = l_qty_conv.
        CATCH /scwm/cx_md INTO lx_md.
          mo_log->add( ix_exception = lx_md ).
      ENDTRY.

      TRY.
*         Konvertiere zu quittierende Menge zu alternative Mengeneinheit
          CALL METHOD zswl_cl_services_conv=>quan_unit_to_unit
            EXPORTING
              i_matid    = ms_ordim_o-matid
              i_quan     = i_conf_quan
              i_uom_from = i_uom
              i_uom_to   = ms_ordim_o-altme
              i_batchid  = ms_ordim_o-batchid
            RECEIVING
              r_quantity = l_qty.
        CATCH /scwm/cx_md INTO lx_md.
          mo_log->add( ix_exception = lx_md ).
      ENDTRY.

      rs_remaining_qty-quan = ms_ordim_o-vsola - l_qty_conv - l_qty.
      rs_remaining_qty-unit = i_uom.

    ENDIF.

  ENDMETHOD.


METHOD fill_attributes_after_creation.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Fill the attributes after the WT creation on the actual
*               warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

    FIELD-SYMBOLS:
      <ls_created>              TYPE /scwm/ltap.

    IF i_tanum IS NOT INITIAL.

      READ TABLE it_ltap ASSIGNING <ls_created>
      WITH KEY tanum = i_tanum.

    ELSE.

      READ TABLE it_ltap ASSIGNING <ls_created>
        WITH KEY tostat = wmegc_to_open.

    ENDIF.

    IF sy-subrc = 0.

      m_tanum     = <ls_created>-tanum.
      m_status    = <ls_created>-tostat.

      IF m_status <> wmegc_to_confirmed.
        MOVE-CORRESPONDING <ls_created> TO ms_ordim_o ##ENH_OK.
      ELSE.
        MOVE-CORRESPONDING <ls_created> TO ms_ordim_c ##ENH_OK.
      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD get_next_papos.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the next sub no. from the Warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    FIELD-SYMBOLS:
      <ls_conf_quan>            TYPE zswl_s_wt_conf_quan.

    DATA:
      l_lines                   TYPE i.

    CLEAR r_papos.

    IF lines( mt_conf_quan ) = 0.
      r_papos = mc_dflt_papos.
    ELSE.
      l_lines = lines( mt_conf_quan ).
      READ TABLE mt_conf_quan ASSIGNING <ls_conf_quan> INDEX l_lines.
      IF sy-subrc = 0.
        r_papos = <ls_conf_quan>-papos + 1.
      ENDIF.
    ENDIF.

  ENDMETHOD.


METHOD get_ordim_o.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the structure from the open warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rs_ordim_o = ms_ordim_o.

  ENDMETHOD.


METHOD get_serials.

    SELECT * FROM /scwm/ordim_os INTO CORRESPONDING FIELDS OF TABLE rt_serials
      WHERE lgnum = ms_ordim_o-lgnum
        AND tanum = ms_ordim_o-tanum.

  ENDMETHOD.


METHOD get_tanum.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the tanum from the actual wt
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_tanum = m_tanum.

  ENDMETHOD.


METHOD read_buscon.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the business context for the transportation type
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR r_buscon.

    CALL FUNCTION '/SCWM/GET_BUSCON_FOR_TRART'
      EXPORTING
        iv_trart    = i_trart
      IMPORTING
        ev_buscon   = r_buscon
      EXCEPTIONS
        wrong_input = 1
        OTHERS      = 2.
    IF sy-subrc <> 0.

*     Log error
      MESSAGE e021
         WITH i_trart
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD remove_assignmentid.

*    DATA : ls_change_att TYPE /scwm/s_to_change_att,
*           ls_change     TYPE /scwm/s_changed,
*           lt_change_att TYPE /scwm/tt_to_change_att,
*           lt_bapiret    TYPE bapiret2_t,
*           ls_bapiret    TYPE bapiret2,
*           lv_severity   TYPE  bapi_mtype.
*
*    IF ms_ordim_o IS INITIAL.
*
**     Warehouse task isn`t open --> Update not possible
*      MESSAGE e030
*         WITH m_tanum
*         INTO zswl_cl_log=>m_dummy_msg.
*      mo_log->add( i_syst = abap_true ).
*      zcx_ewm_general_exception=>raise_system_exception( ).
*
*    ENDIF.
*
**   Change warehouse task
*    MESSAGE i031
*       WITH m_tanum
*       INTO zswl_cl_log=>m_dummy_msg.
*    mo_log->add( i_syst = abap_true ).
*
*    CLEAR: lt_change_att[], ls_change_att.
*
*    CLEAR: ls_change.
*    ls_change_att-tanum = m_tanum.
*    ls_change-fieldname = 'ZZSWL_ASSIGNMENTID'.
*    APPEND ls_change TO ls_change_att-tt_changed.
*    APPEND ls_change_att TO lt_change_att.
*
*    CALL FUNCTION 'Z_SWL_TO_CHANGE_ATT'
*      EXPORTING
*        iv_lgnum       = m_lgnum
*        iv_subst       = 'X'
*        iv_update_task = ' '
*        iv_commit_work = ' '
*        it_change_att  = lt_change_att
*      IMPORTING
*        et_bapiret     = lt_bapiret
*        ev_severity    = lv_severity.
*
*    IF lv_severity CA 'AE'.
*      READ TABLE lt_bapiret INTO ls_bapiret
*        WITH KEY type = wmegc_severity_err.
*      IF sy-subrc = 0.
*        MESSAGE ID     ls_bapiret-id
*                TYPE   ls_bapiret-type
*                NUMBER ls_bapiret-number
*                WITH   ls_bapiret-message_v1 ls_bapiret-message_v2
*                       ls_bapiret-message_v3 ls_bapiret-message_v4
*                INTO   zswl_cl_log=>m_dummy_msg.
*        mo_log->add( i_syst = abap_true ).
*        zcx_ewm_general_exception=>raise_system_exception( ).
*      ENDIF.
*    ELSE.
**      CLEAR: ms_ordim_o-zzswl_assignmentid.
*    ENDIF.
*
*    IF iv_commit = abap_true.
*      me->commit( ).
*    ENDIF.

  ENDMETHOD.


METHOD select_ordim.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Select warehouse tasks
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

    TRY .

        me->select_ordim_o( i_tanum = i_tanum ).

        m_tanum   = ms_ordim_o-tanum.
        m_status  = ms_ordim_o-tostat.

      CATCH zcx_ewm_general_exception.

        IF i_only_open = abap_true.

*         Log error
          MESSAGE e025
             WITH i_tanum
             INTO zswl_cl_log=>m_dummy_msg.
          mo_log->add( i_syst = abap_true ).
          zcx_ewm_general_exception=>raise_system_exception( ).

        ENDIF.

    ENDTRY.

    IF ms_ordim_o     IS INITIAL AND
        i_only_open =  abap_false.

      TRY .

          me->select_ordim_c( i_tanum = i_tanum ).

          m_tanum   = ms_ordim_c-tanum.
          m_status  = ms_ordim_c-tostat.

        CATCH zcx_ewm_general_exception.

*         Log error
          MESSAGE e026
             WITH i_tanum
             INTO zswl_cl_log=>m_dummy_msg.
          mo_log->add( i_syst = abap_true ).
          zcx_ewm_general_exception=>raise_system_exception( ).

      ENDTRY.

    ENDIF.

  ENDMETHOD.


METHOD select_ordim_c.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Select confirmed warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

    SELECT SINGLE *
      FROM /scwm/ordim_c
      INTO ms_ordim_c
     WHERE lgnum  = m_lgnum
       AND tanum  = i_tanum ##WARN_OK.

    IF sy-subrc <> 0.

*     Log message
      MESSAGE i024
         WITH i_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_ordim_o.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Select open warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************


    SELECT SINGLE *
      FROM /scwm/ordim_o
      INTO ms_ordim_o
     WHERE lgnum = m_lgnum
       AND tanum = i_tanum.

    IF sy-subrc <> 0.

*     Log message
      MESSAGE i023
         WITH i_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.


  ENDMETHOD.


METHOD set_conf_quantity.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the quanties before you confirm the wt.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_quan_conf TYPE zswl_s_wt_conf_quan,
      l_papos      TYPE /scwm/ltap_hu_papos.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    l_papos = me->get_next_papos( ).

    CLEAR ls_quan_conf.
    ls_quan_conf-papos    = l_papos.
    ls_quan_conf-conf_qty = i_conf_quan.
    ls_quan_conf-altme    = i_conf_uom.
    ls_quan_conf-parti    = i_parti.

    IF i_parti IS SUPPLIED AND
       i_parti = abap_true.

      ls_quan_conf-diff_qty = 0.
      ls_quan_conf-rema_qty = me->determine_quans(
                                EXPORTING
                                  i_conf_quan = i_conf_quan
                                  i_uom       = i_conf_uom )-quan.

    ELSE.

      ls_quan_conf-rema_qty = 0.
      ls_quan_conf-diff_qty = me->determine_quans(
                                EXPORTING
                                  i_conf_quan = i_conf_quan
                                  i_uom       = i_conf_uom )-quan.

    ENDIF.

    APPEND ls_quan_conf TO mt_conf_quan.


* If a exception code is supplied, we transfer them into the table for
* the exception codes
    IF i_exccode    IS NOT INITIAL AND
       i_exec_step  IS NOT INITIAL.

      me->set_exccode(
        EXPORTING
          i_papos         = l_papos
          i_exccode       = i_exccode
          i_exec_step     = i_exec_step
          i_seqno         = i_seqno
          i_exec_no_proc  = i_exec_no_proc ).

    ENDIF.

  ENDMETHOD.


METHOD set_destination.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the destination fields before you confirm the wt
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      lo_bin    TYPE REF TO zswl_cl_storage_bin,
      l_huident TYPE /scwm/de_huident.


    IF i_nlpla IS NOT INITIAL.

*     check if the destination storage bin exist
      CREATE OBJECT lo_bin
        EXPORTING
          i_lgnum      = m_lgnum
          i_lgpla      = i_nlpla
          io_log       = mo_log
*         is_lagp      =
          i_sel_lagps  = abap_false
          i_sel_status = abap_false.

      ms_ordim_o-nltyp  = lo_bin->get_lgtyp( ).
      ms_ordim_o-nlber  = lo_bin->get_lgber( ).
      ms_ordim_o-nlpla  = lo_bin->get_lgpla( ).

    ENDIF.

    IF i_nlenr IS NOT INITIAL.

      l_huident = i_nlenr.

      zswl_cl_hu=>append_leading_zeros_huident(
        CHANGING
          c_hu = l_huident ).

      IF l_huident <> ms_ordim_o-nlenr.
        ms_ordim_o-nlenr  = l_huident.
        m_nlenr_changed   = abap_true.
      ELSE.
        m_nlenr_changed = abap_false.
      ENDIF.

    ELSE.

      IF i_clear_nlenr = abap_true.

        CLEAR ms_ordim_o-nlenr.
        m_nlenr_changed = abap_true.

      ELSE.

        m_nlenr_changed = abap_false.

      ENDIF.

    ENDIF.

    IF i_drsrc IS NOT INITIAL.

      ms_ordim_o-drsrc = i_drsrc.

    ENDIF.

    IF i_dtu_num IS NOT INITIAL.

      ms_ordim_o-dtu_num = i_dtu_num.

    ENDIF.

    IF i_nlpla    IS NOT INITIAL AND
       i_nlenr    IS NOT INITIAL AND
       i_drsrc    IS NOT INITIAL AND
       i_dtu_num  IS NOT INITIAL.

*    Log error
      MESSAGE e043
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

* If a exception code is supplied, we transfer them into the table for
* the exception codes
    IF i_papos      IS NOT INITIAL AND
       i_exccode    IS NOT INITIAL AND
       i_exec_step  IS NOT INITIAL.

      me->set_exccode(
        EXPORTING
          i_papos         = i_papos
          i_exccode       = i_exccode
          i_exec_step     = i_exec_step
          i_seqno         = i_seqno
          i_exec_no_proc  = i_exec_no_proc ).

    ENDIF.

  ENDMETHOD.


METHOD set_exccode.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Set the exception code
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

    DATA:
      ls_exccode                 TYPE /scwm/s_conf_exc.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_exccode IS INITIAL.

*     Es wurde kein Ausnahmecode übergeben!
      MESSAGE e042
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CLEAR ls_exccode.
    ls_exccode-tanum        = ms_ordim_o-tanum.
    ls_exccode-papos        = i_papos.
    ls_exccode-exccode      = i_exccode.
    ls_exccode-exec_step    = i_exec_step.
    ls_exccode-seqno        = i_seqno.
    ls_exccode-exec_no_proc = i_exec_no_proc.

    CALL METHOD me->read_buscon
      EXPORTING
        i_trart  = ms_ordim_o-trart
      RECEIVING
        r_buscon = ls_exccode-buscon.

    READ TABLE mt_exccode TRANSPORTING NO FIELDS
      WITH KEY tanum    = ls_exccode-tanum
               papos    = ls_exccode-papos
               exccode  = ls_exccode-exccode.

    IF sy-subrc <> 0.

      APPEND ls_exccode TO mt_exccode.

    ENDIF.

  ENDMETHOD.


METHOD set_procty.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the process type into the warehouse task struc.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    ms_ordim_o-procty = i_procty.

  ENDMETHOD.


METHOD set_qname.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the confirmation user
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    m_qname = i_qname.

  ENDMETHOD.


METHOD set_source.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the source of the open warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      l_huident                 TYPE /scwm/de_huident.

    IF i_vlenr IS NOT INITIAL.

      l_huident = i_vlenr.

      zswl_cl_hu=>append_leading_zeros_huident(
        CHANGING
          c_hu = l_huident ).

      ms_ordim_o-vlenr  = l_huident.

    ELSE.

*     Log error
      MESSAGE e044
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD set_wtcode.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set the wt code (Called Application )
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    m_wtcode = i_wtcode.

  ENDMETHOD.


METHOD to_confirm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Confirm the actual warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_severity TYPE bapi_mtype,
      lt_bapiret TYPE bapirettab,
      lt_serid   TYPE /scwm/tt_conf_serid,
      l_qin_name TYPE trfcqnam,
      l_qempty   TYPE syst_input.

    FIELD-SYMBOLS:
      <ls_conf_serid> TYPE /scwm/s_conf_serid,
      <ls_conf>       TYPE /scwm/to_conf.
* End declarations
**********************************************************************

    CLEAR: et_ltap_vb[],
           et_bapiret[],
           e_severity,
           e_ser_err.

    IF m_who_print <> abap_false.

*********************************************************************
*     Start warehouse task confirmation
*********************************************************************
      IF i_use_smq2 = abap_false.
        CALL FUNCTION '/SCWM/TO_CONFIRM'
          EXPORTING
            iv_lgnum         = m_lgnum
            iv_subst         = m_subst
            iv_qname         = m_qname
            iv_creto         = m_creto
            iv_wtcode        = m_wtcode
            iv_update_task   = i_upd_task
            iv_commit_work   = abap_false
            iv_processor_det = m_proc_det
            it_conf          = it_conf
            it_conf_exc      = mt_exccode
            it_conf_serid    = mt_conf_serid
          IMPORTING
            et_ltap_vb       = et_ltap_vb
            et_bapiret       = lt_bapiret
            ev_severity      = e_severity
            ev_ser_err       = e_ser_err.

        APPEND LINES OF lt_bapiret TO et_bapiret.
      ENDIF.

*********************************************************************
*     Start warehouse task confirmation in Background via SMQ2
*********************************************************************
      IF i_use_smq2 = abap_true.
        READ TABLE it_conf ASSIGNING <ls_conf>
             INDEX 1
        .
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_ewm_general_exception.
        ENDIF.

*       Set queue name
        IF lines( it_conf ) > 1.
*         In case of several WT`s
          CONCATENATE 'ZQWT_'
                      <ls_conf>-tanum
                      '_MULTI'
                 INTO l_qin_name.
        ELSE.
*         Only one WT will be confirmed
          CONCATENATE 'ZQWT_'
                      <ls_conf>-tanum
                      '_SINGLE'
                 INTO l_qin_name.
        ENDIF.

*       Check if the queue name exists already
        CALL FUNCTION 'TRFC_QIN_CHECK'
          EXPORTING
            qname             = l_qin_name
*           CLIENT            = SY-MANDT
          IMPORTING
            qempty            = l_qempty
          EXCEPTIONS
            invalid_parameter = 1
            OTHERS            = 2.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_ewm_general_exception.
        ELSE.
          IF l_qempty <> abap_true.
*           Log warning
            MESSAGE w046
               WITH l_qin_name
               INTO zswl_cl_log=>m_dummy_msg.
            mo_log->add( i_syst = abap_true ).
          ENDIF.
        ENDIF.

*       Register entry in the inbound queue
        CALL FUNCTION 'TRFC_SET_QIN_PROPERTIES'
          EXPORTING
*           QOUT_NAME          = ' '
            qin_name           = l_qin_name
*           QIN_COUNT          =
*           CALL_EVENT         = ' '
*           NO_EXECUTE         = ' '
          EXCEPTIONS
            invalid_queue_name = 1
            OTHERS             = 2.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_ewm_general_exception.
        ENDIF.

**       Confirm warehouse task
*        CALL FUNCTION 'Z_EWMBBC_TO_CONFIRM_SMQ2'
*          IN BACKGROUND TASK
*          AS SEPARATE UNIT
*          EXPORTING
*            i_lgnum         = m_lgnum
*            i_subst         = m_subst
*            i_qname         = m_qname
*            i_creto         = m_creto
*            i_wtcode        = m_wtcode
*            i_update_task   = i_upd_task
*            i_commit_work   = abap_false
*            i_processor_det = m_proc_det
*            it_conf         = it_conf
*            it_conf_exc     = mt_exccode
*            it_conf_serid   = mt_conf_serid
*            i_qin_name      = l_qin_name.
      ENDIF.

    ELSE.

*     central Cleanup before WT confirmation
      /scwm/cl_tm=>cleanup( EXPORTING iv_lgnum = m_lgnum ).

      LOOP AT mt_conf_serid ASSIGNING <ls_conf_serid>
        WHERE lscheck IS INITIAL.
        APPEND <ls_conf_serid> TO lt_serid.
      ENDLOOP.

      CALL FUNCTION '/SCWM/TO_CONF_INT'
        EXPORTING
          iv_subst      = m_subst
          iv_qname      = m_qname
          iv_creto      = m_creto
          iv_wtcode     = m_wtcode
          it_conf       = it_conf
          it_conf_exc   = mt_exccode
          it_conf_serid = lt_serid
        IMPORTING
          et_ltap_vb    = et_ltap_vb
          et_bapiret    = lt_bapiret
          ev_severity   = e_severity
          ev_ser_err    = e_ser_err.

      APPEND LINES OF lt_bapiret TO et_bapiret.

      CALL FUNCTION '/SCWM/TO_CONF_INV'
        EXPORTING
          iv_qname      = m_qname
          it_conf       = it_conf
          it_ltap       = et_ltap_vb
          it_conf_serid = mt_conf_serid
        IMPORTING
          et_bapiret    = lt_bapiret
          ev_severity   = l_severity.

      APPEND LINES OF lt_bapiret TO et_bapiret.

      IF l_severity CA wmegc_severity_eax
      OR e_severity CA wmegc_severity_eax.

        IF m_write_standard_log = abap_true.
          IF l_severity CA wmegc_severity_eax.
            me->write_std_log(
              EXPORTING
                i_severity  = l_severity
                it_bapiret  = lt_bapiret ).
          ELSE.
            me->write_std_log(
              EXPORTING
                i_severity  = e_severity
                it_bapiret  = lt_bapiret ).
          ENDIF.
        ENDIF.

        IF i_commit = abap_true.
          me->commit( i_wait = abap_false ).
        ENDIF.

      ENDIF.

      CALL FUNCTION '/SCWM/TO_POST'
        EXPORTING
          iv_update_task   = i_upd_task
          iv_commit_work   = abap_false
          iv_processor_det = m_proc_det
          iv_wo_noprint    = m_who_print
        IMPORTING
          et_ltap_vb       = et_ltap_vb
          et_bapiret       = lt_bapiret
          ev_severity      = l_severity.

      APPEND LINES OF lt_bapiret TO et_bapiret.

      IF l_severity CA wmegc_severity_eax
      OR e_severity CA wmegc_severity_eax.

        IF m_write_standard_log = abap_true.
          IF l_severity CA wmegc_severity_eax.
            me->write_std_log(
              EXPORTING
                i_severity  = l_severity
                it_bapiret  = lt_bapiret ).
          ELSE.
            me->write_std_log(
              EXPORTING
                i_severity  = e_severity
                it_bapiret  = lt_bapiret ).
          ENDIF.
        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


method UPDATE_ASTASKNO.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Update the actual open warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_change_att TYPE /scwm/s_to_change_att,
      ls_changed    TYPE /scwm/s_changed,
*      lt_change_att TYPE /scwm/tt_to_change_att,
      lt_ordim_o    TYPE STANDARD TABLE OF /scwm/ordim_o.


    IF ms_ordim_o IS INITIAL.

*     Warehouse task isn`t open --> Update not possible
      MESSAGE e030
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Change warehouse task
    MESSAGE i031
       WITH m_tanum
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    ls_change_att-tanum = ms_ordim_o-tanum.
    ls_changed-fieldname = 'ZZSWL_ASTASK'.
    ls_changed-value_c = iv_astaskno.
    APPEND ls_changed TO ls_change_att-tt_changed.

*    APPEND ls_change_att TO lt_change_att.

*     Change WT and set KZSUB in update task; Commit is done later;
    ms_ordim_o-zzswl_astask = iv_astaskno.
    APPEND ms_ordim_o TO lt_ordim_o.
    UPDATE /scwm/ordim_o FROM TABLE lt_ordim_o.
*    IF lt_change_att IS NOT INITIAL.
*      CALL FUNCTION '/SCWM/TO_CHANGE_ATT'
*        EXPORTING
*          iv_lgnum       = m_lgnum
*          iv_subst       = 'X'
*          iv_qname       = sy-uname
*          iv_update_task = 'X'
*          iv_commit_work = ' '
*          it_change_att  = lt_change_att
*        IMPORTING
*          et_bapiret     = lt_bapiret
*          ev_severity    = lv_severity.
*      IF lv_severity CA wmegc_severity_ea.
*        READ TABLE lt_bapiret INTO ls_bapiret
*          WITH KEY type = wmegc_severity_err.
*        IF sy-subrc = 0.
*          MESSAGE ID     ls_bapiret-id
*                  TYPE   ls_bapiret-type
*                  NUMBER ls_bapiret-number
*                  WITH   ls_bapiret-message_v1 ls_bapiret-message_v2
*                         ls_bapiret-message_v3 ls_bapiret-message_v4
*                  INTO   zswl_cl_log=>m_dummy_msg.
*          mo_log->add( i_syst = abap_true ).
*          zcx_ewm_general_exception=>raise_system_exception( ).
*        ENDIF.
*      ENDIF.
*    ENDIF.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      me->commit( ).
    ENDIF.
  endmethod.


METHOD update_kzsub.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Update the actual open warehouse task
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      ls_change_att TYPE /scwm/s_to_change_att,
      ls_changed    TYPE /scwm/s_changed,
      lt_change_att TYPE /scwm/tt_to_change_att,
      lt_bapiret    TYPE bapirettab,
      ls_bapiret    TYPE bapiret2,
      lv_severity   TYPE bapi_mtype.


    IF ms_ordim_o IS INITIAL.

*     Warehouse task isn`t open --> Update not possible
      MESSAGE e030
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Change warehouse task
    MESSAGE i031
       WITH m_tanum
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    ls_change_att-tanum = ms_ordim_o-tanum.
    ls_changed-fieldname = 'KZSUB'.
    ls_changed-value_c = iv_kzsub.
    APPEND ls_changed TO ls_change_att-tt_changed.

    APPEND ls_change_att TO lt_change_att.

*     Change WT and set KZSUB in update task; Commit is done later;
    IF lt_change_att IS NOT INITIAL.
      CALL FUNCTION '/SCWM/TO_CHANGE_ATT'
        EXPORTING
          iv_lgnum       = m_lgnum
          iv_subst       = 'X'
          iv_qname       = sy-uname
          iv_update_task = 'X'
          iv_commit_work = ' '
          it_change_att  = lt_change_att
        IMPORTING
          et_bapiret     = lt_bapiret
          ev_severity    = lv_severity.
      IF lv_severity CA wmegc_severity_ea.
        READ TABLE lt_bapiret INTO ls_bapiret
          WITH KEY type = wmegc_severity_err.
        IF sy-subrc = 0.
          MESSAGE ID     ls_bapiret-id
                  TYPE   ls_bapiret-type
                  NUMBER ls_bapiret-number
                  WITH   ls_bapiret-message_v1 ls_bapiret-message_v2
                         ls_bapiret-message_v3 ls_bapiret-message_v4
                  INTO   zswl_cl_log=>m_dummy_msg.
          mo_log->add( i_syst = abap_true ).
          zcx_ewm_general_exception=>raise_system_exception( ).
        ENDIF.
      ENDIF.
    ENDIF.

    IF iv_commit = abap_true.
      me->commit( ).
    ENDIF.

  ENDMETHOD.


METHOD update_open_wt.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Update the actual open warehouse task
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
      lt_bapiret TYPE bapirettab,
      lt_ordim_o TYPE /scwm/tt_ordim_o,
      lt_change  TYPE /scwm/tt_to_change,
      ls_change  TYPE /scwm/s_to_change,
      ls_ordim_o TYPE /scwm/ordim_o,
      l_severity TYPE bapi_mtype.
* End declarations
**********************************************************************

    CALL FUNCTION '/SCWM/TO_INIT_NEW'
      EXPORTING
        iv_lgnum = m_lgnum.

    IF ms_ordim_o IS INITIAL.

*     Warehouse task isn`t open --> Update not possible
      MESSAGE e030
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Change warehouse task
    MESSAGE i031
       WITH m_tanum
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    ls_ordim_o = ms_ordim_o.
    me->select_ordim_o( i_tanum = ms_ordim_o-tanum ).

* Check which fields have changed. These fields hand over
* now to the changing function module
    CLEAR ls_change.
    ls_change-tanum   = m_tanum.
    IF ms_ordim_o-procty <> ls_ordim_o-procty.
      ls_change-procty  = ls_ordim_o-procty.
    ENDIF.
    IF ms_ordim_o-nltyp <> ls_ordim_o-nltyp.
      ls_change-nltyp  = ls_ordim_o-nltyp.
      ls_change-d_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-nlber <> ls_ordim_o-nlber.
      ls_change-nlber  = ls_ordim_o-nlber.
      ls_change-d_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-nlpla <> ls_ordim_o-nlpla.
      ls_change-nlpla  = ls_ordim_o-nlpla.
      ls_change-d_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-nlenr <> ls_ordim_o-nlenr.
      ls_change-nlenr  = ls_ordim_o-nlenr.
      ls_change-d_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-drsrc <> ls_ordim_o-drsrc.
      ls_change-drsrc  = ls_ordim_o-drsrc.
      ls_change-d_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-dtu_num <> ls_ordim_o-dtu_num.
      ls_change-dtu_num  = ls_ordim_o-dtu_num.
      ls_change-d_new    = abap_true.
    ENDIF.
    IF ms_ordim_o-vltyp <> ls_ordim_o-vltyp.
      ls_change-vltyp  = ls_ordim_o-vltyp.
      ls_change-s_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-vlpla <> ls_ordim_o-vlpla.
      ls_change-vlpla  = ls_ordim_o-vlpla.
      ls_change-s_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-vlenr <> ls_ordim_o-vlenr.
      ls_change-vlenr  = ls_ordim_o-vlenr.
      ls_change-s_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-srsrc <> ls_ordim_o-srsrc.
      ls_change-srsrc  = ls_ordim_o-srsrc.
      ls_change-s_new  = abap_true.
    ENDIF.
    IF ms_ordim_o-stu_num <> ls_ordim_o-stu_num.
      ls_change-stu_num  = ls_ordim_o-stu_num.
      ls_change-s_new    = abap_true.
    ENDIF.
    ls_change-stu_num = ls_ordim_o-stu_num.
    ls_change-d_exc   = abap_false.
    ls_change-s_exc   = abap_false.
    APPEND ls_change TO lt_change.

    CALL FUNCTION '/SCWM/TO_CHANGE'
      EXPORTING
        iv_lgnum       = m_lgnum
        iv_subst       = m_subst
        iv_qname       = m_qname
        iv_update_task = i_upd_task
        iv_commit_work = abap_false
        it_change      = lt_change
      IMPORTING
        et_ordim_o     = lt_ordim_o
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF me->handle_error(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          i_severity  = l_severity
          it_bapiret  = lt_bapiret ) = abap_true.

*     Log error
      MESSAGE e032
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     Log message
      MESSAGE i033
         WITH m_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

    CALL FUNCTION '/SCWM/TO_POST'
      EXPORTING
        iv_update_task   = i_upd_task
        iv_commit_work   = abap_false
        iv_processor_det = m_proc_det
*       iv_wo_noprint    =
      IMPORTING
*       et_ltap_vb       =
        et_bapiret       = lt_bapiret
        ev_severity      = l_severity.

    IF me->handle_error(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait
          i_severity  = l_severity
          it_bapiret  = lt_bapiret ) = abap_true.

*     Log error
      MESSAGE e034
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Write change data into the actual attribute
    READ TABLE lt_ordim_o INTO ms_ordim_o
      WITH KEY lgnum = m_lgnum
               tanum = m_tanum.

  ENDMETHOD.


METHOD write_std_log.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Write standard SAP logging
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-08¦ B7REHMT  ¦ Review
************************************************************************

    DATA:
      l_create_log TYPE xfeld,
      l_lognr      TYPE /scwm/de_tologno,
      ls_log_act   TYPE /scwm/log_act,
      ls_log       TYPE bal_s_log,
      lo_prot      TYPE REF TO /scwm/cl_log.

    CLEAR r_lognr.

    IF lines( it_bapiret ) > 0.
      CALL FUNCTION '/SCWM/LOG_ACT_READ_SINGLE'
        EXPORTING
          iv_lgnum     = m_lgnum
          iv_subobject = wmegc_apl_subob_whs_task
        IMPORTING
          es_log_act   = ls_log_act
        EXCEPTIONS
          OTHERS       = 0.

      CASE ls_log_act-actglob.
        WHEN wmegc_log_vip.
          IF i_severity CA 'A'.
            l_create_log = 'X'.
          ENDIF.
        WHEN wmegc_log_imp.
          IF i_severity CA 'AE'.
            l_create_log = 'X'.
          ENDIF.
        WHEN wmegc_log_med.
          IF i_severity CA 'AEW'.
            l_create_log = 'X'.
          ENDIF.
        WHEN wmegc_log_add.
          IF i_severity CA 'AEWIS'.
            l_create_log = 'X'.
          ENDIF.
        WHEN OTHERS.
      ENDCASE.

      IF l_create_log IS NOT INITIAL.
        CALL FUNCTION '/SCWM/TO_LOG_GET_LOGNR'
          EXPORTING
            iv_lgnum     = m_lgnum
            iv_memory    = 'X'
          IMPORTING
            ev_lognumber = l_lognr.

        CALL FUNCTION '/SCWM/TO_LOG_GET_INSTANCE'
          EXPORTING
            iv_lgnum = m_lgnum
          IMPORTING
            eo_prot  = lo_prot.

        ls_log-extnumber = l_lognr.
        ls_log-object    = wmegc_apl_object_wme.
        ls_log-subobject = wmegc_apl_subob_whs_task.
        ls_log-aldate    = lo_prot->mv_created_date.
        ls_log-altime    = lo_prot->mv_created_time.

*       fill expiration date for log
        CALL FUNCTION '/SCWM/APP_LOG_EXPIRY_DATE_DET'
          EXPORTING
            is_log_act = ls_log_act
          CHANGING
            cs_log     = ls_log.

*       write log in update task with low priority
        CALL FUNCTION '/SCWM/APP_LOG_WRITE_V2' IN UPDATE TASK
          EXPORTING
            is_log     = ls_log
            it_bapiret = it_bapiret.

*       store external lognumber for navigation SMQ2 -> SLG1
        r_lognr = l_lognr.
      ENDIF.
    ENDIF.

  ENDMETHOD.


METHOD zif_swlbc_object~cleanup.
    RETURN.
  ENDMETHOD.


METHOD zif_swlbc_object~free.

    CLEAR:
      ms_mfs_info,
      mt_conf_quan[],
      mt_conf_serid[],
      mt_exccode[],
      m_creto,
      m_huent,
      m_qname,
      m_proc_det,
      m_subst,
      m_who_print,
      m_wtcode.

  ENDMETHOD.
ENDCLASS.
