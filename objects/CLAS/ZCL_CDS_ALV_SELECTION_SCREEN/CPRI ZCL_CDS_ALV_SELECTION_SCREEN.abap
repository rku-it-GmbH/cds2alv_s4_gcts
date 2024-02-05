  PRIVATE SECTION.
    CONSTANTS: BEGIN OF fixed_parameters,
                 max_records TYPE rsscr_name VALUE 'P_MAXREC',
                 no_max      TYPE rsscr_name VALUE 'P_NO_MAX',
                 selection   TYPE rsscr_name VALUE 'P_SELEXT',
                 display     TYPE rsscr_name VALUE 'P_DISEXT',
                 split       TYPE rsscr_name VALUE 'P_SPLIT',
               END OF fixed_parameters.

    CONSTANTS: BEGIN OF modif_id,
                 max TYPE screen-group1 VALUE 'MAX' ##NO_TEXT,
                 sel TYPE screen-group1 VALUE 'SEL' ##NO_TEXT,
                 dis TYPE screen-group1 VALUE 'DIS' ##NO_TEXT,
               END OF modif_id.

    CONSTANTS default_maxrec TYPE ddshmaxrec VALUE 500 ##NO_TEXT.

    METHODS set_new_selections
      RAISING zcx_cds_alv_message.