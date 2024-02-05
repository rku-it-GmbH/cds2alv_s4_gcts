  METHOD zif_cds_alv_memory~import_forall_table.
    IMPORT source_view       = e_source_view
           association_name  = e_association_name
           source_parameters = e_source_parameters
           FROM MEMORY ID i_memory_id.

    CREATE DATA e_ref_to_forall_table TYPE STANDARD TABLE OF (e_source_view).
    ASSIGN e_ref_to_forall_table->* TO FIELD-SYMBOL(<forall_table>).

    IMPORT forall_table = <forall_table> FROM MEMORY ID i_memory_id.
  ENDMETHOD.