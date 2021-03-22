class ZSWL_CL_SERVICES_WT definition
  public
  final
  create public .

public section.
  type-pools ABAP .

  class-methods CANCEL_MULTIPLE_WT
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_QNAME type SYST_UNAME optional
      !IT_CANCL_EXC type /SCWM/TT_CONF_EXC optional
      !IT_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods CONFIRM_MULTIPLE_WT
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_QNAME type SYST_UNAME optional
      !I_NLPLA type /SCWM/LTAP_NLPLA optional
      !IT_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods CREATE_HU_WTS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_CREATE type /SCWM/TT_TO_CREA_HU
      !I_COMMIT type XFELD default 'X'
      !I_UPDATE_TASK type /SCWM/RL03AVERBU default 'X'
      !I_WAIT type XFELD default 'X'
    exporting
      !ET_WT_OBJECT type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods CREATE_PROD_WTS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_CREATE type /SCWM/TT_TO_CREATE_INT
      !I_COMMIT type XFELD
      !I_UPDATE_TASK type /SCWM/RL03AVERBU
    exporting
      !ET_WT_OBJECT type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods CREATE_WHR_WTS
    importing
      !I_LGNUM type /SCWM/LGNUM
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_UPD_TASK type XFELD default ABAP_FALSE
      !IT_CREATE_WHR type /SCWM/TT_TO_PREP_WHR_INT optional
      !IT_CREATE_HU type /SCWM/TT_TO_PREP_HU_INT optional
    exporting
      !ET_LTAP_VB type /SCWM/TT_LTAP_VB
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_DESTINATION
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !IT_LGBER type /SCWM/TT_LGBER optional
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_HU type /SCWM/TT_HUIDENT optional
      !IT_RSRC type /SCWM/TT_RSRC optional
      !IT_TU type /SCWM/TT_TU_NUM optional
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_HU
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_HUIDENT type /SCWM/TT_HUIDENT
      !I_RAISE type XFELD default ABAP_TRUE
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_REFDOC
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_REFDOC type /SCWM/DLV_DOCID_ITEM_TAB optional
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_SOURCE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !IT_LGBER type /SCWM/TT_LGBER optional
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_HU type /SCWM/TT_HUIDENT optional
      !IT_RSRC type /SCWM/TT_RSRC optional
      !IT_TU type /SCWM/TT_TU_NUM optional
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_WAVE
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_WAVE type /SCWM/TT_WAVE_ITM optional
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods READ_OPEN_WT_BY_WHO
    importing
      !I_LGNUM type /SCWM/LGNUM
      !IT_WHO type /SCWM/TT_WHO optional
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.
private section.

  class-methods BUILD_REF_TABLE
    importing
      !IT_ORDIM_O type /SCWM/TT_ORDIM_O
    exporting
      !ET_WT_REF type ZSWL_TT_WT_REF
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods GET_RANGE_TABLES
    importing
      !IT_LGTYP type /SCWM/TT_LGTYP optional
      !IT_LGBER type /SCWM/TT_LGBER optional
      !IT_LGPLA type /SCWM/TT_LGPLA optional
      !IT_HU type /SCWM/TT_HUIDENT optional
      !IT_RSRC type /SCWM/TT_RSRC optional
      !IT_TU type /SCWM/TT_TU_NUM optional
    exporting
      !ERT_LGTYP type /SCWM/TT_LGTYP_R
      !ERT_LGBER type /SCWM/TT_LGBER_R
      !ERT_LGPLA type /SCWM/TT_LGPLA_R
      !ERT_HU type /SCWM/TT_HUIDENT_R
      !ERT_RSRC type /SCWM/TT_RSRC_R
      !ERT_TU type /SCWM/TT_TU_NUM_R
    changing
      !CO_LOG type ref to ZSWL_CL_LOG optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods HANDLE_ERROR
    importing
      !I_COMMIT type XFELD default ABAP_TRUE
      !I_WAIT type XFELD default ABAP_TRUE
      !I_SEVERITY type BAPI_MTYPE
      !IT_BAPIRET type BAPIRETTAB
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    returning
      value(R_ERROR) type XFELD .
ENDCLASS.



CLASS ZSWL_CL_SERVICES_WT IMPLEMENTATION.


