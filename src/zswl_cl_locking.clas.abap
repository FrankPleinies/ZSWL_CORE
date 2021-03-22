class ZSWL_CL_LOCKING definition
  public
  final
  create public .

public section.

  constants MC_PREFIX_WORKSTATION type CHAR2 value 'WS' ##NO_TEXT.
  constants MC_ENQMODE_S type ENQMODE value 'S' ##NO_TEXT.
  constants MC_ENQMODE_E type ENQMODE value 'E' ##NO_TEXT.
  constants MC_ENQMODE_X type ENQMODE value 'X' ##NO_TEXT.
  constants MC_ENQMODE_O type ENQMODE value 'O' ##NO_TEXT.
  constants MC_SCOPE_1 type DDENQSCOPE value 1 ##NO_TEXT.
  constants MC_SCOPE_2 type DDENQSCOPE value 2 ##NO_TEXT.
  constants MC_SCOPE_3 type DDENQSCOPE value 3 ##NO_TEXT.

  class-methods DEQUEUE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_LOCK_PRAEFIX type ANY
      !I_LOCK_ID type ANY optional
      !I_ENQMODE type ENQMODE default 'X'
      !I_ENQSCOPE type DDENQSCOPE default '3'
      !I_DELETE_KUMULATION type XFELD default 'X'
      !I_CNT_DEQUEUE_TRIES type I default 100
      !I_WAIT_AFTER_DEQUEUE_TRY type I default 100
    changing
      !XO_LOG type ref to ZSWL_CL_LOG optional
    exceptions
      ERROR .
  class-methods ENQUEUE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_LOCK_PRAEFIX type ANY
      !I_LOCK_ID type ANY optional
      !I_ENQMODE type ENQMODE default 'X'
      !I_ENQSCOPE type DDENQSCOPE default '3'
      !I_CNT_ENQUEUE_RETRIES type I default 0
      !I_WAIT_AFTER_ENQUEUE_TRY type I default 1000
    exporting
      !E_ENQ_UNAME type EQEUNAME
    changing
      !XO_LOG type ref to ZSWL_CL_LOG optional
    exceptions
      ERROR .
  class-methods ENQUEUE_READ
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_LOCK_PRAEFIX type ANY
      !I_LOCK_ID type ANY optional
    exporting
      !E_ENQ_UNAME type EQEUNAME
      !ET_ENQ_ENTRIES type /SCWM/TT_SEQG3
    changing
      !XO_LOG type ref to ZSWL_CL_LOG optional
    exceptions
      ERROR .
protected section.
private section.

  class-methods _CREATE_LOCK_NAME
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_LOCK_PRAEFIX type ANY
      !I_LOCK_ID type ANY
    exporting
      !E_LOCK_NAME type TRDIR-NAME .
  class-methods _WAIT
    importing
      !I_WAITTIME type I .
ENDCLASS.



CLASS ZSWL_CL_LOCKING IMPLEMENTATION.


METHOD dequeue.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : DEQUEUE
* Function    : N/A
* Enhancement : N/A
* Description : Unlock the object
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
    DATA: l_lock_name          TYPE trdir-name,
          l_garg_name          TYPE eqegraarg,
          l_lock_cnt           TYPE i,
          l_kumulation         TYPE i,
          l_kumulation_checked TYPE xfeld,
          l_subrc              TYPE sy-subrc.

    DATA: lt_enq                    TYPE /scwm/tt_seqg3.

    FIELD-SYMBOLS: <ls_enq>         TYPE seqg3.
* End declarations
************************************************************************

************************************************************************
*** Create log object if not given
************************************************************************
    IF xo_log IS NOT BOUND.

      CREATE OBJECT xo_log.

    ENDIF.
************************************************************************

************************************************************************
*** Create lock name based on prefix and ID
************************************************************************
    CALL METHOD zswl_cl_locking=>_create_lock_name
      EXPORTING
        i_lgnum        = i_lgnum
        i_lock_praefix = i_lock_praefix
        i_lock_id      = i_lock_id
      IMPORTING
        e_lock_name    = l_lock_name.
************************************************************************

