class ZSWL_CL_STOCK definition
  public
  inheriting from ZSWL_CL_OBJECT
  final
  create public .

public section.
  type-pools ABAP .

  class-methods READ_AVAILABLE_STOCK
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !IT_LGBER type /SCWM/TT_LGBER optional
      !IT_RSRC type /SCWM/TT_RSRC optional
      !IT_TU type /SCWM/TT_TU_NUM optional
      !IT_HU type /SCWM/TT_HUIDENT optional
      !IT_MATID type /SCWM/TT_MATID optional
      !IT_MATNR type /SAPAPO/MATNR_TAB optional
      !IT_CAT type /SCDL/DL_STOCK_CAT_TAB optional
      !I_FLG_MOVE type /SCWM/FLGMOVE optional
      !IRT_WDATU type ZSWL_TT_WDATU optional
    exporting
      !ET_STOCK_REF type ZSWL_TT_STOCK_REF
      !ET_AQUA type /SCWM/TT_AQUA
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_STOCK
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_PARENT_GUID type ZSWL_TT_GUIDPARENT optional
      !IT_QDOCID type /SCWM/TT_QDOCID optional
      !IT_INSPID type /SCWM/TT_INSPID optional
    exporting
      !ET_STOCK_REF type ZSWL_TT_STOCK_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_GUID_PARENT type /LIME/GUID_PARENT optional
      !I_GUID_STOCK type /LIME/GUID_STOCK optional
      !I_READ_AQUA type XFELD default ABAP_TRUE
      !I_READ_QUAN type XFELD default ABAP_FALSE
      !IS_AQUA type /SCWM/AQUA optional
      !IS_QUAN type /SCWM/QUAN optional
      !I_GM type XFELD default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods FREE .
  methods GET_AQUA
    returning
      value(RS_AQUA) type /SCWM/AQUA .
  methods GET_QUAN
    returning
      value(RS_QUAN) type /SCWM/QUAN .
  methods SET_DATA_FOR_GM
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_DIRECTION type /LIME/DIRECTION
      !I_REASON type /LIME/REASON
      !I_SEND_ERP type XFELD default 'X'
      !I_LGTYP type /SCWM/LGTYP optional
      !I_PROCTY type /SCWM/DE_PROCTY optional
      !IS_DLV_REF type ZSWL_S_STOCK_DOCREF optional
      !IT_STOCK type /SCWM/TT_STOCK_UPLOAD
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_MM_LGORT type /SCWM/ERP_LGORT optional .
  methods START_GM
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.

  data MS_AQUA type /SCWM/AQUA .
  data MS_DLV_REF type ZSWL_S_STOCK_DOCREF .
  data MS_QUAN type /SCWM/QUAN .
  data MT_BAPIRET type BAPIRETTAB .
  data MT_GMITEMS type /SCWM/TT_GMITEM .
  data MT_STOCK type /SCWM/TT_STOCK_UPLOAD .
  data M_DIRECTION type /LIME/DIRECTION .
  data M_LGTYP type /SCWM/LGTYP .
  data M_MM_LGORT type /SCWM/ERP_LGORT .
  data M_MOVE_REAS type /LIME/PI_REASON .
  data M_PROCTY type /SCWM/DE_PROCTY .
  data M_SEND_ERP type XFELD .
  data M_TANUM type /SCWM/TANUM .

  methods CREATE_GM
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods PREPARE_DATA_FOR_GM .
  methods SELECT_SINGLE_AQUA
    importing
      !I_GUID_PARENT type /LIME/GUID_PARENT optional
      !I_GUID_STOCK type /LIME/GUID_STOCK optional .
  methods SELECT_SINGLE_QUAN
    importing
      !I_GUID_PARENT type /LIME/GUID_PARENT
      !I_GUID_STOCK type /LIME/GUID_STOCK .
private section.
ENDCLASS.



