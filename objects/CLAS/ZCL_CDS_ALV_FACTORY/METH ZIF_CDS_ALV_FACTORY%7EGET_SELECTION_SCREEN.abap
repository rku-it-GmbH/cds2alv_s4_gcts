  METHOD zif_cds_alv_factory~get_selection_screen.
    r_selection_screen ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.