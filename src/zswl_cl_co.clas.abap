class ZSWL_CL_CO definition
  public
  final
  create public .

public section.
  type-pools ABAP .

  class-methods WAIT_MS
    importing
      !I_COUNT_MS type I .
  class-methods COMMIT
    importing
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_WAIT type XFELD default ABAP_TRUE .
protected section.
private section.
ENDCLASS.



CLASS ZSWL_CL_CO IMPLEMENTATION.


METHOD commit.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : WAIT_MS
* Function    : N/A
* Enhancement : N/A
* Description : Force an COMMIT on the database
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
      l_time_before TYPE timestampl,
      l_time_after  TYPE timestampl,
      l_duration    TYPE tzntstmpl.
* End declarations
**********************************************************************

* Get timestamp before
    GET TIME STAMP FIELD l_time_before.

    IF i_wait = abap_true.
      COMMIT WORK AND WAIT.
    ELSE.
      COMMIT WORK.
    ENDIF.

* Get timestamp after
    GET TIME STAMP FIELD l_time_after.

* Determine duration time for the commit execution
    TRY.
        cl_abap_tstmp=>subtract(
          EXPORTING
            tstmp1 = l_time_after
            tstmp2 = l_time_before
          RECEIVING
            r_secs = l_duration ).

      CATCH: cx_parameter_invalid_range cx_parameter_invalid_type. ##NO_HANDLER
        CLEAR l_duration.
    ENDTRY.

*     >>Data Commited
    IF io_log IS BOUND.
      MESSAGE i001(zswl_ca)
         WITH l_duration
         INTO zswl_cl_log=>m_dummy_msg.
      io_log->add( i_syst = abap_true ).
    ENDIF.

  ENDMETHOD.


METHOD WAIT_MS.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CA
* Method      : WAIT_MS
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
    DATA:
        l_timestamp_start TYPE tzntstmpl,
        l_timestamp_curr  TYPE tzntstmpl,
        l_differenz       TYPE p.
* End declarations
**********************************************************************

    IF i_count_ms <= 0.
      RETURN.
    ENDIF.

    GET TIME STAMP FIELD l_timestamp_start.
    WHILE ( l_differenz < i_count_ms ).
      GET TIME STAMP FIELD l_timestamp_curr.
      l_differenz = ( l_timestamp_curr - l_timestamp_start ) * 1000.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.
