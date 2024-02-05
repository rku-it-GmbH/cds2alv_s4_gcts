  METHOD zif_cds_alv_report_controller~at_value_request.
    TRY.
        selection_screen->value_help_for_field( EXPORTING i_sel_name = i_sel_name
                                                CHANGING  c_value    = c_value ).

        LOOP AT extensions INTO DATA(extension).
          extension-instance->value_help( EXPORTING i_selection_screen = selection_screen
                                                    i_sel_name         = i_sel_name
                                          CHANGING  c_value            = c_value ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.