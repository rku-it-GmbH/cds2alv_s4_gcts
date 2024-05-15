  METHOD zif_cds_alv_grid_event_handler~on_toolbar.
    LOOP AT standard_functions INTO DATA(function).
      IF NOT line_exists( e_object->mt_toolbar[ function = function-name ] ).
        INSERT VALUE #( function  = function-name
                        icon      = function-icon
                        text      = function-text
                        quickinfo = function-tooltip
                        butn_type = function-button_type )
               INTO TABLE e_object->mt_toolbar.
      ENDIF.
    ENDLOOP.

    IF additional_functions IS INITIAL.
      DELETE e_object->mt_toolbar WHERE function = standard_function_code-additional_functions_menu.
    ENDIF.

    IF functions_display_mode = display_mode-buttons.
      LOOP AT additional_functions INTO DATA(additional_function).
        INSERT VALUE #(
          function   = additional_function-name
          icon       = additional_function-icon
          text       = additional_function-text
          quickinfo  = additional_function-tooltip
          butn_type  = additional_function-button_type )
        INTO TABLE e_object->mt_toolbar.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.