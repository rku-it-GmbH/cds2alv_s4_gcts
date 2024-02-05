  METHOD zif_cds_alv_factory~get_table_container.
    r_table_container ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.