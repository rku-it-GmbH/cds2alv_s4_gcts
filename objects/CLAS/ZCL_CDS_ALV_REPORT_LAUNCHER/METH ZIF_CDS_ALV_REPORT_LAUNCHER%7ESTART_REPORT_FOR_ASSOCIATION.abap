  METHOD zif_cds_alv_report_launcher~start_report_for_association.
    DATA selection_table     TYPE STANDARD TABLE OF rsparamsl_255.
    DATA ref_to_forall_table TYPE REF TO data.
    FIELD-SYMBOLS <forall_table> TYPE STANDARD TABLE.

    ensure_generation( i_target_view ).

    DATA(program) = persistence->get_report_for_cds_view( i_source_view ).

    LOOP AT program-parameters INTO DATA(parameter).
      READ TABLE i_target_parameters INTO DATA(parameter_value)
           WITH KEY parname = parameter-parname.
      IF sy-subrc = 0.
        INSERT VALUE #( kind = 'P' selname = parameter-sel_name low = parameter_value-value )
               INTO TABLE selection_table.
      ENDIF.
    ENDLOOP.

    DATA(memory_id) = CONV zcds_alv_memory_id( |{ i_source_view }\\{ i_association_name }| ).

    CREATE DATA ref_to_forall_table TYPE TABLE OF (i_source_view).
    ASSIGN ref_to_forall_table->* TO <forall_table>.
    MOVE-CORRESPONDING i_forall_table TO <forall_table>.

    memory->export_forall_table( i_memory_id         = memory_id
                                 i_source_view       = i_source_view
                                 i_association_name  = i_association_name
                                 i_source_parameters = i_source_parameters
                                 i_forall_table      = <forall_table> ).

    selection_table = VALUE #( BASE selection_table
                               kind = 'P'
                               ( selname = 'P_FORALL' low = abap_true )
                               ( selname = 'P_MEM_ID' low = memory_id ) ).

    SUBMIT (program-progname) WITH SELECTION-TABLE selection_table AND RETURN. "#EC CI_SUBMIT

    FREE MEMORY ID memory_id.
  ENDMETHOD.