METHOD build_ref_table.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_ordim_o>              TYPE /scwm/ordim_o.

    DATA:
     ls_wt_ref                  TYPE zswl_s_wt_ref.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    LOOP AT it_ordim_o ASSIGNING <ls_ordim_o>.

      CLEAR ls_wt_ref.
      ls_wt_ref-lgnum   = <ls_ordim_o>-lgnum.
      ls_wt_ref-tanum   = <ls_ordim_o>-tanum.

      CREATE OBJECT ls_wt_ref-o_wt
        EXPORTING
          i_lgnum    = <ls_ordim_o>-lgnum
          io_log     = co_log
          i_tanum    = <ls_ordim_o>-tanum
          is_ordim_o = <ls_ordim_o>.

      APPEND ls_wt_ref TO et_wt_ref.

    ENDLOOP.

  ENDMETHOD.


METHOD cancel_multiple_wt.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_wt_ref> TYPE zswl_s_wt_ref.

    DATA:
      ls_ordim_o TYPE /scwm/ordim_o,
      lt_cancel  TYPE /scwm/tt_cancl,
      ls_cancel  TYPE /scwm/cancl,
      lt_bapiret TYPE bapirettab,
      l_severity TYPE bapi_mtype,
      l_qname    TYPE syst_uname.


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*   Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.


    IF i_qname IS SUPPLIED.
      l_qname = i_qname.
    ELSE.
      l_qname = sy-uname.
    ENDIF.


    IF lines( it_wt_ref ) > 0.

      LOOP AT it_wt_ref ASSIGNING <ls_wt_ref>.

        ls_ordim_o = <ls_wt_ref>-o_wt->get_ordim_o( ).

*     Storniere Lageraufgabe [&]
        MESSAGE i001
           WITH ls_ordim_o-tanum
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).

        CLEAR ls_cancel.
        ls_cancel-tanum = ls_ordim_o-tanum.
        ls_cancel-subst = abap_true.
        APPEND ls_cancel TO lt_cancel.

      ENDLOOP.

    ELSE.

*   Es wurden keine Lageraufgaben für die Stornierung übergeben!
      MESSAGE e002
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Lageraufgeben stornieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF lines( lt_cancel ) > 0.

      CALL FUNCTION '/SCWM/TO_CANCEL'
        EXPORTING
          iv_lgnum       = i_lgnum
*         iv_subst       =
          iv_qname       = l_qname
*         IV_HUMI        = ' '
          iv_update_task = i_upd_task
          iv_commit_work = abap_false
          it_cancl       = lt_cancel
          it_cancl_exc   = it_cancl_exc
        IMPORTING
          et_bapiret     = lt_bapiret
          ev_severity    = l_severity.


      IF zswl_cl_services_wt=>handle_error(
          EXPORTING
            i_commit    = i_commit
            i_wait      = i_wait
            i_severity  = l_severity
            it_bapiret  = lt_bapiret
          CHANGING
            co_log      = co_log ) = abap_true.

*     Lageraufgaben konnte nicht storniert werden!
        MESSAGE e003
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ELSE.

*     Lageraufgaben wurden erfolgreich storniert.
        MESSAGE i004
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).

      ENDIF.


    ENDIF.

  ENDMETHOD.


METHOD confirm_multiple_wt.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    FIELD-SYMBOLS:
      <ls_wt_ref> TYPE zswl_s_wt_ref.

    DATA:
      ls_ordim_o  TYPE /scwm/ordim_o,
      ls_conf     TYPE /scwm/to_conf,
      lt_conf     TYPE /scwm/to_conf_tt,
      lt_conf_exc TYPE /scwm/tt_conf_exc,
      ls_conf_exc TYPE /scwm/s_conf_exc,
*      et_ltap_vb  TYPE /scwm/tt_ltap_vb,
      lt_bapiret  TYPE bapirettab,
      l_severity  TYPE bapi_mtype,
      l_qname     TYPE syst_uname.
*      lv_ser_err  TYPE xfeld.


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF i_lgnum IS INITIAL.
*   Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.


    IF i_qname IS SUPPLIED.
      l_qname = i_qname.
    ELSE.
      l_qname = sy-uname.
    ENDIF.


    IF lines( it_wt_ref ) > 0.

      LOOP AT it_wt_ref ASSIGNING <ls_wt_ref>.

        ls_ordim_o = <ls_wt_ref>-o_wt->get_ordim_o( ).

