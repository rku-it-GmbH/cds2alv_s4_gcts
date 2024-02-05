  METHOD zif_cds_alv_ddic_access~exists_view.
    SELECT SINGLE @abap_true FROM dd02b
     WHERE strucobjn = @i_cds_view
      INTO @r_exists.
  ENDMETHOD.