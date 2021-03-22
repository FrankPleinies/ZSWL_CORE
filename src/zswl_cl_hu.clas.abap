class ZSWL_CL_HU definition
  public
  inheriting from ZSWL_CL_OBJECT
  create public .

public section.

  interfaces ZIF_SWLBC_OBJECT .

  constants MC_HUIDENT_ONE type /SCWM/HUIDENT value '00000000000000000001' ##NO_TEXT.

  methods PROCESS_COMPLETED
    importing
      !IV_WORKSTATION type ZSWL_DE_WORKSTATION .
  methods GET_STOCK
    exporting
      !ET_STOCK type /SCWM/TT_STOCK_SELECT
      !EV_QUANTITY type /SCWM/DE_QUANTITY .
  methods HAS_STOCK
    returning
      value(RV_STOCK) type BOOLEAN .
  methods GET_HUTYP
    returning
      value(R_HUTYP) type /SCWM/DE_HUTYP .
  class-methods APPEND_LEADING_ZEROS_HUIDENT
    changing
      !C_HU type /SCWM/DE_HUIDENT .
  class-methods BUILD_OBJECTS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_HUHDR type /SCWM/TT_HUHDR_INT
      !IT_HUITM type /SCWM/TT_HUITM_INT
      !IT_HUREF type /SCWM/TT_HUREF_INT
      !IT_HUTREE type /SCWM/TT_HUTREE
      !IV_ONLY_SUB_HUS type BOOLEAN default ABAP_FALSE
    exporting
      value(ET_HU_REF) type ZSWL_TT_HU_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods DELETE_LEADING_ZEROS_HUIDENT
    changing
      !C_HU type /SCWM/DE_HUIDENT .
  class-methods GET_HUTYPE_DESC
    importing
      !I_HUTYPE type /SCWM/DE_HUTYP
    exporting
      !E_HUTYPE_TXT type /SCWM/DE_DESC40
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_INSTANCE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !I_CLEANUP type XFELD default ABAP_FALSE
      !I_LOCK type XFELD default ABAP_FALSE
      !I_READ_HU_TREE type XFELD default ABAP_FALSE
      !I_READ_FROM_GM type XFELD default ABAP_FALSE
      !I_CREATE_HU type XFELD default ABAP_FALSE
      !I_PMAT type /SCMB/MDL_PRODUCT_NO optional
      !I_LGPLA type /SCWM/DE_LGPLA optional
      !I_RSRC type /SCWM/DE_RSRC optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
      !EO_HU type ref to ZSWL_CL_HU
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods IS_HU_EXISTING
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_HUIDENT type /SCWM/DE_HUIDENT
      !I_VHI type /SCWM/VHI optional
    exporting
      !E_EXISTING type XFELD
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_HUS_BY_GUID
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_GUID type /SCWM/TT_GUID_HU
      !IV_ONLY_SUB_HUS type BOOLEAN default ABAP_FALSE
    exporting
      !ET_HU type ZSWL_TT_HU_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_HUS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_HUIDENT type /SCWM/TT_HUIDENT
    exporting
      !ET_HU type ZSWL_TT_HU_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !I_CLEANUP type XFELD default ABAP_FALSE
      !I_LOCK type XFELD default ABAP_FALSE
      !I_READ_HU_TREE type XFELD default ABAP_FALSE
      !I_READ_FROM_GM type XFELD default ABAP_FALSE
      !I_CREATE_HU type XFELD default ABAP_FALSE
      !I_PMAT type /SCMB/MDL_PRODUCT_NO optional
      !IS_HU_CREATE type /SCWM/S_HUHDR_CREATE_EXT optional
      !I_LGPLA type /SCWM/DE_LGPLA optional
      !I_RSRC type /SCWM/DE_RSRC optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DELETE
    importing
      !I_SAVE type XFELD default ABAP_TRUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CHANGE_STOCK
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
      !IV_STOCK_CAT type /LIME/STOCK_CATEGORY
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DELETE_STOCK
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_GUID
    returning
      value(R_GUID_HU) type /SCWM/GUID_HU .
  methods GET_HUHDR_ALL
    returning
      value(RT_HUHDR) type /SCWM/TT_HUHDR_INT .
  methods GET_HUHDR_HU
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    returning
      value(RS_HUHDR) type /SCWM/S_HUHDR_INT .
  methods GET_HUHDR_TOP
    returning
      value(RS_HUHDR) type /SCWM/S_HUHDR_INT .
  methods GET_HUTREE
    returning
      value(RT_HUTREE) type /SCWM/TT_HUTREE .
  methods GET_HU_IDENT
    importing
      !I_IDART type /SCWM/DE_HUIDART optional
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    exporting
      !ES_HUID type /SCWM/S_HU_IDENT
      !ET_HUID type /SCWM/TT_HU_IDENT .
  methods GET_HUREF_ALL
    returning
      value(ET_HUREF) type /SCWM/TT_HUREF_INT .
  methods GET_ITEM_ALL
    exporting
      !ET_HUITM type /SCWM/TT_HUITM_INT .
  methods GET_ITEM_HU
    importing
      !I_GUID_HU type /SCWM/GUID_HU
    exporting
      !ET_HUITM type /SCWM/TT_HUITM_INT .
  methods GET_OPEN_HU_WT
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    returning
      value(RS_ORDIM_O) type /SCWM/ORDIM_O .
  methods GET_OPEN_HU_WTS
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
  methods GET_OPEN_PICKS
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
  methods INIT_PACK
    importing
      !IT_GUID_HU type /SCWM/TT_GUID_HU optional
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !I_PROCTY type /SCWM/DE_PROCTY optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods LOCK
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods MOVE
    importing
      !I_UPD_TASK type /SCWM/RL03AVERBU default ABAP_FALSE
      !I_COMMIT type /SCWM/RL03ACOMIT default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_WTCODE type /SCWM/DE_WTCODE optional
      !I_BNAME type /SCWM/LVS_BNAME default SY-UNAME
      !I_PROCTY type /SCWM/DE_PROCTY
      !I_SQUIT type /SCWM/RL03TSQUIT default ABAP_FALSE
      !I_NLPLA type /SCWM/DE_LGPLA optional
      !I_NLENR type /SCWM/DE_HUIDENT optional
      !I_NRSRC type /SCWM/DE_RSRC optional
      !I_NTU type /SCWM/DE_TU_NUM optional
    returning
      value(RO_WT) type ref to ZSWL_CL_WT
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods PACK_HU_STOCK_TO_HU
    importing
      !I_PROCTY type /SCWM/DE_PROCTY
      !I_HUGUID_SRC type /SCWM/GUID_HU optional
      !IT_HUITM_SRC type /SCWM/TT_HUITM_INT optional
      !I_SAVE type XFELD default ABAP_TRUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods PACK_HU_TO_HU
    importing
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !I_PROCTY type /SCWM/DE_PROCTY optional
      !I_SOURCE_GUID_HU type /SCWM/GUID_HU optional
      !IT_SOURCE_GUID_HU type /SCWM/TT_GUID_HU optional
      !I_SAVE type XFELD default ABAP_TRUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods PACK_STOCK_FROM_HU_TO_LGPLA
    importing
      !I_NLPLA type /SCWM/DE_LGPLA
      !I_SOURCE_HU type /SCWM/DE_HUIDENT optional
      !IT_HUITM type /SCWM/TT_STOCK_SELECT optional
      !I_PROCTY type /SCWM/DE_PROCTY optional
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_SAVE type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods PACK_STOCK_TO_HU
    importing
      !I_WORKSTATION type /SCWM/DE_WORKSTATION optional
      !IS_QUANTITY type /SCWM/S_QUAN optional
      !IS_STOCK type /SCWM/S_HUITM_KEY optional
      !IT_STOCK type /SCWM/TT_HUITM_KEY optional
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_MATNR type /SCWM/TT_MATNR_MATID optional
      !I_DOCID type /SCDL/DL_DOCID optional
      !I_ITEMID type /SCDL/DL_ITEMID optional
      !I_LOCATION type /SCWM/LGPLA optional
      !I_PROCTY type /SCWM/DE_PROCTY optional
      !I_SAVE type XFELD default ABAP_TRUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SAVE
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_HUHDR
    importing
      !IS_HUHDR type /SCWM/S_HUHDR_INT .
  methods SET_HUREF
    importing
      !IT_HUREF type /SCWM/TT_HUREF .
  methods SET_HUTREE
    importing
      !IT_HUTREE type /SCWM/TT_HUTREE .
  methods SET_HUITM
    importing
      !IT_HUITEM type /SCWM/TT_HUITM_INT .
  methods UPDATE_HU_IDENT
    importing
      !I_HU_IDENT type /SCWM/DE_IDENT
      !I_IDART type /SCWM/DE_HUIDART
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UNLOCK
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UPDATE_HUHDR
    importing
      !IS_HUHDR type /SCWM/S_HUHDR_INT
      !I_SAVE type XFELD default ABAP_TRUE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods REFRESH
    importing
      !IV_READ_HU_TREE type XFELD default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_OPEN_INTERNAL_MOVES
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
protected section.

  data MO_PACK type ref to /SCWM/CL_WM_PACKING .
  data MO_WORKSTATION type ref to ZSWL_CL_WORKSTATION .
  data MS_HUHDR type /SCWM/S_HUHDR_INT .
  data MT_HUHDR_ALL type /SCWM/TT_HUHDR_INT .
  data MT_HUITM type /SCWM/TT_HUITM_INT .
  data MT_HUREF type /SCWM/TT_HUREF_INT .
  data MT_HUTREE type /SCWM/TT_HUTREE .
  data MT_HU_IDENT type /SCWM/TT_HU_IDENT .

  methods CREATE
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
      !I_PMAT type /SCMB/MDL_PRODUCT_NO
      !I_LGPLA type /SCWM/LGPLA optional
      !IS_HU_CREATE type /SCWM/S_HUHDR_CREATE_EXT optional
      !I_RSRC type /SCWM/DE_RSRC optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods READ_HU
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
      !I_LOCK type XFELD default ABAP_FALSE
      !I_READ_FROM_GM type XFELD default ABAP_FALSE
      !I_READ_HU_TREE type XFELD default ABAP_FALSE
      !I_CREATE type XFELD default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods REREAD_HU
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_HU_IDENT
    importing
      !I_IDART type /SCWM/DE_HUIDART
      !I_HUIDENT type /SCWM/DE_HUIDENT .
  methods SELECT_OPEN_HU_WT
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
  methods SELECT_OPEN_PICKS
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
  methods SELECT_QUIT_PICKS
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
    returning
      value(RT_ORDIM_C) type /SCWM/TT_ORDIM_C .
  methods SELECT_OPEN_INTERNAL_MOVES
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
    returning
      value(RT_ORDIM_O) type /SCWM/TT_ORDIM_O .
  methods READ_HU_GM
    importing
      !I_HUIDENT type /SCWM/DE_HUIDENT
    exporting
      !ET_HUHDR type /SCWM/TT_HUHDR_INT
      !ET_HUITM type /SCWM/TT_HUITM_INT
      !ET_HUREF type /SCWM/TT_HUREF_INT
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  class-data ST_HU_REFERENCES type ZSWL_TT_HU_REF .

  methods GET_HU_IDENT_FROM_ATTRIBUTES
    importing
      !I_IDART type /SCWM/DE_HUIDART optional
      !I_HUIDENT type /SCWM/DE_HUIDENT optional
    exporting
      !ES_HUID type /SCWM/S_HU_IDENT
      !ET_HUID type /SCWM/TT_HU_IDENT .
  methods LOG_SAP_PROT .
ENDCLASS.



CLASS ZSWL_CL_HU IMPLEMENTATION.


METHOD append_leading_zeros_huident.
************************************************************************
* Company     : Swisslog AG
*
* Description : Fill the HUIDENT field with '0'
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL FUNCTION 'CONVERSION_EXIT_HUID_INPUT'
      EXPORTING
        input  = c_hu
      IMPORTING
        output = c_hu.

  ENDMETHOD.


METHOD build_objects.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Build HU objects with the incoming data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author      ¦ Description
* ------- ¦ -------- ¦ ------------ ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ F. Pleinies  ¦ Initial version
* 1.1     ¦2016-09-27¦ T. Rehmann   ¦ Review
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_huhdr>     TYPE /scwm/s_huhdr_int,
      <ls_huhdr_sub> TYPE /scwm/s_huhdr_int,
      <ls_huitm>     TYPE /scwm/s_huitm_int,
      <ls_huref>     TYPE /scwm/s_huref_int,
      <ls_hutree>    TYPE /scwm/s_hutree.

    DATA:
