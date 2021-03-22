class ZSWL_CL_WHO definition
  public
  inheriting from ZSWL_CL_OBJECT
  final
  create public .

public section.
  type-pools ABAP .

  methods CONSTRUCTOR
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !I_WHO type /SCWM/DE_WHO optional
      !IS_WHO type /SCWM/WHO optional
      !I_RF_READ type XFELD default ABAP_FALSE
      !I_HU_READ type XFELD default ABAP_FALSE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_OPEN_WTS
    returning
      value(RT_WT) type ZSWL_TT_WT_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SPLIT
    importing
      !IT_ORDIM_O type /SCWM/TT_ORDIM_O optional
      !IT_WT_REF type ZSWL_TT_WT_REF optional
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_SIMULATE type XFELD default ABAP_FALSE
    exporting
      !EO_NEW_WHO type ref to ZSWL_CL_WHO
      !ET_WHO_REF type ZSWL_TT_WHO_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UPDATE_PRIORITY
    importing
      !I_PRIO type /SCWM/DE_PRIO_WHO
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_WHOS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_QUEUE type /SCWM/TT_QUEUE optional
      !IT_WHOSTAT type ZSWL_TT_WHOSTAT optional
      !I_INVENTORY type /SCWM/DE_FLGINV default ABAP_FALSE
    exporting
      !ET_WHO_REF type ZSWL_TT_WHO_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods HOLD_UNHOLD
    importing
      !IV_HOLD type BOOLEAN optional
      !IV_UNHOLD type BOOLEAN optional .
  methods GET_DATA
    returning
      value(RS_DATA) type /SCWM/WHO .
  methods GET_WHO_HUS
    returning
      value(RT_WHOHUS) type /SCWM/TT_WHOHU .
  methods GET_PICK_WTS
    exporting
      !ET_OPEN_PICK_WTS type ZSWL_TT_WT_REF
      !ET_ALL_PICK_WTS type ZSWL_TT_WT_REF
      !ET_CONFIRMED_PICK_WTS type ZSWL_TT_WT_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.

  data MS_WHO type /SCWM/WHO .
  data MT_RSRC_TY type /SCWM/TT_WO_RSRC_TY .
  data MT_WHO_HU type /SCWM/TT_WHOHU .

  methods SELECT_WHO
    importing
      value(I_WHO) type /SCWM/DE_WHO
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods SELECT_WHO_HU
    importing
      !I_WHO type /SCWM/DE_WHO
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
private section.

  class-methods SELECT_WHOS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IRT_QUEUE type /SCWM/TT_QUEUE_R
      !IRT_WHOSTAT type /SCWM/TT_WHOSTAT_R
      !I_INVENTORY type /SCWM/DE_FLGINV
    exporting
      !ET_WHO type /SCWM/TT_WHO
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods BUILD_REF_TABLE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_WHO type /SCWM/TT_WHO
      !IO_LOG type ref to ZSWL_CL_LOG
    returning
      value(RT_WHO_REF) type ZSWL_TT_WHO_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
ENDCLASS.



CLASS ZSWL_CL_WHO IMPLEMENTATION.


METHOD build_ref_table.

    DATA:
      lo_who     TYPE REF TO zswl_cl_who,
      ls_who_ref TYPE zswl_s_who_ref.

    FIELD-SYMBOLS:
      <ls_who>                    TYPE /scwm/who.


    CLEAR rt_who_ref[].

* Tabelle mit Lagerauftrag-Objekten füllen
    LOOP AT it_who ASSIGNING <ls_who>.
      CLEAR ls_who_ref.

*   Lagerauftrags-Objekt erstellen
      CREATE OBJECT lo_who
        EXPORTING
          i_lgnum = i_lgnum
          io_log  = io_log
          is_who  = <ls_who>.

      ls_who_ref-lgnum = i_lgnum.
      ls_who_ref-who   = <ls_who>-who.
      ls_who_ref-o_who = lo_who.
      APPEND ls_who_ref TO rt_who_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD constructor.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    super->constructor(
      EXPORTING
        i_lgnum   = i_lgnum
        io_log    = io_log ).

    IF i_who  IS INITIAL AND
       is_who IS INITIAL.

