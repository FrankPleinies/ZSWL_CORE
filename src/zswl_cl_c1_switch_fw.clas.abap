class ZSWL_CL_C1_SWITCH_FW definition
  public
  final
  create public .

public section.
  type-pools ABAP .
  type-pools WMEGC .

  methods CONSTRUCTOR
    importing
      !IV_PROGRAMM type PROGRAMM
      !IV_FORMNAME type FORMNAME optional
      !IV_KEY1 type ANY
      !IV_KEY2 type ANY optional
      !IV_KEY3 type ANY optional
      !IV_VAL1 type ANY
      !IV_VAL2 type ANY optional
      !IV_VAL3 type ANY optional
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  methods EXECUTE_CHECK
    exporting
      !EV_ACTIVE type XFELD
      !ET_FUN_MODULE type FUNCNAME_TAB .
protected section.
private section.

*  data MT_C1_SWITCHFW type ZSWL_TT_C1_SWITCHFW .
  data MV_PROGRAMM type PROGRAMM .
  data MV_FORMNAME type FORMNAME .
  data MV_KEY_FIELD type STRING .
  constants MC_FSLASH type CHAR1 value '/' ##NO_TEXT.
  data MV_VAL1 type STRING .
  data MV_VAL2 type STRING .
  data MV_VAL3 type STRING .

  methods GET_DATA .
  methods CHECK_ACTIVATION
    exporting
      !EV_ACTIVE type XFELD
      !ET_FUN_MODULE type FUNCNAME_TAB .
ENDCLASS.



CLASS ZSWL_CL_C1_SWITCH_FW IMPLEMENTATION.


METHOD check_activation.

    " ------------------------------------------ "
    "  Local Declarations..
    " ------------------------------------------ "

**    DATA : ls_c1_switchfw TYPE zswl_c1_switchfw,
*           ls_fun_module  TYPE funcname.
*
*    DATA : lv_selval_1 TYPE string,
*           lv_selval_2 TYPE string,
*           lv_selval_3 TYPE string.
*
*    " ------------------------------------------ "
*    "  Processing Logic..
*    " ------------------------------------------ "
*
*    " Initializing exporting parameters..
*    CLEAR : ev_active,
*            et_fun_module[].
*
*    LOOP AT mt_c1_switchfw[] INTO ls_c1_switchfw.
*      SPLIT ls_c1_switchfw-key_values AT mc_fslash
*                                      INTO lv_selval_1
*                                           lv_selval_2
*                                           lv_selval_3.
*      IF sy-subrc = 0.
*        IF mv_val1 CP lv_selval_1 AND
*           mv_val2 CP lv_selval_2 AND
*           mv_val3 CP lv_selval_3.
*          ev_active = abap_true.
*          ls_fun_module = ls_c1_switchfw-fun_module.
*          IF ls_fun_module IS NOT INITIAL.
*            APPEND ls_fun_module TO et_fun_module[].
*          ENDIF.
*          CLEAR ls_fun_module.
*        ELSE.
*          IF lv_selval_1 CP mv_val1 AND
*             lv_selval_2 CP mv_val2 AND
*             lv_selval_3 CP mv_val3.
*            ev_active = abap_true.
*            ls_fun_module = ls_c1_switchfw-fun_module.
*            IF ls_fun_module IS NOT INITIAL.
*              APPEND ls_fun_module TO et_fun_module[].
*            ENDIF.
*            CLEAR ls_fun_module.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*      CLEAR : lv_selval_1,
*              lv_selval_2,
*              lv_selval_3,
*              ls_fun_module.
*    ENDLOOP.
*    IF sy-subrc EQ 0 AND
*       et_fun_module[] IS NOT INITIAL.
*      SORT et_fun_module[].
*      DELETE ADJACENT DUPLICATES FROM et_fun_module[].
*    ENDIF.

  ENDMETHOD.


METHOD constructor.
************************************************************************
* Company     : Swisslog AG
*
* Package     : ZSWL_CORE
* Group       : N/A
* Function    : CORE Switch Activation Framework
* Enhancement : N/A
* Description : This ABAP is used as a CORE Framework to switch ON/OFF
*               any specific functionality for supplied organizational
*               elements. It can be achieved with a call to this CLASS
*               in the calling program for supplied input parameters.
*               Activation entries must be maintained in the
*               configuration table 'ZSWL_C1_SWITCHFW'.
*               Any and all inactive entry will be treated out-of-scope.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-08-15 ¦ B7GOKHN          ¦ Initial version
*
************************************************************************

