  METHOD is_oo_exception.
    LOOP AT i_exceptions INTO DATA(exception).
      TRY.
          " Exception Name is an exception Class?
          cl_oo_class=>get_instance( exception-name ).

          r_is_oo_exception = abap_true.
        CATCH cx_class_not_existent.
          r_is_oo_exception = abap_false.
      ENDTRY.

      " Either all or none are OO exceptions
      RETURN.
    ENDLOOP.
  ENDMETHOD.