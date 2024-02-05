  METHOD zif_cds_alv_report_controller~at_help_request.
    TRY.
        LOOP AT extensions INTO DATA(extension).
          extension-instance->show_help( i_selection_screen = selection_screen
                                         i_sel_name         = i_sel_name ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.