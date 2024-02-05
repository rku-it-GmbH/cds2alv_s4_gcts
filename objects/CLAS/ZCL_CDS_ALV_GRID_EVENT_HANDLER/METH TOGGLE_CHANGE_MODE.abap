  METHOD toggle_change_mode.
    table_container->toggle_change_mode( alv_grid ).
    alv_grid->refresh_table_display( ).
    cl_gui_cfw=>flush( ).
  ENDMETHOD.