CLASS ZSWL_CL_STOCK IMPLEMENTATION.


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

    IF i_gm = abap_false.

      IF i_guid_parent IS INITIAL AND
         i_guid_stock  IS INITIAL AND
         is_aqua       IS INITIAL AND
         is_quan       IS INITIAL.

*       No parameter for stock selection were filled
        MESSAGE e000
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*    Select available stock
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
      IF i_read_aqua = abap_true.

        IF is_aqua IS NOT INITIAL.
          ms_aqua = is_aqua.
        ELSE.
          me->select_single_aqua(
                i_guid_parent = i_guid_parent
                i_guid_stock  = i_guid_stock ).
        ENDIF.

      ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*    Select stock attributes
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
      IF i_read_quan = abap_true.

        IF is_quan IS NOT INITIAL.
          ms_quan = is_quan.
        ELSE.
          me->select_single_quan(
                i_guid_parent = i_guid_parent
                i_guid_stock  = i_guid_stock ).
        ENDIF.

        IF ms_quan IS NOT INITIAL.
          ms_dlv_ref-guid_stock = i_guid_stock.
          ms_dlv_ref-rdoccat    = ms_quan-qdoccat.
          ms_dlv_ref-rdocid     = ms_quan-qdocid.
          ms_dlv_ref-ritmid     = ms_quan-qitmid.
        ENDIF.

      ENDIF.

      IF ms_aqua IS INITIAL AND
         ms_quan IS INITIAL.

*       No stock found
        MESSAGE e001
           WITH i_guid_parent
                i_guid_stock
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD create_gm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Call standard function module for posting the
*               goods movement
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
      l_severity   TYPE bapi_mtype,
      ls_gmheader  TYPE /scwm/s_gmheader,
      ls_bapiret   TYPE bapiret2,
*      ls_item      TYPE /scwm/s_gmitem,
      lx_exception TYPE REF TO /scwm/cx_core.
* End declarations
**********************************************************************

*   Fill Header
    ls_gmheader-lgnum = m_lgnum.

    MOVE:
          sy-uname               TO ls_gmheader-created_by,
          wmegc_gmcode_init_load TO ls_gmheader-code,
          abap_true              TO ls_gmheader-compl, "all or nothing
          abap_true              TO ls_gmheader-post.  "direct posting

    GET TIME STAMP FIELD ls_gmheader-created_at.

    TRY.
*       GM Posting
        CALL FUNCTION '/SCWM/GM_CREATE'
          EXPORTING
*           IV_CALL     = ' '
            is_header   = ls_gmheader
            it_item     = mt_gmitems
          IMPORTING
            ev_tanum    = m_tanum
*           ET_RESULT   =
            et_bapiret  = mt_bapiret
            ev_severity = l_severity.
      CATCH /scwm/cx_core INTO lx_exception.            "#EC NO_HANDLER

        mo_log->add( ix_exception = lx_exception ).

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

*       Error while creating the goods movement
        MESSAGE e005
            INTO zswl_cl_log=>m_dummy_msg.

        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

    ENDTRY.

*   Log
    mo_log->add( it_bapi_list = mt_bapiret ).

    IF l_severity CA wmegc_severity_eax.

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

*     Error while creating the goods movement
      MESSAGE e005
          INTO zswl_cl_log=>m_dummy_msg.

      mo_log->add( i_syst = abap_true ).

      zcx_ewm_general_exception=>raise_system_exception( ).
    ELSE.

      READ TABLE mt_bapiret
        WITH KEY type = zswl_cl_log=>mc_msgty_status
        INTO ls_bapiret.

      IF sy-subrc = 0.
        m_tanum = ls_bapiret-message_v1.
      ENDIF.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD free.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Clear object attributes
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR: mt_gmitems,
           mt_stock,
           m_lgtyp,
           m_lgnum,
           m_move_reas,
           m_procty,
           m_send_erp,
           m_mm_lgort.


  ENDMETHOD.


