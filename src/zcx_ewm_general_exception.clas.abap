CLASS zcx_ewm_general_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES if_t100_dyn_msg .
  INTERFACES if_t100_message .

  CONSTANTS write__no_balid TYPE sotr_conc VALUE '00505694009E1EE28CFF3029C95A8824' ##NO_TEXT.
  CONSTANTS write__no_subobj TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC626C824' ##NO_TEXT.
  CONSTANTS context_too_long TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC6270824' ##NO_TEXT.
  CONSTANTS write__no_protlvl TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC627A824' ##NO_TEXT.
  CONSTANTS para_descp_not_found TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC6278824' ##NO_TEXT.
  CONSTANTS para_values_not_found TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC6276824' ##NO_TEXT.
  CONSTANTS para_not_found TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC6274824' ##NO_TEXT.
  CONSTANTS no_lgnum_assigned TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC6272824' ##NO_TEXT.
  CONSTANTS write__no_balobj TYPE sotr_conc VALUE '00505694009E1EE28CFF30BBC626E824' ##NO_TEXT.
  DATA t100key TYPE scx_t100key READ-ONLY .
  DATA m_msgty TYPE symsgty .
  DATA m_msgv1 TYPE symsgv .
  DATA m_msgv2 TYPE symsgv .
  DATA m_msgv3 TYPE symsgv .
  DATA m_msgv4 TYPE symsgv .

  METHODS constructor
    IMPORTING
      !textid LIKE if_t100_message=>t100key OPTIONAL
      !previous LIKE previous OPTIONAL
      !t100key TYPE scx_t100key OPTIONAL
      !m_msgty TYPE symsgty OPTIONAL
      !m_msgv1 TYPE symsgv OPTIONAL
      !m_msgv2 TYPE symsgv OPTIONAL
      !m_msgv3 TYPE symsgv OPTIONAL
      !m_msgv4 TYPE symsgv OPTIONAL .
  CLASS-METHODS raise_exception
    IMPORTING
      !i_msgty TYPE symsgty OPTIONAL
      !i_msgid TYPE symsgid
      !i_msgno TYPE symsgno
      !i_msgv1 TYPE any OPTIONAL
      !i_msgv2 TYPE any OPTIONAL
      !i_msgv3 TYPE any OPTIONAL
      !i_msgv4 TYPE any OPTIONAL
    RAISING
      zcx_ewm_general_exception .
  CLASS-METHODS raise_system_exception
    RAISING
      zcx_ewm_general_exception .

  METHODS get_exception_message
    RETURNING
      VALUE(pr_result) TYPE string .

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcx_ewm_general_exception IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
CALL METHOD super->constructor
EXPORTING
previous = previous
.
me->t100key = t100key .
me->m_msgty = m_msgty .
me->m_msgv1 = m_msgv1 .
me->m_msgv2 = m_msgv2 .
me->m_msgv3 = m_msgv3 .
me->m_msgv4 = m_msgv4 .
CLEAR me->textid.
IF textid IS INITIAL.
  if_t100_message~t100key = if_t100_message=>default_textid.
ELSE.
  if_t100_message~t100key = textid.
ENDIF.
  ENDMETHOD.
  METHOD raise_exception.
    DATA:
 ref_exception                 TYPE REF TO zcx_ewm_general_exception.

    CREATE OBJECT ref_exception.
    CLEAR ref_exception->t100key.

    ref_exception->m_msgty       = i_msgty.
    ref_exception->t100key-msgid = i_msgid.
    ref_exception->t100key-msgno = i_msgno.
    ref_exception->t100key-attr1 = 'M_MSGV1'.
    ref_exception->t100key-attr2 = 'M_MSGV2'.
    ref_exception->t100key-attr3 = 'M_MSGV3'.
    ref_exception->t100key-attr4 = 'M_MSGV4'.

    WRITE:
      i_msgv1 TO ref_exception->m_msgv1 LEFT-JUSTIFIED,
      i_msgv2 TO ref_exception->m_msgv2 LEFT-JUSTIFIED,
      i_msgv3 TO ref_exception->m_msgv3 LEFT-JUSTIFIED,
      i_msgv4 TO ref_exception->m_msgv4 LEFT-JUSTIFIED.

    RAISE EXCEPTION ref_exception.
  ENDMETHOD.
    METHOD raise_system_exception.
     raise_exception(
    i_msgty = sy-msgty
    i_msgid = sy-msgid
    i_msgno = sy-msgno
    i_msgv1 = sy-msgv1
    i_msgv2 = sy-msgv2
    i_msgv3 = sy-msgv3
    i_msgv4 = sy-msgv4 ).
  ENDMETHOD.
    METHOD get_exception_message.

    IF me IS BOUND.
      cl_message_helper=>get_t100_text_for(
        EXPORTING
          obj     = me
          t100key = me->t100key
        IMPORTING
          result  = pr_result ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
