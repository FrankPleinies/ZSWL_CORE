*&---------------------------------------------------------------------*
*&  Include           ZSWLBLOF03
*&---------------------------------------------------------------------*
TABLES:
  baldat.
FIELD-SYMBOLS:
  <g_t_baldat>   TYPE baldat_t,
  <g_s_db>       TYPE bal_s_db.
DATA:
  g_baldat       TYPE baldat,
  g_last_srtf2   TYPE baldat-srtf2.


*&---------------------------------------------------------------------*
*&      Form  log_compress
*&---------------------------------------------------------------------*
FORM log_compress
       USING
         i_time_stamp     TYPE balhdr-tim_stmp
       CHANGING
         c_s_ldat         TYPE bal_s_ldat
         c_s_db           TYPE bal_s_db.


  DATA:
    l_balhdr              TYPE balhdr,
    l_s_par2              TYPE bal_s_par2,
    l_s_message_block     TYPE bal_s_msgs,
    l_s_block             TYPE bal_s_blch,
    l_msgnum_min          TYPE balmnr,
    l_msgnum_max          TYPE balmnr,
    l_start_tabix         TYPE i,
    l_end_tabix           TYPE i,
    l_s_mhdr              TYPE bal_s_mhdr,
    l_count               TYPE i.
  FIELD-SYMBOLS:
    <l_s_par>             TYPE bal_s_par.

*********************************************************************
* fill header data (BALHDR)
*********************************************************************
  macro_statistics_problemclass c_s_ldat-sdat-counts.
  CLEAR l_balhdr.
  MOVE-CORRESPONDING c_s_ldat-log TO l_balhdr.
  l_balhdr-mandant    = c_s_ldat-admin-client.
  l_balhdr-lognumber  = c_s_ldat-admin-lognumber.
  l_balhdr-last_msgnr = c_s_ldat-admin-last_msgnr.
  l_balhdr-client_cre = c_s_ldat-admin-client_cre.
  l_balhdr-db_version = c_s_ldat-admin-db_version.
  l_balhdr-tim_stmp   = i_time_stamp.
  l_balhdr-log_handle = c_s_ldat-log_handle.
  l_balhdr-altext     = c_s_ldat-log-params-altext.
  l_balhdr-userexitp  = c_s_ldat-log-params-callback-userexitp.
  l_balhdr-userexitf  = c_s_ldat-log-params-callback-userexitf.
  l_balhdr-userexitt  = c_s_ldat-log-params-callback-userexitt.
  l_balhdr-tabname    = c_s_ldat-log-context-tabname.
  l_balhdr-msg_cnt_al = c_s_ldat-sdat-counts-msg_cnt_al.
  l_balhdr-msg_cnt_a  = c_s_ldat-sdat-counts-msg_cnt_a.
  l_balhdr-msg_cnt_e  = c_s_ldat-sdat-counts-msg_cnt_e.
  l_balhdr-msg_cnt_w  = c_s_ldat-sdat-counts-msg_cnt_w.
  l_balhdr-msg_cnt_i  = c_s_ldat-sdat-counts-msg_cnt_i.
  l_balhdr-msg_cnt_s  = c_s_ldat-sdat-counts-msg_cnt_s.
  l_balhdr-msg_cnt_p1 = c_s_ldat-sdat-counts-msg_cnt_p1.
  l_balhdr-msg_cnt_p2 = c_s_ldat-sdat-counts-msg_cnt_p2.
  l_balhdr-msg_cnt_p3 = c_s_ldat-sdat-counts-msg_cnt_p3.
  l_balhdr-msg_cnt_p4 = c_s_ldat-sdat-counts-msg_cnt_p4.
  l_balhdr-probclass  = c_s_ldat-sdat-counts-msg_max_pc.
  l_balhdr-char_size  = c_s_ldat-admin-char_size.
  IF c_s_ldat-admin-is_on_db = false.
    INSERT l_balhdr INTO TABLE c_s_db-balhdr_i.
  ELSE.
    INSERT l_balhdr INTO TABLE c_s_db-balhdr_u.
  ENDIF.


