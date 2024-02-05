  METHOD zif_cds_alv_factory~get_memory.
    r_memory ?= get_parent_container( )->resolve( ).
  ENDMETHOD.