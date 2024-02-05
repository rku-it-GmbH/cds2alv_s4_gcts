  METHOD zif_cds_alv_grid_event_handler~on_hotspot_click.
    FIELD-SYMBOLS <table> TYPE STANDARD TABLE.

    ASSIGN ref_to_table->* TO <table>.

    READ TABLE <table> INDEX es_row_no-row_id ASSIGNING FIELD-SYMBOL(<selected_row>).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    TRY.
        DATA(field_action) = field_actions[ fieldname = e_column_id-fieldname hotspot = abap_true ].
        dispatch_single_action( i_field_action = field_action i_selected_row = <selected_row> ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.