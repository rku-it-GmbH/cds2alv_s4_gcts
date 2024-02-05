  METHOD zif_cds_alv_report_controller~at_selection_screen_output.
    TRY.
        selection_screen->apply_restriction( ).
        selection_screen->apply_selection_texts( ).
        selection_screen->modify_screen( ).

        LOOP AT extensions INTO DATA(extension).
          extension-instance->modify_screen( selection_screen ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.