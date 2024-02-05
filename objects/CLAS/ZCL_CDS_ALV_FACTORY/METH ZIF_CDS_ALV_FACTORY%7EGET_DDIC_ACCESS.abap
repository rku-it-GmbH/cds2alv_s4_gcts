  METHOD zif_cds_alv_factory~get_ddic_access.
    r_ddic_access ?= get_parent_container( )->resolve( ).
  ENDMETHOD.