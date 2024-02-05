  METHOD zif_cds_alv_report_controller~initialization.
    TRY.
        LOOP AT extensions INTO DATA(extension).
          extension-instance->initialization( selection_screen ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.