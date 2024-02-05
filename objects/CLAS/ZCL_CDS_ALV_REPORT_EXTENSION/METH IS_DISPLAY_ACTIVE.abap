  METHOD is_display_active.
    DATA(alternative_display) = VALUE zcds_alv_report_extension_name( ).
    i_selection_screen->get_dynpro_field( EXPORTING i_sel_name  = main_parameters-alternative_display
                                          IMPORTING e_parameter = alternative_display ).
    r_is_active = xsdbool( alternative_display = extension_name ).
  ENDMETHOD.