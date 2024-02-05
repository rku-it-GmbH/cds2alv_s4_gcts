  METHOD zif_cds_alv_factory~get_persistence.
    r_persistence ?= get_parent_container( )->resolve( ).
  ENDMETHOD.