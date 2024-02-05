  METHOD check_class.
    TRY.
        IF cl_oo_object=>get_instance( i_class ) IS NOT INSTANCE OF cl_oo_class.
          RAISE EXCEPTION TYPE cx_class_not_existent
            EXPORTING clsname = i_class.
        ENDIF.

      CATCH cx_class_not_existent.
        RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e027(zcds_alv) WITH i_class.
    ENDTRY.
  ENDMETHOD.