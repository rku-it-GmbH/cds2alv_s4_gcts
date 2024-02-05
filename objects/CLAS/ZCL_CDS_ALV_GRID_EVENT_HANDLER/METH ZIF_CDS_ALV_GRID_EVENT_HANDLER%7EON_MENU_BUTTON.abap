  METHOD zif_cds_alv_grid_event_handler~on_menu_button.
    IF e_ucomm = standard_function_code-additional_functions_menu.
      LOOP AT additional_functions INTO DATA(function).
        e_object->add_function( fcode = function-name
                                text  = CONV #( function-text )
                                icon  = CONV #( function-icon ) ).
      ENDLOOP.
    ENDIF.

*    DATA: ref_to_selected_rows TYPE REF TO data.
*    FIELD-SYMBOLS: <selected_rows> TYPE STANDARD TABLE.
*    FIELD-SYMBOLS: <table> TYPE STANDARD TABLE.
*    ASSIGN ref_to_table->* TO <table>.
*
*    CREATE DATA ref_to_selected_rows LIKE <table>.
*    ASSIGN ref_to_selected_rows->* TO <selected_rows>.
*
*    alv_grid->get_selected_rows( IMPORTING et_row_no = DATA(lt_row_no) ).
*    LOOP AT lt_row_no INTO DATA(row_no) WHERE row_id <> 0.
*      INSERT <table>[ row_no-row_id ] INTO TABLE <selected_rows>.
*    ENDLOOP.
*
*    IF line_exists( standard_function_codes[ table_line = e_ucomm ] ).
*      dispatch_standard_function( i_function = e_ucomm i_selected_rows = <selected_rows> ).
*      RETURN.
*    ENDIF.
*
*    TRY.
*        DATA(field_action) = field_actions[ user_command = e_ucomm ].
*        dispatch_mass_action( i_field_action = field_action i_selected_rows = <selected_rows> ).
*      CATCH cx_sy_itab_line_not_found.
*    ENDTRY.
  ENDMETHOD.