METHOD get_aqua.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return /SCWM/AQUA data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rs_aqua.

    IF ms_aqua IS INITIAL.
      me->select_single_aqua(
        EXPORTING
          i_guid_parent   = ms_quan-guid_parent
          i_guid_stock    = ms_quan-guid_stock ).
    ENDIF.

    rs_aqua = ms_aqua.

  ENDMETHOD.


METHOD get_quan.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the /SCWM/QUAN data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rs_quan.

    IF ms_quan IS INITIAL.
      me->select_single_quan(
        EXPORTING
          i_guid_parent   = ms_aqua-guid_parent
          i_guid_stock    = ms_aqua-guid_stock ).
    ENDIF.

    rs_quan = ms_quan.

  ENDMETHOD.


METHOD prepare_data_for_gm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Prepare the GM structure for posting the goods movement
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
      ls_stock    TYPE /scwm/s_stock_upload,
      ls_gmitem   TYPE /scwm/s_gmitem,
      ls_quantity TYPE /scwm/s_quan,
      ls_lime_par TYPE /lime/param,
      l_id_group  TYPE /lime/line_item_group.


* End declarations
**********************************************************************

    LOOP AT mt_stock INTO ls_stock.

      CLEAR: ls_gmitem, ls_quantity.

*     Umbuchung nach MM-Lagerort
      IF m_mm_lgort IS NOT INITIAL.

        CLEAR ls_lime_par.
        ls_lime_par-param_name      = 'NWMLOC'.
        ls_lime_par-param_value     = m_mm_lgort.
        ls_lime_par-param_group     = wmegc_scwm.
        APPEND ls_lime_par          TO ls_gmitem-t_param.

        ls_gmitem-id                = 1.
        ls_gmitem-id_group          = 1.
        ls_gmitem-direction         = wmegc_lime_post_outbound.
        ls_gmitem-reason            = wmegc_lime_reason_nwlo.
        ls_gmitem-huident	          = ls_stock-huident.
        APPEND ls_gmitem            TO mt_gmitems.

      ELSE.

        MOVE:
          1                         TO ls_gmitem-id,
          l_id_group                TO ls_gmitem-id_group,
          m_direction               TO ls_gmitem-direction,
*          wmegc_lime_reason_corr    TO ls_gmitem-reason,
          wmegc_idx_lgpla           TO ls_gmitem-loc-idx_loc.

        MOVE:
          m_procty                  TO ls_gmitem-procty,
          ls_stock-lgpla            TO ls_gmitem-loc-lgpla,
          m_move_reas               TO ls_gmitem-reason_wm,
          m_lgnum                   TO ls_gmitem-loc-lgnum,
          m_lgtyp                   TO ls_gmitem-loc-lgtyp,

          ls_stock-huident          TO ls_gmitem-huident,
          ls_stock-matid            TO ls_gmitem-source_s-matid,
          ls_stock-batchid          TO ls_gmitem-source_s-batchid,
          ls_stock-cat              TO ls_gmitem-source_s-cat,
          ls_stock-stock_doccat     TO ls_gmitem-source_s-stock_doccat,
          ls_stock-stock_docno      TO ls_gmitem-source_s-stock_docno,
          ls_stock-stock_itmno      TO ls_gmitem-source_s-stock_itmno,
          ls_stock-stock_usage      TO ls_gmitem-source_s-stock_usage,
          ls_stock-owner            TO ls_gmitem-source_s-owner,
          ls_stock-owner_role       TO ls_gmitem-source_s-owner_role,
          ls_stock-entitled         TO ls_gmitem-source_s-entitled,
          ls_stock-entitled_role    TO ls_gmitem-source_s-entitled_role,

          ls_stock-matid            TO ls_gmitem-dest_s-matid,
          ls_stock-batchid          TO ls_gmitem-dest_s-batchid,
          ls_stock-cat              TO ls_gmitem-dest_s-cat,
          ls_stock-stock_doccat     TO ls_gmitem-dest_s-stock_doccat,
          ls_stock-stock_docno      TO ls_gmitem-dest_s-stock_docno,
          ls_stock-stock_itmno      TO ls_gmitem-dest_s-stock_itmno,
          ls_stock-stock_usage      TO ls_gmitem-dest_s-stock_usage,
          ls_stock-owner            TO ls_gmitem-dest_s-owner,
          ls_stock-owner_role       TO ls_gmitem-dest_s-owner_role,
          ls_stock-entitled         TO ls_gmitem-dest_s-entitled,
          ls_stock-entitled_role    TO ls_gmitem-dest_s-entitled_role.

          IF ms_quan IS NOT INITIAL AND ms_aqua IS NOT INITIAL.
            ls_gmitem-guid_hu = ms_quan-guid_parent.
            ls_gmitem-source_s-idx_stock = ms_quan-idx_stock.
            ls_gmitem-source_s-guid_stock = ms_quan-guid_stock.
            ls_gmitem-source_s-guid_stock0 = ms_quan-guid_stock0.
            ls_gmitem-source_s-qdoccat = ms_quan-qdoccat.
            ls_gmitem-source_s-qdocid = ms_quan-qdocid.
            ls_gmitem-source_s-qitmid = ms_quan-qitmid.
            ls_gmitem-dest_s-qdoccat = ms_quan-qdoccat.
            ls_gmitem-dest_s-qdocid = ms_quan-qdocid.
            ls_gmitem-dest_s-qitmid = ms_quan-qitmid.
            ls_gmitem-source_s-cat = ms_aqua-cat.
            ls_gmitem-dest_s-cat = ls_stock-cat.
          ENDIF.

        ls_quantity-quan  =  abs( ls_stock-quan ).
        ls_quantity-unit  =  ls_stock-unit.

