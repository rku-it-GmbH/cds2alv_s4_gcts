  METHOD is_selection_active.
    DATA(alternative_selection) = VALUE zcds_alv_report_extension_name( ).
    i_selection_screen->get_dynpro_field( EXPORTING i_sel_name  = main_parameters-alternative_selection
                                          IMPORTING e_parameter = alternative_selection ).
    r_is_active = xsdbool( alternative_selection = extension_name ).
  ENDMETHOD.