*      lt_huhdr_hu  TYPE /scwm/tt_huhdr_int,
      lt_huitm_hu  TYPE /scwm/tt_huitm_int,
      lt_huref_hu  TYPE /scwm/tt_huref,
      lt_hutree_hu TYPE /scwm/tt_hutree,
      ls_hu_obj    LIKE LINE OF et_hu_ref.

* End declarations
**********************************************************************

* Implementation

    CLEAR et_hu_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

* Top-HUs verarbeiten
    LOOP AT it_huhdr ASSIGNING <ls_huhdr>.

      IF iv_only_sub_hus = abap_true.
        IF <ls_huhdr>-top = abap_true.
          CONTINUE.
        ENDIF.
      ELSE.
        IF <ls_huhdr>-top = abap_false.
          CONTINUE.
        ENDIF.
      ENDIF.

      CLEAR: lt_huitm_hu[],
             lt_huref_hu[],
             lt_hutree_hu[].

      CLEAR: ls_hu_obj.

      ls_hu_obj-lgnum   = i_lgnum.
      ls_hu_obj-huident = <ls_huhdr>-huident.

      TRY.

          CREATE OBJECT ls_hu_obj-o_hu
            EXPORTING
              i_lgnum     = i_lgnum
              io_log      = co_log
              i_create_hu = abap_false.

          ls_hu_obj-o_hu->set_huhdr(
            EXPORTING
              is_huhdr = <ls_huhdr> ).

*          APPEND <ls_huhdr> TO lt_huhdr_hu.

*       Position der HU
          LOOP AT it_huitm ASSIGNING <ls_huitm>
            WHERE guid_parent = <ls_huhdr>-guid_hu.
            APPEND <ls_huitm> TO lt_huitm_hu.
          ENDLOOP.

*       Referenzen der HU
          LOOP AT it_huref ASSIGNING <ls_huref>
            WHERE guid_hu = <ls_huhdr>-guid_hu.
            APPEND <ls_huref> TO lt_huref_hu.
          ENDLOOP.

*       Ermittle und setze HU-Baum der Hierarchie
          LOOP AT it_hutree ASSIGNING <ls_hutree>
            WHERE guid_parent = <ls_huhdr>-guid_hu.

            APPEND <ls_hutree> TO lt_hutree_hu.

            READ TABLE it_huhdr ASSIGNING <ls_huhdr_sub>
              WITH KEY guid_hu = <ls_hutree>-guid.
            IF sy-subrc = 0.

*              APPEND <ls_huhdr_sub> TO lt_huhdr_hu.

            ENDIF.

*         Positionen der Sub-HU
            LOOP AT it_huitm ASSIGNING <ls_huitm>
              WHERE guid_parent = <ls_hutree>-guid.
              APPEND <ls_huitm> TO lt_huitm_hu.
            ENDLOOP.

*         Referenzen der Sub-HU
            LOOP AT it_huref ASSIGNING <ls_huref>
              WHERE guid_hu = <ls_hutree>-guid.
              APPEND <ls_huref> TO lt_huref_hu.
            ENDLOOP.

          ENDLOOP.

*       Setze Positionsdaten
          ls_hu_obj-o_hu->set_huitm(
            EXPORTING
              it_huitem  = lt_huitm_hu ).

*       Setze HU-Baum
          ls_hu_obj-o_hu->set_hutree(
            EXPORTING
              it_hutree = lt_hutree_hu ).

*       Setze Referenzdaten
          ls_hu_obj-o_hu->set_huref(
            EXPORTING
              it_huref  = lt_huref_hu ).

**       Setze Kopfdaten
*          ls_hu_obj-o_hu->set_huhdr_all(
*            EXPORTING
*              it_huhdr  = lt_huhdr_hu ).

        CATCH zcx_ewm_general_exception.
          CONTINUE.
      ENDTRY.

      APPEND ls_hu_obj TO et_hu_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD change_stock.
************************************************************************
* Company     : Swisslog AG
*
* Description : Post the whole HU stock to incoming stock category
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2019-07-17¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA: lo_stock   TYPE REF TO zswl_cl_stock,
          ls_stock   TYPE        /scwm/s_stock_upload,
          lt_stock   TYPE        /scwm/tt_stock_upload,
          lv_huident TYPE       /scwm/de_huident.

    FIELD-SYMBOLS:
      <ls_huitm> TYPE /scwm/s_huitm_int,
      <ls_huhdr> TYPE /scwm/s_huhdr_int.

    IF i_huident IS NOT INITIAL.
      lv_huident = i_huident.
      zswl_cl_hu=>append_leading_zeros_huident( CHANGING c_hu = lv_huident ).
    ELSE.
      lv_huident = ms_huhdr-huident.
    ENDIF.

*   >> Lösche gepackten Bestand für HU [&]
    MESSAGE i097
       WITH iv_stock_cat lv_huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
      WITH KEY lgnum   = m_lgnum
               huident = lv_huident.

    IF sy-subrc <> 0.

*     HU [&] ist in der HU-Hierarchie nicht vorhanden!
      MESSAGE e094
         WITH lv_huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

      LOOP AT mt_huitm ASSIGNING <ls_huitm>
*        WHERE guid_parent = <ls_huhdr>-guid_hu
          WHERE cat <> iv_stock_cat.

        CLEAR: ls_stock,
               lt_stock.
        IF i_huident IS SUPPLIED AND i_huident IS NOT INITIAL.
          IF <ls_huitm>-guid_parent <> <ls_huhdr>-guid_hu.
            CONTINUE.
          ENDIF.
        ENDIF.

        ls_stock-mandt          = <ls_huitm>-mandt.
        ls_stock-huident        = ms_huhdr-huident.
*        ls_stock-
        ls_stock-matid          = <ls_huitm>-matid.
        ls_stock-quan           = <ls_huitm>-quan.
        ls_stock-unit           = <ls_huitm>-altme.
        ls_stock-cat            = iv_stock_cat.
        ls_stock-coo            = <ls_huitm>-coo.
        ls_stock-owner          = <ls_huitm>-owner.
        ls_stock-owner_role     = <ls_huitm>-owner_role.
        ls_stock-entitled       = <ls_huitm>-entitled.
        ls_stock-entitled_role  = <ls_huitm>-entitled_role.
        ls_stock-lgpla          = <ls_huhdr>-lgpla.
        "Customer stock fields
        ls_stock-stock_doccat   = <ls_huitm>-stock_doccat.
        ls_stock-stock_docno   = <ls_huitm>-stock_docno.
        ls_stock-stock_itmno   = <ls_huitm>-stock_itmno.

*        ls_stock-
        APPEND ls_stock TO lt_stock.

        DATA(ls_tophuid) = get_guid( ).
        "Read /scwm/aqua because of subhuid key
        SELECT SINGLE *
          FROM /scwm/aqua
          INTO @DATA(ls_aqua)
         WHERE guid_parent = @ls_tophuid
           AND guid_stock  = @<ls_huitm>-guid_stock.


        CREATE OBJECT lo_stock
          EXPORTING
            i_lgnum       = m_lgnum
            io_log        = mo_log
            i_guid_parent = <ls_huitm>-guid_parent
            i_guid_stock  = <ls_huitm>-guid_stock
*           i_read_aqua   = ABAP_TRUE
            i_read_quan   = abap_true
            is_aqua       = ls_aqua
*           is_quan       =
            i_gm          = abap_false.

        CALL METHOD lo_stock->set_data_for_gm
          EXPORTING
            i_lgnum     = m_lgnum
            i_direction = wmegc_lime_post_transfer
            i_reason    = ' ' "wmegc_lime_reason_scrp
            i_send_erp  = abap_true
*           i_lgtyp     =
            i_procty    = '4010'
*           is_dlv_ref  =
            it_stock    = lt_stock
            io_log      = mo_log.

        CALL METHOD lo_stock->start_gm
          EXPORTING
            i_commit = i_commit
            i_wait   = i_wait.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


METHOD constructor.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Constructor. Build HU object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declaration

    DATA:
      l_lock TYPE char1,
*      ls_workst TYPE /scwm/tworkst,
      ls_ref TYPE zswl_s_hu_ref.