*       Do not notify ERP-System
        IF m_send_erp IS INITIAL.

          MOVE: 'NO_ERP'   TO ls_lime_par-param_name,
                abap_true  TO ls_lime_par-param_value,
                wmegc_scwm TO ls_lime_par-param_group.

          APPEND ls_lime_par TO ls_gmitem-t_param.
          CLEAR: ls_lime_par.
        ENDIF.

        APPEND ls_quantity TO ls_gmitem-t_quan.
        APPEND ls_gmitem   TO mt_gmitems.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


METHOD read_available_stock.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select the available stock and
*               return stock tables
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
      <ls_aqua>    TYPE /scwm/aqua,
      <l_lgpla>    TYPE /scwm/lgpla,
      <l_lgtyp>    TYPE /scwm/lgtyp,
      <l_lgber>    TYPE /scwm/lgber,
      <ls_rsrc>    TYPE /scwm/rsrc,
      <l_tu_num>   TYPE /scwm/de_tu_num,
      <ls_huident> TYPE /scwm/s_huident,
      <lrs_wdatu>  TYPE zswl_s_wdatu,
      <l_matid>    TYPE /scwm/de_matid,
      <ls_matnr>   TYPE /sapapo/matnr_str,
      <ls_cat>     TYPE /scdl/dl_stock_cat_str.

    DATA:
*      lt_aqua                   TYPE /scwm/tt_aqua,
      ls_stock   TYPE zswl_s_stock_ref,
      lrs_selopt TYPE rsdsselopt,
      lrs_matid  TYPE rsdsselopt.

    DATA:
      lrt_lgpla    TYPE rseloption,
      lrt_lgtyp    TYPE rseloption,
      lrt_lgber    TYPE rseloption,
      lrt_rsrc     TYPE rseloption,
      lrt_tu       TYPE rseloption,
      lrt_hu       TYPE rseloption,
      lrt_matid    TYPE rseloption,
      lrt_matnr    TYPE rseloption,
      lrt_cat      TYPE rseloption,
      lrt_wdatu    TYPE rseloption,
      lrt_flg_move TYPE rseloption.

* End declarations
**********************************************************************

    CLEAR et_stock_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.
