  METHOD default_selection.
    CASE i_forall.
      WHEN abap_false.
        selection->perform_selection( EXPORTING i_condition_provider = selection_screen
                                      IMPORTING e_result_table       = e_result_table ).

      WHEN abap_true.
        memory->import_forall_table( EXPORTING i_memory_id           = i_memory_id
                                     IMPORTING e_source_view         = DATA(source_view)
                                               e_association_name    = DATA(association_name)
                                               e_source_parameters   = DATA(source_parameters)
                                               e_ref_to_forall_table = DATA(ref_to_forall_table) ).

        ASSIGN ref_to_forall_table->* TO FIELD-SYMBOL(<forall_table>).

        selection->perform_selection_forall( EXPORTING i_condition_provider = selection_screen
                                                       i_source_view        = source_view
                                                       i_association_name   = association_name
                                                       i_source_parameters  = source_parameters
                                                       i_forall_table       = <forall_table>
                                             IMPORTING e_result_table       = e_result_table ).
    ENDCASE.
  ENDMETHOD.