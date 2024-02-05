  METHOD instantiate.
    TRY.
        DATA(entity_id) = CONV sadl_entity_id( cds_view ).
        entity = cl_sadl_entity_factory=>get_instance( )->get_entity( iv_type = cl_sadl_entity_factory=>co_type-cds
                                                                      iv_id   = entity_id ).

        " This gets the correct entity, when ObjectModel.transactionalProcessingDelegated is used!
        DATA(source_id) = ddic_access->get_source_id( entity ).

        runtime = cl_sadl_crud_runtime_util=>get_ta_runtime(
                      iv_entity_id   = COND #( WHEN source_id IS NOT INITIAL THEN source_id ELSE entity_id )
                      iv_entity_type = cl_sadl_entity_factory=>co_type-cds ).

        transaction_manager = cl_sadl_transaction_manager=>get_transaction_manager( ).

        IF source_id IS NOT INITIAL.
          DATA(mp) = ddic_access->get_mp_for_entity( entity ).

          DATA(entity_type_trans_manager) =
            cl_sadl_entity_trans_factory=>get_transactional_provider( cl_sadl_entity_factory=>co_type-bopf
              )->get_transaction_manager( cl_sadl_entity_factory=>co_type-bopf ).

          transaction_manager->register_transaction_framework( io_transaction_manager = entity_type_trans_manager
                                                               iv_entity_type         = cl_sadl_entity_factory=>co_type-bopf
                                                               io_mdp                 = cl_sadl_mdp_factory=>get_mdp_for_mp( mp ) ).
        ENDIF.

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.