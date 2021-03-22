class ZSWL_CL_WORKSTATION definition
  public
  inheriting from ZSWL_CL_OBJECT
  final
  create public .

public section.
  type-pools ABAP .

  class-data:
    BEGIN OF ws_status,
        off    TYPE zswl_de_ws_status VALUE '1',
        on     TYPE zswl_de_ws_status VALUE '2',
        runout TYPE zswl_de_ws_status VALUE '3',
      END OF ws_status .
  class-data:
    BEGIN OF ws_mode,
        ptwy TYPE zswl_de_wsmode VALUE 'PTWY',
        pick TYPE zswl_de_wsmode VALUE 'PICK',
        insb TYPE zswl_de_wsmode VALUE 'INSB',
        send TYPE zswl_de_wsmode VALUE 'SEND',
        cc   TYPE zswl_de_wsmode VALUE 'CC',
        view TYPE zswl_de_wsmode VALUE 'VIEW',
        cons TYPE zswl_de_wsmode VALUE 'CONS', " Added 23.05.18 for EWD
        inv  TYPE zswl_de_wsmode VALUE 'INV', " Added 23.05.18 for EWD
        intp TYPE zswl_de_wsmode VALUE 'INTP', " Added 23.02.21 for internal picking screen
      END OF ws_mode .
  class-data:
    BEGIN OF ws_orientation,
        north TYPE zswl_de_orientation VALUE 'N',
        south TYPE zswl_de_orientation VALUE 'S',
        west  TYPE zswl_de_orientation VALUE 'W',
        east  TYPE zswl_de_orientation VALUE 'E',
      END OF ws_orientation .

  methods CONSTRUCTOR
    importing
      !IV_LGNUM type /SCWM/LGNUM
      !IO_LOG type ref to ZSWL_CL_LOG optional
      !IV_WORKSTATION type ZSWL_DE_WORKSTATION
      !IV_LOCK type BOOLEAN optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_DATA
    returning
      value(RS_DATA) type ZSWL_T_WORKS .
  methods GET_WS_MODE
    returning
      value(RV_MODE) type ZSWL_DE_WSMODE .
  methods GET_WS_STATUS
    returning
      value(RV_STATUS) type ZSWL_DE_WS_STATUS .
  methods SET_WS_MODE
    importing
      !IV_MODE type ZSWL_DE_WSMODE
      !IV_COMMIT type BOOLEAN default ABAP_TRUE .
  methods SET_WS_STATUS
    importing
      !IV_STATUS type ZSWL_DE_WS_STATUS
      !IV_COMMIT type BOOLEAN default ABAP_TRUE .
  methods UPDATE
    importing
      !IS_DATA type ZSWL_T_WORKS
      !IV_COMMIT type BOOLEAN default ABAP_TRUE .
  methods ACTIVATE
    importing
      !IV_COMMIT type BOOLEAN default ABAP_TRUE .
  methods DEACTIVATE
    importing
      !IV_COMMIT type BOOLEAN default ABAP_TRUE .
  methods GET_PACK_MATERIALS
    returning
      value(RT_PACKAGING_MATERIALS) type ZSWL_TT_PACK_MAT_REF
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods GET_PACK_MATERIALS_FROM_CUST
    returning
      value(RT_PMAT_WS_CUSTOMIZING) type ZSWL_TT_WS_PACKMAT .
  methods LOCK
    changing
      value(CV_EQEUNAME) type EQEUNAME
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods UNLOCK
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods DBWRITE .
protected section.

  data MS_DATA type ZSWL_T_WORKS .
private section.
ENDCLASS.



CLASS ZSWL_CL_WORKSTATION IMPLEMENTATION.


method ACTIVATE.
    ms_data-active = abap_true.
    ms_data-status = zswl_cl_workstation=>ws_status-on.

    IF iv_commit = abap_true.
      ms_data-last_login_date = sy-datum.
      ms_data-last_login_time = sy-uzeit.
      ms_data-last_login_user = sy-uname.
      dbwrite( ).
    ENDIF.

*   activated
    MESSAGE i004
       WITH ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  endmethod.


METHOD constructor.
    super->constructor( i_lgnum = iv_lgnum io_log = io_log ).

**********************************************************************
* Check if workstation ID exists in ZSWL_T_WORKS table
**********************************************************************
    SELECT SINGLE *
      FROM zswl_t_works
      INTO ms_data
      WHERE "lgnum = iv_lgnum
       " AND
      workstation = iv_workstation.

    IF sy-subrc <> 0.
*     Workstation '&1' could not be found in database!
      MESSAGE e011
        WITH iv_workstation
        INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).
    ENDIF.

**   Lock immediately if requested
*    IF iv_lock IS SUPPLIED AND iv_lock = abap_true.
*      lock( ).
*    ENDIF.

  ENDMETHOD.


METHOD dbwrite.

    MODIFY zswl_t_works FROM ms_data.
    IF sy-subrc = 0.
      commit( ).
    ENDIF.

    MESSAGE i007
    INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD deactivate.
    ms_data-active = abap_false.
        ms_data-status = zswl_cl_workstation=>ws_status-off.


    IF iv_commit = abap_true.
      ms_data-last_logout_date = sy-datum.
      ms_data-last_logout_time = sy-uzeit.
      ms_data-last_logout_user = sy-uname.
      dbwrite( ).
    ENDIF.

*   activated
    MESSAGE i005
       WITH ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.


method GET_DATA.
    rs_data = ms_data.
  endmethod.


