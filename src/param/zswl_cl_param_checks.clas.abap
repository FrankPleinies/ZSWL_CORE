class ZSWL_CL_PARAM_CHECKS definition
  public
  final
  create public .

public section.

  interfaces ZSWL_IF_PARAM_C .

  types:
    BEGIN OF ts_param_tab,
        absolute_name TYPE abap_abstypename,
        value         TYPE char40,
      END OF ts_param_tab .
  types:
    tth_param_tab TYPE HASHED TABLE OF ts_param_tab WITH UNIQUE KEY absolute_name value .

  class-methods CLASS_CONSTRUCTOR .
  class-methods CHECK_PARC_CREATE_NEW
    importing
      !IS_PARC type ZSWL_V_PARC
    raising
      YCX_EWM_GENERAL_EXCEPTION .
  class-methods CHECK_PARMD_CREATE_NEW
    importing
      !IS_PARMD type ZSWL_V_PARMD
    raising
      YCX_EWM_GENERAL_EXCEPTION .
  class-methods CHECK_PARDF_CREATE_NEW
    importing
      !IS_PARDF type ZSWL_V_PARDF
    raising
      YCX_EWM_GENERAL_EXCEPTION .
  PRIVATE SECTION.

    CONSTANTS gc_usage_type_c_md TYPE zswl_de_param_usage_type VALUE '2' ##NO_TEXT.
    CLASS-DATA st_parameter_md TYPE tth_param_tab .
    CLASS-DATA sv_id1_absolute_name TYPE abap_abstypename .
    CLASS-DATA sv_id2_absolute_name TYPE abap_abstypename .
ENDCLASS.



CLASS ZSWL_CL_PARAM_CHECKS IMPLEMENTATION.


  METHOD check_parc_create_new.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Check at new entry for parameter customizing
* From               : Dzmitry Hrynevich
* Date               : 27.02.2018
* Transport order    : EWDK900071
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC002
* EWM-Task           : 0072
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*

    DATA: ls_param_def TYPE zswl_t_pardf ##NEEDED, "needed for dest.str in selection
          lv_dummy     TYPE string ##NEEDED. "needed for exception handling

    BREAK-POINT ID zswl_param.

    IF is_parc-id1 IS INITIAL
      OR is_parc-id2 IS INITIAL
      OR is_parc-lgnum IS INITIAL
      OR is_parc-seqno IS INITIAL.
      MESSAGE e002 INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.

    SELECT * FROM zswl_t_pardf
      WHERE id1 = @is_parc-id1
        AND id2 = @is_parc-id2
        INTO @ls_param_def UP TO 1 ROWS.
    ENDSELECT.

    IF sy-subrc  <> 0.
      MESSAGE e001 WITH is_parc-id1
                        is_parc-id1
                   INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.
  ENDMETHOD.


  METHOD check_pardf_create_new.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Check at new entry for parameter definition
* From               : Dzmitry Hrynevich
* Date               : 27.02.2018
* Transport order    : EWDK900071
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC002
* EWM-Task           : 0072
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*
    DATA: lv_dummy TYPE string ##NEEDED. "needed for exception handling

    BREAK-POINT ID zswl_param.

    IF is_pardf-id1 IS INITIAL
      OR is_pardf-id2 IS INITIAL
      OR is_pardf-usage_type IS INITIAL.
      MESSAGE e002 INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.

    IF NOT line_exists( st_parameter_md[ absolute_name = sv_id1_absolute_name
                                      value = is_pardf-id1 ] ).
      MESSAGE e004 WITH is_pardf-id1 INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.

    IF NOT line_exists( st_parameter_md[ absolute_name = sv_id2_absolute_name
                                      value = is_pardf-id2 ] ).
      MESSAGE e005 WITH is_pardf-id2 INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.
  ENDMETHOD.


  METHOD check_parmd_create_new.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Check at new entry for parameter master data
* From               : Dzmitry Hrynevich
* Date               : 27.02.2018
* Transport order    : EWDK900071
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC002
* EWM-Task           : 0072
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*
    DATA: ls_param_def TYPE zswl_v_pardf,
          lv_dummy     TYPE string ##NEEDED. "needed for exception handling

    BREAK-POINT ID zswl_param.

    IF is_parmd-id1 IS INITIAL
      OR is_parmd-id2 IS INITIAL
      OR is_parmd-lgnum IS INITIAL
      OR is_parmd-seqno IS INITIAL.
      MESSAGE e002 INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.

    SELECT * FROM zswl_t_pardf
      WHERE id1 = @is_parmd-id1
        AND id2 = @is_parmd-id2
        INTO  @ls_param_def UP TO 1 ROWS.
    ENDSELECT.

    IF sy-subrc  <> 0.
      MESSAGE e001 WITH is_parmd-id1
                        is_parmd-id2
                   INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.

    IF ls_param_def-usage_type <> gc_usage_type_c_md.
      MESSAGE e003 WITH is_parmd-id1
                        is_parmd-id2
                   INTO lv_dummy.
      ycx_ewm_general_exception=>raise_sy_msg( ).
    ENDIF.
  ENDMETHOD.


  METHOD class_constructor.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Initialization of global attributes
* From               : Dzmitry Hrynevich
* Date               : 27.02.2018
* Transport order    : EWDK900071
* Ticket             : 253808 (EWM in plant Weil a.Rhein)
* EWM-Id             : EWMC002
* EWM-Task           : 0072
*---------------------------------------------------------------------*
* Modification       :
* From               :
* Date               :
* Transport order    :
* Ticket             :
*---------------------------------------------------------------------*

    DATA:
      lx_typedesc_const TYPE REF TO cl_abap_typedescr,
      lx_classdesc      TYPE REF TO cl_abap_classdescr,
      ls_padf           TYPE zswl_t_pardf,
      lv_const_name     TYPE string.

    FIELD-SYMBOLS: <ls_val>       TYPE data.

    BREAK-POINT ID zswl_param.

    lx_classdesc = CAST cl_abap_classdescr( cl_abap_classdescr=>describe_by_object_ref(
                                            NEW zswl_cl_param_checks( ) ) ).


    LOOP AT lx_classdesc->attributes ASSIGNING FIELD-SYMBOL(<ls_attribute>).
      IF NOT (      <ls_attribute>-is_interface = abap_true
                AND <ls_attribute>-is_constant = abap_true ).
        CONTINUE.
      ENDIF.
      lv_const_name = <ls_attribute>-name.
      REPLACE '~' IN lv_const_name WITH '=>'.

      ASSIGN (lv_const_name) TO <ls_val>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      lx_typedesc_const = cl_abap_datadescr=>describe_by_data( <ls_val> ).
      COLLECT VALUE ts_param_tab( absolute_name = lx_typedesc_const->absolute_name
                                  value = CONV #( <ls_val> ) )
                                  INTO st_parameter_md.
    ENDLOOP.

    lx_typedesc_const = cl_abap_datadescr=>describe_by_data( ls_padf-id1 ).
    sv_id1_absolute_name = lx_typedesc_const->absolute_name.

    lx_typedesc_const = cl_abap_datadescr=>describe_by_data( ls_padf-id2 ).
    sv_id2_absolute_name = lx_typedesc_const->absolute_name.
  ENDMETHOD.
ENDCLASS.
