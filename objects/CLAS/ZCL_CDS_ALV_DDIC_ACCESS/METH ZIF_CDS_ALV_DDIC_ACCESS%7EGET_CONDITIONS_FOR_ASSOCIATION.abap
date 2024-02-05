  METHOD zif_cds_alv_ddic_access~get_conditions_for_association.
    TRY.
        DATA dd_object TYPE REF TO if_dd_sobject.

        dd_object = NEW cl_dd_sobject( ).
        dd_object->read( EXPORTING sobjnames  = VALUE #( ( i_source_view ) )
                         IMPORTING dd08bv_tab = e_dd08bv_tab
                                   dd05bv_tab = e_dd05bv_tab ).

        READ TABLE e_dd08bv_tab INTO DATA(dd08bv)
             WITH KEY assocname_raw = i_association_name.

        e_target_view = dd08bv-strucobjn_t.
        DELETE e_dd08bv_tab WHERE associationname <> dd08bv-associationname.
        DELETE e_dd05bv_tab WHERE associationname <> dd08bv-associationname.

        " This removes conditions on the source and target view to allow
        " Navigation via association in cases where no FORALL table is available.
        " The implementation is somewhat ad hoc and may well need future adjustment
        " for complex conditions that are not correctly rearranged by it.
        IF i_only_constants = abap_true.
          SORT e_dd05bv_tab BY fdposition DESCENDING.
          LOOP AT e_dd05bv_tab ASSIGNING FIELD-SYMBOL(<curr_dd05bv>).
            DATA(curr_tabix) = sy-tabix.

            IF <curr_dd05bv>-side_info CO 'LPS'.
              CONTINUE.
            ENDIF.

            READ TABLE e_dd05bv_tab INDEX ( curr_tabix + 1 ) ASSIGNING FIELD-SYMBOL(<prev_dd05bv>).
            IF sy-subrc = 0.
              IF <curr_dd05bv>-and_or = 'AND' AND <prev_dd05bv>-and_or = 'OR'.
                <prev_dd05bv>-and_or = 'AND'.
              ELSEIF <curr_dd05bv>-and_or IS INITIAL.
                CLEAR <prev_dd05bv>-and_or.
              ENDIF.
            ENDIF.

            DELETE e_dd05bv_tab INDEX curr_tabix.
            CONTINUE.
          ENDLOOP.
        ENDIF.

      CATCH cx_dd_sobject_get INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.