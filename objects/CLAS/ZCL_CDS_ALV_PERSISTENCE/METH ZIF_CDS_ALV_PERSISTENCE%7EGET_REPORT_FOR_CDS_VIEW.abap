  METHOD zif_cds_alv_persistence~get_report_for_cds_view.
    SELECT SINGLE * FROM zcds_alv_program
     WHERE cds_view = @i_cds_view
      INTO CORRESPONDING FIELDS OF @r_program_info.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e008(zcds_alv) WITH i_cds_view.
    ENDIF.

    IF r_program_info-progname IS NOT INITIAL.
      SELECT * FROM zcds_alv_selopts
        WHERE progname = @r_program_info-progname
        INTO CORRESPONDING FIELDS OF TABLE @r_program_info-select_options.

      SELECT * FROM zcds_alv_params
        WHERE progname = @r_program_info-progname
        INTO CORRESPONDING FIELDS OF TABLE @r_program_info-parameters.

      READ REPORT r_program_info-progname INTO r_program_info-source_lines.
    ENDIF.
  ENDMETHOD.