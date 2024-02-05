  METHOD zif_cds_alv_factory~get_value_help.
    r_value_help ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.