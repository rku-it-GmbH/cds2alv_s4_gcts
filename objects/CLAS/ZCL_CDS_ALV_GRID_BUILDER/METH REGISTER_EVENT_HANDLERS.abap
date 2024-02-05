  METHOD register_event_handlers.
    LOOP AT event_handlers INTO DATA(event_handler).
      SET HANDLER event_handler->on_help_request FOR alv_grid.
      SET HANDLER event_handler->on_value_request FOR alv_grid.
      SET HANDLER event_handler->on_data_changed FOR alv_grid.
      SET HANDLER event_handler->on_before_user_command FOR alv_grid.
      SET HANDLER event_handler->on_user_command FOR alv_grid.
      SET HANDLER event_handler->on_after_user_command FOR alv_grid.
      SET HANDLER event_handler->on_double_click FOR alv_grid.
      SET HANDLER event_handler->on_context_menu_request FOR alv_grid.
      SET HANDLER event_handler->on_menu_button FOR alv_grid.
      SET HANDLER event_handler->on_toolbar FOR alv_grid.
      SET HANDLER event_handler->on_hotspot_click FOR alv_grid.
      SET HANDLER event_handler->on_after_refresh FOR alv_grid.
      SET HANDLER event_handler->on_button_click FOR alv_grid.
      SET HANDLER event_handler->on_data_changed_finished FOR alv_grid.
    ENDLOOP.
  ENDMETHOD.