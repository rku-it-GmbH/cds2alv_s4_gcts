  METHOD zif_cds_alv_ddic_access~get_target_for_association.
    TRY.
        DATA dd_object TYPE REF TO if_dd_sobject.

        dd_object = NEW cl_dd_sobject( ).
        dd_object->read( EXPORTING sobjnames  = VALUE #( ( i_source_view ) )
                         IMPORTING dd08bv_tab = DATA(dd08bv_tab) ).

        READ TABLE dd08bv_tab INTO DATA(dd08bv)
             WITH KEY assocname_raw = i_association_name.

        r_target_view = dd08bv-strucobjn_t.

      CATCH cx_dd_sobject_get INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.