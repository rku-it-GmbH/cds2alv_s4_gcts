  METHOD zif_cds_alv_selection~perform_selection.
    CLEAR: e_result_table,
           e_number_all_hits.

    TRY.
        DATA(alv_parameters) = i_condition_provider->get_parameters( ).
        IF alv_parameters IS NOT INITIAL.
          DATA(parameters) = VALUE if_sadl_query_engine_types=>ty_parameters(
              entity = VALUE #( ( entity_alias = cl_sadl_entity_util=>convert( CONV #( cds_view ) )
                                  parameters   = CORRESPONDING #( alv_parameters MAPPING name = parname ) ) ) ).
        ENDIF.

        i_condition_provider->get_selections( IMPORTING e_field_ranges = DATA(field_ranges)
                                                        e_maxrec       = DATA(max_records) ).

        DATA(sadl_condition_providers) = VALUE ty_sadl_condition_providers(
                                                   FOR field_range IN field_ranges
                                                   ( cl_sadl_cond_prov_factory_pub=>create_basic_condition_factory(
                                                       )->in_range(
                                                           name     = CONV #( field_range-fieldname )
                                                           t_ranges = CORRESPONDING #( field_range-selopt_t ) ) )  ).

        DATA(paging) = VALUE if_sadl_query_engine_types=>ty_paging( maximum_rows = max_records ).

        DATA(ddfields) = ddic_access->get_ddic_fields_for_cds_view( cds_view ).
        DATA(elements) = VALUE if_sadl_query_engine_types=>tt_requested_elements( FOR ddfield IN ddfields
                                                                                  ( CONV #( ddfield-fieldname ) ) ).

        DATA(requested) = VALUE if_sadl_query_engine_types=>ty_requested( elements             = elements
                                                                          fill_data            = abap_true
                                                                          fill_number_all_hits = abap_true ).

        " Selection via Runtime
        DATA(sadl_runtime) = ddic_access->get_sadl_runtime( cds_view ).

        LOOP AT sadl_condition_providers INTO DATA(sadl_condition_provider).
          sadl_runtime->if_sadl_query_fetch~register_condition_provider( sadl_condition_provider ).
        ENDLOOP.

        sadl_runtime->fetch( EXPORTING is_paging          = paging
                                       is_parameters      = parameters
                                       is_requested       = requested
                             IMPORTING et_data_rows       = e_result_table
                                       ev_number_all_hits = e_number_all_hits ).

        " save parameters for reselection
        save_request( i_parameters               = parameters
                      i_paging                   = paging
                      i_requested                = requested
                      i_sadl_condition_providers = sadl_condition_providers ).

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.