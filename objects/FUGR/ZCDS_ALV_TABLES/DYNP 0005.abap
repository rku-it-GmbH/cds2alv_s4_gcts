PROCESS BEFORE OUTPUT.
 MODULE LISTE_INITIALISIEREN.
 LOOP AT EXTRACT WITH CONTROL
  TCTRL_ZCDS_ALV_NAVEXIT CURSOR NEXTLINE.
   MODULE LISTE_SHOW_LISTE.
 ENDLOOP.
*
PROCESS AFTER INPUT.
 MODULE LISTE_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE LISTE_BEFORE_LOOP.
 LOOP AT EXTRACT.
   MODULE LISTE_INIT_WORKAREA.
   CHAIN.
    FIELD ZCDS_ALV_NAVEXIT-SEMANTIC_OBJECT .
    FIELD ZCDS_ALV_NAVEXIT-SEMANTIC_ACTION .
    FIELD ZCDS_ALV_NAVEXIT-CDS_VIEW .
    FIELD ZCDS_ALV_NAVEXIT-IMPLEMENTING_CLASS .
    MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
   ENDCHAIN.
   FIELD VIM_MARKED MODULE LISTE_MARK_CHECKBOX.
   CHAIN.
    FIELD ZCDS_ALV_NAVEXIT-SEMANTIC_OBJECT .
    FIELD ZCDS_ALV_NAVEXIT-SEMANTIC_ACTION .
    FIELD ZCDS_ALV_NAVEXIT-CDS_VIEW .
    MODULE LISTE_UPDATE_LISTE.
   ENDCHAIN.
 ENDLOOP.
 MODULE LISTE_AFTER_LOOP.