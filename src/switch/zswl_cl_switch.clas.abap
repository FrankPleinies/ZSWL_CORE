class ZSWL_CL_SWITCH definition
  public
  final
  create private .

public section.

  types:
      "Field names which should be provided by the caller,
      "for the wanted 'combination'
    BEGIN OF ts_req_f ,
        field TYPE zswl_de_dyn_field,
      END OF ts_req_f .
  types:
    BEGIN OF tth_req_f ,
        field TYPE zswl_de_dyn_field,
      END OF tth_req_f .

  constants GC_USER_NAME type CHAR5 value 'UNAME' ##NO_TEXT.
  data GV_LGNUM type /SCWM/LGNUM read-only .
  data GV_IPNUM type ZSWL_DE_IPNUM read-only .

  methods CONSTRUCTOR
    importing
      !IV_LGNUM type /SCWM/LGNUM
      !IV_IPNUM type ZSWL_DE_IPNUM .
  class-methods GET_SWITCH_STATE
    importing
      !IV_LGNUM type /SCWM/LGNUM
      !IV_IPNUM type ZSWL_DE_IPNUM
      !IT_FIELDS type ZSWL_TT_SW_FIELDS optional
    returning
      value(RV_STATE) type BOOLE_D .
protected section.
private section.

  types TS_INSTANCE type ref to ZSWL_CL_SWITCH .
  types:
    tt_instance TYPE STANDARD TABLE OF ts_instance .

  data GV_NOT_EXISTING_CUSTOMIZING type SY-SUBRC value 0 ##NO_TEXT.
  data GS_SW_ACT type ZSWL_T_SW_ACT .
  data GT_CRITERIA type ZSWL_TT_SW_CRIT .
  class-data ST_INSTANCE type TT_INSTANCE .

  class-methods GET_INSTANCE
    importing
      !IV_LGNUM type /SCWM/LGNUM
      !IV_IPNUM type ZSWL_DE_IPNUM
    returning
      value(RO_INSTANCE) type ref to ZSWL_CL_SWITCH .
  methods GET_STATE
    importing
      !IT_FIELDS type ZSWL_TT_SW_FIELDS optional
    returning
      value(RV_STATE) type BOOLE_D .
ENDCLASS.



CLASS ZSWL_CL_SWITCH IMPLEMENTATION.


  METHOD constructor.
*---------------------------------------------------------------------*
* Subject            : Load the customizing for the importing IPnum
*                      implementation number and warehouse
* From               : Grigor Grigorov
* Date               : 02.08.2018
* Transport order    :
* Ticket             :
* EWM-Id             : EWMC001
* EWM-Task           : 0071
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*

    BREAK-POINT ID zswl_switch.

    gv_ipnum = iv_ipnum.
    gv_lgnum = iv_lgnum.

    "Take make table with act/inact status for current instance
    "(import parameters)
    SELECT SINGLE * FROM zswl_t_sw_act
      WHERE lgnum = @iv_lgnum
        AND ipnum = @iv_ipnum
        INTO @gs_sw_act.

    IF sy-subrc = 0.
      "Take the second table with the additional criteria if provided (not obligotary)
      SELECT * FROM zswl_t_sw_crit                       "#EC CI_SUBRC
        WHERE lgnum = @iv_lgnum
          AND ipnum = @iv_ipnum
          AND xactive = @abap_true
          INTO TABLE @gt_criteria.                      "#EC CI_GENBUFF

    ELSE.
      gv_not_existing_customizing = 1.
    ENDIF.

  ENDMETHOD.


  METHOD get_instance.
*-----------------------------------------------------------------------------*
* Subject            : Create instance for imported warehouse number and
*                     implementation number or return already instantiate one
* From               : Grigor Grigorov
* Date               : 02.08.2018
* Transport order    :
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC001
* EWM-Task           : 0071
*-----------------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*-----------------------------------------------------------------------------*

    FIELD-SYMBOLS <ls_instance> LIKE LINE OF st_instance.

    "take already loaded object for this switch parameters if exist
    LOOP AT st_instance ASSIGNING <ls_instance>.
      IF iv_lgnum = <ls_instance>->gv_lgnum AND iv_ipnum = <ls_instance>->gv_ipnum.
        ro_instance = <ls_instance>.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF ro_instance IS BOUND.
      RETURN.
    ENDIF.

    "Create instance and add it to the global object table
    ro_instance = NEW #( iv_lgnum = iv_lgnum iv_ipnum = iv_ipnum ).

    IF ro_instance->gv_not_existing_customizing = 0.
      APPEND ro_instance TO st_instance.
    ELSE.
      CLEAR ro_instance.
    ENDIF.

  ENDMETHOD.


  METHOD get_state.
