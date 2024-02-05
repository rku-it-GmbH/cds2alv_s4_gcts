  METHOD constructor.
    super->constructor( i_cds_view    = i_cds_view
                        i_ddic_access = i_ddic_access
                        i_persistence = i_persistence
                        i_memory      = i_memory
                        i_factory     = i_factory ).

    value_help = i_value_help.

    DATA(program) = persistence->get_report_for_cds_view( cds_view ).

    progname = program-progname.
    parameter_mappings = program-parameters.
    selection_mappings = program-select_options.

    evaluate_annotations( ).
  ENDMETHOD.