*     Log error
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fill Range tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    CLEAR lrs_selopt.
    lrs_selopt-option   = wmegc_option_eq.
    lrs_selopt-sign     = wmegc_sign_inclusive.

*   for storage bins
    LOOP AT it_lgpla ASSIGNING <l_lgpla>.

      IF <l_lgpla> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <l_lgpla>.
      APPEND lrs_selopt TO lrt_lgpla.

    ENDLOOP.

*   for storage types
    LOOP AT it_lgtyp ASSIGNING <l_lgtyp>.

      IF <l_lgtyp> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <l_lgtyp>.
      APPEND lrs_selopt TO lrt_lgtyp.

    ENDLOOP.

*   for storage areas
    LOOP AT it_lgber ASSIGNING <l_lgber>.

      IF <l_lgber> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <l_lgber>.
      APPEND lrs_selopt TO lrt_lgber.

    ENDLOOP.

*   for ressources
    LOOP AT it_rsrc ASSIGNING <ls_rsrc>.

      IF <ls_rsrc>-rsrc IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <ls_rsrc>-rsrc.
      APPEND lrs_selopt TO lrt_rsrc.

    ENDLOOP.

*   for transport units
    LOOP AT it_tu ASSIGNING <l_tu_num>.

      IF <l_tu_num> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <l_tu_num>.
      APPEND lrs_selopt TO lrt_tu.

    ENDLOOP.

*   for Handling Units
    LOOP AT it_hu ASSIGNING <ls_huident>.

      IF <ls_huident>-huident IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <ls_huident>-huident.
      APPEND lrs_selopt TO lrt_hu.

    ENDLOOP.

*   for material identifications
    LOOP AT it_matid ASSIGNING <l_matid>.

      IF <l_matid> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_matid.
      lrs_matid-option  = wmegc_option_eq.
      lrs_matid-sign    = wmegc_sign_inclusive.
      lrs_matid-low     = <l_matid>.
      APPEND lrs_matid TO lrt_matid.

    ENDLOOP.

*   for Material numbers
    LOOP AT it_matnr ASSIGNING <ls_matnr>.

      IF <ls_matnr>-matnr IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <ls_matnr>-matnr.
      APPEND lrs_selopt TO lrt_matnr.

    ENDLOOP.

*   for storage categories
    LOOP AT it_cat ASSIGNING <ls_cat>.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = <ls_cat>-stock_category.
      APPEND lrs_selopt TO lrt_cat.

    ENDLOOP.

    IF i_flg_move IS SUPPLIED.

      CLEAR: lrs_selopt-high,
             lrs_selopt-low.

      lrs_selopt-low = i_flg_move.
      APPEND lrs_selopt TO lrt_flg_move.

    ENDIF.

    LOOP AT irt_wdatu ASSIGNING <lrs_wdatu>.

      CLEAR lrs_selopt.
      MOVE-CORRESPONDING <lrs_wdatu> TO lrs_selopt.
      APPEND lrs_selopt TO lrt_wdatu.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Select available stock
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL FUNCTION '/SCWM/AQUA_SELECT'
      EXPORTING
        iv_lgnum    = i_lgnum
*       IV_CHECK_AUTH    = ' '
*       IT_AQUA_GUID     =
*       IR_GUID_STOCK    =
*       IR_GUID_PARENT   =
*       IR_LGTYPGRP =
        ir_lgtyp    = lrt_lgtyp
        ir_lgber    = lrt_lgber
        ir_lgpla    = lrt_lgpla
        ir_rsrc     = lrt_rsrc
        ir_tu_num   = lrt_tu
        ir_huident  = lrt_hu
        ir_flgmove  = lrt_flg_move
        ir_matid    = lrt_matid
        ir_matnr    = lrt_matnr
*       IR_STOCK_USAGE   =
*       IR_OWNER    =
*       IR_OWNER_ROLE    =
        ir_cat      = lrt_cat
