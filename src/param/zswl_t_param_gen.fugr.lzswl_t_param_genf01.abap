*----------------------------------------------------------------------*
***INCLUDE LZSWL_T_PARAM_GENF01.
*----------------------------------------------------------------------*
FORM z_parc_create_new.
  TRY.
      zswl_cl_param_checks=>check_parc_create_new( zswl_v_parc ).
    CATCH ycx_ewm_general_exception.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDTRY.
ENDFORM.

FORM z_parmd_create_new.
  TRY.
      zswl_cl_param_checks=>check_parmd_create_new( zswl_v_parmd ).
    CATCH ycx_ewm_general_exception.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDTRY.
ENDFORM.

FORM z_pardf_create_new.
  TRY.
      zswl_cl_param_checks=>check_pardf_create_new( zswl_v_pardf ).
    CATCH ycx_ewm_general_exception.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDTRY.
ENDFORM.