*     Quittiere Lageraufgabe [&]
        MESSAGE i005
           WITH ls_ordim_o-tanum
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).

        CLEAR ls_conf.
        ls_conf-tanum = ls_ordim_o-tanum.
        ls_conf-subst = abap_true.
        ls_conf-squit = abap_true.

*     Nachplatzquittierung, müssen wir zusätzliche Felder füllen
        IF i_nlpla IS SUPPLIED AND
           i_nlpla IS NOT INITIAL AND
           i_nlpla <> ls_ordim_o-nlpla.

          ls_conf-nlpla = i_nlpla.

*       Befüllen der Ausnahmestruktur
          CLEAR ls_conf_exc.
          ls_conf_exc-tanum     = ls_ordim_o-tanum.
          ls_conf_exc-exccode   = wmegc_iprcode_chbd.
          ls_conf_exc-buscon    = wmegc_buscon_mfs.
          ls_conf_exc-exec_step = wmegc_execstep_a0.
          APPEND ls_conf_exc TO lt_conf_exc.

        ELSE.
          ls_conf-nlpla = ls_ordim_o-nlpla.
        ENDIF.

        APPEND ls_conf TO lt_conf.

      ENDLOOP.

    ELSE.

*   Es wurden keine Lageraufgaben für die Quittierung übergeben!
      MESSAGE e006
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Lageraufgeben  quittieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    IF lines( lt_conf ) > 0.

      CALL FUNCTION '/SCWM/TO_CONFIRM'
        EXPORTING
          iv_lgnum       = i_lgnum
*         IV_SUBST       = ' '
          iv_qname       = l_qname
*         IV_CRETO       = ' '
*         IV_WTCODE      =
          iv_update_task = i_upd_task
          iv_commit_work = abap_false
*         IV_PROCESSOR_DET       = ' '
          it_conf        = lt_conf
          it_conf_exc    = lt_conf_exc
*         IT_CONF_SERID  =
        IMPORTING
*          et_ltap_vb     = et_ltap_vb
          et_bapiret     = lt_bapiret
          ev_severity    = l_severity.
*          ev_ser_err     = lv_ser_err.

      IF zswl_cl_services_wt=>handle_error(
          EXPORTING
            i_commit    = i_commit
            i_wait      = i_wait
            i_severity  = l_severity
            it_bapiret  = lt_bapiret
          CHANGING
            co_log      = co_log ) = abap_true.

*     Lageraufgaben konnte nicht quittiert werden!
        MESSAGE e007
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).

      ELSE.

*     Lageraufgaben wurden erfolgreich quittiert.
        MESSAGE i008
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).

      ENDIF.


    ENDIF.

  ENDMETHOD.


METHOD create_hu_wts.

    DATA:
      lt_ltap_vb TYPE /scwm/tt_ltap_vb,
      lt_bapiret TYPE bapirettab,
*      ls_bapiret LIKE LINE OF lt_bapiret,
      ls_wt_obj  TYPE zswl_s_wt_ref,
      ls_ordim_o TYPE /scwm/ordim_o,
      l_severity TYPE bapi_mtype.

    FIELD-SYMBOLS:
      <ls_ltap_vb>                TYPE /scwm/ltap.


* LOG-Objekt erstellen
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

* Lageraufgaben erstellen
    CALL FUNCTION '/SCWM/TO_CREATE_MOVE_HU'
      EXPORTING
        iv_lgnum       = i_lgnum
        iv_update_task = i_update_task
        iv_commit_work = abap_false
*       IV_WTCODE      =
*       IV_BNAME       = SY-UNAME
*       IS_RFC_QUEUE   =
        it_create_hu   = it_create
*       IV_PROCESSOR_DET       = ' '
      IMPORTING
*       EV_TANUM       =
        et_ltap_vb     = lt_ltap_vb
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF handle_error(
       EXPORTING
         i_commit   = i_commit
         i_wait     = i_wait
         i_severity = l_severity
         it_bapiret = lt_bapiret
       CHANGING
         co_log     = co_log
     ) = abap_true.

      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

