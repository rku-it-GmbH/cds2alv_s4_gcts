  METHOD zif_cds_alv_bopf_handler~update.
    DATA entity_data TYPE REF TO data.

    TRY.
        instantiate( ).
        entity_data = runtime->create_entity_table_ref( ).
        ASSIGN entity_data->* TO FIELD-SYMBOL(<entity_data>).
        map_attributes_table( EXPORTING i_entity_keys = i_selected_rows
                                        i_attributes  = sadl_definition-attributes
                              IMPORTING e_source_keys = <entity_data> ).

        runtime->update( EXPORTING it_entity_data = <entity_data>
                         IMPORTING et_failed      = DATA(failed_keys) ).

        DATA(failed) = xsdbool( failed_keys IS NOT INITIAL ).

        IF failed = abap_false.
          failed = transaction_manager->if_sadl_transaction_manager~save( ).
        ENDIF.

        IF failed = abap_true.
          transaction_manager->if_sadl_transaction_manager~discard_changes( ).
        ENDIF.

      CATCH cx_sadl_contract_violation cx_sadl_static INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.