*     Es wurde kein Lagerauftrag übergeben!
      MESSAGE e000
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*   Lagerauftragsstruktur lesen
    IF is_who IS NOT INITIAL.
      ms_who = is_who.
    ELSE.
      me->select_who( i_who = i_who ).
    ENDIF.

    IF i_hu_read = abap_true.
      me->select_who_hu( i_who = i_who ).
    ENDIF.

  ENDMETHOD.


method GET_DATA.
    rs_data = ms_who.
  endmethod.


METHOD get_open_wts.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      lt_who TYPE /scwm/tt_who,
      ls_who TYPE /scwm/who.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR rt_wt[].

    CLEAR ls_who.
    ls_who-lgnum = m_lgnum.
    ls_who-who   = ms_who-who.
    APPEND ls_who TO lt_who.

    CALL METHOD zswl_cl_services_wt=>read_open_wt_by_who
      EXPORTING
        i_lgnum   = m_lgnum
        it_who    = lt_who
      IMPORTING
        et_wt_ref = rt_wt
      CHANGING
        co_log    = mo_log.

  ENDMETHOD.


METHOD get_pick_wts.
    DATA:
          ls_wt_ref TYPE zswl_s_wt_ref.

    "1 get all open pick warehouse tasks
*    DATA(lt_open_wts) = get_open_wts( ).
    SELECT * FROM /scwm/ordim_o INTO TABLE @DATA(lt_open_wts)
      WHERE lgnum = @ms_who-lgnum AND who = @ms_who-who.

    LOOP AT lt_open_wts INTO DATA(ls_open_wt).
      IF ls_open_wt-trart = '2'.
        CLEAR ls_wt_ref.
        ls_wt_ref-lgnum   = ls_open_wt-lgnum.
        ls_wt_ref-tanum   = ls_open_wt-tanum.
        APPEND ls_wt_ref TO et_open_pick_wts.
      ENDIF.
    ENDLOOP.

    "2 get all confirmed pick warehouse tasks
    et_all_pick_wts = et_open_pick_wts.
    SELECT * FROM /scwm/ordim_c INTO TABLE @DATA(lt_conf_wts)
      WHERE lgnum = @ms_who-lgnum AND who = @ms_who-who.

    LOOP AT lt_conf_wts INTO DATA(ls_conf_wt).
      IF ls_conf_wt-trart = '2'.
        CLEAR ls_wt_ref.
        ls_wt_ref-lgnum   = ls_conf_wt-lgnum.
        ls_wt_ref-tanum   = ls_conf_wt-tanum.

*        CREATE OBJECT ls_wt_ref-o_wt
*          EXPORTING
*            i_lgnum    = ls_conf_wt-lgnum
**           io_log     = co_log
*            i_tanum    = ls_conf_wt-tanum
*            is_ordim_o = ls_conf_wt.

        APPEND ls_wt_ref TO et_all_pick_wts.
        APPEND ls_wt_ref TO et_confirmed_pick_wts.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


method GET_WHO_HUS.
    rt_whohus = mt_who_hu.
  endmethod.


METHOD hold_unhold.
    DATA:
      lt_who TYPE /scwm/tt_whoid,
      ls_who LIKE LINE OF lt_who.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   Hold or unhold the warehouse order &1
    MESSAGE i050
       WITH ms_who-who
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    ls_who-who = ms_who-who.
    APPEND ls_who TO lt_who.

    CALL FUNCTION '/SCWM/WHO_HOLD_UNHOLD'
      EXPORTING
        iv_lgnum  = m_lgnum
        iv_hold   = iv_hold
        iv_unhold = iv_unhold
        it_who    = lt_who.

*     LA-Update erfolgreich ausgeführt
    MESSAGE i017
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).


  ENDMETHOD.


METHOD read_whos.

    DATA:
      lrt_whostat TYPE /scwm/tt_whostat_r,
      lrt_queue   TYPE /scwm/tt_queue_r,
      lt_who      TYPE /scwm/tt_who,

      ls_whostat  TYPE /scwm/s_whostat_r,
      ls_queue    TYPE /scwm/s_queue_r.

    FIELD-SYMBOLS:
      <ls_status> TYPE zswl_s_whostat,
      <l_queue>   TYPE /scwm/de_queue.


