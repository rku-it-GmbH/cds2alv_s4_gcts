  METHOD zif_cds_alv_ddic_access~get_parameters_for_cds_view.
    TRY.
        DATA dd_object TYPE REF TO if_dd_sobject.

        dd_object = NEW cl_dd_sobject( ).
        dd_object->read( EXPORTING sobjnames  = VALUE #( ( i_cds_view ) )
                         IMPORTING dd10bv_tab = r_dd10bv_tab ).

      CATCH cx_dd_sobject_get INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.