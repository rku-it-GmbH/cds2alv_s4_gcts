  METHOD zif_cds_alv_report_launcher~start_report_for_view.
    ensure_generation( i_cds_view ).
    DATA(program) = persistence->get_report_for_cds_view( i_cds_view ).
    SUBMIT (program-progname) WITH p_split = i_in_split_screen VIA SELECTION-SCREEN AND RETURN. "#EC CI_SUBMIT
  ENDMETHOD.