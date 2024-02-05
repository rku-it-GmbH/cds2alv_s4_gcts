  METHOD zif_cds_alv_ioc_container~resolve.
    DATA(interface) = COND #( WHEN i_interface IS NOT INITIAL
                              THEN i_interface
                              ELSE get_return_type(
                                       i_increase_depth_by = 1 ) ).

    IF parent IS BOUND.
      TRY.
          r_instance = parent->resolve( i_interface = i_interface i_filters = i_filters ).
          IF r_instance IS BOUND.
            RETURN.
          ENDIF.

        CATCH zcx_cds_alv_message.
          " not resolved by parent
      ENDTRY.
    ENDIF.

    TRY.
        r_instance = instances[ interface = interface filters = i_filters ]-object.

      CATCH cx_sy_itab_line_not_found.
        r_instance = create_object( i_interface = interface i_filters = i_filters ).
        store_object( i_interface = interface i_filters = i_filters i_object = r_instance ).
    ENDTRY.
  ENDMETHOD.