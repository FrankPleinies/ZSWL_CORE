class ZSWL_CL_SERVICES_CONV definition
  public
  final
  create public .

public section.
  type-pools ZEBBC .

  class-methods CONVERT_TIMESTAMP_ZONLO
    importing
      !IV_TIMESTAMP type TZNTSTMPL
      !IV_ZONLO type SYSTZONLO
    exporting
      !EV_TIMESTAMP type TZNTSTMPL .
  class-methods DOCID_TO_DOCNO
    importing
      !I_DOCID type /SCDL/DL_DOCID
      !I_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !E_DOCNO type /SCDL/DL_DOCNO_INT
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods DOCNO_TO_DOCID
    importing
      !I_DOCNO type /SCDL/DL_DOCNO
      !I_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !E_DOCID type /SCWM/DE_DOCID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods ITMID_TO_ITMNO
    importing
      !I_DOCID type /SCDL/DL_DOCID
      !I_ITMID type /SCDL/DL_ITEMID
      !I_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !E_DOCNO type /SCDL/DL_DOCNO
      !E_ITMNO type /SCDL/DL_ITEMNO
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods ITMNO_TO_ITMID
    importing
      !I_DOCNO type /SCDL/DL_DOCNO
      !I_ITMNO type /SCDL/DL_ITEMNO
      !I_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !E_DOCID type /SCDL/DL_DOCID
      !E_ITMID type /SCDL/DL_ITEMID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods LGNUM_TO_GUID
    importing
      !I_LGNUM type /SCWM/LGNUM
    exporting
      !E_LGNUM_GUID type /SCMB/MDL_SCUGUID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods MATID_C22_TO_MATNR
    importing
      !I_MATID type /SAPAPO/MATID
    exporting
      !E_MATNR type /SAPAPO/MATNR
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods MATID_TO_MATNR
    importing
      !I_MATID type /SCWM/DE_MATID
    exporting
      !E_MATNR type /SCWM/DE_MATNR
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods MATNR_TO_MATID
    importing
      !I_MATNR type /SCWM/DE_MATNR
    exporting
      !E_MATID type /SCWM/DE_MATID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods MATNR_TO_MATID_C22
    importing
      !I_MATNR type /SAPAPO/MATNR
    exporting
      !E_MATID type /SAPAPO/MATID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods PARTNERID_TO_PARTNERNO
    importing
      !I_PARTNER_ID type /SCDL/DL_PARTYID
    exporting
      !E_PARTNER_NO type /SCDL/DL_PARTYNO
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods PARTNERNO_TO_PARTNERID
    importing
      !I_PARTNER_NO type /SCDL/DL_PARTYNO
    exporting
      !E_PARTNER_ID type /SCDL/DL_PARTYID
    changing
      !CO_LOG type ref to ZSWL_CL_LOG
    exceptions
      ERROR .
  class-methods QUAN_UNIT_TO_UNIT
    importing
      !I_MATID type /SCWM/DE_MATID
      !I_QUAN type /SCWM/DE_QUANTITY
      !I_UOM_FROM type /SCWM/DE_UNIT
      !I_UOM_TO type /SCWM/DE_UNIT
      !I_BATCHID type /SCWM/DE_BATCHID optional
    returning
      value(R_QUANTITY) type /SCWM/DE_QUANTITY
    raising
      /SCWM/CX_MD .
protected section.
private section.

  class-methods MAP_DOCNO_TO_DOCID_FD
    importing
      !IT_DOCNO type /SCWM/DLV_DOCNO_TAB
    exporting
      !ET_MAPPING type /SCWM/DLV_PRD_MAP_TAB
      !ET_ITEMMAP type /SCWM/DLV_PRD_ITEM_MAP_TAB .
  class-methods CONVERSION_EXIT_MTNID_INPUT
    importing
      !INPUT type ANY
    exporting
      !OUTPUT type ANY
    exceptions
      ERROR .
  class-methods CONVERSION_EXIT_MTNID_OUTPUT
    importing
      !INPUT type ANY
    exporting
      !OUTPUT type ANY
    exceptions
      ERROR .
ENDCLASS.



CLASS ZSWL_CL_SERVICES_CONV IMPLEMENTATION.


