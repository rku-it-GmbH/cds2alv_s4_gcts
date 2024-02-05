  METHOD zif_cds_alv_factory~get_extension_provider.
    r_extension_provider ?= get_parent_container( )->resolve( ).
  ENDMETHOD.