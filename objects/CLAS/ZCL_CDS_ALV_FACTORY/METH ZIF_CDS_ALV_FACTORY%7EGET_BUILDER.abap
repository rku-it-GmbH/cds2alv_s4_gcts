  METHOD zif_cds_alv_factory~get_builder.
    r_builder ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.