*    " ------------------------------------------ "
*    "  Local Declarations..
*    " ------------------------------------------ "
*
*    DATA : lv_message TYPE string.                          "#EC NEEDED
*
*    " ------------------------------------------ "
*    "  Processing Logic..
*    " ------------------------------------------ "
*
*    " Clear objects global private data holders..
*    CLEAR : mt_c1_switchfw[],
*            mv_programm,
*            mv_formname,
*            mv_key_field,
*            mv_val1,
*            mv_val2,
*            mv_val3.
*
*    " Get the input parameters to set global data..
*    mv_programm = iv_programm.
*    mv_formname = iv_formname.
*
*    IF iv_key1 IS NOT INITIAL AND
*       iv_key2 IS NOT INITIAL AND
*       iv_key3 IS NOT INITIAL.
*      mv_val1 = iv_val1.
*      mv_val2 = iv_val2.
*      mv_val3 = iv_val3.
*      " Formulate the key fields list..
*      CONCATENATE : iv_key1
*                    iv_key2
*                    iv_key3
*                    INTO mv_key_field
*                    SEPARATED BY mc_fslash.
*    ELSEIF iv_key1 IS NOT INITIAL AND
*           iv_key2 IS NOT INITIAL AND
*           iv_key3 IS INITIAL.
*      mv_val1 = iv_val1.
*      mv_val2 = iv_val2.
*      " Formulate the key fields list..
*      CONCATENATE : iv_key1
*                    iv_key2
*                    INTO mv_key_field
*                    SEPARATED BY mc_fslash.
*    ELSEIF iv_key1 IS NOT INITIAL AND
*           iv_key2 IS INITIAL AND
*           iv_key3 IS INITIAL.
*      mv_val1 = iv_val1.
*      " Formulate the key & value lists..
*      mv_key_field = iv_key1.
*    ELSE.
*      MESSAGE e200(zswl_ca) INTO lv_message.
*      zcx_ewm_general_exception=>raise_system_exception( ).
*    ENDIF.
*
*    CONDENSE mv_key_field NO-GAPS.

  ENDMETHOD.


METHOD execute_check.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-08-15 ¦ B7GOKHN          ¦ Initial version
*
************************************************************************

    " ------------------------------------------ "
    "  Processing Logic..
    " ------------------------------------------ "

*    " Initialize exporting parameters..
*    CLEAR : ev_active,
*            et_fun_module[].
*    " Check upfront within the selected dataset..
*    IF mt_c1_switchfw[] IS NOT INITIAL.
*      me->check_activation(
*        IMPORTING
*          ev_active     = ev_active
*          et_fun_module = et_fun_module[] ).
*    ENDIF.
*    IF ev_active IS INITIAL.
*      " Get the activation data maintained..
*      me->get_data( ).
*      " Check activation criteria..
*      me->check_activation(
*        IMPORTING
*          ev_active     = ev_active
*          et_fun_module = et_fun_module[] ).
*    ENDIF.

  ENDMETHOD.


METHOD get_data.
************************************************************************
* REVISIONS:
* ---------
*
* Version ¦ Date       ¦ Author           ¦ Description
* ------- ¦ ---------- ¦ ---------------- ¦ ----------------------------
* 1.0     ¦ 2016-08-15 ¦ B7GOKHN          ¦ Initial version
*
************************************************************************

    " ------------------------------------------ "
    "  Processing Logic..
    " ------------------------------------------ "
*
*    " Select the maintained switch framework activation entries..
*    SELECT * APPENDING TABLE mt_c1_switchfw[]
*             FROM zswl_c1_switchfw
*             WHERE programm = mv_programm
*             AND formname = mv_formname
*             AND key_fields = mv_key_field
*             AND active = abap_true.
*    IF sy-subrc = 0.
*      SORT mt_c1_switchfw[] BY programm formname counter key_fields key_values.
*      DELETE ADJACENT DUPLICATES FROM mt_c1_switchfw[]
*                                 COMPARING programm formname counter key_fields key_values.
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
