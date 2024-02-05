  METHOD constructor.
    super->constructor( i_cds_view    = i_cds_view
                        i_ddic_access = i_ddic_access
                        i_persistence = i_persistence
                        i_memory      = i_memory
                        i_factory     = i_factory ).

    selection = i_selection.
    value_help = i_value_help.
    bopf_handler = i_bopf_handler.
    navigation = i_navigation.
    selection_screen = i_selection_screen.

    evaluate_annotations( ).
  ENDMETHOD.