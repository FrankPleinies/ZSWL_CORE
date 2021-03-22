class ZSWL_CL_PRODUCT definition
  public
  inheriting from ZSWL_CL_OBJECT
  create public .

public section.

  interfaces ZIF_SWLBC_OBJECT .

  aliases CLEANUP
    for ZIF_SWLBC_OBJECT~CLEANUP .
  aliases FREE
    for ZIF_SWLBC_OBJECT~FREE .

  methods GET_MAT_LGTYP
    returning
      value(RS_MAT_LGTYP) type /SCWM/S_MATERIAL_LGTYP .
  methods GET_MAT_UOM
    returning
      value(RT_MAT_UOM) type /SCWM/TT_MATERIAL_UOM .
  class-methods APPEND_LEADING_ZEROS_PROD
    changing
      !C_MATNR type /SAPAPO/MATNR .
  class-methods DELETE_LEADING_ZEROS_PROD
    changing
      !C_MATNR type /SAPAPO/MATNR .
  class-methods READ_PRODUCT_BY_EAN
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_NO_TXT_SELECTION type XFELD default ABAP_FALSE
      !I_READ_GLOBAL type XFELD default ABAP_TRUE
      !I_READ_HAZARD type XFELD default ABAP_FALSE
      !I_READ_LGNUM type XFELD default ABAP_FALSE
      !I_READ_LGTYP type XFELD default ABAP_FALSE
      !I_READ_UOM type XFELD default ABAP_FALSE
      !I_EAN11 type /SAPAPO/EAN11
      !I_EANCAT type /SCMB/DE_EAN_CAT optional
      !IT_MATID_R16 type /SCWM/TT_MATID optional
      !IT_MATID_C22 type /SAPAPO/MATID_TAB optional
      !IT_MATNR type /SAPAPO/MATNR_TAB optional
      !I_ENTITLED type /SCWM/DE_ENTITLED optional
      !IT_LGTYP type /SCWM/TT_LGTYP optional
    exporting
      !ET_PROD_REF type ZSWL_TT_PRODUCT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_PRODUCT
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_MATID_R16 type /SCWM/TT_MATID optional
      !IT_MATID_C22 type /SAPAPO/MATID_TAB optional
      !IT_MATNR type /SAPAPO/MATNR_TAB optional
      !I_ENTITLED type /SCWM/DE_ENTITLED optional
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !I_NO_TXT_SELECTION type XFELD default ABAP_FALSE
      !I_READ_GLOBAL type XFELD default ABAP_TRUE
      !I_READ_HAZARD type XFELD default ABAP_FALSE
      !I_READ_LGNUM type XFELD default ABAP_FALSE
      !I_READ_LGTYP type XFELD default ABAP_FALSE
      !I_READ_UOM type XFELD default ABAP_FALSE
      !I_READ_MEAN type XFELD default ABAP_FALSE
    exporting
      !ET_PROD_REF type ZSWL_TT_PRODUCT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_MATID_R16 type /SCWM/DE_MATID optional
      !I_MATID_C22 type /SAPAPO/MATID optional
      !I_MATNR_C40 type /SAPAPO/MATNR optional
      !IS_MATKEY type /SAPAPO/MATKEY optional
      !I_NEW_MAT type XFELD default ABAP_FALSE
      !I_SEL_MAT type XFELD default ABAP_FALSE
      !I_EAN11 type /SAPAPO/EAN11 optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DB_DEL_MATLWH
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DB_GET_MATLWH
    returning
      value(RS_MATLWH) type /SAPAPO/MATLWH
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DB_INIT_MATLWH
    importing
      !I_LGNUM type /SCWM/LGNUM optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DB_INS_MATLWH
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DB_UPD_MATLWH
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_LGBKZ
    returning
      value(R_LGBKZ) type /SCWM/LVS_LGBKZ .
  methods GET_MAKTX
    importing
      !IV_LANGU type LANGU optional
    returning
      value(R_MAKTX) type /SAPAPO/MAKTX .
  methods GET_MATKEY
    returning
      value(RS_MATKEY) type /SAPAPO/MATKEY .
  methods GET_MATID_C22
    returning
      value(R_MATID_C22) type /SAPAPO/MATID .
  methods GET_MATID_R16
    returning
      value(R_MATID_R16) type /SCWM/DE_MATID .
  methods GET_EAN11
    returning
      value(R_EAN11) type /SAPAPO/EAN11 .
  methods GET_MATNR
    returning
      value(R_MATNR) type /SAPAPO/MATNR .
  methods LOAD_DATA
    importing
      !I_ENTITLED type /SCWM/DE_ENTITLED optional
      !I_LGTYP type /SCWM/LGTYP optional
      !I_READ_GLOBAL type XFELD default ABAP_TRUE
      !I_READ_MATPACK type XFELD default ABAP_FALSE
      !I_READ_HAZARD type XFELD default ABAP_FALSE
      !I_READ_LGNUM type XFELD default ABAP_FALSE
      !I_READ_LGTYP type XFELD default ABAP_FALSE
      !I_READ_UOM type XFELD default ABAP_FALSE
      !I_READ_MEAN type XFELD default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SET_DATA
    importing
      !IS_MAT_GLOBAL type /SCWM/S_MATERIAL_GLOBAL optional
      !IS_MAT_PACK type /SCWM/S_MATERIAL_PACK optional
      !IS_MAT_HAZARD type /SCWM/S_MATERIAL_HAZARD optional
      !IS_MAT_LGNUM type /SCWM/S_MATERIAL_LGNUM optional
      !IS_MAT_LGTYP type /SCWM/S_MATERIAL_LGTYP optional
      !IT_MAT_UOM type /SCWM/TT_MATERIAL_UOM optional
      !IT_MAT_MEAN type /SCWM/TT_MAT_MEAN optional .
  methods GET_MAT_LGNUM
    returning
      value(RS_MAT_LGNUM) type /SCWM/S_MATERIAL_LGNUM .
  methods GET_MAT_GLOBAL
    returning
      value(RS_MAT_GLOBAL) type /SCWM/S_MATERIAL_GLOBAL .