METHOD conversion_exit_mtnid_input.
*|======================================================================
*| Beschreibung  :
*| Die Methode ersetzt den FuBa: CONVERSION_EXIT_MTNID_INPUT, da
*| dieser in einem integrierten System nicht vorhanden ist!
*|
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    DATA: lv_prodno TYPE /scmb/dm_prod_id.
    DATA: lv_prodguid TYPE /scmb/dm_prod_guid.
    DATA: lt_return TYPE bapirettab.

    FIELD-SYMBOLS: <fs_msg> LIKE LINE OF lt_return.

    IF input IS INITIAL.
      CLEAR output.
      RETURN.
    ENDIF.

    CALL FUNCTION 'CONVERSION_EXIT_MDLP1_INPUT'
      EXPORTING
        input  = input
      IMPORTING
        output = lv_prodno.

    CALL FUNCTION '/SCMB/MDL_KEYC_BY_MATNR_SNL'
      EXPORTING
        iv_matnr  = lv_prodno
      IMPORTING
        ev_matid  = lv_prodguid
      CHANGING
        ct_return = lt_return.

    output = lv_prodguid.
    IF input IS NOT INITIAL AND output IS INITIAL.

      LOOP AT lt_return ASSIGNING <fs_msg>
        WHERE type = wmegc_severity_abort
           OR type = wmegc_severity_err
           OR type = wmegc_severity_suc.

        MESSAGE ID <fs_msg>-id TYPE <fs_msg>-type NUMBER <fs_msg>-number
          WITH <fs_msg>-message_v1 <fs_msg>-message_v2
          <fs_msg>-message_v3 <fs_msg>-message_v4
          RAISING error.


      ENDLOOP.
    ENDIF.


  ENDMETHOD.


METHOD conversion_exit_mtnid_output.
*| Beschreibung  :
*| Die Methode ersetzt den FuBa: CONVERSION_EXIT_MTNID_OUTPUT, da
*| dieser in einem integrierten System nicht vorhanden ist!
*|
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    DATA: lv_prodno TYPE /scmb/dm_prod_id.
    DATA: lv_prodguid TYPE /scmb/dm_prod_guid.
    DATA: lt_return TYPE bapirettab.

    FIELD-SYMBOLS: <fs_msg> LIKE LINE OF lt_return.

    IF input IS INITIAL.
      CLEAR output.
      RETURN.
    ENDIF.

    lv_prodguid = input.

    CALL FUNCTION '/SCMB/MDL_KEYC_BY_MATID_SNL'
      EXPORTING
        iv_matid  = lv_prodguid
      IMPORTING
        ev_matnr  = lv_prodno
      CHANGING
        ct_return = lt_return.

    CALL FUNCTION 'CONVERSION_EXIT_MDLP1_OUTPUT'
      EXPORTING
        input  = lv_prodno
      IMPORTING
        output = output.

    IF input IS NOT INITIAL AND output IS INITIAL.
      LOOP AT lt_return ASSIGNING <fs_msg>
        WHERE type = wmegc_severity_abort.

        MESSAGE ID <fs_msg>-id TYPE <fs_msg>-type NUMBER <fs_msg>-number
          WITH <fs_msg>-message_v1 <fs_msg>-message_v2
          <fs_msg>-message_v3 <fs_msg>-message_v4
          RAISING error.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


METHOD convert_timestamp_zonlo.

**********************************************************************
* declaration
**********************************************************************
    DATA: lv_date  LIKE sy-datum,
          lv_time  LIKE sy-uzeit,
          lv_zonlo LIKE sy-zonlo.

**********************************************************************
* implementation
**********************************************************************
    CLEAR: ev_timestamp.

    IF iv_timestamp IS INITIAL.
      RETURN.
    ENDIF.

    CONVERT TIME STAMP iv_timestamp TIME ZONE iv_zonlo
       INTO DATE lv_date            TIME lv_time.

    CONVERT DATE lv_date            TIME lv_time
       INTO TIME STAMP ev_timestamp TIME ZONE lv_zonlo.

  ENDMETHOD.


METHOD docid_to_docno.
*|======================================================================
*| Beschreibung  : Konvertieren einer DOCID/DOCCAT in eine DOCNO

    DATA: lo_docno_instance    TYPE REF TO /scwm/cl_dlv_management_prd.

