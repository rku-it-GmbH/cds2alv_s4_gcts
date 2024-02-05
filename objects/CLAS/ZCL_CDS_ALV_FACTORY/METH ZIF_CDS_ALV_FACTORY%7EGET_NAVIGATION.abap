  METHOD zif_cds_alv_factory~get_navigation.
    r_navigation ?= get_parent_container( )->resolve( ).
  ENDMETHOD.