METHOD get_pack_materials.
    DATA: ls_worksmode TYPE zswl_t_worksmode,
          lt_pmats     TYPE TABLE OF zswl_v_ws_pmat,
          ls_pmat      LIKE LINE OF lt_pmats,
          lr_pmat      TYPE REF TO zswl_cl_pack_mat,
          ls_pack_mat  LIKE LINE OF rt_packaging_materials.


    "First the workgroup
    SELECT SINGLE * FROM zswl_t_worksmode INTO ls_worksmode
      WHERE lgnum = ms_data-lgnum AND workstation = ms_data-workstation AND
      wsmode = ms_data-act_mode.

    IF sy-subrc = 0.
      SELECT * FROM zswl_v_ws_pmat INTO CORRESPONDING FIELDS OF TABLE lt_pmats
        WHERE lgnum = ms_data-lgnum AND workgroup = ls_worksmode-workgroup AND spras = sy-langu .
    ENDIF.

    "Read the HUTYP description with sy-langu
    LOOP AT lt_pmats INTO ls_pmat.
      IF ls_pmat-pmat IS NOT INITIAL.
        CREATE OBJECT lr_pmat
          EXPORTING
            i_lgnum     = ms_data-lgnum
            i_matnr_c40 = ls_pmat-pmat.
        ls_pack_mat-o_ref = lr_pmat.
      ENDIF.
      ls_pack_mat-lgnum = ms_data-lgnum.
      ls_pack_mat-matnr = ls_pmat-pmat.
      ls_pack_mat-desc_long = ls_pmat-desc_long.
      ls_pack_mat-desc_short = ls_pmat-desc_short.
      ls_pack_mat-hu_typgrp = ls_pmat-hutypgrp.
      APPEND ls_pack_mat TO rt_packaging_materials.

      CLEAR: ls_pack_mat, lr_pmat.
    ENDLOOP.

  ENDMETHOD.


METHOD get_pack_materials_from_cust.
    DATA: ls_worksmode TYPE zswl_t_worksmode.


    "First the workgroup
    SELECT SINGLE * FROM zswl_t_worksmode INTO ls_worksmode
      WHERE lgnum = ms_data-lgnum AND workstation = ms_data-workstation AND
      wsmode = ms_data-act_mode.

    IF sy-subrc = 0.
      SELECT * FROM zswl_t_ws_pmat INTO CORRESPONDING FIELDS OF TABLE rt_pmat_ws_customizing
        WHERE lgnum = ms_data-lgnum AND workgroup = ls_worksmode-workgroup.
    ENDIF.

  ENDMETHOD.


method GET_WS_MODE.
    rv_mode = ms_data-act_mode.
  endmethod.


method GET_WS_STATUS.
    rv_status = ms_data-status.
  endmethod.


METHOD lock.

*   Lock workstation [&]
    MESSAGE i001
       WITH ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    zswl_cl_locking=>enqueue(
  EXPORTING
    i_lgnum         = m_lgnum
    i_enqmode       = 'E'
    i_lock_id       = ms_data-workstation
    i_lock_praefix  = zswl_cl_locking=>mc_prefix_workstation
  IMPORTING
    e_enq_uname     = cv_eqeuname
  EXCEPTIONS
    error           = 1
    OTHERS          = 2 ).

    IF sy-subrc <> 0.

      IF cv_eqeuname IS INITIAL.
*     Problems while locking
        MESSAGE e002
           WITH ms_data-workstation
           INTO zswl_cl_log=>m_dummy_msg.
        mo_log->add( i_syst = abap_true ).
        zcx_ewm_general_exception=>raise_system_exception( ).
      ENDIF.

    ELSE.

*     WS sucessfully locked
      MESSAGE i003
         WITH ms_data-workstation
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  ENDMETHOD.


METHOD set_ws_mode.

    ms_data-act_mode = iv_mode.

    IF iv_commit = abap_true.
      dbwrite( ).
    ENDIF.

*   activated
    MESSAGE i006
       WITH ms_data-act_mode ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.


METHOD SET_WS_STATUS.

    ms_data-status = iv_status.

    IF iv_commit = abap_true.
      dbwrite( ).
    ENDIF.

*   status changed
    MESSAGE i012
       WITH ms_data-status ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.


method UNLOCK.
    DATA: lv_enqname TYPE eqeuname.

*   Lock workstation [&]
    MESSAGE i008
       WITH ms_data-workstation
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

    zswl_cl_locking=>dequeue(
  EXPORTING
    i_lgnum         = m_lgnum
    i_lock_id       = ms_data-workstation
    i_lock_praefix  = zswl_cl_locking=>mc_prefix_workstation
  CHANGING
    xo_log          = mo_log
  EXCEPTIONS
    error           = 1
    OTHERS          = 2 ).

    IF sy-subrc <> 0.

*     Problems while locking
      MESSAGE e009
         WITH ms_data-workstation
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).
      zcx_ewm_general_exception=>raise_system_exception( ).

    ELSE.

*     WS sucessfully locked
      MESSAGE i010
         WITH ms_data-workstation
         INTO zswl_cl_log=>m_dummy_msg.
      mo_log->add( i_syst = abap_true ).

    ENDIF.

  endmethod.


METHOD UPDATE.

    ms_data = is_data.

    IF iv_commit = abap_true.
      dbwrite( ).
    ENDIF.

*   status changed
    MESSAGE i007
       INTO zswl_cl_log=>m_dummy_msg.
    mo_log->add( i_syst = abap_true ).

  ENDMETHOD.
ENDCLASS.
