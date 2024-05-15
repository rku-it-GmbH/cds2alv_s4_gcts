  METHOD build_function_table.
    additional_functions = VALUE #( FOR field_action IN field_actions
                                    WHERE ( user_command IS NOT INITIAL )
                                    ( name = field_action-user_command
                                      text = field_action-label ) ).

    " Refresh; always first after standard functions
    INSERT VALUE #( name    = standard_function_code-refresh
                    icon    = icon_refresh
                    tooltip = TEXT-001 )
           INTO TABLE standard_functions.

    " standard buttons for editable grids
    IF update_enabled = abap_true.
      INSERT VALUE #( name    = standard_function_code-toggle_change_mode
                      icon    = icon_toggle_display_change
                      tooltip = TEXT-002 )
             INTO TABLE standard_functions.

      INSERT VALUE #( name    = standard_function_code-save
                      icon    = icon_system_save
                      tooltip = TEXT-003 )
             INTO TABLE standard_functions.
    ENDIF.

    IF delete_enabled = abap_true.
      INSERT VALUE #( name    = standard_function_code-delete
                      icon    = icon_delete
                      tooltip = TEXT-004 )
             INTO TABLE standard_functions.
    ENDIF.

    IF additional_functions IS NOT INITIAL AND functions_display_mode = display_mode-dropdown_menu.
      INSERT VALUE #( name        = standard_function_code-additional_functions_menu
                      icon        = icon_context_menu
                      tooltip     = TEXT-005
                      button_type = button_type-menu )
             INTO TABLE standard_functions.
    ENDIF.
  ENDMETHOD.