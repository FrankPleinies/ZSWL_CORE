class ZSWL_CL_PACK_MAT definition
  public
  inheriting from ZSWL_CL_PRODUCT
  final
  create public .

public section.

  methods GET_MATPACK
    returning
      value(RS_MATPACK) type /SAPAPO/MATPACK .
  class-methods GET_INSTANCE_BY_MATID
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_MATID type /SAPAPO/MATID
    exporting
      !EO_PMAT type ref to ZSWL_CL_PACK_MAT
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_INSTANCE_TO_HUTYP
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_HUTYP type /SCWM/DE_HUTYP
    exporting
      !EO_PMAT type ref to ZSWL_CL_PACK_MAT
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
      !IS_MATPACK type /SAPAPO/MATPACK optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.

  data MS_MATPACK type /SAPAPO/MATPACK .

  methods SELECT_MATPACK
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  class-methods SELECT_MATPACK_BY_HUTYP
    importing
      !I_HUTYP type /SCWM/DE_HUTYP
    exporting
      !ES_MATPACK type /SAPAPO/MATPACK
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods SELECT_MATPACK_BY_MATID
    importing
      !I_MATID type /SAPAPO/MATID
    exporting
      !ES_MATPACK type /SAPAPO/MATPACK
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
ENDCLASS.



CLASS ZSWL_CL_PACK_MAT IMPLEMENTATION.


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
        i_matid_r16   = i_matid_r16
        i_matid_c22   = i_matid_c22
        i_matnr_c40   = i_matnr_c40
        io_log        = io_log ).

    IF is_matpack IS INITIAL.
      me->select_matpack( ).
    ELSE.
      ms_matpack = is_matpack.
    ENDIF.

  ENDMETHOD.


METHOD get_instance_by_matid.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the pack mat object to the incoming MATID (C22)
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
      ls_matpack                TYPE /sapapo/matpack.

* End declarations
**********************************************************************

    CLEAR eo_pmat.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     No warehouse no. given
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF i_matid IS INITIAL.

*     No MAT ID given
      MESSAGE e016
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   First select the pack material on DB for the HU Type
    select_matpack_by_matid(
      EXPORTING
        i_matid     = i_matid
      IMPORTING
        es_matpack  = ls_matpack
      CHANGING
        co_log      = co_log ).

    CREATE OBJECT eo_pmat
      EXPORTING
        i_lgnum     = i_lgnum
        i_matid_c22 = ls_matpack-matid
        io_log      = co_log
        is_matpack  = ls_matpack.

*   Pack-Material [&] for HU-Typ [&] determined
    MESSAGE i011
       WITH eo_pmat->get_matnr( )
            i_matid
       INTO zswl_cl_log=>m_dummy_msg.
    co_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD get_instance_to_hutyp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the pack mat object to the incoming HU Type
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
      ls_matpack                TYPE /sapapo/matpack.

* End declarations
**********************************************************************

    CLEAR eo_pmat.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_lgnum IS INITIAL.

*     No warehouse no. given
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF i_hutyp IS INITIAL.

*     No HU type given
      MESSAGE e010
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   First select the pack material on DB for the HU Type
    select_matpack_by_hutyp(
      EXPORTING
        i_hutyp     = i_hutyp
      IMPORTING
        es_matpack  = ls_matpack
      CHANGING
        co_log      = co_log ).

    CREATE OBJECT eo_pmat
      EXPORTING
        i_lgnum     = i_lgnum
        i_matid_c22 = ls_matpack-matid
        io_log      = co_log
        is_matpack  = ls_matpack.

*   Pack-Material [&] for HU-Typ [&] determined
    MESSAGE i011
       WITH eo_pmat->get_matnr( )
            i_hutyp
       INTO zswl_cl_log=>m_dummy_msg.
    co_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD get_matpack.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the matpack data of the object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    rs_matpack = ms_matpack.

  ENDMETHOD.


METHOD select_matpack.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select the material pack data
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    SELECT SINGLE *
      FROM /sapapo/matpack
      INTO ms_matpack
     WHERE matid = m_matid_c22.

    IF sy-subrc <> 0.

*     Log message
      MESSAGE e012
         WITH m_matnr_c40
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_matpack_by_hutyp.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select material pack data by HU type
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR es_matpack.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    SELECT SINGLE *
      FROM /sapapo/matpack
      INTO es_matpack
     WHERE hutyp = i_hutyp.

    IF sy-subrc <> 0.

*     Log message
      MESSAGE e008
         WITH i_hutyp
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_matpack_by_matid.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Select material pack data by HU type
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR es_matpack.

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    SELECT SINGLE *
      FROM /sapapo/matpack
      INTO es_matpack
     WHERE matid = i_matid.

    IF sy-subrc <> 0.

*     Log message
      MESSAGE e009
         WITH i_matid
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
