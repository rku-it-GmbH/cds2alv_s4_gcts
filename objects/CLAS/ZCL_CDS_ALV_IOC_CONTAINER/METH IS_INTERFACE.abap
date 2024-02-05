  METHOD is_interface.
    TRY.
        r_is_interface = xsdbool( cl_oo_object=>get_instance( CONV #( i_parameter_type ) ) IS INSTANCE OF cl_oo_interface ).
      CATCH cx_class_not_existent.
        r_is_interface = abap_false.
    ENDTRY.
  ENDMETHOD.