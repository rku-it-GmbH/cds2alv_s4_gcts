  METHOD get_constructor_parameters.
    TRY.
        DATA(class) = CAST cl_oo_class( cl_oo_class=>get_instance( i_class_name ) ).
        IF line_exists( class->methods[ cmpname = 'CONSTRUCTOR' ] ).
          r_parameters = VALUE #( FOR parameter IN class->method_parameters
                                  WHERE
                                  ( cmpname = 'CONSTRUCTOR' )
                                  ( parameter ) ).
        ELSEIF class->superclass IS NOT INITIAL.
          r_parameters = get_constructor_parameters( class->superclass ).
        ENDIF.
      CATCH cx_class_not_existent.
    ENDTRY.
  ENDMETHOD.