* Lageraufgaben-Objekte erstellen
    LOOP AT lt_ltap_vb ASSIGNING <ls_ltap_vb>.
      CLEAR ls_wt_obj.
      ls_wt_obj-lgnum = i_lgnum.
      ls_wt_obj-tanum = <ls_ltap_vb>-tanum.
      MOVE-CORRESPONDING <ls_ltap_vb> TO ls_ordim_o.

      TRY.
          CREATE OBJECT ls_wt_obj-o_wt
            EXPORTING
              i_lgnum    = i_lgnum
              i_tanum    = ls_wt_obj-tanum
              io_log     = co_log
              is_ordim_o = ls_ordim_o.
        CATCH zcx_ewm_general_exception .
          co_log->add(
            EXPORTING
              i_syst  = abap_true ).

          ROLLBACK WORK.
          zcx_ewm_general_exception=>raise_system_exception( ).
      ENDTRY.

      APPEND ls_wt_obj TO et_wt_object.

    ENDLOOP.

  ENDMETHOD.


METHOD create_prod_wts.

    DATA:
      lt_ltap_vb TYPE /scwm/tt_ltap_vb,
      lt_bapiret TYPE bapirettab,
*      ls_bapiret LIKE LINE OF lt_bapiret,
      ls_wt_obj  TYPE zswl_s_wt_ref,
      ls_ordim_o TYPE /scwm/ordim_o,
      l_severity TYPE bapi_mtype.

    FIELD-SYMBOLS:
      <ls_ltap_vb>                TYPE /scwm/ltap.


* LOG-Objekt erstellen
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

* Lageraufgaben erstellen
    CALL FUNCTION '/SCWM/TO_CREATE'
      EXPORTING
        iv_lgnum       = i_lgnum
        iv_update_task = i_update_task
        iv_commit_work = i_commit
*       iv_wtcode      =
*       IV_BNAME       = SY-UNAME
*       IS_RFC_QUEUE   =
        it_create      = it_create
*       IT_CREATE_EXC  =
*       IV_PROCESSOR_DET       = ' '
      IMPORTING
*       EV_TANUM       =
        et_ltap_vb     = lt_ltap_vb
       ET_BAPIRET     = lt_bapiret
        ev_severity    = l_severity.
    IF lines( lt_bapiret ) > 0.
      CALL METHOD co_log->add
        EXPORTING
          it_bapi_list = lt_bapiret.

      IF l_severity CA wmegc_severity_eax.

        zcx_ewm_general_exception=>raise_system_exception( ).
      ENDIF.

    ENDIF.

* Lageraufgaben-Objekte erstellen
    LOOP AT lt_ltap_vb ASSIGNING <ls_ltap_vb>.
      CLEAR ls_wt_obj.
      ls_wt_obj-lgnum = i_lgnum.
      ls_wt_obj-tanum = <ls_ltap_vb>-tanum.
      MOVE-CORRESPONDING <ls_ltap_vb> TO ls_ordim_o.

      TRY.
          CREATE OBJECT ls_wt_obj-o_wt
            EXPORTING
              i_lgnum    = i_lgnum
              io_log     = co_log
              i_tanum    = ls_ordim_o-tanum
              is_ordim_o = ls_ordim_o.
        CATCH zcx_ewm_general_exception .
          co_log->add(
            EXPORTING
              i_syst  = abap_true ).

          ROLLBACK WORK.
          zcx_ewm_general_exception=>raise_system_exception( ).
      ENDTRY.

      APPEND ls_wt_obj TO et_wt_object.

    ENDLOOP.

  ENDMETHOD.