************************************************************************
*** Dequeue SM12 lock entry
************************************************************************
    CALL FUNCTION 'DEQUEUE_ESRDIRE'
      EXPORTING
        mode_trdir    = i_enqmode
        name          = l_lock_name
        x_name        = ' '
        _scope        = i_enqscope
        _synchron     = abap_true
        _collect      = abap_false
      EXCEPTIONS
        error_message = 99
        OTHERS        = 1.

    IF sy-subrc <> 0.

* Normaly the function module above does not catch an exception. The
* handling for exception "ERROR_MESSAGE" is only assigned to avoid
* dumps!


    ENDIF.
************************************************************************

* >>> Check if SM12 lock entry could be dequeued
*     This needs to be done because function module for DEQUEUE does not
*     return an exception in case of error!

    l_garg_name = l_lock_name.

    DO.

      CLEAR: l_subrc,
             lt_enq.

************************************************************************
*** Read SM12 lock
************************************************************************
      CALL FUNCTION 'ENQUEUE_READ'
        EXPORTING
          gclient               = sy-mandt
          gname                 = 'TRDIR'
          garg                  = l_garg_name
          guname                = '*'
*         local                 = ' '
        IMPORTING
*         NUMBER                =
          subrc                 = l_subrc
        TABLES
          enq                   = lt_enq
        EXCEPTIONS
          communication_failure = 1
          system_failure        = 2
          error_message         = 99
          OTHERS                = 3.                          "#EC *

      IF sy-subrc <> 0 OR
         l_subrc  <> 0 OR
         lines( lt_enq ) <= 0.

* SM12 lock entry with name '&' successfully dequeued by user '&'
        MESSAGE i001(zswl_locking)
          WITH l_lock_name sy-uname
          INTO zswl_cl_log=>m_dummy_msg.
        xo_log->add( i_syst = abap_true ).

        RETURN.

      ENDIF.
************************************************************************

************************************************************************
*** Also delete kumulated locks and this is not happend yet?
************************************************************************
      IF i_delete_kumulation  = abap_true AND
         l_kumulation_checked = abap_false.

        CLEAR: l_kumulation.

        l_kumulation_checked = abap_true.

* Read lock entry
        READ TABLE lt_enq
         ASSIGNING <ls_enq>
             INDEX 1.

* Is the kumulation bigger as zero, then ...
        IF sy-subrc = 0 AND
           <ls_enq>-guse > 0.

* ... take count of kumulations
          l_kumulation = <ls_enq>-guse.

        ENDIF.

* Kumulations available, then ...
        IF l_kumulation > 0.

* ... try to dequeue all kumulations

          DO l_kumulation TIMES.

            CALL FUNCTION 'DEQUEUE_ESRDIRE'
              EXPORTING
                mode_trdir    = i_enqmode
                name          = l_lock_name
                x_name        = ' '
                _scope        = i_enqscope
                _synchron     = abap_true
                _collect      = abap_false
              EXCEPTIONS
                error_message = 99
                OTHERS        = 1.                            "#EC *

            IF sy-subrc <> 0.                               "#EC NEEDED
            ENDIF.

          ENDDO.

* Next run!
          CONTINUE.

        ENDIF.

      ENDIF.
************************************************************************

* The SM12 lock still exists ...
* > Increase count of tries and try again after a short waiting time
      ADD 1 TO l_lock_cnt.

* If maximum count of tries not reached yet, then wait and try again
      IF ( l_lock_cnt <= i_cnt_dequeue_tries ).

* This waiting time is needed, because we have to wait for the "DEQUEUE"
* function module. Also in case of using the "SYNCHRON" flag the module
* does not always work synchron!!

        CALL METHOD zswl_cl_locking=>_wait
          EXPORTING
            i_waittime = i_wait_after_dequeue_try.

* Next try!
        CONTINUE.

      ENDIF.

* If we reached here, then the SM12 lock could not be dequeued ...

* Error during dequeue SM12 lock with name '&'!
      MESSAGE e006(zswl_locking)
        WITH l_lock_name
        INTO zswl_cl_log=>m_dummy_msg.
      xo_log->add( i_syst = abap_true ).

      RAISE error.

    ENDDO.
************************************************************************

  ENDMETHOD.


METHOD enqueue.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : ENQUEUE
* Function    : N/A
* Enhancement : N/A
* Description : Lock the object
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
    DATA: l_lock_name TYPE trdir-name,
          l_lock_cnt  TYPE i.
