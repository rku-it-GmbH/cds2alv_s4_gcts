  METHOD zif_cds_alv_persistence~get_report_header.
    SELECT SINGLE * FROM zcds_alv_program
     WHERE cds_view = @i_cds_view
      INTO CORRESPONDING FIELDS OF @r_program_header.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e008(zcds_alv) WITH i_cds_view.
    ENDIF.
  ENDMETHOD.