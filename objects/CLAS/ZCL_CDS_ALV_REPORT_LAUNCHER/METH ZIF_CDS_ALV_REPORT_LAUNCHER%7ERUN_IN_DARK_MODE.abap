  METHOD zif_cds_alv_report_launcher~run_in_dark_mode.
    ensure_generation( i_cds_view ).
    DATA(program) = persistence->get_report_for_cds_view( i_cds_view ).

    DATA(read_metadata) = xsdbool(    e_layout IS SUPPLIED OR e_field_catalog IS SUPPLIED
                                   OR e_filter IS SUPPLIED OR e_sort          IS SUPPLIED ).

    DATA(read_data) = xsdbool( e_ref_to_table IS SUPPLIED OR e_table_descriptor IS SUPPLIED ).

    TRY.
        cl_salv_bs_runtime_info=>set( display  = abap_false
                                      metadata = read_metadata
                                      data     = read_data ).

        IF i_variant IS NOT INITIAL.
          SUBMIT (program-progname) USING SELECTION-SET i_variant AND RETURN.
        ELSE.
          SUBMIT (program-progname) WITH SELECTION-TABLE i_selection_table AND RETURN.
        ENDIF.

        IF read_metadata = abap_true.
          DATA(metadata) = cl_salv_bs_runtime_info=>get_metadata( ).
          e_layout = metadata-s_layout.
          e_field_catalog = metadata-t_fcat.
          e_filter = metadata-t_filter.
          e_sort = metadata-t_sort.
        ENDIF.

        IF read_data = abap_true.
          cl_salv_bs_runtime_info=>get_data_ref( IMPORTING r_data       = DATA(ref_to_data)
                                                           r_data_descr = DATA(data_descriptor) ).

          e_ref_to_table ?= ref_to_data.
          e_table_descriptor ?= data_descriptor.
        ENDIF.

        cl_salv_bs_runtime_info=>clear_all( ).
      CATCH cx_salv_bs_sc_runtime_info INTO DATA(previous).
        cl_salv_bs_runtime_info=>clear_all( ).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.