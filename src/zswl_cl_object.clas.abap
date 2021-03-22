class ZSWL_CL_OBJECT definition
  public
  abstract
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .

  class-data:
    BEGIN OF mc_acttype,
        insert  TYPE zswl_de_acttype VALUE 'I',
        update  TYPE zswl_de_acttype VALUE 'U',
        delete  TYPE zswl_de_acttype VALUE 'D',
        display TYPE zswl_de_acttype VALUE 'S',
      END OF mc_acttype .

  methods COMMIT
    importing
      !I_WAIT type XFELD default ABAP_TRUE .
  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_LOG_MESSAGES
    returning
      value(RT_MESSAGES) type BAPIRET2_T .
  methods GET_LOG_OBJECT
    returning
      value(RO_LOG) type ref to ZSWL_CL_LOG .
  methods ROLLBACK .
protected section.

  data MO_LOG type ref to ZSWL_CL_LOG .
  data M_LGNUM type /SCWM/LGNUM .

  methods HANDLE_ERROR
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_SEVERITY type BAPI_MTYPE
      !IT_BAPIRET type BAPIRETTAB
    returning
      value(R_ERROR) type XFELD .
private section.
ENDCLASS.



CLASS ZSWL_CL_OBJECT IMPLEMENTATION.


METHOD COMMIT.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Execute DB commit
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Commit
    IF i_wait = abap_true.
      zswl_cl_co=>commit( io_log = mo_log       "#001
                             i_wait = abap_true ).
    ELSE.
      zswl_cl_co=>commit( io_log = mo_log       "#001
                             i_wait = abap_false ).
    ENDIF.

*   Cleanup
    /scwm/cl_tm=>cleanup( iv_lgnum = m_lgnum ).

  ENDMETHOD.


METHOD CONSTRUCTOR.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Description : Constructor
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

*   Fill or create log object
    IF io_log IS NOT BOUND.
      CREATE OBJECT mo_log.
    ELSE.
      mo_log = io_log.
    ENDIF.

*   Warehouse no. may not be empty
    IF i_lgnum IS INITIAL.

*     No warehouse no. was commited!
      MESSAGE e026(zswl_ca)
         INTO ZSWL_CL_LOG=>m_dummy_msg.
      IF io_log IS BOUND.
        io_log->add( i_syst = abap_true ).
      ENDIF.
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.
      IF zswl_cl_services_ewm=>is_lgnum_existing( i_lgnum = i_lgnum ) = abap_true.
        m_lgnum = i_lgnum.
      ELSE.
*       Warehouse no. is not available!
        MESSAGE e160(zswl_ca)
           WITH i_lgnum
           INTO ZSWL_CL_LOG=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


METHOD GET_LOG_MESSAGES.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return all messages
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    CLEAR rt_messages[].

*   Get messages
    mo_log->get_messages(
              IMPORTING
*               et_messages_bal_s_msg =
                et_messages_bapiret2  = rt_messages ).

  ENDMETHOD.


METHOD GET_LOG_OBJECT.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Return the log object
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    ro_log = mo_log.

  ENDMETHOD.


METHOD HANDLE_ERROR.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Error handling
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

    r_error = abap_false.

*   1. Check Severity for error messages
    IF i_severity CA wmegc_severity_eax.

*     Add bapi messages to log object
      mo_log->add( it_bapi_list = it_bapiret ).

      IF i_commit = abap_true.
        me->rollback( ).
      ENDIF.

      r_error = abap_true.

    ELSE.

*     2. Check severity for bapi messages
      LOOP AT it_bapiret TRANSPORTING NO FIELDS
        WHERE type CA wmegc_severity_eax.
        EXIT.
      ENDLOOP.

      IF sy-subrc = 0.
*       min. 1 error message

        mo_log->add( it_bapi_list = it_bapiret ).

        IF i_commit = abap_true.
          me->rollback( ).
        ENDIF.

        r_error = abap_true.

      ELSE.

        IF i_commit = abap_true.

          me->commit( i_wait = i_wait ).

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD ROLLBACK.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_AA
* Description : Execute DB rollback
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦   Date   ¦  Author  ¦ Description
* ------- ¦ -------- ¦ -------- ¦ --------------------------------------
* 1.0     ¦2016-04-15¦ B7PLEIF  ¦ Initial version
************************************************************************

*   >>> ROLLBACK
    MESSAGE i042(zswl_ca)
       INTO ZSWL_CL_LOG=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    ROLLBACK WORK.

*   Cleanup
    /scwm/cl_tm=>cleanup( iv_lgnum = m_lgnum ).

  ENDMETHOD.
ENDCLASS.
