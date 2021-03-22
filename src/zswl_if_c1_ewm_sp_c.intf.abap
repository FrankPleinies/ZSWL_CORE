interface ZSWL_IF_C1_EWM_SP_C
  public .

  type-pools ABAP .
  type-pools WMEGC .

  constants MC_EVTLOG_APPLN_COMP_AS type ZSWL_DE_C1_EVTLOG_APPCOMP value 'AS' ##NO_TEXT.
  constants MC_EVTLOG_APPLN_COMP_MFS type ZSWL_DE_C1_EVTLOG_APPCOMP value 'MFS' ##NO_TEXT.
  constants MC_MSGTYPES_AE type CHAR2 value 'AE' ##NO_TEXT.
  constants MC_TELEGRAM_MO type /SCWM/DE_MFSTELETYPE value 'MO' ##NO_TEXT.
  constants MC_TELEGRAM_ST type /SCWM/DE_MFSTELETYPE value 'ST' ##NO_TEXT.
  constants MC_TELEGRAM_LV type /SCWM/DE_MFSTELETYPE value 'LV' ##NO_TEXT.
  constants MC_TELEGRAM_DI type /SCWM/DE_MFSTELETYPE value 'DI' ##NO_TEXT.
  constants MC_TELEGRAM_ARQ type /SCWM/DE_MFSTELETYPE value 'ARQ' ##NO_TEXT.
  constants MC_TELEGRAM_TOR type /SCWM/DE_MFSTELETYPE value 'TOR' ##NO_TEXT.
  constants MC_TELEGRAM_AMQ type /SCWM/DE_MFSTELETYPE value 'AMQ' ##NO_TEXT.
  constants MC_TELEGRAM_TRQ type /SCWM/DE_MFSTELETYPE value 'TRQ' ##NO_TEXT.
  constants MC_TELEGRAM_TSR type /SCWM/DE_MFSTELETYPE value 'TSR' ##NO_TEXT.
  constants MC_TELEGRAM_ACP type /SCWM/DE_MFSTELETYPE value 'ACP' ##NO_TEXT.
  constants MC_TELEGRAM_TTQ type /SCWM/DE_MFSTELETYPE value 'TTQ' ##NO_TEXT.
  constants MC_TELEGRAM_PRQ type /SCWM/DE_MFSTELETYPE value 'PRQ' ##NO_TEXT.
  constants MC_TELEGRAM_IPR type /SCWM/DE_MFSTELETYPE value 'IPR' ##NO_TEXT.
  constants MC_TELEGRAM_POR type /SCWM/DE_MFSTELETYPE value 'POR' ##NO_TEXT.
  constants MC_TELEGRAM_GSR type /SCWM/DE_MFSTELETYPE value 'GSR' ##NO_TEXT.
  constants MC_TELEGRAM_PSR type /SCWM/DE_MFSTELETYPE value 'PSR' ##NO_TEXT.
  constants MC_TELEGRAM_BSR type /SCWM/DE_MFSTELETYPE value 'BSR' ##NO_TEXT.
  constants MC_TELEGRAM_BRQ type /SCWM/DE_MFSTELETYPE value 'BRQ' ##NO_TEXT.
  constants MC_TELEGRAM_CSR type /SCWM/DE_MFSTELETYPE value 'CSR' ##NO_TEXT.
  constants MC_TELEGRAM_CRQ type /SCWM/DE_MFSTELETYPE value 'CRQ' ##NO_TEXT.
  constants MC_TELEGRAM_GRQ type /SCWM/DE_MFSTELETYPE value 'GRQ' ##NO_TEXT.
  constants MC_TELEGRAM_DUM type /SCWM/DE_MFSTELETYPE value 'DUM' ##NO_TEXT.
  constants MC_TELEGRAM_DUA type /SCWM/DE_MFSTELETYPE value 'DUA' ##NO_TEXT.
  constants MC_TELEGRAM_SYS type /SCWM/DE_MFSTELETYPE value 'SYS' ##NO_TEXT.
  constants MC_TELEGRAM_SYB type /SCWM/DE_MFSTELETYPE value 'SYB' ##NO_TEXT.
  constants MC_TELEGRAM_SYN type /SCWM/DE_MFSTELETYPE value 'SYN' ##NO_TEXT.
  constants MC_TELEGRAM_ACK type /SCWM/DE_MFSTELETYPE value 'ACK' ##NO_TEXT.
  constants MC_TELEGRAM_SDO type /SCWM/DE_MFSTELETYPE value 'SDO' ##NO_TEXT.
  constants MC_TELEGRAM_SDI type /SCWM/DE_MFSTELETYPE value 'SDI' ##NO_TEXT.
  constants MC_TELEGRAM_DEC type /SCWM/DE_MFSTELETYPE value 'DEC' ##NO_TEXT.
  constants MC_TELEGRAM_ADC type /SCWM/DE_MFSTELETYPE value 'ADC' ##NO_TEXT.
  constants MC_TELEGRAM_PLR type /SCWM/DE_MFSTELETYPE value 'PLR' ##NO_TEXT.
  constants MC_TELEGRAM_CON type /SCWM/DE_MFSTELETYPE value 'CON' ##NO_TEXT.
  constants MC_TELEGRAM_MON type /SCWM/DE_MFSTELETYPE value 'MON' ##NO_TEXT.
  constants MC_NR_ASGID type NROBJ value 'ZSWL_ASGID' ##NO_TEXT.
  constants MC_NR_HUID type NROBJ value '/SCWM/HUID' ##NO_TEXT.
  constants MC_NR_ROBOT type NROBJ value 'ZSWL_ROBOT' ##NO_TEXT.
  constants MC_NR_EVTID type NROBJ value 'ZSWL_EVTID' ##NO_TEXT.
  constants MC_PLCIFTY_A type /SCWM/DE_MFSPLC_IFTYPE value 'A' ##NO_TEXT.
  constants MC_PLCIFTY_C type /SCWM/DE_MFSPLC_IFTYPE value 'C' ##NO_TEXT.
  constants MC_PLCIFTY_L type /SCWM/DE_MFSPLC_IFTYPE value 'L' ##NO_TEXT.
  constants MC_PLCIFTY_H type /SCWM/DE_MFSPLC_IFTYPE value 'H' ##NO_TEXT.
  constants MC_PLCIFTY_M type /SCWM/DE_MFSPLC_IFTYPE value 'M' ##NO_TEXT.
  constants MC_PLCIFTY_O type /SCWM/DE_MFSPLC_IFTYPE value 'O' ##NO_TEXT.
  constants MC_PLCIFTY_K type /SCWM/DE_MFSPLC_IFTYPE value 'K' ##NO_TEXT.
  constants MC_PLCIFTY_R type /SCWM/DE_MFSPLC_IFTYPE value 'R' ##NO_TEXT.
  constants MC_TAB_MFS_CORRDET type TABNAME value 'ZSWL_T_MFSCORDET' ##NO_TEXT.
  constants MC_TAB_MFS_ROBOT type TABNAME value 'ZSWL_T_ROBOT' ##NO_TEXT.
  constants MC_TAB_MFS_CRANE type TABNAME value 'ZSWL_T_CRANE' ##NO_TEXT.
  constants MC_NR_NUM_01 type NRNR value '01' ##NO_TEXT.
  constants MC_RSRC_MODE_A type /SCWM/DE_MFSRMM value 'A' ##NO_TEXT.
  constants MC_RSRC_MODE_B type /SCWM/DE_MFSRMM value 'B' ##NO_TEXT.
  constants MC_CONVEYOR_KZ type /SCWM/DE_MFSPLC value 'CONV' ##NO_TEXT.
  constants MC_CRANE_KZ type /SCWM/DE_MFSPLC value 'CRAN' ##NO_TEXT.
  constants MC_TAB_TUTYPEMAP type TABNAME value 'ZSWL_T_TUTYPEMAP' ##NO_TEXT.
  constants MC_TAB_EVENTLOG type TABNAME value 'ZSWL_T_EVENTLOG' ##NO_TEXT.
  constants MC_TAB_EMTYSTACK type TABNAME value 'ZSWL_T_EMTYSTACK' ##NO_TEXT.
  constants MC_OBJTYPE_B type /SCWM/DE_MFSOBJTYPE value 'B' ##NO_TEXT.
  constants MC_TAB_HOP type TABNAME value 'ZSWL_T_HOP' ##NO_TEXT.
  constants MC_COMMA type CHAR1 value ',' ##NO_TEXT.
  constants MC_HUIDENT_ALLZERO type /SCWM/DE_HUIDENT value '00000000000000000000' ##NO_TEXT.
  constants MC_AS_TASK_NR type NROBJ value 'ZSWL_ASTSK' ##NO_TEXT.
  constants MC_PLCOBJ_ALLZERO type /SCWM/DE_MFSPLCOBJ value '000000000000' ##NO_TEXT.
  constants MC_TAB_AS_HOP type TABNAME value 'ZSWL_AS_HOP_T' ##NO_TEXT.
  constants MC_TAB_REJREASON type TABNAME value 'ZSWL_T_REJREASON' ##NO_TEXT.
  constants MC_ZERO type CHAR1 value '0' ##NO_TEXT.
  constants MC_HOP_TYPE_PUP_CR type ZSWL_DE_HOP_TYPE value 'PUP_CR' ##NO_TEXT.
  constants MC_HOP_TYPE_DEP_CR type ZSWL_DE_HOP_TYPE value 'DEP_CR' ##NO_TEXT.
  constants MC_HOP_TYPE_PUP_MO type ZSWL_DE_HOP_TYPE value 'PUP_MO' ##NO_TEXT.
  constants MC_HOP_TYPE_DEP_MO type ZSWL_DE_HOP_TYPE value 'DEP_MO' ##NO_TEXT.
  constants MC_EXCCODE_ZUFO type /SCWM/DE_EXCCODE value 'ZUFO' ##NO_TEXT.
  constants MC_EXCCODE_ZNWT type /SCWM/DE_EXCCODE value 'ZNWT' ##NO_TEXT.
  constants MC_EXCCODE_MBLK type /SCWM/DE_EXCCODE value 'MBLK' ##NO_TEXT.
  constants MC_EXCCODE_ZBLK type /SCWM/DE_EXCCODE value 'ZBLK' ##NO_TEXT.
  constants MC_EXCCODE_ZMAN type /SCWM/DE_EXCCODE value 'ZMAN' ##NO_TEXT.
  constants MC_EXCCODE_ZSTP type /SCWM/DE_EXCCODE value 'ZSTP' ##NO_TEXT.
  constants MC_EXCCODE_ZWRP type /SCWM/DE_EXCCODE value 'ZWRP' ##NO_TEXT.
  constants MC_EXCCODE_ZORN type /SCWM/DE_EXCCODE value 'ZORN' ##NO_TEXT.
  constants MC_EXCCODE_ZRET type /SCWM/DE_EXCCODE value 'ZRET' ##NO_TEXT.
  constants MC_CP_TYPE_BUF1 type /SCWM/DE_MFSCP_TYPE value 'BUF1' ##NO_TEXT.
  constants MC_CP_TYPE_ESD type /SCWM/DE_MFSCP_TYPE value 'ESD' ##NO_TEXT.
  constants MC_CP_TYPE_PTP type /SCWM/DE_MFSCP_TYPE value 'PTP' ##NO_TEXT.
  constants MC_CP_TYPE_WAE type /SCWM/DE_MFSCP_TYPE value 'WAE' ##NO_TEXT.
  constants MC_LGBER_BUF1 type /SCWM/DE_LGBER_LGST value 'BUF1' ##NO_TEXT.
  constants MC_VLTYP_CO11 type /SCWM/LTAP_VLTYP value 'CO11' ##NO_TEXT.
  constants MC_REJREASON_WTCR type /SCWM/DE_MFS_ERROR value 'WTCR' ##NO_TEXT.
  constants MC_REJREASON_HUEX type /SCWM/DE_MFS_ERROR value 'HUEX' ##NO_TEXT.
  constants MC_REJREASON_NORD type /SCWM/DE_MFS_ERROR value 'NORD' ##NO_TEXT.
  constants MC_PROCTY_MFS_DEFAULT type /SCWM/DE_PROCTY value 'Z800' ##NO_TEXT.
  constants MC_TELEGRAM_TTC type /SCWM/DE_MFSTELETYPE value 'TTC' ##NO_TEXT.

  class-methods LOCK_EXECRUN_INSTANCE
    importing
      !PIV_LGNUM type /SCWM/LGNUM
      !PIV_PLC type /SCWM/DE_MFSPLC
      !PIV_UNIQUEID type CHAR10
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
  class-methods UNLOCK_EXCERRUN_INSTANCE
    importing
      !PIV_LGNUM type /SCWM/LGNUM
      !PIV_PLC type /SCWM/DE_MFSPLC
      !PIV_UNIQUEID type CHAR10
    raising
      ZCX_EWM_GENERAL_EXCEPTION .
endinterface.