*{#001 - mwe
    DATA: lo_docno_instance_fd TYPE REF TO /scwm/cl_dlv_management_fd.
*}#001

    DATA: lt_docid       TYPE /scwm/dlv_docid_tab,
          lt_dlv_prd_map TYPE /scwm/dlv_prd_map_tab.
    DATA: ls_docid       LIKE LINE OF lt_docid,
          ls_dlv_prd_map TYPE /scwm/dlv_prd_map_str.


* Exportparameter leeren
    CLEAR: e_docno.


* Wenn kein Protokollierungsobjekt übergeben wurde, dann erstellen
* wir hier einfach ein neues
    IF co_log IS NOT BOUND.

      CREATE OBJECT co_log.

    ENDIF.


    IF i_docid IS INITIAL.

*   Es wurde keine DOCID übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '100'
        i_set_syst = abap_true ).
      RAISE error.

    ENDIF.


    IF i_doccat IS INITIAL.

*   Es wurde keine DOCCAT übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '101'
        i_set_syst = abap_true ).

      RAISE error.

    ENDIF.


* Tabelle lt_docid befüllen
    REFRESH lt_docid.
    ls_docid-docid = i_docid.
    APPEND ls_docid TO lt_docid.


*{#001
    IF i_doccat = /scdl/if_dl_doc_c=>sc_doccat_out_fd. "FDO

*   Create instance.
      lo_docno_instance_fd = /scwm/cl_dlv_management_fd=>get_instance( ).

*   Get/create instance for object
      IF lo_docno_instance_fd IS NOT BOUND.

        CREATE OBJECT lo_docno_instance_fd.

      ENDIF.

*   Ermitteln der Docno zur Docid / Doccat
      CALL METHOD lo_docno_instance_fd->map_docid_to_docno
        EXPORTING
          it_docid   = lt_docid
        IMPORTING
          et_mapping = lt_dlv_prd_map.

    ELSE.
*}#001

*   Create instance.
      lo_docno_instance = /scwm/cl_dlv_management_prd=>get_instance( ).

*   Get/create instance for object
      IF lo_docno_instance IS NOT BOUND.

        CREATE OBJECT lo_docno_instance.

      ENDIF.

*   Ermitteln der Docno zur Docid / Doccat
      CALL METHOD lo_docno_instance->map_docid_to_docno
        EXPORTING
          iv_doccat  = i_doccat
          it_docid   = lt_docid
        IMPORTING
          et_mapping = lt_dlv_prd_map.

*{#001 - mwe
    ENDIF.
*}#001


* Tabelleneintrag in die Struktur schieben
    READ TABLE lt_dlv_prd_map INTO ls_dlv_prd_map INDEX 1.


    IF sy-subrc <> 0.

*   Fehler bei der Ermittlung der DOCNO zur DOCID '&' / DOCCAT '&'!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '102'
        i_msgv1              = i_docid
        i_msgv2              = i_doccat
        i_set_syst           = abap_true ).
      RAISE error.

    ENDIF.


* Exportparameter e_docno füllen
    e_docno = ls_dlv_prd_map-docno.


  ENDMETHOD.


METHOD docno_to_docid.
*|======================================================================
*| Beschreibung  :
*| Konvertieren einer DOCNO/DOCCAT in eine DOCID
*|======================================================================
*| ID    Entwickler Datum
*| #001  CF         2014-10-16
*|       convert I_DOCNO to leading zeros before selection
*|
*| #002  mwe        2014-12-16  Umwandlung von DOCIDs für FDOs
*|
*|======================================================================


    DATA: l_docno           TYPE /scdl/dl_docno,
          lt_docno          TYPE /scwm/dlv_docno_tab,
          ls_docno          TYPE /scwm/dlv_docno_str,
          lt_dlv_prd_map    TYPE /scwm/dlv_prd_map_tab,
          ls_dlv_prd_map    TYPE /scwm/dlv_prd_map_str,
          lo_docno_instance TYPE REF TO /scwm/cl_dlv_management_prd.

