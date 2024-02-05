  METHOD zif_cds_alv_factory~get_generation_strategy.
    r_strategy ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.