METHOD create_whr_wts.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      lt_bapiret TYPE bapirettab,
      l_severity TYPE bapi_mtype.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_ltap_vb[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    CALL FUNCTION '/SCWM/TO_CREATE_WHR'
      EXPORTING
        iv_lgnum       = i_lgnum
*       IV_PROCESS     =
*       IV_MVE_HU      =
*       IV_MVE_MAT     =
*       IV_MVE_HU_MULT =
*       IV_SQUIT       =
*       IV_FULL_PICK   =
*       IV_TO_INIT     = 'X'
*       IV_BNAME       = SY-UNAME
*       IV_WTCODE      = ' '
*       IV_FILTER_HU   = ' '
*       IS_RFC_QUEUE   =
        it_create_whr  = it_create_whr
        it_crea_hu     = it_create_hu
        iv_update_task = i_upd_task
        iv_commit_work = abap_false
      IMPORTING
*       EV_TANUM       =
        et_ltap_vb     = et_ltap_vb
        et_bapiret     = lt_bapiret
        ev_severity    = l_severity.

    IF handle_error(
         EXPORTING
           i_commit   = i_commit
           i_wait     = i_wait
           i_severity = l_severity
           it_bapiret = lt_bapiret
         CHANGING
           co_log     = co_log ) = abap_true.

*     Lageraufgabenerstellung fehlgeschlagen!
      MESSAGE e029
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

  ENDMETHOD.


METHOD get_range_tables.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <l_lgtyp>    TYPE /scwm/de_lgtyp,
      <l_lgber>    TYPE /scwm/de_lgber,
      <l_lgpla>    TYPE /scwm/de_lgpla,
      <ls_huident> TYPE /scwm/s_huident,
      <ls_rsrc>    TYPE /scwm/rsrc,
      <l_tu_num>   TYPE /scwm/de_tu_num.

    DATA:
      lrs_lgtyp TYPE /scwm/s_lgtyp_r,
      lrs_lgber TYPE /scwm/s_lgber_r,
      lrs_lgpla TYPE /scwm/s_lgpla_r,
      lrs_hu    TYPE /scwm/s_huident_r,
      lrs_rsrc  TYPE /scwm/s_rsrc_r,
      lrs_tu    TYPE /scwm/s_tu_num_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR: ert_lgtyp[],
           ert_lgber[],
           ert_lgpla[],
           ert_hu[],
           ert_rsrc[],
           ert_tu[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF lines( it_lgtyp ) = 0 AND
       lines( it_lgber ) = 0 AND
       lines( it_lgpla ) = 0 AND
       lines( it_hu    ) = 0 AND
       lines( it_rsrc  ) = 0 AND
       lines( it_tu    ) = 0.

*     Für die LB-Selektion wurden keine Lokationsdaten übergeben!
      MESSAGE e019
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für Lagertypen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_lgtyp ASSIGNING <l_lgtyp>.

      READ TABLE ert_lgtyp TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgtyp>.
      IF sy-subrc <> 0.

        CLEAR lrs_lgtyp.
        lrs_lgtyp-option  = wmegc_option_eq.
        lrs_lgtyp-sign    = wmegc_sign_inclusive.
        lrs_lgtyp-low     = <l_lgtyp>.
        APPEND lrs_lgtyp TO ert_lgtyp.

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für Lagerbereiche
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_lgber ASSIGNING <l_lgber>.

      READ TABLE ert_lgber TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgber>.
      IF sy-subrc <> 0.

        CLEAR lrs_lgber.
        lrs_lgber-option  = wmegc_option_eq.
        lrs_lgber-sign    = wmegc_sign_inclusive.
        lrs_lgber-low     = <l_lgber>.
        APPEND lrs_lgber TO ert_lgber.

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für Lagerplätze
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_lgpla ASSIGNING <l_lgpla>.

      READ TABLE ert_lgpla TRANSPORTING NO FIELDS
        WITH KEY low = <l_lgpla>.
      IF sy-subrc <> 0.

        CLEAR lrs_lgpla.
        lrs_lgpla-option  = wmegc_option_eq.
        lrs_lgpla-sign    = wmegc_sign_inclusive.
        lrs_lgpla-low     = <l_lgpla>.
        APPEND lrs_lgpla TO ert_lgpla.

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für HUs
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_hu ASSIGNING <ls_huident>.

      READ TABLE ert_hu TRANSPORTING NO FIELDS
        WITH KEY low = <ls_huident>-huident.
      IF sy-subrc <> 0.

        CLEAR lrs_hu.
        lrs_hu-option  = wmegc_option_eq.
        lrs_hu-sign    = wmegc_sign_inclusive.
        lrs_hu-low     = <ls_huident>-huident.
        APPEND lrs_hu TO ert_hu.

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für Ressourcen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_rsrc ASSIGNING <ls_rsrc>.

      READ TABLE ert_rsrc TRANSPORTING NO FIELDS
        WITH KEY low = <ls_rsrc>-rsrc.
      IF sy-subrc <> 0.

        CLEAR lrs_rsrc.
        lrs_rsrc-option  = wmegc_option_eq.
        lrs_rsrc-sign    = wmegc_sign_inclusive.
        lrs_rsrc-low     = <ls_rsrc>-rsrc.
        APPEND lrs_rsrc TO ert_rsrc.

      ENDIF.

    ENDLOOP.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Fülle Range-Tabelle für Transporteinheiten
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    LOOP AT it_tu ASSIGNING <l_tu_num>.

      READ TABLE ert_tu TRANSPORTING NO FIELDS
        WITH KEY low = <l_tu_num>.
      IF sy-subrc <> 0.

        CLEAR lrs_tu.
        lrs_tu-option  = wmegc_option_eq.
        lrs_tu-sign    = wmegc_sign_inclusive.
        lrs_tu-low     = <l_tu_num>.
        APPEND lrs_tu TO ert_tu.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


METHOD handle_error.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    r_error = abap_false.

*   1. Prüfe Severity aus Standard-Funktion
    IF i_severity CA wmegc_severity_eax.

*     Protokollierung der Bapi-Meldungen
      co_log->add( it_bapi_list = it_bapiret ).

      IF i_commit = abap_true.
        ROLLBACK WORK.
      ENDIF.

      r_error = abap_true.

    ELSE.

*     2. Prüfe Nachrichten-Typen in Bapi-Liste
      LOOP AT it_bapiret TRANSPORTING NO FIELDS
        WHERE type CA wmegc_severity_eax.
        EXIT.
      ENDLOOP.

      IF sy-subrc = 0.
*       mind. 1 Nachricht mit Fehler

*       Protokollierung der Bapi-Meldungen
        co_log->add( it_bapi_list = it_bapiret ).

        IF i_commit = abap_true.
          ROLLBACK WORK.
        ENDIF.

        r_error = abap_true.

      ELSE.

        IF i_commit = abap_true.

          IF i_wait = abap_true.
            COMMIT WORK AND WAIT.
          ELSE.
            COMMIT WORK.
          ENDIF.

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD read_open_wt_by_destination.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      lt_ordim_o                TYPE /scwm/tt_ordim_o.

    DATA:
      lrt_lgtyp TYPE /scwm/tt_lgtyp_r,
      lrt_lgber TYPE /scwm/tt_lgber_r,
      lrt_lgpla TYPE /scwm/tt_lgpla_r,
      lrt_hu    TYPE /scwm/tt_huident_r,
      lrt_rsrc  TYPE /scwm/tt_rsrc_r,
      lrt_tu    TYPE /scwm/tt_tu_num_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CALL METHOD zswl_cl_services_wt=>get_range_tables
      EXPORTING
        it_lgtyp  = it_lgtyp
        it_lgber  = it_lgber
        it_lgpla  = it_lgpla
        it_hu     = it_hu
        it_rsrc   = it_rsrc
        it_tu     = it_tu
      IMPORTING
        ert_lgtyp = lrt_lgtyp
        ert_lgber = lrt_lgber
        ert_lgpla = lrt_lgpla
        ert_hu    = lrt_hu
        ert_rsrc  = lrt_rsrc
        ert_tu    = lrt_tu
      CHANGING
        co_log    = co_log.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE lgnum   = i_lgnum
       AND ( ( nltyp   IN lrt_lgtyp
       AND     nlber   IN lrt_lgber
       AND     nlpla   IN lrt_lgpla )
       AND     nlenr   IN lrt_hu
       AND     drsrc   IN lrt_rsrc
       AND     dtu_num IN lrt_tu ).

    IF sy-subrc <> 0.

*     Zu den Zieldaten wurden keine offene Lageraufgaben gefunden!
      MESSAGE e011
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.


METHOD read_open_wt_by_hu.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_huident>              TYPE /scwm/s_huident.

    DATA:
      lt_ordim_o TYPE /scwm/tt_ordim_o,
      lrt_hu     TYPE /scwm/tt_huident_r,
      lrs_hu     TYPE /scwm/s_huident_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_huident ) > 0.

      LOOP AT it_huident ASSIGNING <ls_huident>.

        READ TABLE lrt_hu TRANSPORTING NO FIELDS
          WITH KEY low = <ls_huident>-huident.
        IF sy-subrc <> 0.

          CLEAR lrs_hu.
          lrs_hu-option   = wmegc_option_eq.
          lrs_hu-sign     = wmegc_sign_inclusive.
          lrs_hu-low      = <ls_huident>-huident.
          APPEND lrs_hu TO lrt_hu.

        ENDIF.

      ENDLOOP.

    ELSE.

*     Es wurden keine HUs für die LB-Selektion übergeben!
      MESSAGE e009
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE   lgnum = i_lgnum
       AND ( vlenr IN lrt_hu
        OR   nlenr IN lrt_hu ).

    IF sy-subrc <> 0.

*     Zu den HUs wurden keine offene Lageraufgaben gefunden!
      IF i_raise = abap_true.
        MESSAGE e010
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      ELSE.
        MESSAGE s010
           INTO zswl_cl_log=>m_dummy_msg.
        co_log->add( i_syst = abap_true ).
      ENDIF.

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.


METHOD read_open_wt_by_refdoc.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_refdoc>               TYPE /scwm/dlv_docid_item_str.

    DATA:
      lt_ordim_o TYPE /scwm/tt_ordim_o,
      lrt_doccat TYPE /scwm/tt_doccat_r,
      lrt_docid  TYPE /scwm/tt_qdocid_r,
      lrt_itmid  TYPE /scwm/tt_qitmid_r,
      lrs_doccat TYPE /scwm/s_doccat_r,
      lrs_itmid  TYPE /scwm/s_qitmid_r,
      lrs_docid  TYPE /scwm/s_qdocid_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_refdoc ) > 0.

      CLEAR: lrs_doccat,
             lrs_itmid,
             lrs_docid.

      lrs_doccat-option = wmegc_option_eq.
      lrs_doccat-sign   = wmegc_sign_inclusive.
      lrs_itmid-option  = wmegc_option_eq.
      lrs_itmid-sign    = wmegc_sign_inclusive.
      lrs_docid-option  = wmegc_option_eq.
      lrs_docid-sign    = wmegc_sign_inclusive.

      LOOP AT it_refdoc ASSIGNING <ls_refdoc>.

        READ TABLE lrt_doccat TRANSPORTING NO FIELDS
          WITH KEY low = <ls_refdoc>-doccat.
        IF sy-subrc <> 0.

          CLEAR lrs_doccat-low.
          lrs_doccat-low = <ls_refdoc>-doccat.
          APPEND lrs_doccat TO lrt_doccat.

        ENDIF.

        READ TABLE lrt_docid TRANSPORTING NO FIELDS
          WITH KEY low = <ls_refdoc>-docid.
        IF sy-subrc <> 0.

          CLEAR lrs_docid-low.
          lrs_docid-low = <ls_refdoc>-docid.
          APPEND lrs_docid TO lrt_docid.

        ENDIF.

        READ TABLE lrt_itmid TRANSPORTING NO FIELDS
          WITH KEY low = <ls_refdoc>-itemid.
        IF sy-subrc <> 0.