* {#002
    DATA: ls_docno_int TYPE /scwm/dlv_docno_str,
          lt_docno_int TYPE /scwm/dlv_docno_tab.
* #002}


    CLEAR: e_docid.


* Wenn kein Protokollierungsobjekt übergeben wurde, dann erstellen
* wir hier einfach ein neues
    IF co_log IS NOT BOUND.

      CREATE OBJECT co_log.

    ENDIF.


* Es muss eine DOCNO mit DOCCAT übergeben worden sein!
    IF i_docno IS INITIAL OR
       i_doccat IS INITIAL.

      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '103'
        i_set_syst = abap_true ).

      RAISE error.

    ENDIF.


* {#001
    l_docno = i_docno.
    CALL FUNCTION 'CONVERSION_EXIT_NUMCV_INPUT'
      EXPORTING
        input  = l_docno
      IMPORTING
        output = l_docno.
* #001}


* {#002
    IF i_doccat = /scdl/if_dl_doc_c=>sc_doccat_out_fd. "FDO

      CLEAR ls_docno_int.
      ls_docno_int-doccat = i_doccat.
      ls_docno_int-docno  = l_docno.

      APPEND ls_docno_int TO lt_docno_int.

      CALL METHOD zswl_cl_services_conv=>map_docno_to_docid_fd
        EXPORTING
          it_docno   = lt_docno_int
        IMPORTING
          et_mapping = lt_dlv_prd_map.

    ELSE.
* #002}

*   Create instance.
      lo_docno_instance = /scwm/cl_dlv_management_prd=>get_instance( ).

*   Get/create instance for object
      IF lo_docno_instance IS NOT BOUND.
        CREATE OBJECT lo_docno_instance.
      ENDIF.

      REFRESH lt_docno.
      ls_docno-docno  = l_docno.
      ls_docno-doccat = i_doccat.
      APPEND ls_docno TO lt_docno.

*   Convert DOCNO to RDOCID
      CALL METHOD lo_docno_instance->map_docno_to_docid
        EXPORTING
          it_docno   = lt_docno
        IMPORTING
          et_mapping = lt_dlv_prd_map.

* {#002
    ENDIF.
* #002}


    READ TABLE lt_dlv_prd_map INTO ls_dlv_prd_map INDEX 1.

    e_docid = ls_dlv_prd_map-docid.

    IF e_docid IS INITIAL.

*   Die DOCID konnte zur DOCNO '&' / DOCCAT '&' nicht ermittelt!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '104'
        i_msgv1              = l_docno
        i_msgv2              = i_doccat
        i_set_syst           = abap_true ).

      RAISE error.

    ENDIF.


  ENDMETHOD.


METHOD itmid_to_itmno.
*|======================================================================
*| Beschreibung  : Konvertieren einer ITMID/DOCCAT in eine ITMNO
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    DATA: lo_docno_instance TYPE REF TO /scwm/cl_dlv_management_prd.

    DATA: lt_docid       TYPE /scwm/dlv_docid_tab,
          lt_dlv_prd_map TYPE /scwm/dlv_prd_map_tab.
    DATA: ls_docid       LIKE LINE OF lt_docid,
          ls_dlv_prd_map TYPE /scwm/dlv_prd_map_str.

* Exportparameter leeren
    CLEAR: e_itmno, e_docno.

* Wenn kein Protokollierungsobjekt übergeben wurde, dann erstellen
* wir hier einfach ein neues
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_docid IS INITIAL.
*   Es wurde keine DOCID übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '100'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    IF i_itmid IS INITIAL.
*   Es wurde keine ITMNID übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '109'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    IF i_doccat IS INITIAL.
*   Es wurde keine DOCCAT übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '101'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

* Create instance.
    lo_docno_instance = /scwm/cl_dlv_management_prd=>get_instance( ).

* Get/create instance for object
    IF lo_docno_instance IS NOT BOUND.
      CREATE OBJECT lo_docno_instance.
    ENDIF.

* Ermitteln der Docno zur Docid / Doccat
    CALL METHOD lo_docno_instance->map_itemid_to_itemno
      EXPORTING
        iv_doccat         = i_doccat
        iv_docid          = i_docid
        iv_itemid         = i_itmid
      IMPORTING
        ev_itemno         = e_itmno
      EXCEPTIONS
        itemid_not_unique = 1
        not_found         = 2
        OTHERS            = 3.

    IF sy-subrc <> 0.
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_syst               = abap_true
        i_set_syst           = abap_true ).
      RAISE error.
    ENDIF.

    IF e_itmno IS INITIAL.
*   Fehler bei der Ermittlung der ITMID zur DOCID '&', ITMID '&'
*   / DOCCAT '&'!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '108'
        i_msgv1              = i_docid
        i_msgv2              = i_itmid
        i_msgv3              = i_doccat
       i_set_syst           = abap_true ).
      RAISE error.
    ENDIF.

