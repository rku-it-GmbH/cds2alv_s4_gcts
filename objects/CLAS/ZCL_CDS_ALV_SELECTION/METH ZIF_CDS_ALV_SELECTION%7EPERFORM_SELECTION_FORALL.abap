  METHOD zif_cds_alv_selection~perform_selection_forall.
    TRY.
        DATA(parameters) = VALUE if_sadl_query_engine_types=>ty_parameters(
            entity = VALUE #(
                ( entity_alias = cl_sadl_entity_util=>convert( CONV #( cds_view ) )
                  parameters   = CORRESPONDING #( i_condition_provider->get_parameters( ) MAPPING name = parname ) ) ) ).

        DATA(sadl_condition_provider) = NEW lcl_sadl_cond_provider_forall( i_ddic_access       = ddic_access
                                                                           i_source_view       = i_source_view
                                                                           i_association_name  = i_association_name
                                                                           i_source_parameters = i_source_parameters
                                                                           i_forall_table      = i_forall_table ).

        DATA(sadl_condition_providers) = VALUE ty_sadl_condition_providers( ( sadl_condition_provider ) ).

        DATA(ddfields) = ddic_access->get_ddic_fields_for_cds_view( cds_view ).
        DATA(elements) = VALUE if_sadl_query_engine_types=>tt_requested_elements( FOR ddfield IN ddfields
                                                                                  ( CONV #( ddfield-fieldname ) ) ).

        DATA(requested) = VALUE if_sadl_query_engine_types=>ty_requested( elements             = elements
                                                                          fill_data            = abap_true
                                                                          fill_number_all_hits = abap_true ).

        " Selection via Runtime
        DATA(sadl_runtime) = ddic_access->get_sadl_runtime( cds_view ).

        sadl_runtime->if_sadl_query_fetch~register_condition_provider( sadl_condition_provider ).

        sadl_runtime->fetch( EXPORTING is_parameters      = parameters
                                       is_requested       = requested
                             IMPORTING et_data_rows       = e_result_table
                                       ev_number_all_hits = e_number_all_hits  ).

        " save parameters for reselection
        save_request( i_parameters               = parameters
                      i_requested                = requested
                      i_sadl_condition_providers = sadl_condition_providers ).

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.