*          CLEAR lrs_itmid-low.
*          lrs_itmid-low = <ls_refdoc>-itemid.
*          APPEND lrs_itmid TO lrt_itmid.

        ENDIF.

      ENDLOOP.

    ELSE.

*     Es wurden keine Lieferreferenzen für die LB-Selektion übergeben!
      MESSAGE e017
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE lgnum   = i_lgnum
       AND rdoccat IN lrt_doccat
       AND rdocid  IN lrt_docid
       AND ritmid  IN lrt_itmid.

    IF sy-subrc <> 0.

*     Zu Lieferreferenzen kontnen keine offene Lageraufgaben
*     gefunden werden!
      MESSAGE e018
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.


METHOD read_open_wt_by_source.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    DATA:
      lt_ordim_o                TYPE /scwm/tt_ordim_o.

    DATA:
      lrt_lgtyp TYPE /scwm/tt_lgtyp_r,
      lrt_lgber TYPE /scwm/tt_lgber_r,
      lrt_lgpla TYPE /scwm/tt_lgpla_r,
      lrt_hu    TYPE /scwm/tt_huident_r,
      lrt_rsrc  TYPE /scwm/tt_rsrc_r,
      lrt_tu    TYPE /scwm/tt_tu_num_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    CALL METHOD zswl_cl_services_wt=>get_range_tables
      EXPORTING
        it_lgtyp  = it_lgtyp
        it_lgber  = it_lgber
        it_lgpla  = it_lgpla
        it_hu     = it_hu
        it_rsrc   = it_rsrc
        it_tu     = it_tu
      IMPORTING
        ert_lgtyp = lrt_lgtyp
        ert_lgber = lrt_lgber
        ert_lgpla = lrt_lgpla
        ert_hu    = lrt_hu
        ert_rsrc  = lrt_rsrc
        ert_tu    = lrt_tu
      CHANGING
        co_log    = co_log.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE lgnum   = i_lgnum
       AND ( ( vltyp   IN lrt_lgtyp
       AND     vlber   IN lrt_lgber
       AND     vlpla   IN lrt_lgpla )
       AND     vlenr   IN lrt_hu
       AND     srsrc   IN lrt_rsrc
       AND     stu_num IN lrt_tu ).

    IF sy-subrc <> 0.