*---------------------------------------------------------------------*
* Subject            : Switch framework
*                      Calculate switch state
* From               : Grigor Grigorov
* Date               : 02.08.2018
* Transport order    : EWDK900069
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC001
* EWM-Task           : 0071
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*

    DATA: lt_fields        TYPE zswl_tt_sw_fields,
          lt_req_fields    TYPE HASHED TABLE OF tth_req_f WITH UNIQUE KEY field,
          ls_req_fields    TYPE ts_req_f,
          lv_user_fg       TYPE bool VALUE abap_false,
          lv_user_found_fg TYPE bool VALUE abap_false.
    "Fields with the additional configuration
    "if provided by the caller
    lt_fields = it_fields.

    "Set the act/inact Status from the main table
    rv_state = gs_sw_act-xactive.

    " check if top level switch is not active
    IF gs_sw_act-xactive = abap_false.
      RETURN.
    ENDIF.

    "When there is no additional configuration,
    "we will just return the above assigned status and exit here
    IF gt_criteria IS INITIAL.
      RETURN.
    ENDIF.

    "Additional implementation to make possible that the code is execute
    "only for single user/s
    LOOP AT gt_criteria ASSIGNING FIELD-SYMBOL(<ls_criteria>)
      WHERE field = zswl_cl_switch=>gc_user_name
        AND xactive = abap_true.

      lv_user_fg = abap_true.
      IF <ls_criteria>-field_value = sy-uname.
        lv_user_found_fg = abap_true.
        EXIT.
      ENDIF.
    ENDLOOP.

    "When active 'UNAME' is found, this mean that the switch should be executed
    "only for the mentioned user otherwise return not active state
    IF lv_user_fg = abap_true AND lv_user_found_fg = abap_false.
      rv_state = abap_false.
      "EXIT.
      RETURN.
    ENDIF.

    " Loop the provided fields from the caller
    LOOP AT lt_fields ASSIGNING FIELD-SYMBOL(<ls_fields>) GROUP BY <ls_fields>-combination.

      "For every COMBINATION we took every field name once
      "because we want later to check if the caller provide
      "values for all fields in the combination group
      CLEAR lt_req_fields.
      LOOP AT gt_criteria ASSIGNING FIELD-SYMBOL(<ls_crit>)
                          WHERE combination = <ls_fields>-combination
                            AND field NE 'UNAME'.        "#EC CI_STDSEQ

        ls_req_fields-field = <ls_crit>-field.
        COLLECT ls_req_fields INTO lt_req_fields.
      ENDLOOP.

      "Loop all fields from the current combination
      LOOP AT GROUP <ls_fields> INTO DATA(ls_fld).

        "Check if the value of the current field have match in the criteria table
        READ TABLE gt_criteria
        WITH KEY field = ls_fld-field field_value = ls_fld-field_value
        TRANSPORTING NO FIELDS.                          "#EC CI_STDSEQ
        IF sy-subrc = 0.
          rv_state = abap_true.
          "when all fields for one combination have match
          "the lt_req_fields at the end should be empty
          DELETE lt_req_fields WHERE field = ls_fld-field. "#EC CI_STDSEQ
        ELSE.
          "We expect that in one combination group all fields should match,
          "So if single one did not match set inactive status
          rv_state = abap_false.
          EXIT.
        ENDIF.

      ENDLOOP.

      "If all needed fields are provided by the caller, than this should be empty
      DESCRIBE TABLE lt_req_fields LINES DATA(lv_req_lines).

      IF lv_req_lines = 0 AND rv_state = abap_true.
        "When one combination group match, this is enough to exit with active status
        rv_state = abap_true.
        EXIT.
      ELSE.
        "Set inactive state for current combination and check the next one if exist
        rv_state = abap_false.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_switch_state.
*---------------------------------------------------------------------*
* Subject            : Switch framework
*                      Check state for current switch option
* From               : Grigor Grigorov
* Date               : 02.08.2018
* Transport order    : EWDK900069
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC001
* EWM-Task           : 0071
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*

    BREAK-POINT ID zswl_switch.

    " Create object from already existing reference or create new one
    DATA(lo_switch) = zswl_cl_switch=>get_instance(
                                            iv_lgnum = iv_lgnum
                                            iv_ipnum = iv_ipnum
                                            ).

    IF lo_switch IS BOUND.
      rv_state = lo_switch->get_state( it_fields = it_fields ).
    ELSE.
      "If there is No existing configuration for provided IV_LGNUM and IV_IPNUM
      " return inactive status
      rv_state = abap_false.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