*       IR_STOCK_DOCCAT  =
*       IR_STOCK_DOCNO   =
*       IR_STOCK_ITMNO   =
*       IR_DOCCAT   =
*       IR_ENTITLED =
*       IR_ENTITLED_ROLE =
*       IR_BATCHID  =
*       IR_CHARG    =
*       IR_VFDAT    =
        ir_wdatu    = lrt_wdatu
*       IR_COO      =
*       IR_OUTCON   =
*       IR_LPTYP    =
*       IR_HUTYP    =
*       IR_PMTYP    =
*       IV_NO_OPUNIT     = ' '
      IMPORTING
*       ET_AQUA_INT =
        et_aqua     = et_aqua
*       EV_FILTERED_AUTH =
      EXCEPTIONS
        wrong_input = 1
        OTHERS      = 2.

    IF sy-subrc <> 0.

*     No available stock found
      MESSAGE e003
        INTO zswl_cl_log=>m_dummy_msg.

      co_log->add( i_syst = abap_true ).

      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Build return tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT et_aqua ASSIGNING <ls_aqua>.

      CLEAR ls_stock.
      ls_stock-lgnum        = i_lgnum.
      ls_stock-guid_parent  = <ls_aqua>-guid_parent.
      ls_stock-guid_stock   = <ls_aqua>-guid_stock.

      CREATE OBJECT ls_stock-o_stock
        EXPORTING
          i_lgnum       = i_lgnum
          io_log        = co_log
          i_guid_parent = <ls_aqua>-guid_parent
          i_guid_stock  = <ls_aqua>-guid_stock
          is_aqua       = <ls_aqua>
*         is_quan       =
*         i_read_aqua   =
          i_read_quan   = abap_true.

      APPEND ls_stock TO et_stock_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD read_stock.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Read the stock data and return
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
      <ls_quan>       TYPE /scwm/quan,
      <ls_qdocid>     TYPE /scwm/s_qdocid,
      <l_parent_guid> TYPE /lime/guid_parent,
      <l_inspid>      TYPE /scwm/de_inspid.

    DATA:
      lt_quan      TYPE TABLE OF /scwm/quan,
      ls_stock_ref TYPE zswl_s_stock_ref.

    DATA:
      lrt_qdocid      TYPE /scwm/tt_qdocid_r,
      lrt_qitemid     TYPE RANGE OF /scwm/de_itmid,
      lrt_qdoccat     TYPE RANGE OF /scwm/de_doccat,
      lrt_parent_guid TYPE RANGE OF /lime/guid_parent,
      lrt_inspid      TYPE RANGE OF /scwm/de_inspid.

    DATA:
      lrs_qdocid      TYPE /scwm/s_qdocid_r,
      lrs_qitemid     LIKE LINE OF lrt_qitemid,
      lrs_qdoccat     LIKE LINE OF lrt_qdoccat,
      lrs_parent_guid LIKE LINE OF lrt_parent_guid,
      lrs_inspid      LIKE LINE OF lrt_inspid.

