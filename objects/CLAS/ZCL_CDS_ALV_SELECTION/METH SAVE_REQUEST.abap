  METHOD save_request.
    last_request-exists                   = abap_true.
    last_request-parameters               = i_parameters.
    last_request-paging                   = i_paging.
    last_request-requested                = i_requested.
    last_request-sadl_condition_providers = i_sadl_condition_providers.
  ENDMETHOD.