protected section.

  data MS_CIF_MATKEY type /SAPAPO/CIF_MATKEY .
  data MS_INIT_MATLWH type /SAPAPO/MATLWH .
  data MS_MATKEY type /SAPAPO/MATKEY .
  data MS_MATLWH type /SAPAPO/MATLWH .
  data MS_MAT_GLOBAL type /SCWM/S_MATERIAL_GLOBAL .
  data MS_MAT_HAZARD type /SCWM/S_MATERIAL_HAZARD .
  data MS_MAT_LGNUM type /SCWM/S_MATERIAL_LGNUM .
  data MS_MAT_LGTYP type /SCWM/S_MATERIAL_LGTYP .
  data MS_MAT_PACK type /SCWM/S_MATERIAL_PACK .
  data MT_MAT_MEAN type /SCWM/TT_MAT_MEAN .
  data MT_MAT_UOM type /SCWM/TT_MATERIAL_UOM .
  data M_MATID_C22 type /SAPAPO/MATID .
  data M_MATID_R16 type /SCWM/DE_MATID .
  data M_MATNR_C40 type /SAPAPO/MATNR .
  data M_MATTXT type /SAPAPO/MAKTX .
  data M_EAN11 type /SAPAPO/EAN11 .

  methods SELECT_MAKTX
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_MATKEY
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_MATLWH
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  class-methods BUILD_MATID_TABLE
    importing
      !IT_MATID_R16 type /SCWM/TT_MATID optional
      !IT_MATID_C22 type /SAPAPO/MATID_TAB optional
      !IT_MATNR type /SAPAPO/MATNR_TAB optional
    exporting
      !ET_MATID_R16 type /SCWM/TT_MATID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional .
  methods DB_SET_MATLWH
    importing
      !I_VB type CHAR01
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods FILL_PRODUCT_NUMBERS
    importing
      !I_MATID_R16 type /SCWM/DE_MATID optional
      !I_MATID_C22 type /SAPAPO/MATID optional
      !I_MATNR_C40 type /SAPAPO/MATNR optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
ENDCLASS.



CLASS ZSWL_CL_PRODUCT IMPLEMENTATION.


METHOD append_leading_zeros_prod.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Insert leading zeros for the matnr
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CALL FUNCTION 'CONVERSION_EXIT_PRODU_INPUT'
      EXPORTING
        input        = c_matnr
      IMPORTING
        output       = c_matnr
      EXCEPTIONS
        length_error = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.


METHOD build_matid_table.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Build tables with all different MATID's
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    FIELD-SYMBOLS:
      <l_matid> TYPE /sapapo/matid,
      <l_matnr> TYPE /sapapo/matnr_str.

    DATA:
      l_matid TYPE /scwm/de_matid,
      l_matnr TYPE /scwm/de_matnr.

    et_matid_r16[] = it_matid_r16[].

    LOOP AT it_matid_c22 ASSIGNING <l_matid>.

      CALL METHOD zswl_cl_services_conv=>matid_c22_to_matnr
        EXPORTING
          i_matid = <l_matid>
        IMPORTING
          e_matnr = l_matnr
        CHANGING
          co_log  = co_log
        EXCEPTIONS
          error   = 1
          OTHERS  = 2.

      IF sy-subrc = 0.

        CALL METHOD zswl_cl_services_conv=>matnr_to_matid
          EXPORTING
            i_matnr = l_matnr
          IMPORTING
            e_matid = l_matid
          CHANGING
            co_log  = co_log
          EXCEPTIONS
            error   = 1
            OTHERS  = 2.

        IF sy-subrc = 0.

          APPEND l_matid TO et_matid_r16.

        ENDIF.

      ENDIF.

    ENDLOOP.

    LOOP AT it_matnr ASSIGNING <l_matnr>.

      CALL METHOD zswl_cl_services_conv=>matnr_to_matid
        EXPORTING
          i_matnr = <l_matnr>-matnr
        IMPORTING
          e_matid = l_matid
        CHANGING
          co_log  = co_log
        EXCEPTIONS
          error   = 1
          OTHERS  = 2.

      IF sy-subrc = 0.

        APPEND l_matid TO et_matid_r16.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


