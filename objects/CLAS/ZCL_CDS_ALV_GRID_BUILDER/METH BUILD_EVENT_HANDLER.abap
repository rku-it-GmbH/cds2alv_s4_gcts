  METHOD build_event_handler.
    DATA(program_info) = persistence->get_report_for_cds_view( cds_view ).
    DATA(functions_display_mode) = program_info-add_func_display_mode.
    DATA(event_handler) = NEW zcl_cds_alv_grid_event_handler( i_cds_view               = cds_view
                                                              i_alv_grid               = alv_grid
                                                              i_selection              = selection
                                                              i_value_help             = value_help
                                                              i_navigation             = navigation
                                                              i_action_handler         = action_handler
                                                              i_bopf_handler           = bopf_handler
                                                              i_table_container        = table_container
                                                              i_selection_screen       = selection_screen
                                                              i_alternative_selection  = alternative_selection
                                                              i_field_actions          = field_actions
                                                              i_has_bopf_object        = has_bopf_object
                                                              i_update_enabled         = update_enabled
                                                              i_delete_enabled         = delete_enabled
                                                              i_editable_fields        = editable_fields
                                                              i_functions_display_mode = functions_display_mode ).
    INSERT event_handler INTO TABLE event_handlers.
  ENDMETHOD.