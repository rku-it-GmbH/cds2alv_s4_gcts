  METHOD refresh.
    DATA ref_to_table TYPE REF TO data.

    DATA(table_descriptor) = table_container->get_table_descriptor( ).
    CREATE DATA ref_to_table TYPE HANDLE table_descriptor.
    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<result_table>).

    TRY.
        DATA(selection_handler) = extensions[ extension = alternative_selection ]-instance.
        selection_handler->alternative_reselection( EXPORTING i_cds_view         = cds_view
                                                              i_selection_screen = selection_screen
                                                              i_table_container  = table_container
                                                    CHANGING  c_result_table     = <result_table> ).

      CATCH cx_sy_itab_line_not_found.
        selection->perform_reselection( CHANGING c_result_table = <result_table> ).
    ENDTRY.

    table_container->set_table( <result_table> ).
  ENDMETHOD.