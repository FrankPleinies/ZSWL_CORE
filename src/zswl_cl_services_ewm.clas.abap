class ZSWL_CL_SERVICES_EWM definition
  public
  create public .

public section.

  class-methods GET_BUSSYS_BY_LOGSYS
    importing
      !I_LOGSYS type LOGSYS
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    returning
      value(R_BUSSYS) type SLD_BSKEY
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_ENTITLED_AND_SCU_BY_LGNUM
    importing
      !I_LGNUM type /SCWM/LGNUM
    exporting
      value(ES_SCU) type /SCWM/S_T300_MD
      value(ES_ENTITLED) type /SCMB/MDL_PARTNER
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_LGNUM_BY_BUSSYS
    importing
      !I_BUSSYS type SLD_BSKEY
    exporting
      value(ET_LGNUM) type /SCWM/TT_LGNUM
      value(E_LGNUM) type /SCWM/LGNUM
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_OWNER_AND_SCU_BY_LGNUM
    importing
      !I_LGNUM type /SCWM/LGNUM
    exporting
      value(ES_SCU) type /SCWM/S_T300_MD
      value(ES_OWNER) type /SCMB/MDL_PARTNER
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods IS_LGNUM_EXISTING
    importing
      !I_LGNUM type /SCWM/LGNUM
    returning
      value(R_EXISTING) type XFELD
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.
private section.
ENDCLASS.



CLASS ZSWL_CL_SERVICES_EWM IMPLEMENTATION.


METHOD GET_BUSSYS_BY_LOGSYS.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_UTILITIES
* Method      : GET_BUSSYS_BY_LOGSYS
* Function    : N/A
* Enhancement : N/A
* Description : This method returns the business system for the logical
*               system id.
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
      l_bussys                  TYPE sld_bskey.
* End declarations
**********************************************************************


*   Initialisation
    CLEAR r_bussys.
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*   Determine business system
    SELECT SINGLE bskey ##WARN_OK
      FROM /scmb/tbussys
      INTO l_bussys
     WHERE logsys = i_logsys
    .
    IF sy-subrc = 0.
*     Set the return value
      r_bussys = l_bussys.

*     Write message
      MESSAGE i000
         WITH r_bussys
              i_logsys
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

    ELSE.
*     Write message
      MESSAGE e001
         WITH i_logsys
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

  ENDMETHOD.


METHOD GET_ENTITLED_AND_SCU_BY_LGNUM.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_UTILITIES
* Method      : GET_ENTITLED_AND_SCU_BY_LGNUM
* Function    : N/A
* Enhancement : N/A
* Description : This method returns the entitled and supply chain unit
*               for the warehouse number.
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
      ls_scu      TYPE /scwm/s_t300_md,
      ls_key      TYPE /scmb/mdl_partner_key_str,
      ls_entitled TYPE /scmb/mdl_partner.
* End declarations
**********************************************************************

*   Initialisation
    CLEAR es_scu.
    CLEAR es_entitled.
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*   Determine the Supply-Chain-Unit (SCU)
    CALL FUNCTION '/SCWM/T300_MD_READ_SINGLE'
      EXPORTING
        iv_lgnum      = i_lgnum
      IMPORTING
        es_t300_md    = ls_scu
      EXCEPTIONS
        not_found     = 1
        error_message = 3
        OTHERS        = 2.
    IF sy-subrc = 0.
*     Set return value
      es_scu = ls_scu.

*     Write log
      MESSAGE i002
         WITH es_scu-sc_unit
              i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

    ELSE.
*     Log error messages from SAP standard
      co_log->add( i_syst = abap_true ).

*     Write log
      MESSAGE e003
         WITH i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

*   Determine the entitled
    ls_key-partner = ls_scu-entitled.
    TRY.
        CALL FUNCTION '/SCMB/MDL_PARTNER_READ'
          EXPORTING
            iv_appl_component = wmegc_mdl_appl_comp
            is_key            = ls_key
            iv_language       = sy-langu
          IMPORTING
            es_data           = ls_entitled.

      CATCH /scmb/cx_mdl_interface      INTO zswl_cl_log=>mx_dummy_exception.
*     Log error messages from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result_empty   INTO zswl_cl_log=>mx_dummy_exception.
*     Log error messages from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result_toomany INTO zswl_cl_log=>mx_dummy_exception.
*     Log error messages from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result         INTO zswl_cl_log=>mx_dummy_exception.
*     Log error messages from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl                INTO zswl_cl_log=>mx_dummy_exception.
*     Log error messages from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).
    ENDTRY.

    IF ls_entitled IS NOT INITIAL.
*     Set partner role
      ls_entitled-partner_role = wmegc_entitled_role_bp.

*     Set return value
      es_entitled = ls_entitled.

