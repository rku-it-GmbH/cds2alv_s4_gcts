  PROTECTED SECTION.
    TYPES ty_rsparamsl_255_tab TYPE STANDARD TABLE OF rsparamsl_255 WITH EMPTY KEY.
    TYPES ty_selection_texts   TYPE STANDARD TABLE OF rsseltexts WITH NON-UNIQUE DEFAULT KEY.

    CONSTANTS: BEGIN OF kind,
                 parameter     TYPE rsscr_kind VALUE 'P' ##NO_TEXT,
                 select_option TYPE rsscr_kind VALUE 'S' ##NO_TEXT,
               END OF kind.
    CONSTANTS: BEGIN OF sign,
                 no_extensions TYPE raldb_sign VALUE 'N' ##NO_TEXT,
                 all           TYPE raldb_sign VALUE '*' ##NO_TEXT,
                 include       TYPE raldb_sign VALUE 'I' ##NO_TEXT,
                 exclude       TYPE raldb_sign VALUE 'E' ##NO_TEXT,
               END OF sign.
    CONSTANTS: BEGIN OF selection_type,
                 interval TYPE rsrest_opl VALUE '#INTERVAL' ##NO_TEXT,
                 range    TYPE rsrest_opl VALUE '#RANGE' ##NO_TEXT,
                 single   TYPE rsrest_opl VALUE '#SINGLE' ##NO_TEXT,
               END OF selection_type.

    CLASS-DATA st_options_tab TYPE sscr_opt_list_tab.

    DATA title              TYPE sytitle.
    DATA progname           TYPE progname.
    DATA selection_table    TYPE ty_rsparamsl_255_tab.
    DATA selection_mappings TYPE zcds_alv_selopts_mapping_tab.
    DATA parameter_mappings TYPE zcds_alv_parameter_mapping_tab.
    DATA restriction        TYPE sscr_restrict.
    DATA selection_texts    TYPE ty_selection_texts.
    DATA value_help         TYPE REF TO zif_cds_alv_value_help.

    METHODS evaluate_annotations REDEFINITION.