METHOD constructor.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Constructor of class
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

    IF i_new_mat  = abap_true.

*     --> new Material will be created (e.g. Via CIF)
      ms_matkey   = is_matkey.
      m_matid_c22 = ms_matkey-matid.
      m_matnr_c40 = ms_matkey-matnr.

    ELSEIF i_sel_mat = abap_true.

*     Material were already selected --> fill only attributes
      ms_matkey   = is_matkey.
      m_matid_r16 = i_matid_r16.
      m_matid_c22 = i_matid_c22.
      m_matnr_c40 = i_matnr_c40.
      m_ean11     = i_ean11.

    ELSE.

*     Determine from the incoming parameters all necessary numbers
*     and identifications
      me->fill_product_numbers(
        EXPORTING
          i_matid_c22 = i_matid_c22
          i_matid_r16 = i_matid_r16
          i_matnr_c40 = i_matnr_c40 ).

      IF is_matkey IS NOT INITIAL.
        ms_matkey = is_matkey.
      ELSE.
        me->select_matkey( ).
      ENDIF.

*     Select material texts
      me->select_maktx( ).

    ENDIF.

  ENDMETHOD.


METHOD db_del_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Delete warehouse product from DB
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    DATA:
      l_vb                      TYPE char01.


    l_vb = 'D'.

*   Delete the warehouse product
    CALL METHOD me->db_set_matlwh
      EXPORTING
        i_vb = l_vb.

  ENDMETHOD.


METHOD db_get_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the warehouse product
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************
    DATA:
      ls_matlwh                 TYPE /sapapo/matlwh.


    CLEAR rs_matlwh.

*   Start selection
    TRY.
        CALL METHOD me->select_matlwh.
      CATCH zcx_ewm_general_exception .
        CLEAR me->ms_matlwh.
    ENDTRY.

    ls_matlwh = me->ms_matlwh.

*   Set return value
    rs_matlwh = ls_matlwh.

*   Set attributes
    me->ms_matlwh = me->ms_init_matlwh.

  ENDMETHOD.


METHOD db_init_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Initial work for handling the warehouse product
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
      l_lgnum     TYPE /scwm/lgnum,
      ls_scu      TYPE /scwm/s_t300_md,
      ls_entitled TYPE /scmb/mdl_partner.
* End declarations
**********************************************************************

    IF i_lgnum IS NOT INITIAL.
      l_lgnum = i_lgnum.
    ELSE.
      l_lgnum = me->m_lgnum.
    ENDIF.

*   Determine Supply-Chain-Unit (SCU) and entitled
    CALL METHOD zswl_cl_services_ewm=>get_entitled_and_scu_by_lgnum
      EXPORTING
        i_lgnum     = l_lgnum
      IMPORTING
        es_scu      = ls_scu
        es_entitled = ls_entitled
      CHANGING
        co_log      = me->mo_log.

    me->ms_init_matlwh-matid       = me->m_matid_c22.
    me->ms_init_matlwh-scuguid     = ls_scu-scuguid.
    me->ms_init_matlwh-entitled_id = ls_entitled-partner_guid.
    me->ms_matlwh                  = me->ms_init_matlwh.

  ENDMETHOD.


METHOD db_ins_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Insert warehouse product
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************
    DATA:
      l_vb                      TYPE char01.


    l_vb = 'I'.

*   Create warehouse product
    CALL METHOD me->db_set_matlwh
      EXPORTING
        i_vb = l_vb.

  ENDMETHOD.


METHOD db_set_matlwh.

