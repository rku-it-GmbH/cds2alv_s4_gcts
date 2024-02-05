  METHOD zif_cds_alv_table_container~set_ref_to_table.
    IF NOT table_descriptor->applies_to_data_ref( i_ref_to_table ).
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e018(zcds_alv) WITH cds_view.
    ENDIF.

    ref_to_table = i_ref_to_table.
    adjust_table( ).
  ENDMETHOD.