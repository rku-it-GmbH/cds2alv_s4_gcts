  METHOD get_extension_parameters.
    r_extension_parameters = VALUE #( FOR x_extension IN persistence->get_report_extensions( cds_view )
                                      ( LINES OF persistence->get_extension_parameters( x_extension-extension_name ) ) ).
  ENDMETHOD.