* End declarations
**********************************************************************


    CLEAR et_stock_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     No warehouse no.
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Fill Range tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    LOOP AT it_parent_guid ASSIGNING <l_parent_guid>.

      CLEAR lrs_parent_guid.
      lrs_parent_guid-option = wmegc_option_eq.
      lrs_parent_guid-sign   = wmegc_sign_inclusive.
      lrs_parent_guid-low    = <l_parent_guid>.
      APPEND lrs_parent_guid TO lrt_parent_guid.

    ENDLOOP.

    LOOP AT it_qdocid ASSIGNING <ls_qdocid>.

      IF <ls_qdocid>-qdocid IS NOT INITIAL.

        CLEAR lrs_qdocid.
        lrs_qdocid-option = wmegc_option_eq.
        lrs_qdocid-sign   = wmegc_sign_inclusive.
        lrs_qdocid-low    = <ls_qdocid>-qdocid.
        APPEND lrs_qdocid TO lrt_qdocid.

      ENDIF.

      IF <ls_qdocid>-qitmid IS NOT INITIAL.

        CLEAR lrs_qitemid.
        lrs_qitemid-option = wmegc_option_eq.
        lrs_qitemid-sign   = wmegc_sign_inclusive.
        lrs_qitemid-low    = <ls_qdocid>-qitmid.
        APPEND lrs_qitemid TO lrt_qitemid.

      ENDIF.

      IF <ls_qdocid>-qdoccat IS NOT INITIAL.

        CLEAR lrs_qdoccat.
        lrs_qdoccat-option = wmegc_option_eq.
        lrs_qdoccat-sign   = wmegc_sign_inclusive.
        lrs_qdoccat-low    = <ls_qdocid>-qdoccat.
        APPEND lrs_qdoccat TO lrt_qdoccat.

      ENDIF.

    ENDLOOP.

    LOOP AT it_inspid ASSIGNING <l_inspid>.

      CLEAR lrs_inspid.
      lrs_inspid-option = wmegc_option_eq.
      lrs_inspid-sign   = wmegc_sign_inclusive.
      lrs_inspid-low    = <l_inspid>.
      APPEND lrs_inspid TO lrt_inspid.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Select stock
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    SELECT *
      FROM /scwm/quan
      INTO TABLE lt_quan
     WHERE guid_parent IN lrt_parent_guid
       AND qdocid      IN lrt_qdocid
       AND qitmid      IN lrt_qitemid
       AND qdoccat     IN lrt_qdoccat
       AND inspid      IN lrt_inspid.

    IF sy-subrc <> 0.

*     No stock found for select options
      MESSAGE e004
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Build return tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT lt_quan ASSIGNING <ls_quan>.

      CLEAR ls_stock_ref.
      ls_stock_ref-lgnum        = i_lgnum.
      ls_stock_ref-guid_parent  = <ls_quan>-guid_parent.
      ls_stock_ref-guid_stock   = <ls_quan>-guid_stock.

      CREATE OBJECT ls_stock_ref-o_stock
        EXPORTING
          i_lgnum     = i_lgnum
          io_log      = co_log
*         i_guid_parent =
*         i_guid_stock  =
*         is_aqua     =
          is_quan     = <ls_quan>
          i_read_aqua = abap_false.
*          i_read_quan   =

      APPEND ls_stock_ref TO et_stock_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD select_single_aqua.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select single entry from /SCWM/AQUA for incoming params.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT SINGLE *
      FROM /scwm/aqua
      INTO ms_aqua
     WHERE guid_parent = i_guid_parent
       AND guid_stock  = i_guid_stock.

    IF sy-subrc <> 0.

      CLEAR ms_aqua.

*     Log error
      MESSAGE i006
         WITH i_guid_parent
              i_guid_stock
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD select_single_quan.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select single entry from /SCWM/QUAN for incoming params.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT SINGLE *
      FROM /scwm/quan
      INTO ms_quan
     WHERE guid_parent = i_guid_parent
       AND guid_stock  = i_guid_stock.

    IF sy-subrc <> 0.

      CLEAR ms_quan.

*     Log error
      MESSAGE i007
         WITH i_guid_parent
              i_guid_stock
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD set_data_for_gm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Fill attributes for goods movement process
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    m_lgnum     = i_lgnum.
    mt_stock    = it_stock.
    m_move_reas = i_reason.
    m_send_erp  = i_send_erp.
    m_procty    = i_procty.
    ms_dlv_ref  = is_dlv_ref.
    m_lgtyp     = i_lgtyp.
    m_direction = i_direction.
    m_mm_lgort  = i_mm_lgort.

  ENDMETHOD.


METHOD start_gm.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Execute the goods movement
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    prepare_data_for_gm( ).

    create_gm(
      EXPORTING
        i_commit = i_commit
        i_wait   = i_wait ).

    free( ).

  ENDMETHOD.
ENDCLASS.
