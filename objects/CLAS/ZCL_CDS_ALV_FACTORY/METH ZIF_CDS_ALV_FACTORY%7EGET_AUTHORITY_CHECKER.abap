  METHOD zif_cds_alv_factory~get_authority_checker.
    r_authority_checker ?= get_parent_container( )->resolve( ).
  ENDMETHOD.