  METHOD zif_cds_alv_factory~get_launcher.
    r_launcher ?= get_parent_container( )->resolve( ).
  ENDMETHOD.