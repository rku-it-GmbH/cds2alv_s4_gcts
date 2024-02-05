  METHOD zif_cds_alv_factory~get_selection.
    r_selection ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.