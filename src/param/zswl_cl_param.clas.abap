class ZSWL_CL_PARAM definition
  public
  final
  create public .

public section.

  interfaces ZSWL_IF_PARAM_C .

  constants GC_TYPE_RANGE type ZSWL_DE_PARAM_TYPE value 'R' ##NO_TEXT.
  constants GC_TYPE_LIST type ZSWL_DE_PARAM_TYPE value 'L' ##NO_TEXT.
  constants GC_TYPE_CONSTANT type ZSWL_DE_PARAM_TYPE value 'C' ##NO_TEXT.

  class-methods CLASS_CONSTRUCTOR .
  class-methods READ_CONST
    importing
      !IV_LGNUM type /SCWM/LGNUM optional
      !IV_CONTEXT type ZSWL_DE_PARAM_ID1
      !IV_PARAMETER type ZSWL_DE_PARAM_ID2
    returning
      value(RV_VALUE) type ZSWL_DE_PARAM_LOW .
  class-methods READ_CONST_LIST
    importing
      !IV_LGNUM type /SCWM/LGNUM optional
      !IV_CONTEXT type ZSWL_DE_PARAM_ID1
      !IV_PARAMETER type ZSWL_DE_PARAM_ID2
    returning
      value(RT_LIST) type ZSWL_TT_PARAM_LIST .
  class-methods READ_CONST_RANGE
    importing
      !IV_LGNUM type /SCWM/LGNUM optional
      !IV_CONTEXT type ZSWL_DE_PARAM_ID1
      !IV_PARAMETER type ZSWL_DE_PARAM_ID2
    returning
      value(RT_RANGE) type RSELOPTION .
protected section.
private section.

  class-data ST_PARAMETER_CUST type ZSWL_TT_PARAM_CUST .
  class-data ST_PARAMETER_MD type ZSWL_TT_PARAM_MD .
ENDCLASS.



CLASS ZSWL_CL_PARAM IMPLEMENTATION.


  METHOD class_constructor.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Initialisation of global attributes
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
    BREAK-POINT ID zswl_param.

    SELECT * FROM zswl_t_parc
      INTO TABLE @st_parameter_cust.                     "#EC CI_SUBRC.

    ASSERT ID zswl_param CONDITION sy-subrc <> 0.

    SELECT * FROM zswl_t_parmd
      INTO TABLE @st_parameter_md.                        "#EC CI_SUBRC

    ASSERT ID zswl_param CONDITION sy-subrc <> 0.
  ENDMETHOD.


    METHOD read_const.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Read constant calue
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

      BREAK-POINT ID zswl_param.

      TRY.
          rv_value = st_parameter_md[ lgnum = iv_lgnum id1 = iv_context id2 = iv_parameter type = gc_type_constant ]-low.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.

      IF rv_value IS NOT INITIAL.
        RETURN.
      ENDIF.

      TRY.
          rv_value = st_parameter_cust[ lgnum = iv_lgnum id1 = iv_context id2 = iv_parameter type = gc_type_constant ]-low.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.

    ENDMETHOD.


  METHOD read_const_list.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Read constant value list
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
    BREAK-POINT ID zswl_param.

    rt_list = VALUE #( FOR <ls_param_md> IN st_parameter_md
                       WHERE ( lgnum = iv_lgnum
                        AND id1 = iv_context
                        AND id2 = iv_parameter
                        AND type = gc_type_list )
                        ( <ls_param_md>-low ) ).

    IF rt_list IS NOT INITIAL.
      RETURN.
    ENDIF.

    rt_list = VALUE #( FOR <ls_param_cust> IN st_parameter_cust
                       WHERE ( lgnum = iv_lgnum
                        AND id1 = iv_context
                        AND id2 = iv_parameter
                        AND type = gc_type_list )
                        ( <ls_param_cust>-low ) ).
  ENDMETHOD.


  METHOD read_const_range.
*---------------------------------------------------------------------*
* Subject            : Parameter framework
*                      Read constant value range
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
    BREAK-POINT ID zswl_param.

    rt_range = VALUE #( FOR <ls_param_md> IN st_parameter_md
                       WHERE (  lgnum = iv_lgnum
                         AND    id1 = iv_context
                         AND    id2 = iv_parameter
                         AND type = gc_type_range )
                        ( sign = <ls_param_md>-sign
                          option = <ls_param_md>-opt
                          low = <ls_param_md>-low
                          high = <ls_param_md>-high ) ).

    IF rt_range IS NOT INITIAL.
      RETURN.
    ENDIF.

    rt_range = VALUE #( FOR <ls_param_cust> IN st_parameter_cust
                       WHERE (  lgnum = iv_lgnum
                         AND    id1 = iv_context
                         AND    id2 = iv_parameter
                         AND type = gc_type_range )
                        ( sign = <ls_param_cust>-sign
                          option = <ls_param_cust>-opt
                          low = <ls_param_cust>-low
                          high = <ls_param_cust>-high ) ).
  ENDMETHOD.
ENDCLASS.