* Tabelle lt_docid befüllen
    REFRESH lt_docid.
    ls_docid-docid = i_docid.
    APPEND ls_docid TO lt_docid.

* jetzt zur DOCID noch die DOCNO ermitteln!
    CALL METHOD lo_docno_instance->map_docid_to_docno
      EXPORTING
        iv_doccat  = i_doccat
        it_docid   = lt_docid
      IMPORTING
        et_mapping = lt_dlv_prd_map.

* Tabelleneintrag in die Struktur schieben
    READ TABLE lt_dlv_prd_map INTO ls_dlv_prd_map INDEX 1.

    IF sy-subrc <> 0.
*   Fehler bei der Ermittlung der DOCNO zur DOCID '&' / DOCCAT '&'!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '102'
        i_msgv1              = i_docid
        i_msgv2              = i_doccat
        i_set_syst           = abap_true ).
      RAISE error.
    ENDIF.

* Exportparameter e_docno füllen
    e_docno = ls_dlv_prd_map-docno.

  ENDMETHOD.


METHOD itmno_to_itmid.
*|======================================================================
*| Beschreibung  : Konvertieren einer ITMNO/DOCCAT in eine ITMID
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    DATA: lt_docno          TYPE /scwm/dlv_docno_tab,
          ls_docno          TYPE /scwm/dlv_docno_str,
          lt_itemmap       	TYPE /scwm/dlv_prd_item_map_tab,
          ls_itemmap        LIKE LINE OF lt_itemmap,
          lo_docno_instance TYPE REF TO /scwm/cl_dlv_management_prd.

* Exportparameter leeren
    CLEAR: e_docid, e_itmid.

* Wenn kein Protokollierungsobjekt übergeben wurde, dann erstellen
* wir hier einfach ein neues
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

    IF i_docno IS INITIAL.
*   Es wurde keine Belegidentifikation (DOCID oder DOCNO) angegeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '105'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    IF i_itmno IS INITIAL.
*   Es wurde keine ITMNO übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '106'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    IF i_doccat IS INITIAL.
*   Es wurde keine DOCCAT übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '101'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

* Create instance.
    lo_docno_instance = /scwm/cl_dlv_management_prd=>get_instance( ).

* Get/create instance for object
    IF lo_docno_instance IS NOT BOUND.
      CREATE OBJECT lo_docno_instance.
    ENDIF.

    REFRESH lt_docno.
    ls_docno-docno  = i_docno.
    ls_docno-itemno = i_itmno.
    ls_docno-doccat = i_doccat.
    APPEND ls_docno TO lt_docno.

* Convert DOCNO to RDOCID
    REFRESH: lt_itemmap.
    CALL METHOD lo_docno_instance->map_docno_to_docid
      EXPORTING
        it_docno   = lt_docno
      IMPORTING
        et_itemmap = lt_itemmap.

    CLEAR: ls_itemmap.
    READ TABLE lt_itemmap INTO ls_itemmap
         INDEX 1.
    IF sy-subrc = 0.
      e_docid = ls_itemmap-docid.
      e_itmid = ls_itemmap-itemid.
      RETURN.
    ENDIF.

    IF e_docid IS INITIAL.
*   Die DOCID konnte zur DOCNO '&' / DOCCAT '&' nicht ermittelt werden!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '104'
        i_msgv1              = i_docno
        i_msgv2              = i_doccat
        i_set_syst           = abap_true ).
      RAISE error.
    ENDIF.

    IF e_itmid IS INITIAL.
*   Die ITMID konnte zur DOCNO '&' ITMNO '&' / DOCCAT '&' nicht
*   ermittelt!
      co_log->add(
        i_protlvl            = zswl_cl_log=>mc_protlvl_important
        i_msgty              = zswl_cl_log=>mc_msgty_error
        i_msgid              = 'ZSWL_CONV'
        i_msgno              = '107'
        i_msgv1              = i_docno
        i_msgv2              = i_itmno
        i_msgv3              = i_doccat
        i_set_syst           = abap_true ).
      RAISE error.
    ENDIF.

  ENDMETHOD.


