  METHOD zif_cds_alv_factory~get_report_controller.
    r_controller ?= get_container_for_cds_view( i_cds_view )->resolve( ).
  ENDMETHOD.