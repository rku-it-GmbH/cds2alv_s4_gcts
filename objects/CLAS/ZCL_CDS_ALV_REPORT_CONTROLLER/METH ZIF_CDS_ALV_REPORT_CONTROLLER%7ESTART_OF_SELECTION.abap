  METHOD zif_cds_alv_report_controller~start_of_selection.
    DATA ref_to_table TYPE REF TO data.

    DATA(table_descriptor) = table_container->get_table_descriptor( ).
    CREATE DATA ref_to_table TYPE HANDLE table_descriptor.
    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<result_table>).

    TRY.
        selection_screen->read_selection_screen( ).

        TRY.
            DATA(no_display) = abap_false.
            DATA(selection_handler) = extensions[ extension = i_selection ]-instance.
            alternative_selection = i_selection.
            builder->register_alternative_selection( selection_handler ).
            selection_handler->alternative_selection( EXPORTING i_cds_view         = cds_view
                                                                i_selection_screen = selection_screen
                                                                i_table_container  = table_container
                                                      IMPORTING e_result_table     = <result_table>
                                                                e_no_display       = no_display ).

          CATCH cx_sy_itab_line_not_found.
            default_selection( EXPORTING i_forall       = i_forall
                                         i_memory_id    = i_memory_id
                               IMPORTING e_result_table = <result_table> ).
        ENDTRY.

        table_container->set_table( <result_table> ).

        IF no_display = abap_true.
          RETURN.
        ENDIF.

        TRY.
            DATA(display_handler) = extensions[ extension = i_display ]-instance.
            alternative_display = i_display.
            display_handler->alternative_display( i_selection_screen = selection_screen
                                                  i_table_container  = table_container
                                                  i_builder          = builder ).

          CATCH cx_sy_itab_line_not_found.
            default_display( i_in_split_screen ).
        ENDTRY.

      CATCH zcx_cds_alv_message INTO DATA(exception).
        MESSAGE exception TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.