*     Write log
      MESSAGE i004
         WITH ls_entitled-partner
              i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

    ELSE.
*     Write log
      MESSAGE e005
         WITH i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

  ENDMETHOD.


METHOD GET_LGNUM_BY_BUSSYS.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_UTILITIES
* Method      : GET_LGNUM_BY_BUSSYS
* Function    : N/A
* Enhancement : N/A
* Description : This method returns the warehouse number for the
*               business system.
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
      lt_lgnum TYPE /scwm/tt_lgnum,
      l_lgnum  TYPE /scwm/lgnum.

* End declarations
**********************************************************************


*   Initialisation
    CLEAR et_lgnum[].
    CLEAR e_lgnum.
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*   Determine warehouse number
    SELECT whnumwme
      FROM /scwm/tmapwhnum
      INTO TABLE lt_lgnum
     WHERE erpbskey = i_bussys
    .
    IF sy-subrc = 0.
*     Set return value
      READ TABLE lt_lgnum INTO l_lgnum INDEX 1.
      e_lgnum  = l_lgnum.
      et_lgnum = lt_lgnum.

*     Write log
      LOOP AT et_lgnum INTO l_lgnum.
        MESSAGE i010
           WITH l_lgnum
                i_bussys
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
      ENDLOOP.

    ELSE.
*     Write log
      MESSAGE e011
         WITH i_bussys
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

  ENDMETHOD.


METHOD GET_OWNER_AND_SCU_BY_LGNUM.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_UTILITIES
* Method      : GET_OWNER_AND_SCU_BY_LGNUM
* Function    : N/A
* Enhancement : N/A
* Description : This method returns the owner and supply chain unit
*               for the warehouse number.
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
      ls_scu   TYPE /scwm/s_t300_md,
      ls_key   TYPE /scmb/mdl_partner_key_str,
      ls_owner TYPE /scmb/mdl_partner.
* End declarations
**********************************************************************

*   Initialisation
    CLEAR es_scu.
    CLEAR es_owner.
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*   Determine the Supply-Chain-Unit (SCU)
    CALL FUNCTION '/SCWM/T300_MD_READ_SINGLE'
      EXPORTING
        iv_lgnum      = i_lgnum
      IMPORTING
        es_t300_md    = ls_scu
      EXCEPTIONS
        not_found     = 1
        error_message = 3
        OTHERS        = 2.
    IF sy-subrc = 0.
*     Set return value
      es_scu = ls_scu.

*     Write log
      MESSAGE i006
         WITH es_scu-sc_unit
              i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

    ELSE.
*     Log error from SAP standard
      co_log->add( i_syst = abap_true ).

*     Write log
      MESSAGE e007
         WITH i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

*   Determine the owner
    ls_key-partner = ls_scu-custodian.
    TRY.
        CALL FUNCTION '/SCMB/MDL_PARTNER_READ'
          EXPORTING
            iv_appl_component = wmegc_mdl_appl_comp
            is_key            = ls_key
            iv_language       = sy-langu
          IMPORTING
            es_data           = ls_owner.

      CATCH /scmb/cx_mdl_interface      INTO zswl_cl_log=>mx_dummy_exception.
*     Log error from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result_empty   INTO zswl_cl_log=>mx_dummy_exception.
*     Log error from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result_toomany INTO zswl_cl_log=>mx_dummy_exception.
*     Log error from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl_result         INTO zswl_cl_log=>mx_dummy_exception.
*     Log error from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).

      CATCH /scmb/cx_mdl                INTO zswl_cl_log=>mx_dummy_exception.
*     Log error from SAP standard
        co_log->add( ix_exception = zswl_cl_log=>mx_dummy_exception ).
    ENDTRY.

    IF ls_owner IS NOT INITIAL.
*     set partner role
      ls_owner-partner_role = wmegc_owner_role_bp.

*     Set return value
      es_owner = ls_owner.

*     Write log
      MESSAGE i008
         WITH ls_owner-partner
              i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

    ELSE.
*     Write log
      MESSAGE e009
         WITH i_lgnum
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

*     Exception Handling
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

  ENDMETHOD.


METHOD IS_LGNUM_EXISTING.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_UTILITIES
* Method      : IS_LGNUM_EXISTING
* Function    : N/A
* Enhancement : N/A
* Description : This method check if the warehouse number exist.
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
      l_lgnum                   TYPE /scwm/lgnum.

* End declarations
**********************************************************************


* Implementation

    r_existing = abap_false.

    IF i_lgnum IS INITIAL.

*     Write log
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Read warehouse data
    CALL FUNCTION '/SCWM/T300_READ_SINGLE'
      EXPORTING
        iv_lgnum  = i_lgnum
*     IMPORTING
*       es_t300   =
*       es_t300t  =
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.

    IF sy-subrc = 0.
      r_existing = abap_true.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
