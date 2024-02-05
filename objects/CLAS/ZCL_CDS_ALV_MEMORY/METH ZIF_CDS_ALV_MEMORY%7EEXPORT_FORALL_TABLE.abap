  METHOD zif_cds_alv_memory~export_forall_table.
    DATA ref_to_forall_table TYPE REF TO data.

    CREATE DATA ref_to_forall_table TYPE STANDARD TABLE OF (i_source_view).
    ASSIGN ref_to_forall_table->* TO FIELD-SYMBOL(<forall_table>).

    MOVE-CORRESPONDING i_forall_table TO <forall_table>.

    EXPORT source_view       = i_source_view
           association_name  = i_association_name
           source_parameters = i_source_parameters
           forall_table      = <forall_table>
           TO MEMORY ID i_memory_id.
  ENDMETHOD.