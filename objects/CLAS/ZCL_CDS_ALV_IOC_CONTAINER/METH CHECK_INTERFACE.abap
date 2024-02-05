  METHOD check_interface.
    TRY.
        IF cl_oo_object=>get_instance( i_interface ) IS NOT INSTANCE OF cl_oo_interface.
          RAISE EXCEPTION TYPE cx_class_not_existent
            EXPORTING clsname = i_interface.
        ENDIF.

      CATCH cx_class_not_existent.
        RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e028(zcds_alv) WITH i_interface.
    ENDTRY.
  ENDMETHOD.