* End declarations
************************************************************************

    CLEAR: e_enq_uname.

************************************************************************
*** Create log object if not given
************************************************************************
    IF xo_log IS NOT BOUND.

      CREATE OBJECT xo_log.

    ENDIF.
************************************************************************

************************************************************************
*** Create lock name based on prefix and ID
************************************************************************
    CALL METHOD zswl_cl_locking=>_create_lock_name
      EXPORTING
        i_lgnum        = i_lgnum
        i_lock_praefix = i_lock_praefix
        i_lock_id      = i_lock_id
      IMPORTING
        e_lock_name    = l_lock_name.
************************************************************************

    DO.

************************************************************************
*** Enqueue SM12 lock entry
************************************************************************
      CALL FUNCTION 'ENQUEUE_ESRDIRE'
        EXPORTING
          mode_trdir     = i_enqmode
          name           = l_lock_name
          x_name         = ' '
          _scope         = i_enqscope
          _wait          = ' '
          _collect       = ' '
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          error_message  = 99
          OTHERS         = 3.

      IF sy-subrc = 0.


* SM12 lock entry with name '&' successfully enqueued by user '&'!
        MESSAGE i002(zswl_locking)
          WITH l_lock_name sy-uname
          INTO zswl_cl_log=>m_dummy_msg.
        xo_log->add( i_syst = abap_true ).
        RETURN.

      ENDIF.
************************************************************************

************************************************************************
*** The SM12 lock already exists
*** > Try again to enqueue in case that max. count of tries not reached
************************************************************************
* Increase count of tries and try again after a short waiting time
      ADD 1 TO l_lock_cnt.

* If maximum count of tries not reached yet, then wait and try again
      IF ( l_lock_cnt <= i_cnt_enqueue_retries ).

        CALL METHOD zswl_cl_locking=>_wait
          EXPORTING
            i_waittime = i_wait_after_enqueue_try.

* Next try!
        CONTINUE.

      ENDIF.

* Maximum count of tries reached ...
      EXIT.
************************************************************************

    ENDDO.

************************************************************************
*** In case of error the argument is already enqueued by another user!
************************************************************************
    CALL METHOD zswl_cl_locking=>enqueue_read
      EXPORTING
        i_lgnum        = i_lgnum
        i_lock_praefix = i_lock_praefix
        i_lock_id      = i_lock_id
      IMPORTING
        e_enq_uname    = e_enq_uname
*       et_enq_entries =
      CHANGING
        xo_log         = xo_log
      EXCEPTIONS
        error          = 1
        OTHERS         = 2.

    IF sy-subrc <> 0 OR
       e_enq_uname IS INITIAL.

** Error during enqueue SM12 lock entry with name '&'!
      MESSAGE e004(zswl_locking)
        WITH sy-uname
        INTO zswl_cl_log=>m_dummy_msg.
      xo_log->add( i_syst = abap_true ).

    ELSE.


** A SM12 lock entry with argument '&' already exists for user '&'!
      MESSAGE e003(zswl_locking)
        WITH l_lock_cnt sy-uname
        INTO zswl_cl_log=>m_dummy_msg.
      xo_log->add( i_syst = abap_true ).

    ENDIF.

    RAISE error.
************************************************************************

  ENDMETHOD.


METHOD enqueue_read.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : ENQUEUE_READ
* Function    : N/A
* Enhancement : N/A
* Description : Read the current locked object
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
    DATA: l_lock_name TYPE trdir-name,
          l_garg_name TYPE eqegraarg,
          l_subrc     TYPE sy-subrc.

    DATA: lt_enq                    TYPE /scwm/tt_seqg3.

    FIELD-SYMBOLS: <ls_enq>         TYPE seqg3.
* End declarations
************************************************************************

    CLEAR: e_enq_uname,
           et_enq_entries.

************************************************************************
*** Create log object if not given
************************************************************************
    IF xo_log IS NOT BOUND.

      CREATE OBJECT xo_log.

    ENDIF.
************************************************************************

************************************************************************
*** Create lock name based on prefix and ID
************************************************************************
    CALL METHOD zswl_cl_locking=>_create_lock_name
      EXPORTING
        i_lgnum        = i_lgnum
        i_lock_praefix = i_lock_praefix
        i_lock_id      = i_lock_id
      IMPORTING
        e_lock_name    = l_lock_name.