**   Definition
*    DATA:
*      ls_matlwh      TYPE /sapapo/matlwh,
*      lt_matlwh      TYPE zewmbbctt_matlwh,
*      ls_matlwh_badi TYPE /sapapo/matlwh.
*
*
**   Initialisierung
*    ls_matlwh = me->ms_matlwh.
*
*************************************************************************
**   Begin BAdI MO_BADI_MATLWH
*************************************************************************
*
**   Ermittlung BAdI
*    GET BADI me->mo_badi_matlwh.
*
**   Prüfen ob BAdI implementiert wurde
*    IF me->mo_badi_matlwh IS BOUND.
*
**     Ausführung BAdI
*      CALL BADI mo_badi_matlwh->modify_matlwh
*        EXPORTING
*          i_vb      = i_vb
*          is_matlwh = ls_matlwh
*        CHANGING
*          cs_matlwh = ls_matlwh_badi.
*
**     Rückgabewert des BAdI prüfen
*      IF ls_matlwh-matid       = ls_matlwh_badi-matid       AND
*         ls_matlwh-scuguid     = ls_matlwh_badi-scuguid     AND
*         ls_matlwh-entitled_id = ls_matlwh_badi-entitled_id.
*
**       Rückgabewert des BAdI übernehmen
*        ls_matlwh = ls_matlwh_badi.
*      ENDIF.
*
*    ELSE.
**     Lagersicht nicht anlegen
*      RETURN.
*    ENDIF.
*
*************************************************************************
**   End BAdI MO_BADI_MATLWH
*************************************************************************
*
**   Lagersicht zum Produkt bearbeiten
*    APPEND ls_matlwh TO lt_matlwh.
*
*    CALL FUNCTION '/SAPAPO/DM_PRODUCTS_POST'
*      EXPORTING
*        iv_vb             = i_vb
*        iv_check_clean_up = abap_true
*      TABLES
*        it_matlwh         = lt_matlwh
*      EXCEPTIONS
*        not_qualified     = 1
*        insert_failed     = 2
*        update_failed     = 3
*        insert_duprec     = 4
*        error_message     = zif_ewmbbc_constants=>mc_error_message
*        OTHERS            = 5.
*    IF sy-subrc <> 0.
**     Fehlermeldung vom SAP-Standard protokollieren
*      mo_log->add( i_syst = abap_true ).
*
**     Exception Handling
*      zcx_ewm_general_exception=>raise_system_exception( ).
*    ENDIF.

  ENDMETHOD.


METHOD db_upd_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Update the warehouse product
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************
    DATA:
      l_vb                      TYPE char01.


    l_vb = 'U'.

*   Modify warehouse product
    CALL METHOD me->db_set_matlwh
      EXPORTING
        i_vb = l_vb.

  ENDMETHOD.


METHOD delete_leading_zeros_prod.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Delete the left leading zeros on the material number
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CALL FUNCTION 'CONVERSION_EXIT_PRODU_OUTPUT'
      EXPORTING
        input  = c_matnr
      IMPORTING
        output = c_matnr.

  ENDMETHOD.


