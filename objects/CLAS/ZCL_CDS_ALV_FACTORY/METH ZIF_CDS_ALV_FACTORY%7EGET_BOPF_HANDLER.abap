  METHOD zif_cds_alv_factory~get_bopf_handler.
    r_bopf_handler ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.