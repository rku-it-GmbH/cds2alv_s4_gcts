  METHOD zif_cds_alv_grid_event_handler~on_value_request.
    FIELD-SYMBOLS <modification> TYPE lvc_t_modi.
    FIELD-SYMBOLS <table>        TYPE STANDARD TABLE.

    ASSIGN ref_to_table->* TO <table>.

    READ TABLE <table> INDEX es_row_no-row_id ASSIGNING FIELD-SYMBOL(<selected_row>).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    TRY.
        IF value_help IS BOUND.
          DATA(in_edit_mode) = table_container->is_in_edit_mode( ).
          DATA(field_is_editable) = xsdbool( line_exists( editable_fields[ table_line = e_fieldname ] ) ).
          DATA(display) = xsdbool( in_edit_mode = abap_false OR field_is_editable = abap_false ).

          value_help->value_help_for_element( EXPORTING i_fieldname    = e_fieldname
                                                        i_selected_row = <selected_row>
                                                        i_display      = display
                                              IMPORTING e_processed    = DATA(processed)
                                              CHANGING  c_value        = e_fieldvalue ).

          IF processed = abap_true AND display = abap_false.
            ASSIGN er_event_data->m_data->* TO <modification>.
            INSERT VALUE #( row_id    = es_row_no-row_id
                            fieldname = e_fieldname
                            value     = e_fieldvalue )
                   INTO TABLE <modification>.
          ENDIF.

          er_event_data->m_event_handled = processed.
        ENDIF.

      CATCH zcx_cds_alv_message INTO DATA(message).
        MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.