METHOD fill_product_numbers.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Convert the product numbers
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF i_matid_r16 IS NOT INITIAL.

      me->m_matid_r16 = i_matid_r16.

      zswl_cl_services_conv=>matid_to_matnr(
        EXPORTING
          i_matid   = me->m_matid_r16
        IMPORTING
          e_matnr   = me->m_matnr_c40
        CHANGING
          co_log    = me->mo_log
        EXCEPTIONS
          error     = 1
          OTHERS    = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e000
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

      zswl_cl_services_conv=>matnr_to_matid_c22(
        EXPORTING
          i_matnr   = me->m_matnr_c40
        IMPORTING
          e_matid   = me->m_matid_c22
        CHANGING
          co_log    = me->mo_log
        EXCEPTIONS
          error     = 1
          OTHERS    = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e001
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSEIF i_matid_c22 IS NOT INITIAL.

      me->m_matid_c22 = i_matid_c22.

      zswl_cl_services_conv=>matid_c22_to_matnr(
        EXPORTING
          i_matid     = me->m_matid_c22
        IMPORTING
          e_matnr     = me->m_matnr_c40
        CHANGING
          co_log      = me->mo_log
        EXCEPTIONS
          error       = 1
          OTHERS      = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e002
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

      zswl_cl_services_conv=>matnr_to_matid(
        EXPORTING
          i_matnr     = me->m_matnr_c40
        IMPORTING
          e_matid     = me->m_matid_r16
        CHANGING
          co_log      = me->mo_log
        EXCEPTIONS
          error       = 1
          OTHERS      = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e003
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSEIF i_matnr_c40 IS NOT INITIAL.

      me->m_matnr_c40 = i_matnr_c40.

      zswl_cl_services_conv=>matnr_to_matid(
        EXPORTING
          i_matnr     = me->m_matnr_c40
        IMPORTING
          e_matid     = me->m_matid_r16
        CHANGING
          co_log      = me->mo_log
        EXCEPTIONS
          error       = 1
          OTHERS      = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e003
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

      zswl_cl_services_conv=>matnr_to_matid_c22(
        EXPORTING
          i_matnr   = me->m_matnr_c40
        IMPORTING
          e_matid   = me->m_matid_c22
        CHANGING
          co_log    = me->mo_log
        EXCEPTIONS
          error     = 1
          OTHERS    = 2 ).

      IF sy-subrc <> 0.

*       Log message
        MESSAGE e001
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ENDIF.

    ELSE.

*     Log message
      MESSAGE e004
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD GET_EAN11.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Rerturn the EAN11
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_ean11 = me->m_ean11.

  ENDMETHOD.


METHOD get_lgbkz.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the storage area indicatior
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_lgbkz = ms_mat_lgnum-lgbkz.

  ENDMETHOD.


METHOD get_maktx.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the material text
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    IF iv_langu IS SUPPLIED AND iv_langu IS NOT INITIAL.

      SELECT SINGLE maktx
           FROM /sapapo/mattxt
           INTO r_maktx
          WHERE matid = m_matid_c22
            AND langu = iv_langu.

      IF sy-subrc <> 0.

        MESSAGE e005
           WITH m_matnr_c40
                sy-langu
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

* No exception will be thrown, because a not maintained text is not compellent an error
      ENDIF.
    ELSE.
      r_maktx = me->m_mattxt.
    ENDIF.

  ENDMETHOD.


METHOD get_matid_c22.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the MATID in CHAR22
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

     r_matid_c22 = me->m_matid_c22.

  ENDMETHOD.


METHOD get_matid_r16.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Rerturn the MATID in RAW16
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_matid_r16 = me->m_matid_r16.

  ENDMETHOD.


METHOD get_matkey.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the product key fields
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rs_matkey = ms_matkey.

  ENDMETHOD.


METHOD get_matnr.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the material no.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_matnr = me->m_matnr_c40.

  ENDMETHOD.


method GET_MAT_GLOBAL.
    rs_mat_global = ms_mat_global.
  endmethod.


method GET_MAT_LGNUM.
    rs_mat_lgnum = ms_mat_lgnum.
  endmethod.


METHOD get_mat_lgtyp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the material storage type data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rs_mat_lgtyp = ms_mat_lgtyp.

  ENDMETHOD.


METHOD get_mat_uom.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the material measurement unit data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rt_mat_uom = mt_mat_uom.

  ENDMETHOD.


METHOD load_data.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Read the material data
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
      lx_exception TYPE REF TO /scwm/cx_md,
      lt_para      TYPE abap_func_parmbind_tab,
      ls_para      TYPE abap_func_parmbind.

* End declarations
**********************************************************************


    CLEAR ls_para.
    ls_para-name = 'IV_MATID'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF m_matid_r16 INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    CLEAR ls_para.
    ls_para-name = 'IV_LGNUM'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF m_lgnum INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    IF i_entitled IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'IV_ENTITLED'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF i_entitled INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_lgtyp IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'IV_LGTYP'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF i_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_global = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ES_MAT_GLOBAL'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF ms_mat_global INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_matpack = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ES_MAT_PACK'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF ms_mat_pack INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_hazard = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ES_MAT_HAZARD'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF ms_mat_hazard INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgnum = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ES_MAT_LGNUM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF ms_mat_lgnum INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgtyp = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ES_MAT_LGTYP'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF ms_mat_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_uom = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_UOM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF mt_mat_uom INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_mean = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_MEAN'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF mt_mat_mean INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Dynamic call of the Material read function
*   We need this because on the basis of the EXPORTING Parameter (IS SUPPLIED)
*   we know which tables should be read
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    TRY.

        CALL FUNCTION '/SCWM/MATERIAL_READ_SINGLE'
          PARAMETER-TABLE lt_para.

      CATCH /scwm/cx_md_interface       INTO lx_exception.
        mo_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_material_exist  INTO lx_exception.
        mo_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_mat_lgnum_exist INTO lx_exception.
        mo_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_lgnum_locid     INTO lx_exception.
        mo_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md                 INTO lx_exception.
        mo_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
    ENDTRY.

  ENDMETHOD.


METHOD read_product.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Read the material product
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
      <ls_mat_global> TYPE /scwm/s_material_global,
      <ls_mat_uom>    TYPE /scwm/s_material_uom,
      <ls_mat_mean>   TYPE /scwm/s_mat_mean.

    DATA:
      lx_exception TYPE REF TO /scwm/cx_md,
      lx_root_exc  TYPE REF TO cx_sy_dyn_call_error,
      lt_matid     TYPE /scwm/tt_matid,
      lt_para      TYPE abap_func_parmbind_tab,
      ls_para      TYPE abap_func_parmbind,
      ls_prod_ref  TYPE zswl_s_product_ref.

    DATA:
      lt_mat_global TYPE /scwm/tt_material_global,
      lt_mat_hazard TYPE /scwm/tt_material_hazard,
      lt_mat_lgnum  TYPE /scwm/tt_material_lgnum,
      lt_mat_lgtyp  TYPE /scwm/tt_material_lgtyp,
      lt_mat_uom    TYPE /scwm/tt_material_uom,
      lt_mat_mean   TYPE /scwm/tt_mat_mean,
      ls_matkey     TYPE /sapapo/matkey.

    DATA:
      ls_mat_hazard    TYPE /scwm/s_material_hazard,
      ls_mat_lgnum     TYPE /scwm/s_material_lgnum,
      ls_mat_lgtyp     TYPE /scwm/s_material_lgtyp,
      lt_mat_uom_prod  TYPE /scwm/tt_material_uom,
      lt_mat_mean_prod TYPE /scwm/tt_mat_mean,
      lv_matidc22      TYPE /sapapo/matid,
      ls_ean           TYPE /sapapo/marm.

* End declarations
**********************************************************************

    CLEAR et_prod_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    CALL METHOD zswl_cl_product=>build_matid_table
      EXPORTING
        it_matid_r16 = it_matid_r16
        it_matid_c22 = it_matid_c22
        it_matnr     = it_matnr
      IMPORTING
        et_matid_r16 = lt_matid
      CHANGING
        co_log       = co_log.


    CLEAR ls_para.
    ls_para-name = 'IT_MATID'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF lt_matid INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    CLEAR ls_para.
    ls_para-name = 'IV_LGNUM'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF i_lgnum INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    IF i_entitled IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'IV_ENTITLED'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF i_entitled INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF it_lgtyp[] IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'TT_LGTYP'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF it_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    CLEAR ls_para.
    ls_para-name = 'IV_NOTEXT'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF i_no_txt_selection INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    IF i_read_global = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_GLOBAL'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_global INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_hazard = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_HAZARD'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_hazard INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgnum = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_LGNUM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_lgnum INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgtyp = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_LGTYP'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_uom = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_UOM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_uom INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_mean = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_MEAN'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_mean INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Dynamic call of the Material read function
*   We need this because on the basis of the EXPORTING Parameter (IS SUPPLIED)
*   we know which tables should be read
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    TRY.

        CALL FUNCTION '/SCWM/MATERIAL_READ_MULTIPLE'
          PARAMETER-TABLE lt_para.

      CATCH /scwm/cx_md_interface       INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_material_exist  INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_mat_lgnum_exist INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_lgnum_locid     INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md                 INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH cx_sy_dyn_call_error INTO lx_root_exc.
        co_log->add( ix_exception = lx_root_exc ).
        zcx_ewm_general_exception=>raise_system_exception( ).
    ENDTRY.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Fill return tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT lt_mat_global ASSIGNING <ls_mat_global>.

      CLEAR ls_prod_ref.
      ls_prod_ref-lgnum     = i_lgnum.
      ls_prod_ref-matnr     = <ls_mat_global>-matnr.
      ls_prod_ref-matid_r16 = <ls_mat_global>-matid.

      MOVE-CORRESPONDING <ls_mat_global> TO ls_matkey.

      "Determine MATID C22
      zswl_cl_services_conv=>matnr_to_matid_c22(
         EXPORTING i_matnr = <ls_mat_global>-matnr
         IMPORTING e_matid = lv_matidc22
         CHANGING  co_log  = co_log ).

      select single * from /SAPAPO/MARM into ls_ean
      where matid = lv_matidc22.


      CREATE OBJECT ls_prod_ref-o_product
        EXPORTING
          i_lgnum     = i_lgnum
          i_sel_mat   = abap_true
          is_matkey   = ls_matkey
          i_matid_r16 = <ls_mat_global>-matid
          i_matnr_c40 = <ls_mat_global>-matnr
          i_ean11     = ls_ean-ean11.

      READ TABLE lt_mat_hazard INTO ls_mat_hazard
        WITH KEY matid = <ls_mat_global>-matid.
      IF sy-subrc <> 0.
        CLEAR ls_mat_hazard.
      ENDIF.

      IF i_entitled IS INITIAL.
        READ TABLE lt_mat_lgnum INTO ls_mat_lgnum
          WITH KEY matid = <ls_mat_global>-matid.
      ELSE.
        READ TABLE lt_mat_lgnum INTO ls_mat_lgnum
          WITH KEY matid    = <ls_mat_global>-matid
                   entitled = i_entitled.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR ls_mat_lgnum.
      ENDIF.

      READ TABLE lt_mat_lgtyp INTO ls_mat_lgtyp
        WITH KEY matid = <ls_mat_global>-matid.
      IF sy-subrc <> 0.
        CLEAR ls_mat_lgtyp.
      ENDIF.

      LOOP AT lt_mat_uom ASSIGNING <ls_mat_uom>
        WHERE matid = <ls_mat_global>-matid.
        APPEND <ls_mat_uom> TO lt_mat_uom_prod.
      ENDLOOP.

      LOOP AT lt_mat_mean ASSIGNING <ls_mat_mean>
        WHERE matid = <ls_mat_global>-matid.
        APPEND <ls_mat_mean> TO lt_mat_mean_prod.
      ENDLOOP.

      ls_prod_ref-o_product->set_data(
        EXPORTING
          is_mat_global   = <ls_mat_global>
*          is_mat_pack     =
          is_mat_hazard   = ls_mat_hazard
          is_mat_lgnum    = ls_mat_lgnum
          is_mat_lgtyp    = ls_mat_lgtyp
          it_mat_uom      = lt_mat_uom_prod
          it_mat_mean     = lt_mat_mean_prod ).

      APPEND ls_prod_ref TO et_prod_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD READ_PRODUCT_BY_EAN.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Read the material product
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
      <ls_mat_global> TYPE /scwm/s_material_global,
      <ls_mat_uom>    TYPE /scwm/s_material_uom,
      <ls_mat_mean>   TYPE /scwm/s_mat_mean.

    DATA:
      lx_exception TYPE REF TO /scwm/cx_md,
      lx_root_exc  TYPE REF TO cx_sy_dyn_call_error,
      lt_matid     TYPE /scwm/tt_matid,
      lt_para      TYPE abap_func_parmbind_tab,
      ls_para      TYPE abap_func_parmbind,
      ls_prod_ref  TYPE zswl_s_product_ref.

    DATA:
      lt_mat_global TYPE /scwm/tt_material_global,
      lt_mat_hazard TYPE /scwm/tt_material_hazard,
      lt_mat_lgnum  TYPE /scwm/tt_material_lgnum,
      lt_mat_lgtyp  TYPE /scwm/tt_material_lgtyp,
      lt_mat_uom    TYPE /scwm/tt_material_uom,
      lt_mat_mean   TYPE /scwm/tt_mat_mean,
      ls_matkey     TYPE /sapapo/matkey.

    DATA:
      ls_mat_hazard    TYPE /scwm/s_material_hazard,
      ls_mat_lgnum     TYPE /scwm/s_material_lgnum,
      ls_mat_lgtyp     TYPE /scwm/s_material_lgtyp,
      lt_mat_uom_prod  TYPE /scwm/tt_material_uom,
      lt_mat_mean_prod TYPE /scwm/tt_mat_mean.

    DATA:
      lt_eans          TYPE STANDARD TABLE OF /SAPAPO/MARM,
      ls_ean           TYPE /SAPAPO/MARM,
*      lt_eans          TYPE STANDARD TABLE OF /SAPAPO/MEANGTIN,
*      ls_ean           TYPE /SAPAPO/MEANGTIN,
      lt_matid_c22     TYPE /SAPAPO/MATID_TAB.

* End declarations
**********************************************************************

    CLEAR et_prod_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    "Select all EAN's for the given code
    select * from /SAPAPO/MARM into CORRESPONDING FIELDS OF TABLE lt_eans
      where ean11 = i_ean11.
*    select * from /SAPAPO/MEANGTIN into CORRESPONDING FIELDS OF TABLE lt_eans
*      where ean11 = i_ean11.

    IF lines( lt_eans ) <= 0.
      "Message: EAN [&1] not found
      MESSAGE e018(zswl_product) with i_ean11 into zswl_cl_log=>M_DUMMY_MSG.
      co_log->ADD( I_SYST = abap_true ).
      zcx_ewm_general_exception=>RAISE_SYSTEM_EXCEPTION( ).
    ELSE.
      "If EAN category is supplied then remove all entries with another category.
      IF i_eancat IS NOT INITIAL.
        LOOP AT lt_eans into ls_ean.
          IF ls_ean-EANCAT <> i_eancat.
            delete lt_eans from ls_ean.
            CONTINUE.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    READ TABLE lt_eans into ls_ean INDEX 1.
    append ls_ean-MATID to lt_matid_c22.

    CALL METHOD zswl_cl_product=>build_matid_table
      EXPORTING
*        it_matid_r16 = it_matid_r16
        it_matid_c22 = lt_matid_c22
*        it_matnr     = it_matnr
      IMPORTING
        et_matid_r16 = lt_matid
      CHANGING
        co_log       = co_log.


    CLEAR ls_para.
    ls_para-name = 'IT_MATID'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF lt_matid INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    CLEAR ls_para.
    ls_para-name = 'IV_LGNUM'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF i_lgnum INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    IF i_entitled IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'IV_ENTITLED'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF i_entitled INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF it_lgtyp[] IS NOT INITIAL.

      CLEAR ls_para.
      ls_para-name = 'TT_LGTYP'.
      ls_para-kind = abap_func_exporting.
      GET REFERENCE OF it_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    CLEAR ls_para.
    ls_para-name = 'IV_NOTEXT'.
    ls_para-kind = abap_func_exporting.
    GET REFERENCE OF i_no_txt_selection INTO ls_para-value.
    INSERT ls_para INTO TABLE lt_para.

    IF i_read_global = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_GLOBAL'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_global INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_hazard = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_HAZARD'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_hazard INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgnum = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_LGNUM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_lgnum INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_lgtyp = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_LGTYP'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_lgtyp INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

    IF i_read_uom = abap_true.

      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_UOM'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_uom INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.

    ENDIF.

      "Return EAN informations all the time
      CLEAR ls_para.
      ls_para-name  = 'ET_MAT_MEAN'.
      ls_para-kind  = abap_func_importing.
      GET REFERENCE OF lt_mat_mean INTO ls_para-value.
      INSERT ls_para INTO TABLE lt_para.


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Dynamic call of the Material read function
*   We need this because on the basis of the EXPORTING Parameter (IS SUPPLIED)
*   we know which tables should be read
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    TRY.

        CALL FUNCTION '/SCWM/MATERIAL_READ_MULTIPLE'
          PARAMETER-TABLE lt_para.

      CATCH /scwm/cx_md_interface       INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_material_exist  INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_mat_lgnum_exist INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md_lgnum_locid     INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH /scwm/cx_md                 INTO lx_exception.
        co_log->add( ix_exception = lx_exception ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      CATCH cx_sy_dyn_call_error INTO lx_root_exc.
        co_log->add( ix_exception = lx_root_exc ).
        zcx_ewm_general_exception=>raise_system_exception( ).
    ENDTRY.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Fill return tables
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT lt_mat_global ASSIGNING <ls_mat_global>.

      CLEAR ls_prod_ref.
      ls_prod_ref-lgnum     = i_lgnum.
      ls_prod_ref-matnr     = <ls_mat_global>-matnr.
      ls_prod_ref-matid_r16 = <ls_mat_global>-matid.

      MOVE-CORRESPONDING <ls_mat_global> TO ls_matkey.

      CREATE OBJECT ls_prod_ref-o_product
        EXPORTING
          i_lgnum     = i_lgnum
          i_sel_mat   = abap_true
          is_matkey   = ls_matkey
          i_matid_r16 = <ls_mat_global>-matid
          i_matnr_c40 = <ls_mat_global>-matnr.

      READ TABLE lt_mat_hazard INTO ls_mat_hazard
        WITH KEY matid = <ls_mat_global>-matid.
      IF sy-subrc <> 0.
        CLEAR ls_mat_hazard.
      ENDIF.

      IF i_entitled IS INITIAL.
        READ TABLE lt_mat_lgnum INTO ls_mat_lgnum
          WITH KEY matid = <ls_mat_global>-matid.
      ELSE.
        READ TABLE lt_mat_lgnum INTO ls_mat_lgnum
          WITH KEY matid    = <ls_mat_global>-matid
                   entitled = i_entitled.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR ls_mat_lgnum.
      ENDIF.

      READ TABLE lt_mat_lgtyp INTO ls_mat_lgtyp
        WITH KEY matid = <ls_mat_global>-matid.
      IF sy-subrc <> 0.
        CLEAR ls_mat_lgtyp.
      ENDIF.

      LOOP AT lt_mat_uom ASSIGNING <ls_mat_uom>
        WHERE matid = <ls_mat_global>-matid.
        APPEND <ls_mat_uom> TO lt_mat_uom_prod.
      ENDLOOP.

      LOOP AT lt_mat_mean ASSIGNING <ls_mat_mean>
        WHERE matid = <ls_mat_global>-matid.
        APPEND <ls_mat_mean> TO lt_mat_mean_prod.
      ENDLOOP.

      ls_prod_ref-o_product->set_data(
        EXPORTING
          is_mat_global   = <ls_mat_global>
*          is_mat_pack     =
          is_mat_hazard   = ls_mat_hazard
          is_mat_lgnum    = ls_mat_lgnum
          is_mat_lgtyp    = ls_mat_lgtyp
          it_mat_uom      = lt_mat_uom_prod
          it_mat_mean     = lt_mat_mean_prod ).

      APPEND ls_prod_ref TO et_prod_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD select_maktx.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select material texts
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT SINGLE maktx
      FROM /sapapo/mattxt
      INTO m_mattxt
     WHERE matid = m_matid_c22
       AND langu = sy-langu.

    IF sy-subrc <> 0.

      MESSAGE e005
         WITH m_matnr_c40
              sy-langu
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

* No exception will be thrown, because a not maintained text is not compellent an error
    ENDIF.

  ENDMETHOD.


METHOD select_matkey.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select the product header data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT SINGLE *
      FROM /sapapo/matkey
      INTO ms_matkey
     WHERE matid = m_matid_c22.

    IF sy-subrc <> 0.

*    Log message
      MESSAGE e006
         WITH m_matnr_c40
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_matlwh.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select the warehouse product data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************
    DATA:
      ls_matlwh                 TYPE /sapapo/matlwh.


    CLEAR ms_matlwh.

*   Start selection
    SELECT SINGLE *
      FROM /sapapo/matlwh
      INTO ls_matlwh
     WHERE matid       = ms_init_matlwh-matid
       AND scuguid     = ms_init_matlwh-scuguid
       AND entitled_id = ms_init_matlwh-entitled_id.

    IF sy-subrc <> 0.
*     Log message
      MESSAGE e007
         WITH ms_matlwh-matid
              ms_matlwh-scuguid
              ms_matlwh-entitled_id
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

*   Set Attributes
    ms_matlwh = ls_matlwh.

  ENDMETHOD.


METHOD set_data.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Set data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    ms_mat_global   = is_mat_global.
    IF is_mat_global-maktx IS NOT INITIAL.
      m_mattxt = is_mat_global-maktx.
    ENDIF.
    ms_mat_pack     = is_mat_pack.
    ms_mat_hazard   = is_mat_hazard.
    ms_mat_lgnum    = is_mat_lgnum.
    ms_mat_lgtyp    = is_mat_lgtyp.
    mt_mat_uom[]    = it_mat_uom[].
    mt_mat_mean[]   = it_mat_mean[].

  ENDMETHOD.


METHOD zif_swlbc_object~cleanup.

    RETURN.

  ENDMETHOD.


METHOD zif_swlbc_object~free.

    RETURN.

  ENDMETHOD.
ENDCLASS.
