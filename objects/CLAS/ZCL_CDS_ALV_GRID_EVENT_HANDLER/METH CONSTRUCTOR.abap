  METHOD constructor.
    cds_view = i_cds_view.
    alv_grid = i_alv_grid.
    selection = i_selection.
    value_help = i_value_help.
    navigation = i_navigation.
    action_handler = i_action_handler.
    bopf_handler = i_bopf_handler.
    selection_screen = i_selection_screen.
    table_container = i_table_container.
    field_actions = i_field_actions.
    has_bopf_object = i_has_bopf_object.
    has_behaviour_definition = i_has_behaviour_definition.
    update_enabled = i_update_enabled.
    delete_enabled = i_delete_enabled.
    editable_fields = i_editable_fields.
    alternative_selection = i_alternative_selection.
    functions_display_mode = i_functions_display_mode.

    ref_to_table = table_container->get_ref_to_table( ).
    build_function_table( ).
  ENDMETHOD.