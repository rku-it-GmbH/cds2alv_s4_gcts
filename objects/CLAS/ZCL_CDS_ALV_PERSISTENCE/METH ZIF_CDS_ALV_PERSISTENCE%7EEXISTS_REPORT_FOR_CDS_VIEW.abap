  METHOD zif_cds_alv_persistence~exists_report_for_cds_view.
    SELECT SINGLE @abap_true FROM zcds_alv_program
     WHERE cds_view = @i_cds_view
      INTO @r_exists.
  ENDMETHOD.