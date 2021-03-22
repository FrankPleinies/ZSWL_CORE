class ZSWL_CL_PAL_STOCK_ADD definition
  public
  final
  create public .

public section.

  class-methods VALIDATE_PALLET
    importing
      !IS_SRC_HU_ITEM type /SCWM/S_HUITM_INT
      !IS_TRG_HU_HEADER type /SCWM/HUHDR
      !IV_LGNUM type /SCWM/LGNUM
    exporting
      !EV_FOUND type BOOLEAN
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
protected section.
private section.
ENDCLASS.



CLASS ZSWL_CL_PAL_STOCK_ADD IMPLEMENTATION.


METHOD validate_pallet.
    DATA: lt_prod_refs    TYPE zswl_tt_product_ref,
          ls_prod_ref     LIKE LINE OF lt_prod_refs,
          lt_mat_uom      TYPE /scwm/tt_material_uom,
          ls_mat_uom      LIKE LINE OF lt_mat_uom,
          lt_matid        TYPE /scwm/tt_matid,
          lv_num          TYPE f,
          lv_den          TYPE f,
          lv_weight       TYPE /scwm/de_quantity,
          lv_total_weight TYPE /scwm/de_quantity,
          lv_volume       TYPE /scwm/btvol,
          lv_total_volume TYPE /scwm/btvol,
          lv_length       TYPE laeng,
          lv_width        TYPE breit,
          lv_height       TYPE height,
          lt_matnr        TYPE /sapapo/matnr_tab,
          ls_matnr        LIKE LINE OF lt_matnr.

*          "Determine total weight and volume for product
    APPEND is_src_hu_item-matid TO lt_matid.
*      ls_matnr-matnr ='ROCHE-PS-001'.
*      APPEND ls_matnr  TO lt_matnr.
    zswl_cl_product=>read_product(
      EXPORTING
        i_lgnum = iv_lgnum
        i_read_uom = abap_true
            it_matid_r16 = lt_matid
*          it_matnr = lt_matnr
      IMPORTING
        et_prod_ref = lt_prod_refs ).

    READ TABLE lt_prod_refs INTO ls_prod_ref INDEX 1.
    lt_mat_uom = ls_prod_ref-o_product->get_mat_uom( ).
    READ TABLE lt_mat_uom INTO ls_mat_uom INDEX 1.

**********************************************************************
* Check weight
    CALL FUNCTION 'CONVERSION_FACTOR_GET'
      EXPORTING
        no_type_check        = 'X'
        unit_in              = ls_mat_uom-gewei
        unit_out             = is_src_hu_item-unit_w
      IMPORTING
        denominator          = lv_den
        numerator            = lv_num
      EXCEPTIONS
        conversion_not_found = 1
        overflow             = 2
        type_invalid         = 3
        units_missing        = 4
        unit_in_not_found    = 5
        unit_out_not_found   = 6
        OTHERS               = 7.
    IF sy-subrc = 0.
      lv_weight = ls_mat_uom-brgew.
      lv_weight = lv_weight * lv_num / lv_den.
      lv_weight = lv_weight * is_src_hu_item-quan.
    ENDIF.
*  ENDIF.

    "Determine total weight and volume for HU
    lv_total_weight = is_trg_hu_header-g_weight + lv_weight.
    IF lv_total_weight > is_trg_hu_header-max_weight.
      "Throw exceptiopn
    ENDIF.
**********************************************************************

**********************************************************************
* Check Volume
    CALL FUNCTION 'CONVERSION_FACTOR_GET'
      EXPORTING
        no_type_check        = 'X'
        unit_in              = ls_mat_uom-voleh
        unit_out             = is_src_hu_item-unit_v
      IMPORTING
        denominator          = lv_den
        numerator            = lv_num
      EXCEPTIONS
        conversion_not_found = 1
        overflow             = 2
        type_invalid         = 3
        units_missing        = 4
        unit_in_not_found    = 5
        unit_out_not_found   = 6
        OTHERS               = 7.
    IF sy-subrc = 0.
      lv_volume = ls_mat_uom-volum.
      lv_volume = lv_volume * lv_num / lv_den.
      lv_volume = lv_volume * is_src_hu_item-quan.
    ENDIF.
*  ENDIF.

    "Determine total weight and volume for HU
    lv_total_volume = is_trg_hu_header-g_volume + lv_volume.
    IF lv_total_volume > is_trg_hu_header-max_volume.
      "Throw exceptiopn
    ENDIF.

**********************************************************************

**********************************************************************
* Check Dimensions
    CALL FUNCTION 'CONVERSION_FACTOR_GET'
      EXPORTING
        no_type_check        = 'X'
        unit_in              = ls_mat_uom-meabm
        unit_out             = is_trg_hu_header-unit_lwh
      IMPORTING
        denominator          = lv_den
        numerator            = lv_num
      EXCEPTIONS
        conversion_not_found = 1
        overflow             = 2
        type_invalid         = 3
        units_missing        = 4
        unit_in_not_found    = 5
        unit_out_not_found   = 6
        OTHERS               = 7.
    IF sy-subrc = 0.
      lv_length = ls_mat_uom-laeng.
      lv_length = lv_length * lv_num / lv_den.
      lv_width = ls_mat_uom-breit.
      lv_width = lv_width * lv_num / lv_den.
      lv_height = ls_mat_uom-hoehe.
      lv_height = lv_height * lv_num / lv_den.

    ENDIF.
*  ENDIF.

    "Determine total weight and volume for HU
    IF lv_length > is_trg_hu_header-max_length.
      "Throw exceptiopn
    ENDIF.
    IF lv_width > is_trg_hu_header-max_width.
      "Throw exceptiopn
    ENDIF.
    IF lv_height > is_trg_hu_header-max_height.
      "Throw exceptiopn
    ENDIF.
**********************************************************************
  ENDMETHOD.
ENDCLASS.
