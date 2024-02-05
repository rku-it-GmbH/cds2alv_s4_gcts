  METHOD get_return_type.
    DATA(depth) = 2 + i_increase_depth_by.
    DATA(call_stack) = cl_abap_get_call_stack=>get_call_stack( ).
    DATA(formatted_call_stack) = cl_abap_get_call_stack=>format_call_stack_with_struct( call_stack ).
    DATA(last_caller) = formatted_call_stack[ depth ].
    SPLIT last_caller-event_long AT '=>' INTO DATA(class_name) DATA(long_method_name).
    IF long_method_name CS '~'.
      SPLIT long_method_name AT '~' INTO DATA(interface_name) DATA(method_name).
    ELSE.
      method_name = long_method_name.
    ENDIF.

    TRY.
        IF interface_name IS NOT INITIAL AND method_name IS NOT INITIAL.
          DATA(interface) = cl_oo_interface=>get_instance( CONV #( interface_name ) ).
          r_return_type = interface->method_parameters[ cmpname = method_name pardecltyp = seos_pardecltyp_returning ]-type.
        ELSEIF class_name IS NOT INITIAL AND method_name IS NOT INITIAL.
          DATA(class) = cl_oo_class=>get_instance( CONV #( class_name ) ).
          r_return_type = class->method_parameters[ cmpname = method_name pardecltyp = seos_pardecltyp_returning ]-type.
        ENDIF.

        check_interface( r_return_type ).
      CATCH cx_class_not_existent cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e030(zcds_alv) WITH method_name.
    ENDTRY.
  ENDMETHOD.