METHOD lgnum_to_guid.
*|======================================================================
*| Beschreibung  :
*| Hier wird die GUID zur übergebenen Lagernummer ermittelt.
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    CLEAR: e_lgnum_guid.

************************************************************************
*** Erzeugen des Protokollierungsobjekts
************************************************************************
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.
************************************************************************

************************************************************************
*** Eingaben prüfen
************************************************************************
    IF i_lgnum IS INITIAL.
*   Es wurde keine Lagernummer angegeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '110'
        i_set_syst = abap_true ).

      RAISE error.
    ENDIF.
************************************************************************

************************************************************************
*** GUID ermitteln
************************************************************************
    SELECT SINGLE scuguid
      FROM /scwm/t300_md
      INTO e_lgnum_guid
     WHERE lgnum = i_lgnum.
    IF sy-subrc <> 0.
*   Zur Lagernummer '&' ist keine GUID vorhanden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '111'
        i_set_syst = abap_true ).

      RAISE error.
    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD map_docno_to_docid_fd.


    DATA:
      lo_sp_fd        TYPE REF TO /scdl/cl_sp_fd,
      lv_rejected     TYPE boole_d,
      ls_docno        TYPE REF TO /scwm/dlv_docno_str,
      ls_map          TYPE /scwm/dlv_prd_map_str,
      lo_managment_fd TYPE REF TO /scwm/cl_dlv_management_fd.

    DATA:
      ls_sp_a_mapkey TYPE REF TO /scdl/s_sp_a_mapkey,
      lt_sp_a_mapkey TYPE /scdl/t_sp_a_mapkey,
      ls_itemmap     TYPE /scwm/dlv_prd_item_map_str,
      lt_no          TYPE /scdl/dl_no_tab,
      ls_no          TYPE /scdl/dl_no_str,
      ls_sp          TYPE REF TO /scwm/dlv_doccat_sp_str,
      lt_guid        TYPE /scdl/dl_guid_tab,
      ls_guid        TYPE REF TO  /scdl/dl_id_str.

* anything to do?
    IF it_docno IS INITIAL.
      EXIT.
    ENDIF.



    lo_managment_fd = /scwm/cl_dlv_management_fd=>get_instance( ).

    lo_sp_fd        ?= lo_managment_fd->get_service_provider(
          iv_doccat =  /scdl/if_dl_doc_c=>sc_doccat_out_fd ).

* fill keys and do checks...
    LOOP AT it_docno REFERENCE INTO ls_docno.
      ASSERT ID /scwm/dlv_manager CONDITION NOT ls_docno->docno IS INITIAL AND NOT ls_docno->doccat IS INITIAL.




**** get first SP (which one does not matter)
***      IF NOT lo_sp_fd IS BOUND.
****** get any SP to read data (as method is independant on SP).
*****        READ TABLE mt_sp REFERENCE INTO ls_sp INDEX 1.
******        lo_sp_prd ?= ls_sp->sp.
***      ENDIF.

      ls_no-doccat = ls_docno->doccat.
      ls_no-docno  = ls_docno->docno.
      ls_no-itemno = ls_docno->itemno.
      COLLECT ls_no INTO lt_no.
    ENDLOOP.

* get keymaps
    lo_sp_fd->query_mapkey( EXPORTING
      it_no = lt_no
      it_id = lt_guid
    IMPORTING
      et_keymap        = lt_sp_a_mapkey
      ev_rejected = lv_rejected ).

* map back
    LOOP AT lt_sp_a_mapkey REFERENCE INTO ls_sp_a_mapkey.
      IF et_itemmap IS REQUESTED AND NOT ls_sp_a_mapkey->itemid IS INITIAL.
        CLEAR ls_itemmap.
        ls_itemmap-docno    = ls_sp_a_mapkey->docno.
        ls_itemmap-doccat   = ls_sp_a_mapkey->doccat.
        ls_itemmap-docid    = ls_sp_a_mapkey->docid.
        ls_itemmap-itemid   = ls_sp_a_mapkey->itemid.
        ls_itemmap-itemno   = ls_sp_a_mapkey->itemno.
        COLLECT ls_itemmap INTO et_itemmap.
      ENDIF.

      IF et_mapping IS REQUESTED.
        CLEAR ls_map.
        ls_map-docid  = ls_sp_a_mapkey->docid.
        ls_map-docno  = ls_sp_a_mapkey->docno.
        ls_map-doccat = ls_sp_a_mapkey->doccat.
        COLLECT ls_map INTO et_mapping.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.


