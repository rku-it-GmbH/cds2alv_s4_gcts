  METHOD store_object.
    check_interface( i_interface ).
    DATA(interface_descriptor) = CAST cl_abap_intfdescr( cl_abap_typedescr=>describe_by_name( i_interface ) ).

    IF NOT interface_descriptor->applies_to( i_object ).
      RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e015(zcds_alv) WITH i_interface.
    ENDIF.

    READ TABLE instances ASSIGNING FIELD-SYMBOL(<instance>)
         WITH KEY interface = i_interface
                  filters   = i_filters.
    IF sy-subrc <> 0.
      INSERT VALUE #( interface = i_interface filters = i_filters )
             INTO TABLE instances ASSIGNING <instance>.
    ENDIF.

    <instance>-object = i_object.
  ENDMETHOD.