* End declaration
**********************************************************************

    super->constructor(
      EXPORTING
        i_lgnum     = i_lgnum
        io_log      = io_log ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Cleanup
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_cleanup = abap_true.

*     Cleanup for warehouse number
      CALL METHOD /scwm/cl_tm=>cleanup
        EXPORTING
          iv_lgnum = m_lgnum.

*     Cleanup for HU class
*      zswl_cl_hu=>cleanup( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Initialisierung Pack-Objekt
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    me->init_pack( i_workstation = i_workstation ).

* { #001
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Setzen des Sperrkennzeichens
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_lock = abap_true.
      l_lock = 'E'."zswl_if_constants=>mc_enqueue_type_writing.
    ENDIF.
* } #001

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   HU lesen - falls eine HU-Number mitgegeben wurde
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_huident   IS NOT INITIAL AND
       i_create_hu = abap_false.

      me->read_hu(
        EXPORTING
          i_huident       = i_huident
          i_lock          = l_lock  " #001
          i_create        = i_create_hu
          i_read_hu_tree  = i_read_hu_tree
          i_read_from_gm  = i_read_from_gm ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Falls das Flag zum Erstellen einer HU mitgegeben wurde - versuchen
*  wir die HU mit den übergebenen Daten zu erstellen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_create_hu = abap_true.

      me->create(
        EXPORTING
          i_huident    = i_huident
          i_pmat       = i_pmat
          i_lgpla      = i_lgpla
          is_hu_create = is_hu_create
          i_rsrc       = i_rsrc
          i_commit     = i_commit
          i_wait       = i_wait ).

    ENDIF.

*   gelesene/erstellte HU in den Puffer schreiben
    IF ms_huhdr IS NOT INITIAL.
      CLEAR ls_ref.
      ls_ref-lgnum    = m_lgnum.
      ls_ref-huident  = ms_huhdr-huident.
      ls_ref-o_hu     = me.  " #002
      APPEND ls_ref TO st_hu_references.
    ENDIF.

  ENDMETHOD.


METHOD create.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Create a Handling Unit object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      lo_pmat        TYPE REF TO zswl_cl_pack_mat,
      l_lgpla        TYPE /scwm/lgpla,
      l_flg_existing TYPE xfeld.

* End declarations
**********************************************************************

*   Wird eine HU-Identifikation übergeben muss geprüft werden, ob
*   bereits eine HU mit der ID existiert
    IF i_huident IS NOT INITIAL.

      zswl_cl_hu=>is_hu_existing(
        EXPORTING
          i_lgnum    = m_lgnum
          i_huident  = i_huident
        IMPORTING
          e_existing = l_flg_existing
        CHANGING
          co_log     = mo_log ).

      IF l_flg_existing = abap_true.
*       HU [&] existiert bereits - HU kann nicht erstellt werden!
        MESSAGE e013
           WITH i_huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      ENDIF.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Pack-Material-Objekt erstellen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    CREATE OBJECT lo_pmat
      EXPORTING
        i_lgnum     = m_lgnum
        io_log      = mo_log
*       i_matid_r16 =
*       i_matid_c22 =
        i_matnr_c40 = i_pmat
*       is_matpack  =
      .

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   HU mit den jeweiligen Übergabeparameter erstellen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   fülle Lagerplatz - wenn Übergabeparameter "LGPLA" gefüllt mit dem
*   Parameter - wenn der Arbeitsplatz gefüllt ist mit dem Lagerplatz
*   des Arbeitsplatzes
    CLEAR l_lgpla.

    IF i_lgpla IS NOT INITIAL.
      l_lgpla = i_lgpla.
    ELSE.
*      IF mo_workstation IS BOUND.
*        l_lgpla = mo_workstation->get_bin( ).
*      ENDIF.
    ENDIF.

    IF i_lgpla IS NOT INITIAL.

*     HU [&] soll mit Packmittel [&] auf Lagerplatz [&] erstellt werden
      MESSAGE i018
         WITH i_huident
              i_pmat
              i_lgpla
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSEIF i_rsrc IS NOT INITIAL.

*     HU [&] soll mit Packmittel [&] auf Ressource [&] erstellt werden
      MESSAGE i061
         WITH i_huident
              i_pmat
              i_rsrc
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.


    IF i_huident IS NOT INITIAL.

      IF i_rsrc IS NOT INITIAL.

        CALL METHOD mo_pack->create_hu_on_resource
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
            iv_huident   = i_huident
            is_hu_create = is_hu_create
*           iv_nohuident =
            iv_resource  = i_rsrc
*           iv_logpos    =
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ELSEIF l_lgpla IS NOT INITIAL.

        CALL METHOD mo_pack->/scwm/if_pack_bas~create_hu
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
            iv_huident   = i_huident
            is_hu_create = is_hu_create
*           iv_nohuident =
            i_location   = l_lgpla
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ELSE.

        CALL METHOD mo_pack->/scwm/if_pack_bas~create_hu
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
            iv_huident   = i_huident
            is_hu_create = is_hu_create
*           iv_nohuident =
*           i_location   =
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ENDIF.

    ELSE.

      IF i_rsrc IS NOT INITIAL.

        CALL METHOD mo_pack->create_hu_on_resource
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
*           iv_huident   =
            is_hu_create = is_hu_create
*           iv_nohuident =
            iv_resource  = i_rsrc
*           iv_logpos    =
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ELSEIF l_lgpla IS NOT INITIAL.

        CALL METHOD mo_pack->/scwm/if_pack_bas~create_hu
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
*           iv_huident   =
            is_hu_create = is_hu_create
*           iv_nohuident =
            i_location   = l_lgpla
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ELSE.

        CALL METHOD mo_pack->/scwm/if_pack_bas~create_hu
          EXPORTING
            iv_pmat      = lo_pmat->get_matid_r16( )
*           iv_huident   =
            is_hu_create = is_hu_create
*           iv_nohuident =
*           i_location   =
          RECEIVING
            es_huhdr     = ms_huhdr
          EXCEPTIONS
            error        = 1
            OTHERS       = 2.

      ENDIF.

    ENDIF.

    IF sy-subrc <> 0.

*     SAP Standard-Protokoll aufnehmen
      me->log_sap_prot( ).

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

*     Fehler beim Erstellen der HU!
      MESSAGE e019
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     Sichern der Daten auf der Datenbank
      me->save(
        EXPORTING
          i_commit    = i_commit
          i_wait      = i_wait ).

      CLEAR mt_huhdr_all[].
      APPEND ms_huhdr TO mt_huhdr_all.

    ENDIF.

  ENDMETHOD.


METHOD delete.
************************************************************************
* Company     : Swisslog AG
*
* Description : Delete HU from DB
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Lösche HU [&]
    MESSAGE i020
       WITH ms_huhdr-huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

*   lösche HU von der Datenbank
    CALL METHOD mo_pack->/scwm/if_pack_bas~delete_hu
      EXPORTING
        iv_hu  = ms_huhdr-guid_hu
      EXCEPTIONS
        error  = 1
        OTHERS = 2.

*   Fehlerhandling je nach Übergabeparameter
    IF sy-subrc <> 0.

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

*     SAP Standard-Protokollierung in Z-Protokoll übernehmen
      me->log_sap_prot( ).

*     HU [&] konnte nicht gelöscht werden!
      MESSAGE e021
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     HU [&] erfolgreich gelöscht
      MESSAGE i022
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

      IF i_save = abap_true.

*       Schreiben der Daten auf die Datenbank
        me->save(
          EXPORTING
            i_commit  = i_commit
            i_wait    = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD delete_leading_zeros_huident.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Delete the leading zeros on left side of the HUIDENT
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author     ¦ Description
* ------- ¦ -------- ¦ ----------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF     ¦ Initial version
* 1.1     ¦2016-09-27¦ T. Rehmann  ¦ Review
************************************************************************

    CALL FUNCTION 'CONVERSION_EXIT_HUID_OUTPUT'
      EXPORTING
        input  = c_hu
      IMPORTING
        output = c_hu.

  ENDMETHOD.


METHOD delete_stock.
************************************************************************
* Company     : Swisslog AG
*
* Description : Delete packed stock from HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA: lo_stock  TYPE REF TO zswl_cl_stock,
          ls_stock  TYPE        /scwm/s_stock_upload,
          lt_stock  TYPE        /scwm/tt_stock_upload,
          l_huident TYPE       /scwm/de_huident.

    FIELD-SYMBOLS:
      <ls_huitm> TYPE /scwm/s_huitm_int,
      <ls_huhdr> TYPE /scwm/s_huhdr_int.

    IF i_huident IS NOT INITIAL.
      l_huident = i_huident.
      zswl_cl_hu=>append_leading_zeros_huident( CHANGING c_hu =
l_huident ).
    ELSE.
      l_huident = ms_huhdr-huident.
    ENDIF.

*   >> Lösche gepackten Bestand für HU [&]
    MESSAGE i095
       WITH l_huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
      WITH KEY lgnum   = m_lgnum
               huident = l_huident.

    IF sy-subrc <> 0.

*     HU [&] ist in der HU-Hierarchie nicht vorhanden!
      MESSAGE e094
         WITH l_huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

      LOOP AT mt_huitm ASSIGNING <ls_huitm>
        WHERE guid_parent = <ls_huhdr>-guid_hu.

        CLEAR: ls_stock,
               lt_stock.

        ls_stock-mandt          = <ls_huitm>-mandt.
        ls_stock-huident        = ms_huhdr-huident.
        ls_stock-matid          = <ls_huitm>-matid.
        ls_stock-quan           = <ls_huitm>-quan.
        ls_stock-unit           = <ls_huitm>-altme.
        ls_stock-cat            = <ls_huitm>-cat.
        ls_stock-coo            = <ls_huitm>-coo.
        ls_stock-owner          = <ls_huitm>-owner.
        ls_stock-owner_role     = <ls_huitm>-owner_role.
        ls_stock-entitled       = <ls_huitm>-entitled.
        ls_stock-entitled_role  = <ls_huitm>-entitled_role.
        ls_stock-lgpla          = <ls_huhdr>-lgpla.
        APPEND ls_stock TO lt_stock.

        CREATE OBJECT lo_stock
          EXPORTING
            i_lgnum = m_lgnum
            io_log  = mo_log
*           i_guid_parent = <ls_huitm>-guid_parent
*           i_guid_stock  = <ls_huitm>-guid_stock
*           i_read_aqua   = ABAP_TRUE
*           i_read_quan   = abap_false
*           is_aqua =
*           is_quan =
            i_gm    = abap_true.

        CALL METHOD lo_stock->set_data_for_gm
          EXPORTING
            i_lgnum     = m_lgnum
            i_direction = wmegc_lime_post_outbound
            i_reason    = ' ' "wmegc_lime_reason_scrp
            i_send_erp  = abap_false
*           i_lgtyp     =
*           i_procty    =
*           is_dlv_ref  =
            it_stock    = lt_stock
            io_log      = mo_log.

        CALL METHOD lo_stock->start_gm
          EXPORTING
            i_commit = i_commit
            i_wait   = i_wait.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


METHOD get_guid.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the GUID of the HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_guid_hu = ms_huhdr-guid_hu.

  ENDMETHOD.


METHOD get_huhdr_all.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return all HU headers
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    rt_huhdr[] = mt_huhdr_all[].

  ENDMETHOD.


METHOD get_huhdr_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the HU Header for the incoming HUIDENT
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_huident                 TYPE /scwm/de_huident.
* End declarations
**********************************************************************

    IF i_huident IS INITIAL.

      l_huident = ms_huhdr-huident.

    ELSE.

      l_huident = i_huident.

    ENDIF.

*   führende Nullen anhängen
    CALL METHOD zswl_cl_hu=>append_leading_zeros_huident
      CHANGING
        c_hu = l_huident.

*   Aus Tabelle lesen
    READ TABLE mt_huhdr_all INTO rs_huhdr
      WITH KEY lgnum    = m_lgnum
               huident  = l_huident.

    IF sy-subrc <> 0.
      IF ms_huhdr IS INITIAL.
        CLEAR rs_huhdr.
      ELSE.
        rs_huhdr = ms_huhdr.
      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD get_huhdr_top.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return HU header for actual HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rs_huhdr.

    IF ms_huhdr IS INITIAL.

      READ TABLE mt_huhdr_all INTO ms_huhdr
        WITH KEY vhi = wmegc_vhi_real
                 top = abap_true.

      IF sy-subrc <> 0.
        CLEAR ms_huhdr.
      ENDIF.

    ENDIF.

    rs_huhdr = ms_huhdr.

  ENDMETHOD.


METHOD GET_HUREF_ALL.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return all actual HU References
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    et_huref[] = mt_huref[].

  ENDMETHOD.


METHOD get_hutree.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the actual Handling Unit tree
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    rt_hutree[] = mt_hutree[].

  ENDMETHOD.


METHOD get_hutyp.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the HU type
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_hutyp = ms_huhdr-letyp.

  ENDMETHOD.


METHOD get_hutype_desc.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Return the HU type description
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

    CLEAR e_hutype_txt.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    CALL FUNCTION '/SCWM/THUTYP_READ_SINGLE'
      EXPORTING
        iv_hutyp    = i_hutype
      IMPORTING
        ev_hutyptxt = e_hutype_txt.

    IF e_hutype_txt IS INITIAL.

*     Zu HU-Typ [&] wurde keine Beschreibung gefunden!
      MESSAGE e015
         WITH i_hutype
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD get_hu_ident.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the Handling Units Identifications if available
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    CLEAR: es_huid,
           et_huid[].

*   Je nach Übergabeparameter werden die alternativen HU-Idents
*   zurückgegeben
    CALL METHOD me->get_hu_ident_from_attributes
      EXPORTING
        i_idart   = i_idart
        i_huident = i_huident
      IMPORTING
        es_huid   = es_huid
        et_huid   = et_huid.

*   Wurde nichts gefunden lesen wir direkt von der DB in die Attribute
    IF es_huid IS INITIAL AND
       lines( et_huid ) = 0.

      CALL METHOD me->select_hu_ident
        EXPORTING
          i_idart   = i_idart
          i_huident = i_huident.

*     Danach wird erneut versucht die angefrageten HU-IDs aus den
*     Attributen zu lesen
      CALL METHOD me->get_hu_ident_from_attributes
        EXPORTING
          i_idart   = i_idart
          i_huident = i_huident
        IMPORTING
          es_huid   = es_huid
          et_huid   = et_huid.

    ENDIF.

  ENDMETHOD.


METHOD get_hu_ident_from_attributes.
************************************************************************
* Company     : Swisslog AG
*
* Description : Determine HU identifications
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_hu_ident> TYPE /scwm/s_hu_ident,
      <ls_huhdr>    TYPE /scwm/s_huhdr_int.

* End declarations
**********************************************************************

    CLEAR: es_huid,
           et_huid[].

*   Je nach Übergabeparameter werden die alternativen HU-Idents
*   zurückgegeben
    IF i_idart IS NOT INITIAL.

      IF i_huident IS NOT INITIAL.

        READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
          WITH KEY huident  = i_huident.

        IF sy-subrc = 0.

          READ TABLE mt_hu_ident ASSIGNING <ls_hu_ident>
            WITH KEY guid_hu = <ls_huhdr>-guid_hu
                     idart   = i_idart.

          IF sy-subrc = 0.

            es_huid = <ls_hu_ident>.
            APPEND es_huid TO et_huid.

          ENDIF.

        ENDIF.

      ELSE.

        LOOP AT mt_hu_ident ASSIGNING <ls_hu_ident>
          WHERE idart = i_idart.

          READ TABLE et_huid TRANSPORTING NO FIELDS
            WITH KEY guid_hu = <ls_hu_ident>-guid_hu
                     idart   = <ls_hu_ident>-idart.

          IF sy-subrc <> 0.
            APPEND <ls_hu_ident> TO et_huid.
          ENDIF.

        ENDLOOP.

      ENDIF.

    ELSE.

      IF i_huident IS NOT INITIAL.

        READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
          WITH KEY huident  = i_huident.

        IF sy-subrc = 0.

          LOOP AT mt_hu_ident ASSIGNING <ls_hu_ident>
            WHERE guid_hu = <ls_huhdr>-guid_hu.

            READ TABLE et_huid TRANSPORTING NO FIELDS
              WITH KEY guid_hu = <ls_hu_ident>-guid_hu
                       idart   = <ls_hu_ident>-idart.

            IF sy-subrc <> 0.
              APPEND <ls_hu_ident> TO et_huid.
            ENDIF.

          ENDLOOP.

        ENDIF.

      ELSE.
        et_huid[] = mt_hu_ident[].
      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD get_instance.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Determine HU data from DB or from the buffer and return
*               a HU object.
*
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_ref>                  TYPE zswl_s_hu_ref.

* End declarations
**********************************************************************

    CLEAR eo_hu.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_huident IS SUPPLIED.

      IF i_huident IS INITIAL.

*       Es wurde keine HU-Identifikation übergeben!
        MESSAGE e010
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

*     Es wird versucht das HU-Objekt aus dem Puffer zu lesen
      READ TABLE st_hu_references ASSIGNING <ls_ref>
        WITH KEY lgnum    = i_lgnum
                 huident  = i_huident.

      IF sy-subrc = 0.

*       Fehler werfen, falls der Aufrufer die HU erstellen wollte
        IF i_create_hu = abap_true.

*         HU [&] existiert bereits - HU kann nicht erstellt werden!
          MESSAGE e013
             WITH i_huident
             INTO zswl_cl_log=>m_dummy_msg.
          co_log->add( i_syst = abap_true ).
          zcx_ewm_general_exception=>raise_system_exception( ).

        ELSE.

          eo_hu = <ls_ref>-o_hu.

        ENDIF.

      ELSE.

*       HU ist noch nicht im Puffer --> von DB lesen
        CREATE OBJECT eo_hu
          EXPORTING
            i_lgnum        = i_lgnum
            io_log         = co_log
            i_huident      = i_huident
            i_workstation  = i_workstation
            i_cleanup      = i_cleanup
            i_lock         = i_lock
            i_read_hu_tree = i_read_hu_tree
            i_read_from_gm = i_read_from_gm
            i_create_hu    = i_create_hu
            i_pmat         = i_pmat
            i_lgpla        = i_lgpla
            i_rsrc         = i_rsrc
            i_commit       = i_commit
            i_wait         = i_wait.

      ENDIF.

    ELSE.

*     Keine HU-Nummer übergeben --> HU anlegen
      CREATE OBJECT eo_hu
        EXPORTING
          i_lgnum       = i_lgnum
          io_log        = co_log
*         i_huident     =
          i_workstation = i_workstation
          i_cleanup     = i_cleanup
*         i_lock        =
*         i_read_hu_tree =
*         i_read_from_gm =
          i_create_hu   = i_create_hu
          i_pmat        = i_pmat
          i_lgpla       = i_lgpla
          i_rsrc        = i_rsrc
          i_commit      = i_commit
          i_wait        = i_wait.

    ENDIF.

  ENDMETHOD.


METHOD get_item_all.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return all actual HU Items
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    et_huitm[] = mt_huitm[].

  ENDMETHOD.


METHOD get_item_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return the HU Items for incoming GUID
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_huitm>                TYPE /scwm/s_huitm_int.

* End declarations
**********************************************************************

    CLEAR et_huitm[].

    LOOP AT mt_huitm ASSIGNING <ls_huitm>
      WHERE guid_parent = i_guid_hu.

      APPEND <ls_huitm> TO et_huitm.

    ENDLOOP.

  ENDMETHOD.


METHOD get_open_hu_wt.
************************************************************************
* Company     : Swisslog AG
*
* Description : Determine open HU WT and return
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      lt_ordim_o TYPE /scwm/tt_ordim_o,
      l_huident  TYPE /scwm/de_huident.

* End declarations
**********************************************************************
    CLEAR rs_ordim_o.

    IF i_huident IS NOT INITIAL.
      l_huident = i_huident.
    ELSE.
      l_huident = ms_huhdr-huident.
    ENDIF.

    CALL METHOD zswl_cl_hu=>append_leading_zeros_huident
      CHANGING
        c_hu = l_huident.

*    selektiere offene LBs von der DB
    lt_ordim_o = me->select_open_hu_wt( i_huident = l_huident ).

    READ TABLE lt_ordim_o INTO rs_ordim_o
      WITH KEY tostat  = wmegc_to_open
               flghuto = abap_true.
    IF sy-subrc <> 0.
      CLEAR rs_ordim_o.
    ENDIF.

  ENDMETHOD.


METHOD get_open_hu_wts.
************************************************************************
* Company     : Swisslog AG
*
* Description : Determine open HU WT and return
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_huident                 TYPE /scwm/de_huident.

* End declarations
**********************************************************************

    CLEAR rt_ordim_o[].

    IF i_huident IS NOT INITIAL.
      l_huident = i_huident.
    ELSE.
      l_huident = ms_huhdr-huident.
    ENDIF.

    CALL METHOD zswl_cl_hu=>append_leading_zeros_huident
      CHANGING
        c_hu = l_huident.

*    selektiere offene LBs von der DB
    rt_ordim_o = me->select_open_hu_wt( i_huident = l_huident ).


  ENDMETHOD.


METHOD get_open_internal_moves.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return all open WT's for HUIDENT
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2017-12-08¦ B7GOKHN  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_huident                 TYPE /scwm/de_huident.
* End declarations
**********************************************************************
    CLEAR rt_ordim_o[].

    IF i_huident IS NOT INITIAL.
      l_huident = i_huident.
    ELSE.
      l_huident = ms_huhdr-huident.
    ENDIF.

    CALL METHOD zswl_cl_hu=>append_leading_zeros_huident
      CHANGING
        c_hu = l_huident.

    " Select open internal momenets for the HU vom the DB..
    rt_ordim_o = me->select_open_internal_moves( i_huident = l_huident ).

  ENDMETHOD.


METHOD get_open_picks.
************************************************************************
* Company     : Swisslog AG
*
* Description : Return all open WT's for HUIDENT
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      l_huident                 TYPE /scwm/de_huident.
* End declarations
**********************************************************************
    CLEAR rt_ordim_o[].

    IF i_huident IS NOT INITIAL.
      l_huident = i_huident.
    ELSE.
      l_huident = ms_huhdr-huident.
    ENDIF.

    CALL METHOD zswl_cl_hu=>append_leading_zeros_huident
      CHANGING
        c_hu = l_huident.

*   selektiere offene Pick-LBs zur HU von der DB
    rt_ordim_o = me->select_open_picks( i_huident = l_huident ).

  ENDMETHOD.


METHOD get_stock.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Return if the HU contains stock
*
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-06-09 ¦ F. Pleinies      ¦ Initial
* 1.1     ¦ 2016-09-27 ¦ T. Rehmann       ¦ Review
*
************************************************************************

    DATA: rt_huident TYPE rseloption,
          rs_huident LIKE LINE OF rt_huident,
          lt_huitems TYPE /scwm/tt_stock_select.

    rs_huident-sign = 'I'.
    rs_huident-option = 'EQ'.
    rs_huident-low = ms_huhdr-huident.

    APPEND rs_huident TO rt_huident.

    CALL FUNCTION '/SCWM/SELECT_STOCK'
      EXPORTING
        iv_lgnum   = ms_huhdr-lgnum
        ir_huident = rt_huident
      IMPORTING
        et_huitm   = lt_huitems
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
      CLEAR et_stock.
    ENDIF.

    IF lines( lt_huitems ) > 0.
      et_stock = lt_huitems.

      IF ev_quantity IS REQUESTED.
        LOOP AT lt_huitems into DATA(ls_huitm).
           ADD ls_huitm-quan TO ev_quantity.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.


METHOD has_stock.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Return if the HU contains stock
*
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-06-09 ¦ F. Pleinies      ¦ Initial
* 1.1     ¦ 2016-09-27 ¦ T. Rehmann       ¦ Review
*
************************************************************************

    " ------------------------------------------ "
    "  Local Declarations..
    " ------------------------------------------ "

    DATA: rt_huident TYPE rseloption,
          rs_huident LIKE LINE OF rt_huident,
          lt_huitems TYPE /scwm/tt_stock_select.

    " ------------------------------------------ "
    "  Processing Logic..
    " ------------------------------------------ "

    rv_stock = abap_false.

    rs_huident-sign = 'I'.
    rs_huident-option = 'EQ'.
    rs_huident-low = ms_huhdr-huident.

    APPEND rs_huident TO rt_huident.

    CALL FUNCTION '/SCWM/SELECT_STOCK'
      EXPORTING
        iv_lgnum   = ms_huhdr-lgnum
        ir_huident = rt_huident
      IMPORTING
        et_huitm   = lt_huitems
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
      rv_stock = abap_false.
    ENDIF.

    IF lines( lt_huitems ) > 0.
      rv_stock = abap_true.
    ENDIF.

  ENDMETHOD.


METHOD init_pack.
************************************************************************
* Company     : Swisslog AG
*
* Description : Inititalize Pack-object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
*    DATA: ls_workst TYPE /scwm/tworkst.
* End declarations
**********************************************************************

*   initialisiere Pack-Objekt der HU-Klasse
    IF mo_pack IS BOUND.
      FREE mo_pack.
    ENDIF.

*   Cleanup
    /scwm/cl_tm=>cleanup( iv_lgnum = m_lgnum ).

    CREATE OBJECT mo_pack.

    CALL METHOD mo_pack->init_pack
      EXPORTING
        iv_badi_appl = wmegc_huappl_wme
        iv_lgnum     = m_lgnum
        it_guid_hu   = it_guid_hu
      EXCEPTIONS
        error        = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
*     Pack-Objekt konnte nicht initialisiert werden!
      MESSAGE e049 INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

*   Initialisierung des Pack-Objekts mit der Lagernummer und der
*   Lagerprozessart (sofern gefüllt)
    "#001
    mo_pack->init(
      EXPORTING
        iv_lgnum  = m_lgnum
        iv_procty = i_procty
      EXCEPTIONS
        error     = 1
        OTHERS    = 2 ).

    IF sy-subrc <> 0.
*     Fehler beim Initialisieren des Pack-Objekts
      MESSAGE e050 INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.
    "#001

*   Das Pack-Objekt muss initialisiert werden wenn
*   --> Das Arbeitsplatzobjekt bereits instanziiert ist
*   --> Ein Arbeitsplatz übergeben wurde
*    IF i_workstation  IS NOT INITIAL OR
*       mo_workstation IS BOUND.

*     Wurde ein anderer Arbeitsplatz übergeben, als im
*     Arbeitsplatzobjekt
*     instanziiert wurde müssen wir das Arbeitsplatzobjekt zurücksetzen
*      IF i_workstation  IS NOT INITIAL AND
*         mo_workstation IS BOUND       AND
*         i_workstation  <> mo_workstation->get_workstation( )-workstation.
*
*        FREE mo_workstation.
*      ENDIF.

*      IF mo_workstation IS NOT BOUND.
*        CREATE OBJECT mo_workstation
*          EXPORTING
*            i_lgnum       = m_lgnum
*            io_log        = mo_log
*            i_workstation = i_workstation.
*      ENDIF.

*     initialisiere Pack-Objekt mit den Arbeitsplatz-Daten
*      ls_workst = mo_workstation->get_workstation( ).

*      IF ls_workst IS NOT INITIAL.
*        CALL METHOD mo_pack->init_by_workstation
*          EXPORTING
*            is_workstation = ls_workst
*          EXCEPTIONS
*            error          = 1
*            OTHERS         = 2.
*
*        IF sy-subrc <> 0.
**         Pack-Objekt konnte nicht mit Arbeitsplatz [&] initialisiert
*werden!
*          MESSAGE e025 WITH ls_workst-workstation INTO
*ZSWL_CL_LOG=>m_dummy_msg.
*          mo_log->add( i_syst = abap_true ).
*          zcx_ewm_general_exception=>raise_system_exception( ).
*        ENDIF.
*      ENDIF.
*
*    ENDIF.

  ENDMETHOD.


METHOD is_hu_existing.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Check if the HU exist on DB
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declaration
    DATA:
      l_guid    TYPE /scwm/guid_hu,
      l_huident TYPE /scwm/de_huident,
      l_vhi     TYPE /scwm/vhi. " #001

* End declaration
**********************************************************************

    e_existing = abap_false.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_huident IS INITIAL.
*     Es wurde keine HU-Identifikation übergeben!
      MESSAGE e010
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ELSE.
      l_huident = i_huident.
      zswl_cl_hu=>append_leading_zeros_huident( CHANGING c_hu =
l_huident ).
    ENDIF.

* { #001
*...Wenn eine VHI übergeben wurde soll nach dieser selektiert werden
*   ansonsten wird nach den richtigen HUs selektiert
    IF i_vhi IS SUPPLIED.
      l_vhi = i_vhi.
    ELSE.
      l_vhi = wmegc_vhi_real.
    ENDIF.

    SELECT SINGLE guid_hu
      FROM /scwm/huhdr
      INTO l_guid
     WHERE lgnum   = i_lgnum
       AND huident = l_huident
       AND vhi     = l_vhi.

* } #001

    IF sy-subrc = 0.
      e_existing = abap_true.
    ELSE.
      e_existing = abap_false.
    ENDIF.

  ENDMETHOD.


METHOD lock.
************************************************************************
* Company     : Swisslog AG
*
* Description : Lock the HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Sperre HU [&]
    MESSAGE i038
       WITH ms_huhdr-huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    CALL FUNCTION 'ENQUEUE_/SCWM/EHU'
      EXPORTING
        mandt          = sy-mandt
*       mode_/scwm/s_huhdr_int =
*                                 zswl_if_constants=>mc_enqueue_type_writing
        huident        = ms_huhdr-huident
        lgnum          = m_lgnum
        _wait          = abap_false
        _collect       = abap_false
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 99.

    IF sy-subrc <> 0.

*     HU [&] konnte nicht gesperrt werden!
      MESSAGE e039
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     HU [&] erfolgreich gesperrt
      MESSAGE i040
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD log_sap_prot.
************************************************************************
* Company     : Swisslog AG
*
* Description : Log SAP standard messages from the pack object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    FIELD-SYMBOLS:
      <ls_messages>             TYPE bapiret2.

    DATA:
      lt_messages               TYPE bapirettab.

* End declarations
**********************************************************************

* SAP-Standard-Protokollierungsobjekt aus Pack-Klasse lesen
    lt_messages = /scwm/cl_pack=>go_log->get_prot( ).

* Protokoll zu Z-Protokollierung hinzufügen
    LOOP AT lt_messages ASSIGNING <ls_messages>.

      MESSAGE ID <ls_messages>-id
            TYPE <ls_messages>-type
          NUMBER <ls_messages>-number
            WITH <ls_messages>-message_v1
                 <ls_messages>-message_v2
                 <ls_messages>-message_v3
                 <ls_messages>-message_v4
            INTO zswl_cl_log=>m_dummy_msg.

      CALL METHOD mo_log->add( i_syst = abap_true ).

    ENDLOOP.

  ENDMETHOD.


METHOD move.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Create HU WT for the actual HU.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      ls_wt_create              TYPE zswl_s_to_crea_hu.
*End declarations
**********************************************************************

    CLEAR ro_wt.

    CLEAR ls_wt_create.
    ls_wt_create-lgnum            = m_lgnum.
    ls_wt_create-update_task      = i_upd_task.
    ls_wt_create-wtcode           = i_wtcode.
    ls_wt_create-s_hu_wt-huident  = ms_huhdr-huident.
    ls_wt_create-s_hu_wt-procty   = i_procty.
    ls_wt_create-s_hu_wt-squit    = i_squit.
    ls_wt_create-s_hu_wt-nlpla    = i_nlpla.
    ls_wt_create-s_hu_wt-nlenr    = i_nlenr.
    ls_wt_create-s_hu_wt-drsrc    = i_nrsrc.
    ls_wt_create-s_hu_wt-dtu_num  = i_ntu.

    CREATE OBJECT ro_wt
      EXPORTING
        i_lgnum    = m_lgnum
        io_log     = mo_log
*       i_tanum    =
*       i_only_open  = ABAP_TRUE
*       is_ordim_o =
        is_wt_crea = ls_wt_create
        i_commit   = i_commit
        i_wait     = i_wait
        i_qname    = i_bname.
*        i_subst      = i_subst.

*   Aktualisiere HU-Daten und lese HU neu von der DB
    me->read_hu(
      EXPORTING
        i_huident = ms_huhdr-huident ).

  ENDMETHOD.


METHOD pack_hu_stock_to_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : DRepack stock from one HU to the actual HU.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      lt_guid_hu   TYPE /scwm/tt_guid_hu,
      ls_guid_hu   TYPE /scwm/s_guid_hu,
      ls_quantity  TYPE /scwm/s_quan,
      ls_huitm_src TYPE /scwm/s_huitm_int,
      l_severity   TYPE bapi_mtype.

* End declarations
**********************************************************************

*   Pack-Objekt mit übergebenen HUs initialisieren
    CLEAR lt_guid_hu.

    CLEAR ls_guid_hu-guid_hu.
    ls_guid_hu-guid_hu = ms_huhdr-guid_hu.
    APPEND ls_guid_hu TO lt_guid_hu.

    CLEAR ls_guid_hu-guid_hu.
    ls_guid_hu-guid_hu = i_huguid_src.
    APPEND ls_guid_hu TO lt_guid_hu.

    me->init_pack(
      EXPORTING
        it_guid_hu    = lt_guid_hu
*        i_workstation =
        i_procty      = i_procty ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Packen des Bestands auf die HU
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_huitm_src INTO ls_huitm_src.

      CLEAR: ls_quantity.
      ls_quantity-quan = ls_huitm_src-quan.
      ls_quantity-unit = ls_huitm_src-meins.

      CALL METHOD mo_pack->/scwm/if_pack_bas~repack_stock
        EXPORTING
          iv_dest_hu    = ms_huhdr-guid_hu
          iv_source_hu  = i_huguid_src
          iv_stock_guid = ls_huitm_src-guid_stock
          is_quantity   = ls_quantity
*         is_valuation  =
*         iv_cwexact    =
*         it_serid      =
*         iv_no_event   = ' '
*         iv_addin      =
*        IMPORTING
*         es_quantity   =
        EXCEPTIONS
          error         = 1
          OTHERS        = 2.

      l_severity = /scwm/cl_pack=>go_log->get_severity( ).

      IF l_severity CA wmegc_severity_eax.

*       Protokollierung der SAP-Standard-Meldungen
        me->log_sap_prot( ).

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

*       Es werden entweder der gesamte Bestand oder kein Bestand
*       umgepackt - sobald ein Fehler auftritt verlassen wir die
*       Bestandsverarbeitung
        RAISE EXCEPTION TYPE zcx_ewm_general_exception. " #001

      ENDIF.

    ENDLOOP.


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Sichern der Verarbeitung
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_save = abap_true.
      me->save(
        EXPORTING
          i_commit  = i_commit
          i_wait    = i_wait ).
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Zum Schluss werden die HU-Attribute aktualisiert (von der DB)
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    me->reread_hu( ).

  ENDMETHOD.


METHOD pack_hu_to_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Repack complete stock from HU to the actual HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA:
      lt_guid_hu_pack TYPE /scwm/tt_guid_hu,
      lt_guid_hu      TYPE /scwm/tt_guid_hu,
      ls_guid_hu      TYPE /scwm/s_guid_hu.

* End declarations
**********************************************************************

*   Zuerst werden alle Einträge mit fehlender GUID-HU gelöscht
    IF lines( it_source_guid_hu ) > 0.

      lt_guid_hu_pack[] = it_source_guid_hu[].

      DELETE lt_guid_hu_pack
       WHERE guid_hu IS INITIAL.

    ENDIF.

*   Prüfen, ob Von-HUs übergeben wurden
    IF i_source_guid_hu         IS INITIAL AND
       lines( lt_guid_hu_pack ) = 0.

*     Es wurden keine Von-HU(s) zum Umpacken nach HU [&] mitgegeben!
      MESSAGE e024
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Initialisiere Pack-Objekt
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR ls_guid_hu-guid_hu.
    ls_guid_hu-guid_hu = ms_huhdr-guid_hu.
    APPEND ls_guid_hu TO lt_guid_hu.

    CLEAR ls_guid_hu-guid_hu.
    ls_guid_hu-guid_hu = i_source_guid_hu.
    APPEND ls_guid_hu TO lt_guid_hu.

*   Übergabe-Tabelle prüfen und in Initialisierungstabelle schreiben
    LOOP AT lt_guid_hu_pack INTO ls_guid_hu.

      READ TABLE lt_guid_hu TRANSPORTING NO FIELDS
        WITH KEY guid_hu = ls_guid_hu-guid_hu.

      IF sy-subrc NE 0.

        APPEND ls_guid_hu TO lt_guid_hu.

      ENDIF.

    ENDLOOP.

*   Leere Einträge löschen
    DELETE lt_guid_hu
     WHERE guid_hu IS INITIAL.

    me->init_pack(
      EXPORTING
        it_guid_hu     = lt_guid_hu
        i_workstation  = i_workstation
        i_procty       = i_procty ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Information zum Packen befüllen (bestehende Tabellen mit HU-GUIDS)
*   anpassen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   Nach GUIDS sortieren
    SORT lt_guid_hu
      BY guid_hu.

*   doppelte Einträge löschen
    DELETE ADJACENT DUPLICATES FROM lt_guid_hu COMPARING guid_hu.

*   Ziel-HU + leere Einträge aus der Tabelle löschen
    DELETE lt_guid_hu
     WHERE guid_hu = ms_huhdr-guid_hu
        OR guid_hu IS INITIAL.


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Pack HUs
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    LOOP AT lt_guid_hu INTO ls_guid_hu.

      CALL METHOD mo_pack->/scwm/if_pack_bas~pack_hu
        EXPORTING
          iv_source_hu = ls_guid_hu-guid_hu
          iv_dest_hu   = ms_huhdr-guid_hu
        EXCEPTIONS
          error        = 1
          OTHERS       = 2.

      IF sy-subrc = 0.

*       HU [&] wurde erfolgreich auf HU [&] gepackt
        MESSAGE i028
           WITH ls_guid_hu-guid_hu
                ms_huhdr-huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

      ELSE.

*       SAP Standard-Protokoll aufnehmen
        me->log_sap_prot( ).

*       HU [&] konnte nicht auf HU [&] gepackt werden
        MESSAGE e029
           WITH ls_guid_hu-guid_hu
                ms_huhdr-huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

      ENDIF.

    ENDLOOP.

*   Prüfen, ob mindestens eine HU verpackt wurde
    IF sy-subrc <> 0.

*     Keine HU wird auf HU [&] gepackt
      MESSAGE i030
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSE.

      IF i_save = abap_true.

        me->save(
          EXPORTING
            i_commit  = i_commit
            i_wait    = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD pack_stock_from_hu_to_lgpla.
************************************************************************
* Company     : Swisslog AG
*
* Description : Pack stock from the actual or another HU to a storage bin
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_huhdr>        TYPE /scwm/s_huhdr_int,
      <ls_huitm>        TYPE /scwm/s_huitm_int,
      <ls_repack_huitm> TYPE /scwm/s_stock_select.

    DATA:
      lo_bin          TYPE REF TO zswl_cl_storage_bin,
      lt_repack_huitm TYPE        /scwm/tt_stock_select,
      lt_guid_hu      TYPE        /scwm/tt_guid_hu,
      ls_guid_hu      TYPE        /scwm/s_guid_hu,
      ls_quantity     TYPE        /scwm/s_quan,
      ls_repack_huitm TYPE        /scwm/s_stock_select.

* End declarations
**********************************************************************

    IF i_nlpla IS INITIAL.

*     Für das Umpacken wurde kein Nach-Lagerplatz übergeben!
      MESSAGE e033
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     Lagerplatzobjekt prüft, ob es den Lagerplatz gibt und liest
*     sich die GUID des Platzes zum Umpacken aus
      CREATE OBJECT lo_bin
        EXPORTING
          i_lgnum = m_lgnum
          io_log  = mo_log
          i_lgpla = i_nlpla.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Daten für Umpack-Vorgang
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_source_hu IS NOT INITIAL.

      READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
        WITH KEY lgnum    = m_lgnum
                 huident  = i_source_hu.
      IF sy-subrc = 0.

        CLEAR ls_guid_hu.
        ls_guid_hu-guid_hu = <ls_huhdr>-guid_hu.
        INSERT ls_guid_hu INTO TABLE lt_guid_hu.

      ELSE.

*       HU [&] für Umpacken von Bestand ist nicht in der HU-Hierarchie!
        MESSAGE e034
           WITH i_source_hu
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

      CLEAR ls_guid_hu.
      ls_guid_hu-guid_hu = ms_huhdr-guid_hu.
      INSERT ls_guid_hu INTO TABLE lt_guid_hu.

    ENDIF.

    IF lines( it_huitm ) > 0.

*     Wurden Items übergeben, packen wir nur die übergebenen Items
*     zum Zielplatz
      lt_repack_huitm[] = it_huitm[].

    ELSEIF i_source_hu IS NOT INITIAL.

      READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
        WITH KEY lgnum    = m_lgnum
                 huident  = i_source_hu.

      IF sy-subrc = 0.

*       Wurden keine Items, aber eine Von-HU übergeben, packen wir alle
*       HUs dieser Von-HU auf den Zielplatz
        LOOP AT mt_huitm ASSIGNING <ls_huitm>
          WHERE guid_parent = <ls_huhdr>-guid_hu.

          CLEAR ls_repack_huitm.
          MOVE-CORRESPONDING <ls_huitm> TO ls_repack_huitm.
          INSERT ls_repack_huitm INTO TABLE lt_repack_huitm.

        ENDLOOP.

      ENDIF.

    ELSE.

*     Wurden keine speziellen Von-Daten übergeben packen wir alle
*     Positionen der HU-Hierarchie auf den Zielplatz
*     Achtung! Bei geschachtelten HUs werden alle HUs der Hierarchie
*     ausgepackt!
      LOOP AT mt_huitm ASSIGNING <ls_huitm>.

        CLEAR ls_repack_huitm.
        MOVE-CORRESPONDING <ls_huitm> TO ls_repack_huitm.
        INSERT ls_repack_huitm INTO TABLE lt_repack_huitm.

      ENDLOOP.

    ENDIF.

    IF lines( lt_repack_huitm ) = 0.

*     Es wurde kein Bestand zum Umpacken gefunden!
      MESSAGE e035
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Pack-Vorgang initialisieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    me->init_pack(
      EXPORTING
        it_guid_hu     = lt_guid_hu
        i_workstation  = i_workstation
        i_procty       = i_procty ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Umpacken
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT lt_repack_huitm ASSIGNING <ls_repack_huitm>.

      ls_quantity-unit = <ls_repack_huitm>-meins.
      ls_quantity-quan = <ls_repack_huitm>-quan.

      CALL METHOD mo_pack->/scwm/if_pack_bas~repack_stock
        EXPORTING
          iv_dest_hu    = lo_bin->get_lagp( )-guid_hu
          iv_source_hu  = <ls_repack_huitm>-guid_parent
          iv_stock_guid = <ls_repack_huitm>-guid_stock
          is_quantity   = ls_quantity
*         is_valuation  =
*         iv_cwexact    =
*         it_serid      =
*         iv_no_event   = ' '
*         iv_addin      =
*       IMPORTING
*         es_quantity   =
        EXCEPTIONS
          error         = 1
          OTHERS        = 2.

      IF sy-subrc <> 0.

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

*       SAP Standard-Protokoll aufnehmen
        me->log_sap_prot( ).

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Änderung Speichern und auf DB schreiben
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_save = abap_true.

*     Speichere Umpack-Vorgang auf die DB
      me->save(
            i_commit = i_commit
            i_wait   = i_wait ).

    ENDIF.

  ENDMETHOD.


METHOD pack_stock_to_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Pack stock to the actual HU and reread stock attributes
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    FIELD-SYMBOLS:
      <ls_huitm> TYPE /scwm/s_stock_select,
      <ls_stock> TYPE /scwm/s_huitm_key,
      <ls_matnr> TYPE /scwm/s_matnr_matid,
      <l_lgpla>  TYPE /scwm/lgpla.

    DATA:
      lt_stock    TYPE /scwm/tt_huitm_key,
      lt_qdocid   TYPE /scwm/tt_docid,
      ls_qdocid   TYPE /scwm/s_docid,
      lt_qitemid  TYPE /scwm/tt_itemid,
      lrt_matnr   TYPE rseloption,
      lrs_matnr   TYPE rsdsselopt,
      lt_matid    TYPE /scwm/tt_matid,
      lrt_lgpla   TYPE rseloption,
      lrs_lgpla   TYPE rsdsselopt,
      lt_guid_hu  TYPE /scwm/tt_guid_hu,
      ls_guid_hu  TYPE /scwm/s_guid_hu,
      lt_huitm    TYPE /scwm/tt_stock_select,
      ls_huitm    TYPE /scwm/s_stock_select,
      ls_quantity TYPE /scwm/s_quan.

*End declaration
**********************************************************************

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Selektion des übergebenen Bestands
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_docid IS NOT INITIAL.
      ls_qdocid-docid = i_docid.
      APPEND ls_qdocid TO lt_qdocid.
    ENDIF.

    IF i_itemid IS NOT INITIAL.
      APPEND i_itemid  TO lt_qitemid.
    ENDIF.

    LOOP AT it_stock ASSIGNING <ls_stock>.
      READ TABLE lt_stock TRANSPORTING NO FIELDS
        WITH KEY guid_parent = <ls_stock>-guid_parent
                 guid_stock  = <ls_stock>-guid_stock.
      IF sy-subrc <> 0.
        INSERT <ls_stock> INTO TABLE lt_stock.
      ENDIF.
    ENDLOOP.

    IF is_stock IS NOT INITIAL.
      READ TABLE lt_stock TRANSPORTING NO FIELDS
        WITH KEY guid_parent = is_stock-guid_parent
                 guid_stock  = is_stock-guid_stock.
      IF sy-subrc <> 0.
        INSERT is_stock INTO TABLE lt_stock.
      ENDIF.
    ENDIF.

    IF i_location IS NOT INITIAL.
      lrs_lgpla-option = wmegc_option_eq.
      lrs_lgpla-sign   = wmegc_sign_inclusive.
      lrs_lgpla-low    = i_location.
      APPEND lrs_lgpla TO lrt_lgpla.
    ENDIF.

    LOOP AT it_lgpla ASSIGNING <l_lgpla>.
      READ TABLE lrt_lgpla TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgpla>.
      IF sy-subrc <> 0.
        CLEAR lrs_lgpla.
        lrs_lgpla-option = wmegc_option_eq.
        lrs_lgpla-sign   = wmegc_sign_inclusive.
        lrs_lgpla-low    = <l_lgpla>.
        APPEND lrs_lgpla TO lrt_lgpla.
      ENDIF.
    ENDLOOP.

    LOOP AT it_matnr ASSIGNING <ls_matnr>.

      IF <ls_matnr>-matid IS NOT INITIAL.
        INSERT <ls_matnr>-matid INTO TABLE lt_matid.
      ENDIF.

      IF <ls_matnr>-matnr IS NOT INITIAL.
        READ TABLE lrt_matnr TRANSPORTING NO FIELDS
          WITH KEY low = <ls_matnr>-matnr.
        IF sy-subrc <> 0.
          CLEAR lrs_matnr.
          lrs_matnr-option = wmegc_option_eq.
          lrs_matnr-sign   = wmegc_sign_inclusive.
          lrs_matnr-low    = <ls_matnr>-matnr.
          APPEND lrs_matnr TO lrt_matnr.
        ENDIF.
      ENDIF.

    ENDLOOP.

    CALL FUNCTION '/SCWM/SELECT_STOCK'
      EXPORTING
        iv_lgnum     = m_lgnum
        ir_lgpla     = lrt_lgpla
        ir_matnr     = lrt_matnr
        it_matid     = lt_matid
        it_qdocid    = lt_qdocid
        it_qitmid    = lt_qitemid
        it_stock_key = lt_stock
      IMPORTING
        et_huitm     = lt_huitm
*       ET_HUHDR     =
      EXCEPTIONS
        error        = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.

*     Bestand zum Umpacken konnte nicht gelesen werden!
      MESSAGE e031
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   only free stock
    LOOP AT lt_huitm INTO ls_huitm.

      IF ls_huitm-huident IS NOT INITIAL.

        DELETE lt_huitm
         INDEX sy-tabix.

      ENDIF.

    ENDLOOP.

    IF lines( lt_huitm ) = 0.

*     Kein freier Bestand zum Umpacken auf HU [&] gefunden!
      MESSAGE e032
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Initialisierung
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   Initialisiere Pack-Objekt mit den HUs
    CLEAR ls_guid_hu-guid_hu.
    ls_guid_hu-guid_hu = ms_huhdr-guid_hu.
    APPEND ls_guid_hu TO lt_guid_hu.

    LOOP AT lt_huitm INTO ls_huitm.

      READ TABLE lt_guid_hu TRANSPORTING NO FIELDS
        WITH KEY guid_hu = ls_huitm-guid_parent.

      IF sy-subrc NE 0.

        CLEAR ls_guid_hu-guid_hu.
        ls_guid_hu-guid_hu = ls_huitm-guid_parent.
        APPEND ls_guid_hu TO lt_guid_hu.

      ENDIF.

    ENDLOOP.

*   Leere Sätze löschen
    DELETE lt_guid_hu
     WHERE guid_hu IS INITIAL.

    me->init_pack(
      EXPORTING
        it_guid_hu     = lt_guid_hu
        i_workstation  = i_workstation
        i_procty       = i_procty ).

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Packen des Bestands auf die HU
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    LOOP AT lt_huitm ASSIGNING <ls_huitm>.

*     Sollte Mengenstruktur übergeben worden sein nehmen wir dieses
      IF is_quantity IS SUPPLIED.

        ls_quantity = is_quantity.

      ELSE.

        ls_quantity-unit = <ls_huitm>-meins.
        ls_quantity-quan = <ls_huitm>-quan.

      ENDIF.

      CALL METHOD mo_pack->/scwm/if_pack_bas~repack_stock
        EXPORTING
          iv_dest_hu    = ms_huhdr-guid_hu
          iv_source_hu  = <ls_huitm>-guid_parent
          iv_stock_guid = <ls_huitm>-guid_stock
          is_quantity   = ls_quantity
*         is_valuation  =
*         iv_cwexact    =
*         it_serid      =
*         iv_no_event   = ' '
*         iv_addin      =
*       IMPORTING
*         es_quantity   =
        EXCEPTIONS
          error         = 1
          OTHERS        = 2.

      IF sy-subrc <> 0.

*       Protokollierung der SAP-Standard-Meldungen
        me->log_sap_prot( ).

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

*       Es werden entweder der gesamte Bestand oder kein Bestand
*       umgepackt - sobald ein Fehler auftritt verlassen wir die
*       Bestandsverarbeitung

*{#001 2015-07-02 cl
*       Fehler beim Umpacken des Bestands in HU [&]
        MESSAGE e085
           WITH ms_huhdr-huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).
*#001}

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Sichern der Verarbeitung
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_save = abap_true.

      me->save(
        EXPORTING
          i_commit  = i_commit
          i_wait    = i_wait ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Zum Schluss werden die HU-Attribute aktualisiert (von der DB)
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    me->reread_hu( ).

  ENDMETHOD.


METHOD process_completed.
    DATA:
      ls_workstation   TYPE /scwm/tworkst,
      ls_pack_controle TYPE /scwm/s_pack_controle.

    /scwm/cl_tm=>cleanup( ).
    /scwm/cl_tm=>cleanup( iv_lgnum = m_lgnum ).
    /scwm/cl_tm=>set_lgnum( m_lgnum ).

    "get the workstation by id /SCWM/TWORKST
    SELECT SINGLE * FROM /scwm/tworkst
         INTO ls_workstation
         WHERE workstation = iv_workstation.

    "call method 'init_by_workstation'
    IF mo_pack IS NOT BOUND.
      CALL METHOD /scwm/cl_wm_packing=>get_instance
        IMPORTING
          eo_instance = mo_pack.
    ENDIF.

* Determine processor from sy-user in case LM is activ
    ls_pack_controle-processor_det = 'X'.

    CALL METHOD mo_pack->init_by_workstation
      EXPORTING
        is_workstation   = ls_workstation
        is_pack_controle = ls_pack_controle
        iv_no_hu_by_wc   = 'X'
      EXCEPTIONS
        error            = 1
        OTHERS           = 2.

    IF sy-subrc <> 0.
*    /scwm/cl_pack_view=>msg_error( ).
    ENDIF.

    "call method 'process_completed'
    CALL METHOD mo_pack->hu_process_completed
      EXPORTING
        iv_hu  = ms_huhdr-guid_hu
      EXCEPTIONS
        error  = 1
        OTHERS = 2.
    IF sy-subrc <> 0.
*     in case of error, release the lock
      CALL FUNCTION 'DEQUEUE_/SCWM/EHU'
        EXPORTING
          mode_/scwm/s_huhdr_int = 'E'
          mandt                  = sy-mandt
          huident                = ms_huhdr-huident
          lgnum                  = m_lgnum
          _scope                 = '2'.

    ELSE.
*      /scwm/cl_rf_bll_srvc=>message(
**          iv_msg_view          = gc_msg_view_scr
*           iv_flg_continue_flow = gc_xfeld
*           iv_msgid             = gc_rf_de_msgid
*           iv_msgty             = gc_msgty_success
*           iv_msgno             = '225'
*           iv_msgv1             = ls_huhdr-huident ).
    ENDIF.

    "Save the HU changes
    me->save( ).

  ENDMETHOD.


METHOD read_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Read Handling Unit
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    DATA:
      l_huident TYPE /scwm/de_huident,
      ls_hu_sel TYPE /scwm/s_huident,
      ls_huhdr  TYPE /scwm/s_huhdr_int,
*      lt_bapiret TYPE bapirettab,
      lt_hu_sel TYPE /scwm/tt_huident,
      lt_hutree TYPE /scwm/tt_hutree,
      lt_huref  TYPE /scwm/tt_huref_int,
*      lt_huident TYPE /scwm/tt_ident_int,
      lt_huhdr  TYPE /scwm/tt_huhdr_int,
      lt_huitm  TYPE /scwm/tt_huitm_int.

* End declarations
**********************************************************************

*   führende Nullen zu der HU hinzufügen
    l_huident = i_huident.
    zswl_cl_hu=>append_leading_zeros_huident(
      CHANGING
        c_hu = l_huident ).

    CLEAR: ls_hu_sel,
           lt_hu_sel.

    ls_hu_sel-lgnum   = m_lgnum.
    ls_hu_sel-huident = l_huident.
    APPEND ls_hu_sel TO lt_hu_sel.

*   Lesen HU mit der kompletten Baumstruktur oder ohne
    IF i_read_hu_tree = abap_false.

      CALL FUNCTION '/SCWM/HU_SELECT'
        EXPORTING
*         IV_LVL        =
          iv_lock       = i_lock
*         IV_WAIT       = ' '
*         IS_LOCATION   =
*         IT_GUID_HU    =
*         IT_IDENT      =
          it_huident    = lt_hu_sel
*         IO_LOG        =
*         IR_HUIDENT    =
        IMPORTING
          et_huhdr      = lt_huhdr
*         et_ident      = lt_huident
          et_ref        = lt_huref
*         et_tree       =
          et_huitm      = lt_huitm
*         ET_LAGP       =
*         ET_HUSTOBJ    =
*         ET_HUSTATUS   =
*         et_bapiret    = lt_bapiret
        EXCEPTIONS
          not_found     = 1
          error         = 2
          error_message = 99
          OTHERS        = 3.

    ELSE.

      CALL FUNCTION '/SCWM/HU_SELECT'
        EXPORTING
*         IV_LVL        =
          iv_lock       = i_lock
*         IV_WAIT       = ' '
*         IS_LOCATION   =
*         IT_GUID_HU    =
*         IT_IDENT      =
          it_huident    = lt_hu_sel
*         IO_LOG        =
*         IR_HUIDENT    =
        IMPORTING
          et_huhdr      = lt_huhdr
*         et_ident      = lt_huident
          et_ref        = lt_huref
          et_tree       = lt_hutree
          et_huitm      = lt_huitm
*         ET_LAGP       =
*         ET_HUSTOBJ    =
*         ET_HUSTATUS   =
*         et_bapiret    = lt_bapiret
        EXCEPTIONS
          not_found     = 1
          error         = 2
          error_message = 99
          OTHERS        = 3.

    ENDIF.

    IF sy-subrc <> 0.

*     HU wurde nicht gefunden --> bei mitgegebenem Flag suchen wir
*     in der Goods-Movement Tabelle
      IF i_create       = abap_false AND
         i_read_from_gm = abap_true.

        me->read_hu_gm(
          EXPORTING
            i_huident   = l_huident
          IMPORTING
            et_huhdr    = lt_huhdr
            et_huitm    = lt_huitm
            et_huref    = lt_huref ).

      ELSEIF i_create = abap_false.

*       HU [&] wurde nicht gefunden!
        MESSAGE e016
           WITH l_huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ENDIF.

*   gelesene Daten in die Attribute schreiben
    READ TABLE lt_huhdr INTO ls_huhdr
      WITH KEY top = abap_true.

    IF sy-subrc = 0.
      ms_huhdr = ls_huhdr.
    ENDIF.

    mt_huhdr_all[] = lt_huhdr[].
    mt_huitm[]     = lt_huitm[].
    mt_huref[]     = lt_huref[].
    mt_hutree[]    = lt_hutree[].

  ENDMETHOD.


METHOD read_hus.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Read Handling Units then build and return the HU objects.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declaration
    DATA:
      lt_huhdr  TYPE /scwm/tt_huhdr_int,
      lt_huitm  TYPE /scwm/tt_huitm_int,
      lt_huref  TYPE /scwm/tt_huref_int,
      lt_hutree TYPE /scwm/tt_hutree.
* End declaration
**********************************************************************

    CLEAR et_hu[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_huident ) = 0.

*     Es wurde keine HU-Identifikation übergeben!
      MESSAGE e010
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CALL FUNCTION '/SCWM/HU_SELECT'
      EXPORTING
*       IV_LVL     =
*       IV_LOCK    = ' '
*       IV_WAIT    = ' '
*       IS_LOCATION       =
*       IT_GUID_HU =
*       IT_IDENT   =
        it_huident = it_huident
*       IO_LOG     =
*       IR_HUIDENT =
      IMPORTING
        et_huhdr   = lt_huhdr
*       ET_IDENT   =
        et_ref     = lt_huref
        et_tree    = lt_hutree
        et_huitm   = lt_huitm
*       ET_LAGP    =
*       ET_HUSTOBJ =
*       ET_HUSTATUS       =
*       ET_BAPIRET =
      EXCEPTIONS
        not_found  = 1
        error      = 2
        OTHERS     = 3.

    IF sy-subrc <> 0.

*     Fehler bei der Selektion der Handling Units
      MESSAGE e011
         INTO zswl_cl_log=>m_dummy_msg.
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
        et_hu_ref = et_hu
      CHANGING
        co_log    = co_log.

  ENDMETHOD.


METHOD read_hus_by_guid.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZSWL_CL_HU
* Description : Read Handling Units then build and return the HU objects.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
* 1.1     ¦2016-09-27¦ B7REHMT  ¦ Review
************************************************************************

**********************************************************************
* Start declaration
    DATA:
      lt_huhdr  TYPE /scwm/tt_huhdr_int,
      lt_huitm  TYPE /scwm/tt_huitm_int,
      lt_huref  TYPE /scwm/tt_huref_int,
      lt_hutree TYPE /scwm/tt_hutree.
* End declaration
**********************************************************************

    CLEAR et_hu[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_guid ) = 0.

*     Es wurde keine HU-Identifikation übergeben!
      MESSAGE e010
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CALL FUNCTION '/SCWM/HU_SELECT'
      EXPORTING
*       IV_LVL     =
*       IV_LOCK    = ' '
*       IV_WAIT    = ' '
*       IS_LOCATION       =
        it_guid_hu = it_guid
*       IT_IDENT   =
*       it_huident =
*       IO_LOG     =
*       IR_HUIDENT =
      IMPORTING
        et_huhdr   = lt_huhdr
*       ET_IDENT   =
        et_ref     = lt_huref
        et_tree    = lt_hutree
        et_huitm   = lt_huitm
*       ET_LAGP    =
*       ET_HUSTOBJ =
*       ET_HUSTATUS       =
*       ET_BAPIRET =
      EXCEPTIONS
        not_found  = 1
        error      = 2
        OTHERS     = 3.

    IF sy-subrc <> 0.

*     Fehler bei der Selektion der Handling Units
      MESSAGE e011
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CALL METHOD zswl_cl_hu=>build_objects
      EXPORTING
        i_lgnum         = i_lgnum
        it_huhdr        = lt_huhdr
        it_huitm        = lt_huitm
        it_huref        = lt_huref
        it_hutree       = lt_hutree
        iv_only_sub_hus = iv_only_sub_hus
      IMPORTING
        et_hu_ref       = et_hu
      CHANGING
        co_log          = co_log.

  ENDMETHOD.


METHOD read_hu_gm.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      ls_gmhuhdr TYPE /scwm/gmhuhdr,
      ls_guid_hu TYPE /scwm/s_guid_hu,
      lt_guid_hu TYPE /scwm/tt_guid_hu,
      lt_gmhuhdr TYPE TABLE OF /scwm/gmhuhdr.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    SELECT *
      FROM /scwm/gmhuhdr
      INTO TABLE lt_gmhuhdr
     WHERE lgnum   = m_lgnum
       AND huident = i_huident.

    IF sy-subrc = 0.

      READ TABLE lt_gmhuhdr INTO ls_gmhuhdr INDEX 1.

      IF sy-subrc = 0.

        ls_guid_hu-guid_hu = ls_gmhuhdr-guid_hu.
        APPEND ls_guid_hu TO lt_guid_hu.

        CALL FUNCTION '/SCWM/GMHU_SELECT_GUID'
          EXPORTING
            it_guid  = lt_guid_hu
          IMPORTING
            et_huhdr = et_huhdr
            et_huitm = et_huitm
            et_huref = et_huref.

      ELSE.

*       Zu HU [&] wurde kein Warenbewegungslog gefunden!
        MESSAGE e014
           WITH i_huident
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

*     Zu HU [&] wurde kein Warenbewegungslog gefunden!
      MESSAGE e014
         WITH i_huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD refresh.
************************************************************************
* Company     : Swisslog AG
*
* Description : Refresh member attributes
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Standard-Funktionsbausteine um globale Puffer-Daten zu löschen
    CALL FUNCTION '/SCWM/HUMAIN_REFRESH'.

*   HU neu von der DB lesen
    me->read_hu( i_huident = ms_huhdr-huident i_read_hu_tree = iv_read_hu_tree ).

*   Pack-Objekt initialisieren
    me->init_pack( ).

  ENDMETHOD.


METHOD reread_hu.
************************************************************************
* Company     : Swisslog AG
*
* Description : Reread the HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    CALL METHOD mo_pack->/scwm/if_pack_bas~get_hu
      EXPORTING
        iv_huident = ms_huhdr-huident
      IMPORTING
        et_huitm   = mt_huitm
        es_huhdr   = ms_huhdr
        et_huref   = mt_huref
      EXCEPTIONS
        not_found  = 1
        OTHERS     = 2.

    IF sy-subrc <> 0.

*     HU-Attribute zu HU [&] konnte nicht erneut gelesen werden!
      MESSAGE e017
         WITH ms_huhdr-huident
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD save.
************************************************************************
* Company     : Swisslog AG
*
* Description : Save changes at the pack object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
*   HU [&] speichern
    MESSAGE i036
       WITH ms_huhdr-huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    CALL METHOD mo_pack->/scwm/if_pack_bas~save
      EXPORTING
        iv_commit = i_commit
        iv_wait   = i_wait
      EXCEPTIONS
        error     = 1
        OTHERS    = 2.

    IF sy-subrc <> 0.

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

*     SAP Standard-Protokoll aufnehmen
      me->log_sap_prot( ).

*     HU konnte nicht gespeichert werden!
      MESSAGE e037
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

      IF i_commit = abap_true.

        me->commit( i_wait = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD select_hu_ident.
************************************************************************
* Company     : Swisslog AG
*
* Description : Determine the HU identification
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations

    FIELD-SYMBOLS:
      <ls_huhdr>  TYPE /scwm/s_huhdr_int,
      <ls_result> TYPE /scwm/s_hu_ident.

    DATA:
      ls_guid_hu      TYPE /scwm/s_guid_hu,
      lt_result       TYPE /scwm/tt_hu_ident,
      lt_guid_hu_read TYPE /scwm/tt_guid_hu.

* End declarations
**********************************************************************

*   Selektionstabelle aufbauen

    CLEAR: lt_guid_hu_read[],
           lt_result[].

    IF i_huident IS NOT INITIAL.

      READ TABLE mt_huhdr_all ASSIGNING <ls_huhdr>
        WITH KEY lgnum    = m_lgnum
                 huident  = i_huident.
      IF sy-subrc = 0.

        CLEAR ls_guid_hu.
        ls_guid_hu-guid_hu = <ls_huhdr>-guid_hu.
        APPEND ls_guid_hu TO lt_guid_hu_read.

      ENDIF.

    ELSE.

      CLEAR ls_guid_hu.
      ls_guid_hu-guid_hu = ms_huhdr-guid_hu.
      APPEND ls_guid_hu TO lt_guid_hu_read.

    ENDIF.

    IF lines( lt_guid_hu_read ) > 0.

      IF i_idart IS NOT INITIAL.

        SELECT *
          FROM /scwm/hu_ident
          INTO TABLE lt_result
           FOR ALL ENTRIES IN lt_guid_hu_read
         WHERE guid_hu = lt_guid_hu_read-guid_hu
           AND idart   = i_idart.

        IF sy-subrc <> 0.
          CLEAR lt_result[].
        ENDIF.

      ELSE.

        SELECT *
          FROM /scwm/hu_ident
          INTO TABLE lt_result
           FOR ALL ENTRIES IN lt_guid_hu_read
         WHERE guid_hu = lt_guid_hu_read-guid_hu.

        IF sy-subrc <> 0.
          CLEAR lt_result[].
        ENDIF.

      ENDIF.

      LOOP AT lt_result ASSIGNING <ls_result>.

        READ TABLE mt_hu_ident TRANSPORTING NO FIELDS
          WITH KEY guid_hu = <ls_result>-guid_hu
                   idart   = <ls_result>-idart.

        IF sy-subrc <> 0.

          APPEND <ls_result> TO mt_hu_ident.

        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


METHOD select_open_hu_wt.
************************************************************************
* Company     : Swisslog AG
*
* Description : Select open HU WT
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rt_ordim_o[].

    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE rt_ordim_o
     WHERE lgnum    = m_lgnum
       AND vlenr    = i_huident
       AND flghuto  = abap_true.

    IF sy-subrc <> 0.

      CLEAR rt_ordim_o[].

    ENDIF.

  ENDMETHOD.


METHOD select_open_internal_moves.
************************************************************************
* Company     : Swisslog AG
*
* Description : Select open internal movement wt's for HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2017-12-08¦ B7GOKHN  ¦ Initial version
************************************************************************
    CLEAR rt_ordim_o[].

    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE rt_ordim_o
     WHERE lgnum    = m_lgnum
       AND ( vlenr  = i_huident
        OR   nlenr  = i_huident )
       AND flghuto  = abap_false
       AND trart    = 3.

    IF sy-subrc <> 0.

      CLEAR rt_ordim_o[].

    ENDIF.

  ENDMETHOD.


METHOD select_open_picks.
************************************************************************
* Company     : Swisslog AG
*
* Description : Select open pick wt's for HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    CLEAR rt_ordim_o[].

    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE rt_ordim_o
     WHERE lgnum    = m_lgnum
       AND ( vlenr  = i_huident
        OR   nlenr  = i_huident )
       AND flghuto  = abap_false
       AND trart    = 2.

    IF sy-subrc <> 0.

      CLEAR rt_ordim_o[].

    ENDIF.

  ENDMETHOD.


METHOD select_quit_picks.
************************************************************************
* Company     : Swisslog AG
*
* Description : Select confirmed pick wt's for HU
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    CLEAR rt_ordim_c[].

    SELECT *
      FROM /scwm/ordim_c
      INTO TABLE rt_ordim_c
     WHERE lgnum    = m_lgnum
       AND ( vlenr  = i_huident
        OR   nlenr  = i_huident )
       AND flghuto  = abap_false.

    IF sy-subrc <> 0.

      CLEAR rt_ordim_c[].

    ENDIF.

  ENDMETHOD.


METHOD set_huhdr.
************************************************************************
* Company     : Swisslog AG
*
* Description : Set HU header
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    ms_huhdr = is_huhdr.

  ENDMETHOD.


METHOD set_huitm.
************************************************************************
* Company     : Swisslog AG
*
* Description : Set the HU items
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    mt_huitm[] = it_huitem[].

  ENDMETHOD.


METHOD set_huref.
************************************************************************
* Company     : Swisslog AG
*
* Description : Set HU references
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    mt_huref[] = it_huref[].

  ENDMETHOD.


METHOD set_hutree.
************************************************************************
* Company     : Swisslog AG
*
* Description : Set the HU tree
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************
    mt_hutree[] = it_hutree[].

  ENDMETHOD.


METHOD unlock.
************************************************************************
* Company     : Swisslog AG
*
* Description : Unlock the Handling Unit
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Entsperre HU [&]
    MESSAGE i041
       WITH ms_huhdr-huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    CALL FUNCTION 'DEQUEUE_/SCWM/EHU'
      EXPORTING
*       mode_/scwm/s_huhdr_int =
*                                 zswl_if_constants=>mc_enqueue_type_writing
        mandt   = sy-mandt
        huident = ms_huhdr-huident
        lgnum   = m_lgnum
*       X_HUIDENT              = ' '
*       X_LGNUM = ' '
*       _SCOPE  = '3'
*       _SYNCHRON              = ' '
*       _COLLECT               = ' '
      .

*   HU [&] erfolgreich entsperrt
    MESSAGE e042
       WITH ms_huhdr-huident
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD update_huhdr.
************************************************************************
* Company     : Swisslog AG
*
* Description : Update the HU header
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

    CALL METHOD mo_pack->change_huhdr
      EXPORTING
        is_huhdr = is_huhdr
      EXCEPTIONS
        error    = 1.

    IF sy-subrc <> 0.

*     Protokollierung der SAP Standard Nachrichten
      me->log_sap_prot( ).

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

*     Kopfdaten für HU [&] konnten nicht geändert werden!
*      MESSAGE e023
*         WITH ms_huhdr-huident
*         INTO ZSWL_CL_LOG=>m_dummy_msg.
*      mo_log->add( i_syst = abap_true ).
*      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

      IF i_save = abap_true.

        me->save(
          EXPORTING
            i_commit  = i_commit
            i_wait    = i_wait ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD update_hu_ident.
************************************************************************
* Company     : Swisslog AG
*
* Description : When no entry in table /scwm/hu_ident exist for HU and
*               IDART create a new one.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-25¦ B7PLEIF  ¦ Initial version
************************************************************************

**********************************************************************
* Start declarations
    DATA:
      ls_huhdr    TYPE /scwm/s_huhdr_int,
      ls_hu_ident TYPE /scwm/s_hu_ident.
* End declarations
**********************************************************************

*|----------------------------------------------------------------------
*|  Zuerst Prüfen, ob ein Eintrag zu dieser HU und dieser Identifika-
*|  tionsart schon vorhanden ist. Wenn ja, dann wird lediglich das
*|  HUIDENT-Feld geändert.
*|  Ist noch kein Eintrag mit diesem Schlüssel vorhanden, dann wird ein
*|  neuer Eintrag hinzugefügt
*|----------------------------------------------------------------------

* Prüfen, ob eine HU-Identifikationsart mitgegeben wurde
    IF i_idart IS INITIAL.
*   Es wurde keine IDART mitgegeben!
      MESSAGE e000
         INTO zswl_cl_log=>m_dummy_msg.

      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

* HU auslesen
    ls_huhdr = me->get_huhdr_top( ).

* Prüfen, ob schon ein Eintrag vorhanden ist
    CALL METHOD me->get_hu_ident
      EXPORTING
        i_idart   = i_idart
        i_huident = ls_huhdr-huident
      IMPORTING
        es_huid   = ls_hu_ident
*       et_huid   =
      .

    IF ls_hu_ident IS NOT INITIAL.
*   -> Eintrag ist schon vorhanden

*   HU-IDENT Eintrag  für HU '&/&' mit IDART '&' schon vorhanden!
      MESSAGE i001
         WITH i_hu_ident
              ls_huhdr-huident
*              ls_huhdr-guid_hu
              i_idart
         INTO zswl_cl_log=>m_dummy_msg.

      mo_log->add( i_syst = abap_true ).

*   Neue HUIDENT '&' für HU'&/&' mit IDART '&'
      MESSAGE i002
         WITH i_hu_ident
              ls_huhdr-huident
              ls_huhdr-guid_hu
              i_idart
         INTO zswl_cl_log=>m_dummy_msg.

      mo_log->add( i_syst = abap_true ).

      UPDATE /scwm/hu_ident
         SET huident = i_hu_ident
       WHERE guid_hu = ls_huhdr-guid_hu
         AND idart   = i_idart.

      IF sy-subrc <> 0.
*     Update der HU-IDENT für HU '&/&' mit IDART '&' HUIDENT '&'
*     gescheitert!
        MESSAGE e003
           INTO zswl_cl_log=>m_dummy_msg
           WITH ls_huhdr-huident
                ls_huhdr-guid_hu
                i_idart
                i_hu_ident.

        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ELSE.
*     Update der HU-IDENT für HU '&/&' mit IDART '&' HUIDENT '&'
*     erfolgreich!
        MESSAGE i004
           INTO zswl_cl_log=>m_dummy_msg
           WITH ls_huhdr-huident
                ls_huhdr-guid_hu
                i_idart
                i_hu_ident.

        mo_log->add( i_syst = abap_true ).

      ENDIF.

    ELSE.
*   -> Eintrag ist noch nicht vorhanden und muss hinzugefügt werden

*   HU-IDENT Eintrag  für HU '&/&' mit IDART '&' noch nicht vorhanden!
      MESSAGE i005
         INTO zswl_cl_log=>m_dummy_msg
         WITH ls_huhdr-huident
              ls_huhdr-guid_hu
              i_idart.

      mo_log->add( i_syst = abap_true ).

      ls_hu_ident-guid_hu = ls_huhdr-guid_hu.
      ls_hu_ident-huident = i_hu_ident.
      ls_hu_ident-idart = i_idart.

*   Neuer HU-IDENT Eintrag für HU '&/&' mit IDART '&' HUIDENT '&'
      MESSAGE i006
         INTO zswl_cl_log=>m_dummy_msg
         WITH ls_huhdr-huident
              ls_huhdr-guid_hu
              i_idart
              i_hu_ident.

      mo_log->add( i_syst = abap_true ).

      INSERT INTO /scwm/hu_ident VALUES ls_hu_ident.

      IF sy-subrc <> 0.
*     Insert in HU-IDENT für HU '&/&' mit IDART '&' HUIDENT '&'
*     gescheitert!
*        MESSAGE e007
*           INTO ZSWL_CL_LOG=>m_dummy_msg
*           WITH ls_huhdr-huident
*                ls_huhdr-guid_hu
*                i_idart
*                i_hu_ident.

        mo_log->add( i_syst = abap_true ).

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

        zcx_ewm_general_exception=>raise_system_exception( ).

      ELSE.
*     Insert in HU-IDENT für HU '&/&' mit IDART '&' HUIDENT '&'
*     erfolgreich!
*        MESSAGE i008
*           INTO ZSWL_CL_LOG=>m_dummy_msg
*           WITH ls_huhdr-huident
*                ls_huhdr-guid_hu
*                i_idart
*                i_hu_ident.

        mo_log->add( i_syst = abap_true ).

        IF i_commit = abap_true.

          me->commit( i_wait = i_wait ).

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD zif_swlbc_object~cleanup.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZIF_SWLBC_OBJECT
* Description : Clear all buffered data
*
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-06-09 ¦ F. Pleinies      ¦ Initial
* 1.1     ¦ 2016-09-27 ¦ T. Rehmann       ¦ Review
*
************************************************************************

    " ------------------------------------------ "
    "  Local Declarations..
    " ------------------------------------------ "

    " ------------------------------------------ "
    "  Processing Logic..
    " ------------------------------------------ "


    CLEAR st_hu_references[].

  ENDMETHOD.


METHOD zif_swlbc_object~free.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Class       : ZIF_SWLBC_OBJECT
* Description : Clear all attributes and inititalize objects
*
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-06-09 ¦ F. Pleinies      ¦ Initial
* 1.1     ¦ 2016-09-27 ¦ T. Rehmann       ¦ Review
*
************************************************************************

    DELETE st_hu_references
     WHERE lgnum   = m_lgnum
       AND huident = ms_huhdr-huident.

  ENDMETHOD.
ENDCLASS.
