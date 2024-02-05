  METHOD zif_cds_alv_factory~get_report_generator.
    r_generator ?= get_parent_container( )->resolve( ).
  ENDMETHOD.