METHOD matid_c22_to_matnr.
*|======================================================================
*| Beschreibung  :
*| Hier konvertieren wir die übergebenen Material-ID (C22) in deren
*| Materialnummer.
*| (Kopie von MATID_TO_MATNR)
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    CLEAR: e_matnr.

************************************************************************
*** Erzeugen des Protokollierungsobjekts
************************************************************************
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.
************************************************************************

************************************************************************
*** Eingaben prüfen
************************************************************************
    IF i_matid IS INITIAL.
*   Es wurde kein Material übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '112'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.
************************************************************************

************************************************************************
*** Konvertierung durchführen
************************************************************************
    CALL FUNCTION 'CONVERSION_EXIT_MATID_OUTPUT'
      EXPORTING
        input  = i_matid
      IMPORTING
        output = e_matnr
      EXCEPTIONS
        OTHERS = 1.

    IF sy-subrc <> 0 OR
       e_matnr IS INITIAL.

      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_syst     = abap_true ).

*   Es konnte keine Material-ID zum Material & ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '113'
        i_msgv1    = i_matid
        i_set_syst = abap_true ).

      RAISE error.
    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD matid_to_matnr.
*|======================================================================
*| Beschreibung  :
*| Hier konvertieren wir die übergebenen Material-ID in deren
*| Materialnummer.
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    CLEAR: e_matnr.

************************************************************************
*** Erzeugen des Protokollierungsobjekts
************************************************************************
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.
************************************************************************

************************************************************************
*** Eingaben prüfen
************************************************************************
    IF i_matid IS INITIAL.
*   Es wurde kein Material übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '112'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.
************************************************************************

************************************************************************
*** Konvertierung durchführen
************************************************************************
    CALL METHOD zswl_cl_services_conv=>conversion_exit_mtnid_output
      EXPORTING
        input  = i_matid
      IMPORTING
        output = e_matnr
      EXCEPTIONS
        error  = 1
        OTHERS = 2.
    IF sy-subrc <> 0.
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_syst     = abap_true ).

*   Es konnte keine Material-ID zum Material & ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '113'
        i_msgv1    = i_matid
        i_set_syst = abap_true ).

      RAISE error.
    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD matnr_to_matid.
*|======================================================================
*| Beschreibung  :
*| Dieser Baustien konvertiert eine übergebenen Materialnummer
*| in eine Material-ID.
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

    CLEAR: e_matid.

************************************************************************
*** Erzeugen des Protokollierungsobjekts
************************************************************************
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.
************************************************************************

************************************************************************
*** Eingaben prüfen
************************************************************************
    IF i_matnr IS INITIAL.
*   Es wurde kein Material übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '112'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.
************************************************************************

************************************************************************
*** Konvertierung durchführen
************************************************************************
    CALL METHOD zswl_cl_services_conv=>conversion_exit_mtnid_input
      EXPORTING
        input  = i_matnr
      IMPORTING
        output = e_matid
      EXCEPTIONS
        error  = 1
        OTHERS = 2.
    IF sy-subrc <> 0.

      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_syst     = abap_true ).

*   Es konnte keine Material-ID zum Material & ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '113'
        i_msgv1    = i_matnr
        i_set_syst = abap_true ).

      RAISE error.

    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD matnr_to_matid_c22.
*|======================================================================
*| Beschreibung  :
*| Dieser Baustien konvertiert eine übergebenen Materialnummer
*| in eine Material-ID (C22).
*| (Kopie von MATNR_TO_MATID)
*|======================================================================
*| ID    Entwickler Datum
*| #001  CF         2014-10-13
*|       allow conversion for products without leading zero
*| #002  DKA        2014-12-02
*|       Konvertierung der verkürzten MatNr in lange wurde durchgeführt
*|       aber dann trotzdem die verkürzte benutzt
*|======================================================================

    DATA l_matnr TYPE /sapapo/matnr.
    CLEAR: e_matid.

