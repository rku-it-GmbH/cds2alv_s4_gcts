  METHOD constructor.
    super->constructor( i_cds_view    = i_cds_view
                        i_ddic_access = i_ddic_access
                        i_persistence = i_persistence
                        i_memory      = i_memory
                        i_factory     = i_factory ).

    table_container = i_table_container.
    selection_screen = i_selection_screen.
    selection = i_selection.
    builder = i_builder.
    extension_provider = i_extension_provider.

    evaluate_annotations( ).
    extensions = extension_provider->get_report_extensions( cds_view ).
  ENDMETHOD.