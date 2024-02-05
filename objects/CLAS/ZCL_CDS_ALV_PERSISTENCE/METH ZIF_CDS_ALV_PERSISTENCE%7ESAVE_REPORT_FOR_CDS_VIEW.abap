  METHOD zif_cds_alv_persistence~save_report_for_cds_view.
    DATA(program) = CORRESPONDING zcds_alv_program( i_program_info ).
    program-cds_view = i_cds_view.

    MODIFY zcds_alv_program FROM @program.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e014(zcds_alv) WITH i_cds_view.
    ENDIF.

    DELETE FROM zcds_alv_params WHERE progname = @i_program_info-progname.
    INSERT zcds_alv_params FROM TABLE @i_program_info-parameters.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e014(zcds_alv) WITH i_cds_view.
    ENDIF.

    DELETE FROM zcds_alv_selopts WHERE progname = @i_program_info-progname.
    INSERT zcds_alv_selopts FROM TABLE @i_program_info-select_options.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e014(zcds_alv) WITH i_cds_view.
    ENDIF.
  ENDMETHOD.