* Evtl. LOG-Objekt erstellen
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

* Prüfen, ob Lagernummer übergeben wurde
    IF i_lgnum IS INITIAL.
*   Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
        INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).

      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

* Range-Tabelle mit Queues füllen
    CLEAR lrt_queue[].
    LOOP AT it_queue ASSIGNING <l_queue>.
      ls_queue-low    = <l_queue>.
      ls_queue-sign   = wmegc_sign_inclusive.
      ls_queue-option = wmegc_option_eq.
      APPEND ls_queue TO lrt_queue.
    ENDLOOP.

* Range-Tabelle mit Status füllen
    LOOP AT it_whostat ASSIGNING <ls_status>.
      ls_whostat-low    = <ls_status>-status.
      ls_whostat-sign   = wmegc_sign_inclusive.
      ls_whostat-option = wmegc_option_eq.
      APPEND ls_whostat TO lrt_whostat.
    ENDLOOP.

* Lageraufträge selektieren
    zswl_cl_who=>select_whos(
      EXPORTING
        i_lgnum      = i_lgnum
        irt_queue    = lrt_queue
        irt_whostat  = lrt_whostat
        i_inventory  = i_inventory
      IMPORTING
        et_who       = lt_who
      CHANGING
        co_log       = co_log
    ).

* Objekte zu den Lageraufträgen erstellen
    et_who_ref = zswl_cl_who=>build_ref_table(
                                   i_lgnum  = i_lgnum
                                   it_who   = lt_who
                                   io_log   = co_log ).

  ENDMETHOD.


METHOD select_who.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR ms_who.

    SELECT SINGLE *
      FROM /scwm/who
      INTO ms_who
     WHERE lgnum  = m_lgnum
       AND who    = i_who.

    IF sy-subrc <> 0.

*     Lagerauftrag [&] wurde nicht gefunden!
      MESSAGE e001
         WITH i_who
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD select_whos.

    DATA:
      l_count_whos                TYPE i.


    CLEAR et_who[].

* Ermittlung der Lageraufträge
    MESSAGE i019(zswl_who)
      INTO zswl_cl_log=>m_dummy_msg.
    co_log->add( i_syst = abap_true ).

    SELECT *
      FROM /scwm/who
      INTO TABLE et_who
      WHERE lgnum    = i_lgnum
        AND status  IN irt_whostat
        AND queue   IN irt_queue
        AND flginv   = i_inventory.

    IF sy-subrc <> 0.
*   Zu den Bedingungen wurden keine Lageraufträge gefunden!
      MESSAGE w020(zswl_who)
        INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

    l_count_whos = lines( et_who ).

* '&' Lageraufträge gefunden
    MESSAGE i021(zswl_who)
      WITH l_count_whos
      INTO zswl_cl_log=>m_dummy_msg.
    co_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD select_who_hu.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    SELECT *
      FROM /scwm/whohu
      INTO TABLE mt_who_hu
     WHERE lgnum = m_lgnum
       AND who   = i_who.

    IF sy-subrc <> 0.

*     Zu Lagerauftrag [&] wurde keine HU-Zuordnung gefunden!
      MESSAGE i003
         WITH i_who
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD split.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_ordim_o> TYPE /scwm/ordim_o,
      <ls_wt_ref>  TYPE zswl_s_wt_ref,
      <ls_new_who> TYPE /scwm/s_who_int.

    DATA:
      lt_tanum   TYPE /scwm/tt_tanum,
      lt_bapiret TYPE bapirettab,
      lt_new_who TYPE /scwm/tt_who_int,
      ls_who     TYPE /scwm/who,
      ls_who_ref TYPE zswl_s_who_ref,
      l_severity TYPE bapi_mtype,
      l_tanum    TYPE /scwm/tanum.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR: eo_new_who,
           et_who_ref[].

*   Split des Lagerauftrags [&]
    MESSAGE i008
       WITH ms_who-who
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    IF lines( it_ordim_o ) = 0 AND
       lines( it_wt_ref  ) = 0.

