  PROTECTED SECTION.
    TYPES ty_sadl_condition_providers TYPE STANDARD TABLE OF REF TO if_sadl_condition_provider WITH EMPTY KEY.

    DATA: BEGIN OF last_request,
            exists                   TYPE abap_bool,
            parameters               TYPE if_sadl_query_engine_types=>ty_parameters,
            paging                   TYPE if_sadl_query_engine_types=>ty_paging,
            requested                TYPE if_sadl_query_engine_types=>ty_requested,
            sadl_condition_providers TYPE ty_sadl_condition_providers,
          END OF last_request.

    METHODS evaluate_annotations REDEFINITION.

    METHODS save_request
      IMPORTING i_parameters               TYPE if_sadl_query_engine_types=>ty_parameters OPTIONAL
                i_paging                   TYPE if_sadl_query_engine_types=>ty_paging     OPTIONAL
                i_requested                TYPE if_sadl_query_engine_types=>ty_requested  OPTIONAL
                i_sadl_condition_providers TYPE ty_sadl_condition_providers               OPTIONAL.

    METHODS get_last_request
      EXPORTING e_exists                   TYPE abap_bool
                e_parameters               TYPE if_sadl_query_engine_types=>ty_parameters
                e_paging                   TYPE if_sadl_query_engine_types=>ty_paging
                e_requested                TYPE if_sadl_query_engine_types=>ty_requested
                e_sadl_condition_providers TYPE ty_sadl_condition_providers.
