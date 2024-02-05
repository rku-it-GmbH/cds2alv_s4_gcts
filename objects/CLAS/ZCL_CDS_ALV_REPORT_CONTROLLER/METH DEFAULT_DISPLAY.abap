  METHOD default_display.
    CASE i_in_split_screen.
      WHEN abap_false.
        CALL FUNCTION 'Z_CDS_ALV_FULL_SCREEN'
          EXPORTING i_builder         = builder
                    i_table_container = table_container.

      WHEN abap_true.
        DATA(program) = persistence->get_report_for_cds_view( cds_view ).

        CALL FUNCTION 'Z_CDS_ALV_SPLIT_SCREEN'
          EXPORTING i_builder         = builder
                    i_table_container = table_container
                    i_sub_repid       = program-progname
                    i_sub_dynnr       = program-dynpro
                    i_controller      = me.
    ENDCASE.
  ENDMETHOD.