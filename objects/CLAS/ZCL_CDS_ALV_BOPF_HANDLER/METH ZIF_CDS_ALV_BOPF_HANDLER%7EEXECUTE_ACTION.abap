  METHOD zif_cds_alv_bopf_handler~execute_action.
    DATA parameters     TYPE REF TO data.
    DATA key_values     TYPE REF TO data.
    DATA key_values_tab TYPE REF TO data.
    DATA return         TYPE REF TO data.
    DATA failed         TYPE abap_bool.

    FIELD-SYMBOLS <parameters> TYPE any.
    FIELD-SYMBOLS <return>     TYPE STANDARD TABLE.

    TRY.
        instantiate( ).
        DATA(action) = entity->get_action( to_upper( i_action ) ).

        " Parameters
        IF action-data_type IS NOT INITIAL.
          parameters = runtime->create_action_parameter_ref( action-name ).
          ASSIGN parameters->* TO <parameters>.
          ask_for_parameters( CHANGING c_parameters = <parameters> ).
        ELSE.
          CREATE DATA parameters TYPE char1.
          ASSIGN parameters->* TO <parameters>.
        ENDIF.

        " Return Type
        IF action-return_entity_id IS NOT INITIAL.
          return = cl_sadl_crud_runtime_util=>get_ta_runtime(
                       iv_entity_id   = CONV sadl_entity_id( action-return_entity_id )
                       iv_entity_type = cl_sadl_entity_factory=>co_type-cds )->create_entity_table_ref( ).
          ASSIGN return->* TO <return>.
        ELSEIF action-return_table_type IS NOT INITIAL.
          CREATE DATA return TYPE STANDARD TABLE OF (action-return_table_type).
          ASSIGN return->* TO <return>.
        ELSE.
          CREATE DATA return TYPE STANDARD TABLE OF char1.
          ASSIGN return->* TO <return>.
        ENDIF.

        " Execution
*        CASE action-static.
*          WHEN abap_false.
*            LOOP AT i_selected_rows ASSIGNING FIELD-SYMBOL(<selected_row>).
*              key_values = runtime->create_entity_structure_ref( ).
*              ASSIGN key_values->* TO FIELD-SYMBOL(<key_values>).
*              map_attributes_single( EXPORTING i_entity_key = <selected_row>
*                                               i_attributes = sadl_definition-attributes
*                                     IMPORTING e_source_key = <key_values> ).
*
*              runtime->execute_single( EXPORTING iv_action_name      = action-name
*                                                 i_action_parameters = <parameters>
*                                                 is_key_values       = <key_values>
*                                       IMPORTING ev_failed           = failed
*                                                 et_data             = <return> ).
*
*              IF failed = abap_false.
*                failed = transaction_manager->if_sadl_transaction_manager~save( ).
*              ENDIF.
*
*              IF failed = abap_true.
*                transaction_manager->if_sadl_transaction_manager~discard_changes( ).
*              ENDIF.
*            ENDLOOP.
*
*          WHEN abap_true.
        key_values_tab = runtime->create_entity_table_ref( ).
        ASSIGN key_values_tab->* TO FIELD-SYMBOL(<key_values_tab>).
        map_attributes_table( EXPORTING i_entity_keys = i_selected_rows
                                        i_attributes  = sadl_definition-attributes
                              IMPORTING e_source_keys = <key_values_tab> ).

        runtime->execute( EXPORTING iv_action_name          = action-name
                                    i_action_parameters     = <parameters>
                                    it_key_values           = <key_values_tab>
                          IMPORTING ev_static_action_failed = failed
                                    et_data                 = <return> ).

        IF failed = abap_false.
          failed = transaction_manager->if_sadl_transaction_manager~save( ).
        ENDIF.

        IF failed = abap_true.
          transaction_manager->if_sadl_transaction_manager~discard_changes( ).
        ENDIF.
*        ENDCASE.

        e_refresh_after = abap_true.

      CATCH cx_sadl_contract_violation cx_sadl_static INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.