*********************************************************************
* create a block for context and parameters of log header
*********************************************************************
  CLEAR l_s_message_block.
  IF NOT c_s_ldat-log-context IS INITIAL OR
     NOT c_s_ldat-log-params IS INITIAL.
    CLEAR g_s_1301.
    g_s_1301-msgnumber = const_bal_header_block.
    MOVE-CORRESPONDING c_s_ldat-log-context TO g_s_1301-context.
    MOVE-CORRESPONDING c_s_ldat-log-params  TO g_s_1301-params.
    INSERT g_s_1301 INTO TABLE l_s_message_block-t_1301.
    LOOP AT c_s_ldat-log-params-t_par ASSIGNING <l_s_par>.
      l_s_par2-msgnumber = const_bal_header_block.
      l_s_par2-parnumber = sy-tabix.
      l_s_par2-parname   = <l_s_par>-parname.
      l_s_par2-parvalue  = <l_s_par>-parvalue.
      INSERT l_s_par2 INTO TABLE l_s_message_block-t_par2.
    ENDLOOP.
  ENDIF.
* compress header block
  PERFORM log_block_compress
            USING
              const_bal_header_block
              l_s_message_block
              c_s_ldat
            CHANGING
              c_s_db
              c_s_ldat-admin-t_block_db.


***********************************************************************
* find out which blocks have been changed
***********************************************************************
  IF c_s_ldat-admin-is_on_db = true.
*  all changed blocks have already been recorded in
*  the internal table c_s_ldat-admin-t_block_ch
  ELSE.
*   all messages are new. find out which blocks are involved
*   get highest message number
    DESCRIBE TABLE c_s_ldat-messages-t_mhdr LINES l_count.
    READ TABLE c_s_ldat-messages-t_mhdr INTO l_s_mhdr INDEX l_count.
    IF l_count > 0.
      c_s_ldat-admin-last_msgnr = l_s_mhdr-msgnumber.
*     get maximum number of blocks
      macro_get_block l_s_mhdr-msgnumber l_count.
    ENDIF.
*   create table of blocks
    CLEAR c_s_ldat-admin-t_block_ch.
    CLEAR l_s_block.
    DO l_count TIMES.
      l_s_block-block = sy-index.
      INSERT l_s_block INTO TABLE c_s_ldat-admin-t_block_ch.
    ENDDO.
  ENDIF.


***********************************************************************
* compress messages into table BALDAT
***********************************************************************
  LOOP AT c_s_ldat-admin-t_block_ch INTO l_s_block
                                  WHERE block NE const_bal_header_block.

*   define start end end number of this block of 1000 messages
    l_msgnum_min = const_bal_block_size * ( l_s_block-block - 1 ).
    l_msgnum_max = const_bal_block_size * ( l_s_block-block ).

*   extract a block of 1000 messages from log:
*   define a little macro to extract 1000 entries from a table
    DEFINE macro_extract_table_entries.
      read table c_s_ldat-messages-t_&1&2&3&4 transporting no fields
                 with key msgnumber = l_msgnum_min.
      l_start_tabix = sy-tabix.
      read table c_s_ldat-messages-t_&1&2&3&4 transporting no fields
                 with key msgnumber = l_msgnum_max.
      l_end_tabix = sy-tabix - 1.
      if l_start_tabix > 0 and l_start_tabix <= l_end_tabix.
        append lines of c_s_ldat-messages-t_&1&2&3&4
               from l_start_tabix to l_end_tabix
               to l_s_message_block-t_&1&2&3&4.
      endif.
    END-OF-DEFINITION.
*   extract 1000 entries from all tables and put them into this block
    CLEAR l_s_message_block.
    macro_execute macro_extract_table_entries.
    macro_extract_table_entries:
      m h d r,
      p a r 1,
      p a r 2.

*   compress this message block
    PERFORM log_block_compress
              USING
                l_s_block-block
                l_s_message_block
                c_s_ldat
              CHANGING
                c_s_db
                c_s_ldat-admin-t_block_db.

  ENDLOOP.


***********************************************************************
* set status of log on 'saved'
***********************************************************************
  c_s_ldat-admin-tim_stmp      = i_time_stamp.
  c_s_ldat-admin-is_on_db      = true.
  c_s_ldat-admin-changed       = false.
  c_s_ldat-admin-db_version    = const_bal_db_ver_current.
  c_s_ldat-admin-last_msgnr_db = c_s_ldat-admin-last_msgnr.
  CLEAR c_s_ldat-admin-t_block_ch.


