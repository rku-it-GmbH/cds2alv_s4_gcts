  METHOD get_last_request.
    e_exists = last_request-exists.
    e_parameters = last_request-parameters.
    e_paging = last_request-paging.
    e_requested = last_request-requested.
    e_sadl_condition_providers = last_request-sadl_condition_providers.
  ENDMETHOD.