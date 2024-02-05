  METHOD select.
    DATA ref_to_table TYPE REF TO data.

    DATA(table_descriptor) = table_container->get_table_descriptor( ).
    CREATE DATA ref_to_table TYPE HANDLE table_descriptor.
    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<result_table>).

    selection_screen->read_selection_screen( ).

    TRY.
        DATA(selection_handler) = extensions[ extension = alternative_selection ]-instance.
        selection_handler->alternative_selection( EXPORTING i_cds_view         = cds_view
                                                            i_selection_screen = selection_screen
                                                            i_table_container  = table_container
                                                  IMPORTING e_result_table     = <result_table> ).

      CATCH cx_sy_itab_line_not_found.
        selection->perform_selection( EXPORTING i_condition_provider = selection_screen
                                      IMPORTING e_result_table       = <result_table> ).
    ENDTRY.

    table_container->set_table( <result_table> ).
  ENDMETHOD.