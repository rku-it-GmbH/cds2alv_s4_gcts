* VCL-Modifications
PROCESS BEFORE OUTPUT.
 MODULE LISTE_INITIALISIEREN.
 LOOP AT EXTRACT WITH CONTROL
  TCTRL_ZCDS_ALV_EXTPAR CURSOR NEXTLINE.
   MODULE LISTE_SHOW_LISTE.
 ENDLOOP.
*
PROCESS AFTER INPUT.
 MODULE LISTE_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE LISTE_BEFORE_LOOP.
 LOOP AT EXTRACT.
   MODULE LISTE_INIT_WORKAREA.
   CHAIN.
    FIELD ZCDS_ALV_EXTPAR-EXTENSION_NAME .
    FIELD ZCDS_ALV_EXTPAR-PARAMETER_NAME .
    FIELD ZCDS_ALV_EXTPAR-DB_FIELD .
    FIELD ZCDS_ALV_EXTPAR-HAS_VALUE_HELP .
    FIELD ZCDS_ALV_EXTPAR-HAS_HELP .
    FIELD ZCDS_ALV_EXTPAR-ATTRIBUTE_NAME .
    MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
   ENDCHAIN.
   CHAIN.
    FIELD ZCDS_ALV_EXTPART-PARAMETER_TEXT .
    MODULE SET_TXT_UPDATE_FLAG ON CHAIN-REQUEST.
   ENDCHAIN.
   FIELD VIM_MARKED MODULE LISTE_MARK_CHECKBOX.
   CHAIN.
    FIELD ZCDS_ALV_EXTPAR-EXTENSION_NAME .
    FIELD ZCDS_ALV_EXTPAR-PARAMETER_NAME .
    MODULE LISTE_UPDATE_LISTE.
   ENDCHAIN.
 ENDLOOP.
 MODULE LISTE_AFTER_LOOP.
*
PROCESS ON VALUE-REQUEST.
    FIELD  ZCDS_ALV_EXTPAR-EXTENSION_NAME MODULE VCL_HELP_VALUES.