************************************************************************
*** Erzeugen des Protokollierungsobjekts
************************************************************************
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.
************************************************************************

************************************************************************
*** Eingaben prüfen
************************************************************************
    IF i_matnr IS INITIAL.
*   Es wurde kein Material übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '112'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.
************************************************************************

************************************************************************
*** Konvertierung durchführen
************************************************************************
* {#001
    CALL FUNCTION 'CONVERSION_EXIT_PRODU_INPUT'
      EXPORTING
        input        = i_matnr
      IMPORTING
        output       = l_matnr
      EXCEPTIONS
        length_error = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.

      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_syst     = abap_true ).

*   Es konnte keine Material-ID zum Material & ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '113'
        i_msgv1    = i_matnr
        i_set_syst = abap_true ).

      RAISE error.
    ENDIF.
* #001}

    CALL FUNCTION 'CONVERSION_EXIT_MATID_INPUT'
      EXPORTING
        input  = l_matnr "#002 i_matnr
      IMPORTING
        output = e_matid
      EXCEPTIONS
        OTHERS = 1.

    IF sy-subrc <> 0 OR
       e_matid IS INITIAL.

      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_syst     = abap_true ).

*   Es konnte keine Material-ID zum Material & ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '113'
        i_msgv1    = i_matnr
        i_set_syst = abap_true ).

      RAISE error.

    ENDIF.
************************************************************************

  ENDMETHOD.


METHOD partnerid_to_partnerno.
*|======================================================================
*| Beschreibung  :
*| Die Partner-ID wird durch einen Select Single in ein Spediteur umge-
*| wandelt.
*|
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

*|======================================================================
* Erstellen des Log-Objekts, falls nicht vorhanden!
*|======================================================================
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*|======================================================================
* Importparamter prüfen
*|======================================================================
    IF i_partner_id IS INITIAL.
*   Es wurde keine Partner-ID übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '114'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    CLEAR:
      e_partner_no.

*|======================================================================
* Ermitteln des Partners
*|======================================================================
    SELECT SINGLE partner
             FROM but000
             INTO e_partner_no
            WHERE partner_guid = i_partner_id.

    IF sy-subrc <> 0.
*   Zur Partner-ID '&' konnte kein Partner ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '115'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

  ENDMETHOD.


METHOD partnerno_to_partnerid.
*|======================================================================
*| Beschreibung  :
*| Die Partner-ID wird durch einen Select Single in ein Spediteur umge-
*| wandelt.
*|
*|======================================================================
*| ID    Entwickler Datum
*| #001
*|
*|======================================================================

*|======================================================================
* Erstellen des Log-Objekts, falls nicht vorhanden!
*|======================================================================
    IF co_log IS NOT BOUND.
      CREATE OBJECT co_log.
    ENDIF.

*|======================================================================
* Importparamter prüfen
*|======================================================================
    IF i_partner_no IS INITIAL.
*   Es wurde keine Partner-NO übergeben!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '116'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

    CLEAR:
      e_partner_id.

*|======================================================================
* Ermitteln des Partners
*|======================================================================
    SELECT SINGLE partner_guid
             FROM but000
             INTO e_partner_id
            WHERE partner = i_partner_no.

    IF sy-subrc <> 0.
*   Zur Partner-NO '&' konnte kein Partner-ID ermittelt werden!
      co_log->add(
        i_protlvl  = zswl_cl_log=>mc_protlvl_important
        i_msgty    = zswl_cl_log=>mc_msgty_error
        i_msgid    = 'ZSWL_CONV'
        i_msgno    = '117'
        i_set_syst = abap_true ).
      RAISE error.
    ENDIF.

  ENDMETHOD.


METHOD quan_unit_to_unit.

* Deklarationen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*


* Implementierung ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

    CLEAR r_quantity.

    CALL FUNCTION '/SCWM/MATERIAL_QUAN_CONVERT'
      EXPORTING
        iv_matid     = i_matid
        iv_quan      = i_quan
        iv_unit_from = i_uom_from
        iv_unit_to   = i_uom_to
        iv_batchid   = i_batchid
      IMPORTING
        ev_quan      = r_quantity.

  ENDMETHOD.
ENDCLASS.
