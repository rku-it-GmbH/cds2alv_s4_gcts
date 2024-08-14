  METHOD zif_cds_alv_action_handler~delete.
    DATA key_values TYPE REF TO data.

    TRY.
        instantiate( ).
        key_values = runtime->create_entity_table_ref( ).
        ASSIGN key_values->* TO FIELD-SYMBOL(<key_values>).
        map_attributes_table( EXPORTING i_entity_keys = i_selected_rows
                                        i_attributes  = sadl_definition-attributes
                              IMPORTING e_source_keys = <key_values> ).

        runtime->delete( EXPORTING it_key_values = <key_values>
                         IMPORTING et_failed     = DATA(failed_keys) ).

        DATA(failed) = xsdbool( failed_keys IS NOT INITIAL ).

        IF failed = abap_false.
          failed = transaction_manager->if_sadl_transaction_manager~save( ).
        ENDIF.

        IF failed = abap_true.
          transaction_manager->if_sadl_transaction_manager~discard_changes( ).
        ENDIF.

      CATCH cx_sadl_contract_violation cx_sadl_static INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.