************************************************************************

    l_garg_name = l_lock_name.

************************************************************************
*** Read SM12 lock entry
************************************************************************
    CALL FUNCTION 'ENQUEUE_READ'
      EXPORTING
        gclient               = sy-mandt
        gname                 = 'TRDIR'
        garg                  = l_garg_name
        guname                = '*'
*       local                 = ' '
      IMPORTING
*       NUMBER                =
        subrc                 = l_subrc
      TABLES
        enq                   = lt_enq
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2
        error_message         = 99
        OTHERS                = 3.                            "#EC *

    IF sy-subrc <> 0 OR
       l_subrc  <> 0.

* Error during reading lock table with argument '&'!
      MESSAGE e005(zswl_locking)
        WITH l_lock_name
        INTO zswl_cl_log=>m_dummy_msg.
      xo_log->add( i_syst = abap_true ).

      RAISE error.

    ENDIF.
************************************************************************

************************************************************************
*** Return in case that no SM12 lock entry with that argument exists
************************************************************************
    IF lines( lt_enq ) <= 0.

      RETURN.

    ENDIF.
************************************************************************

************************************************************************
*** A lock entry with that argument exists
*** > Return name of user, who has created the lock entry
************************************************************************
    READ TABLE lt_enq
     ASSIGNING <ls_enq>
         INDEX 1.

    IF sy-subrc <> 0.

* Not possible, because count of lines in tab. have been changed before!
      RETURN.

    ENDIF.

    e_enq_uname      = <ls_enq>-guname.
    et_enq_entries[] = lt_enq[].
************************************************************************

  ENDMETHOD.


METHOD _create_lock_name.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : _CREATE_LOCK_NAME
* Function    : N/A
* Enhancement : N/A
* Description : Build the name for the lock object
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

    DATA: l_lock_lgnum   TYPE string,
          l_lock_praefix TYPE string,
          l_lock_id      TYPE string.
* End declarations
************************************************************************

    CLEAR: e_lock_name.

************************************************************************
*** Create lock name
************************************************************************
    l_lock_lgnum   = i_lgnum.
    l_lock_praefix = i_lock_praefix.
    l_lock_id      = i_lock_id.

    CONDENSE l_lock_lgnum   NO-GAPS.
    CONDENSE l_lock_praefix NO-GAPS.
    CONDENSE l_lock_id      NO-GAPS.

    IF i_lgnum IS NOT INITIAL.

      e_lock_name = l_lock_lgnum.

    ENDIF.

    IF l_lock_praefix IS NOT INITIAL.

      IF e_lock_name IS NOT INITIAL.

        CONCATENATE e_lock_name
                   '-' "ztop_hyphen
               INTO e_lock_name.

      ENDIF.

      CONCATENATE e_lock_name
                  l_lock_praefix
             INTO e_lock_name.

    ENDIF.

    IF l_lock_id IS NOT INITIAL.

      IF e_lock_name IS NOT INITIAL.

        CONCATENATE e_lock_name
                    '-'
               INTO e_lock_name.

      ENDIF.

      CONCATENATE e_lock_name
                  l_lock_id
             INTO e_lock_name.

    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD _wait.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : DEQUEUE
* Function    : N/A
* Enhancement : N/A
* Description :
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
    DATA: l_timestamp_start TYPE tzntstmpl,
          l_timestamp_curr  TYPE tzntstmpl,
          l_differenz       TYPE tzntstmpl.
* End declarations
************************************************************************

************************************************************************
*** Wait count of milisecunds
************************************************************************
    GET TIME STAMP FIELD l_timestamp_start.

    WHILE ( l_differenz < i_waittime ).

      GET TIME STAMP FIELD l_timestamp_curr.

      TRY.
          l_differenz = cl_abap_tstmp=>subtract(
            tstmp1 = l_timestamp_curr
            tstmp2 = l_timestamp_start ).

        CATCH cx_parameter_invalid_range .              "#EC NO_HANDLER
        CATCH cx_parameter_invalid_type .               "#EC NO_HANDLER

      ENDTRY.

      MULTIPLY l_differenz BY 1000.

    ENDWHILE.
************************************************************************

  ENDMETHOD.
ENDCLASS.