ENDFORM.                    "log_compress

*---------------------------------------------------------------------*
*       FORM log_block_compress                                       *
*---------------------------------------------------------------------*
FORM log_block_compress
       USING
         i_block                TYPE baldat-block
         i_s_block              TYPE bal_s_msgs
         i_s_ldat               TYPE bal_s_ldat
       CHANGING
         c_s_db                 TYPE bal_s_db
         c_t_block_db           TYPE bal_t_bldb.

  DATA:
    l_s_block_db                TYPE bal_s_bldb,
    BEGIN OF l_t_tables OCCURS 50,
      name(10)                  TYPE c,
      itabname(50)              TYPE c,
    END   OF l_t_tables.
  FIELD-SYMBOLS:
    <l_s_block_db>              TYPE bal_s_bldb.



********************************************************************
* set global data for FORM baldat_export
********************************************************************
* set pointer to database tables
  ASSIGN ('C_S_DB') TO <g_s_db>.
* point to entry showing number of lines on db for this block
  READ TABLE c_t_block_db ASSIGNING <l_s_block_db>
             WITH KEY block = i_block.
  IF sy-subrc NE 0.
    l_s_block_db-block     = i_block.
    l_s_block_db-max_srtf2 = -1.
    INSERT l_s_block_db INTO TABLE c_t_block_db.
    READ TABLE c_t_block_db ASSIGNING <l_s_block_db>
               WITH KEY block = i_block.
  ENDIF.
* set basic data for the key of table baldat
  CLEAR g_baldat.
  g_baldat-mandant    = i_s_ldat-admin-client.
  g_baldat-relid      = 'AL'.
  g_baldat-log_handle = i_s_ldat-log_handle.
  g_baldat-block      = i_block.
  g_baldat-srtf2      = <l_s_block_db>-max_srtf2.
* initialze entry for the last line which was created
  g_last_srtf2        = -1.


********************************************************************
* compress data
********************************************************************
  IF NOT i_s_block IS INITIAL.

*   find out which tables have to be exported:
*   - define a little macro to add table name to l_t_tables
    DEFINE lmacro_add_export_table.
      l_t_tables-name     = 'T_&1&2&3&4'.
      l_t_tables-itabname = 'I_S_BLOCK-T_&1&2&3&4'.
      append l_t_tables.
    END-OF-DEFINITION.
*   - analyse all tables of this block
    macro_execute: lmacro_add_export_table.
    lmacro_add_export_table:
      m h d r,
      p a r 1,
      p a r 2.

*   now compress this block using the EXPORT statement
    EXPORT           (l_t_tables)
      TO DATABASE    baldat(al)
      ID             i_s_ldat-log_handle
      USING          baldat_export.

  ENDIF.


********************************************************************
* add those lines which are to be deleted from DB
********************************************************************
  IF g_last_srtf2 < <l_s_block_db>-max_srtf2.
    g_baldat-srtf2 = g_last_srtf2.
    DO.
      ADD 1 TO g_baldat-srtf2.
      APPEND g_baldat TO c_s_db-baldat_d.
      IF g_baldat-srtf2 >= <l_s_block_db>-max_srtf2.
        EXIT.
      ENDIF.
    ENDDO.
  ENDIF.


********************************************************************
* update entry showing number of lines for this block
********************************************************************
  IF g_last_srtf2 = -1.
    DELETE c_t_block_db WHERE block = i_block.
  ELSE.
    <l_s_block_db>-max_srtf2 = g_last_srtf2.
  ENDIF.


ENDFORM.                    "log_block_compress
*---------------------------------------------------------------------*
* FORM baldat_export
*---------------------------------------------------------------------*
* This form is used be the EXPORT statement
*---------------------------------------------------------------------*
FORM baldat_export
       USING
         mode TYPE c.

  baldat-mandant    = g_baldat-mandant.
  baldat-relid      = g_baldat-relid.
  baldat-log_handle = g_baldat-log_handle.
  baldat-block      = g_baldat-block.
  IF baldat-srtf2 <= g_baldat-srtf2.
    APPEND baldat TO <g_s_db>-baldat_u.
  ELSE.
    APPEND baldat TO <g_s_db>-baldat_i.
  ENDIF.
  g_last_srtf2 = baldat-srtf2.

ENDFORM.                    "baldat_export
