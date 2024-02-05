  METHOD zif_cds_alv_ioc_container~register_implementing_class.
    check_interface( i_interface ).
    check_class( i_class ).
    check_implements( i_class = i_class i_interface = i_interface ).

    READ TABLE implementations ASSIGNING FIELD-SYMBOL(<implementation>)
         WITH KEY interface = i_interface
                  filters   = i_filters.
    IF sy-subrc <> 0.
      INSERT VALUE #( interface = i_interface filters = i_filters )
             INTO TABLE implementations ASSIGNING <implementation>.
    ENDIF.

    <implementation>-class      = i_class.
    <implementation>-parameters = i_parameters.
  ENDMETHOD.