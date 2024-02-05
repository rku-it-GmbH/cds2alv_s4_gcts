  METHOD zif_cds_alv_selection~perform_reselection.
    get_last_request( IMPORTING e_exists                   = DATA(exists)
                                e_parameters               = DATA(parameters)
                                e_paging                   = DATA(paging)
                                e_requested                = DATA(requested)
                                e_sadl_condition_providers = DATA(sadl_condition_providers) ).

    IF exists = abap_false.
      RETURN.
    ENDIF.

    TRY.
        DATA(sadl_runtime) = ddic_access->get_sadl_runtime( cds_view ).

        LOOP AT sadl_condition_providers INTO DATA(sadl_condition_provider).
          sadl_runtime->if_sadl_query_fetch~register_condition_provider( sadl_condition_provider ).
        ENDLOOP.

        sadl_runtime->fetch( EXPORTING is_requested  = requested
                                       is_paging     = paging
                                       is_parameters = parameters
                             IMPORTING et_data_rows  = c_result_table ).

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.