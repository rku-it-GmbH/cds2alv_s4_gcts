  METHOD zif_cds_alv_report_controller~at_selection_screen.
    TRY.
        LOOP AT extensions INTO DATA(extension).
          extension-instance->handle_user_command( i_selection_screen = selection_screen
                                                   i_user_command     = i_ucomm ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.