*     Zu den Vondaten wurden keine offene Lageraufgaben gefunden!
      MESSAGE e012
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.


METHOD read_open_wt_by_wave.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_wave>                 TYPE /scwm/s_wave_itm.

    DATA:
      lt_ordim_o   TYPE /scwm/tt_ordim_o,
      lrt_wave     TYPE /scwm/tt_wave_r,
      lrt_wave_itm TYPE /scwm/tt_wave_itm_r,
      lrs_wave     TYPE /scwm/s_wave_r,
      lrs_wave_itm TYPE /scwm/s_wave_itm_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_wave ) > 0.

      CLEAR: lrs_wave,
             lrs_wave_itm.

      lrs_wave-option     = wmegc_option_eq.
      lrs_wave-sign       = wmegc_sign_inclusive.
      lrs_wave_itm-option = wmegc_option_eq.
      lrs_wave_itm-sign   = wmegc_sign_inclusive.

      LOOP AT it_wave ASSIGNING <ls_wave>.

        READ TABLE lrt_wave TRANSPORTING NO FIELDS
          WITH KEY low = <ls_wave>-wave.
        IF sy-subrc <> 0.

          CLEAR: lrs_wave-low.
          lrs_wave-low = <ls_wave>-wave.
          APPEND lrs_wave TO lrt_wave.

        ENDIF.

        READ TABLE lrt_wave_itm TRANSPORTING NO FIELDS
          WITH KEY low = <ls_wave>-wave_itm.
        IF sy-subrc <> 0.

          CLEAR: lrs_wave_itm-low.
          lrs_wave_itm-low = <ls_wave>-wave_itm.
          APPEND lrs_wave_itm TO lrt_wave_itm.

        ENDIF.

      ENDLOOP.

    ELSE.

