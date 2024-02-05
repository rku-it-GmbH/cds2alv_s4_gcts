  METHOD zif_cds_alv_table_container~set_table.
    IF NOT table_descriptor->applies_to_data( i_table ).
      " Allow tables of the CDS line type without special columns
      READ TABLE i_table INDEX 1 ASSIGNING FIELD-SYMBOL(<line>).
      IF sy-subrc <> 0 OR NOT ddic_structure_descriptor->applies_to_data( <line> ).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE e018(zcds_alv) WITH cds_view.
      ENDIF.
    ENDIF.

    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<table>).
    <table> = CORRESPONDING #( i_table ).
    adjust_table( ).
  ENDMETHOD.