*     Für Lagerauftragssplit wurden keine Lageraufgaben übergeben!
      MESSAGE e009
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    LOOP AT it_ordim_o ASSIGNING <ls_ordim_o>.

      CLEAR l_tanum.
      l_tanum = <ls_ordim_o>-tanum.

*     Lageraufgabe [&] von Lagerauftrag absplitten
      MESSAGE i010
         WITH l_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

      APPEND l_tanum TO lt_tanum.

    ENDLOOP.

    LOOP AT it_wt_ref ASSIGNING <ls_wt_ref>.

      CLEAR l_tanum.
      l_tanum = <ls_wt_ref>-o_wt->get_tanum( ).

*     Lageraufgabe [&] von Lagerauftrag absplitten
      MESSAGE i010
         WITH l_tanum
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

      APPEND l_tanum TO lt_tanum.

    ENDLOOP.

    IF lines( lt_tanum ) > 0.

      CALL FUNCTION '/SCWM/WHO_SPLIT'
        EXPORTING
          iv_lgnum    = m_lgnum
          iv_who      = ms_who-who
*         iv_wcr      =
*         IV_REASON_CODE =
*         IV_UPDATE   = 'X'
          iv_commit   = abap_false
          iv_simulate = i_simulate
          it_to       = lt_tanum
        IMPORTING
          ev_severity = l_severity
          et_bapiret  = lt_bapiret
          et_who      = lt_new_who.

      IF l_severity CA wmegc_severity_eax.

        mo_log->add( it_bapi_list = lt_bapiret ).

*       Lageraufgaben konnten nicht abgesplittet werden
        MESSAGE e011
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ELSE.

        LOOP AT lt_bapiret TRANSPORTING NO FIELDS
          WHERE type CA wmegc_severity_eax.
          EXIT.
        ENDLOOP.

        IF sy-subrc = 0.

          mo_log->add( it_bapi_list = lt_bapiret ).

*         Lageraufgaben konnten nicht abgesplittet werden
          MESSAGE e011
             INTO zswl_cl_log=>m_dummy_msg.
          mo_log->add( i_syst = abap_true ).
          zcx_ewm_general_exception=>raise_system_exception( ).

        ELSE.

*         Lageraufgaben erfolgreich abgesplittet
          MESSAGE i012
             INTO zswl_cl_log=>m_dummy_msg.
          mo_log->add( i_syst = abap_true ).

        ENDIF.

      ENDIF.

      LOOP AT lt_new_who ASSIGNING <ls_new_who>.

*       Lagerauftrag [&] wurde erstellt
        MESSAGE i013
           WITH <ls_new_who>-who
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).

        CLEAR ls_who_ref.
        ls_who_ref-lgnum  = <ls_new_who>-lgnum.
        ls_who_ref-who    = <ls_new_who>-who.

        MOVE-CORRESPONDING <ls_new_who> TO ls_who.

        CREATE OBJECT ls_who_ref-o_who
          EXPORTING
            i_lgnum   = m_lgnum
            io_log    = mo_log
            i_rf_read = abap_false
            i_hu_read = abap_false
            i_who     = <ls_new_who>-who
            is_who    = ls_who.

        IF eo_new_who IS NOT BOUND.

          eo_new_who = ls_who_ref-o_who.

        ENDIF.

        APPEND ls_who_ref TO et_who_ref.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


METHOD update_priority.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      lt_wo_rsrc_ty             TYPE /scwm/tt_wo_rsrc_ty.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*   Ändere Priorität für Lagerauftrag [&] zu [&]
    MESSAGE i014
       WITH ms_who-who
            i_prio
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    IF i_prio IS INITIAL.

*     Es wurde keine Priorität übergeben!
      MESSAGE e015
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF sy-subrc <> 0.

      CALL FUNCTION '/SCWM/WHO_RSRC_TYP_SET'
        EXPORTING
          iv_action     = wmegc_update
          it_wo_rsrc_ty = lt_wo_rsrc_ty.

*     LA-Update erfolgreich ausgeführt
      MESSAGE i017
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ELSE.

*     Kein Update erforderlich - Priorität bereits gesetzt
      MESSAGE i018
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

*   Commit falls übergeben
    IF i_commit = abap_true.

      me->commit( i_wait = i_wait ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