*     Es wurden keine Wellendaten für die LB-Selektion übergeben!
      MESSAGE e015
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE lgnum    = i_lgnum
       AND wave     IN lrt_wave
       AND wave_itm IN lrt_wave_itm.

    IF sy-subrc <> 0.

*     Zu den Wellen konnten keine offene Lageraufgaben gefunden werden!
      MESSAGE e016
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.


METHOD read_open_wt_by_who.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    FIELD-SYMBOLS:
      <ls_who>                  TYPE /scwm/who.

    DATA:
      lt_ordim_o TYPE /scwm/tt_ordim_o,
      lrt_who    TYPE /scwm/tt_who_r,
      lrs_who    TYPE /scwm/s_who_r.

* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR et_wt_ref[].

    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Daten prüfen und Selektionstabelle aufbauen
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    IF i_lgnum IS INITIAL.

*     Es wurde keine Lagernummer übergeben!
      MESSAGE e026(zswl_ca)
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

    IF lines( it_who ) > 0.

      CLEAR lrs_who.
      lrs_who-option = wmegc_option_eq.
      lrs_who-sign   = wmegc_sign_inclusive.

      LOOP AT it_who ASSIGNING <ls_who>.

        READ TABLE lrt_who TRANSPORTING NO FIELDS
          WITH KEY low = <ls_who>-who.

        IF sy-subrc <> 0.

          CLEAR: lrs_who-low.

          lrs_who-low = <ls_who>-who.
          APPEND lrs_who TO lrt_who.

        ENDIF.

      ENDLOOP.

    ELSE.

*     Es wurden keine Lageraufträge für die LB-Selektion übergeben!
      MESSAGE e013
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Selektieren
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    SELECT *
      FROM /scwm/ordim_o
      INTO TABLE lt_ordim_o
     WHERE lgnum  = i_lgnum
       AND who    IN lrt_who.

    IF sy-subrc <> 0.

*     Zu den Lageraufträgen konnten keine offene Lageraufgaben
*     gefunden werden!
      MESSAGE e014
         INTO zswl_cl_log=>m_dummy_msg.
      co_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ENDIF.

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   Erstelle Rückgabetabelle
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CALL METHOD zswl_cl_services_wt=>build_ref_table
      EXPORTING
        it_ordim_o = lt_ordim_o
      IMPORTING
        et_wt_ref  = et_wt_ref
      CHANGING
        co_log     = co_log.

  ENDMETHOD.
ENDCLASS.
