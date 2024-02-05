  METHOD zif_cds_alv_navigation~navigate_via_association.
    DATA(target_view) = ddic_access->get_target_for_association( i_source_view      = i_source_view
                                                                 i_association_name = i_association_name ).

    DATA(target_parameters) = i_target_parameters.

    ask_for_missing_parameters( EXPORTING i_target_view      = target_view
                                CHANGING  c_parameter_values = target_parameters ).

    launcher->start_report_for_association( i_source_view       = i_source_view
                                            i_target_view       = target_view
                                            i_association_name  = i_association_name
                                            i_source_parameters = i_source_parameters
                                            i_target_parameters = target_parameters
                                            i_forall_table      = i_selected_rows ).
  ENDMETHOD.