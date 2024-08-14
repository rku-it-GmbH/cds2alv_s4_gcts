  METHOD zif_cds_alv_factory~get_action_handler.
    r_action_handler ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.