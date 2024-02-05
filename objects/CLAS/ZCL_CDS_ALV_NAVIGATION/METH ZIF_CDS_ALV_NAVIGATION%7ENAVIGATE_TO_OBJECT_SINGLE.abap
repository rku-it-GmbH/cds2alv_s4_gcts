  METHOD zif_cds_alv_navigation~navigate_to_object_single.
    e_refresh_after = abap_false.

    TRY.
        DATA(exit_called) = abap_false.
        DATA(navigation_exit) = navigation_exits[ semantic_object = i_object
                                                  semantic_action = i_action
                                                  cds_view        = i_cds_view ].

        DATA(exit_object) = get_object_from_ioc_container( navigation_exit ).

        exit_object->navigate_to_object_single( EXPORTING i_object        = i_object
                                                          i_action        = i_action
                                                          i_cds_view      = i_cds_view
                                                          i_key_field     = i_key_field
                                                          i_selected_row  = i_selected_row
                                                IMPORTING e_refresh_after = e_refresh_after ).

        exit_called = abap_true.
      CATCH cx_sy_itab_line_not_found.
        exit_called = abap_false.
    ENDTRY.

    IF exit_called = abap_true.
      RETURN.
    ENDIF.

    TRY.
        DATA(navigation) = navigation_table[ semantic_object = i_object
                                             semantic_action = i_action ].

        IF     navigation-function          IS NOT INITIAL
           AND navigation-default_parameter IS NOT INITIAL.
          call_function_module( i_navigation   = navigation
                                i_key_field    = i_key_field
                                i_selected_row = i_selected_row ).

        ELSEIF     navigation-object_type   IS NOT INITIAL
               AND navigation-object_method IS NOT INITIAL.
          call_bor_method( i_navigation   = navigation
                           i_key_field    = i_key_field
                           i_selected_row = i_selected_row ).

        ELSEIF navigation-transaction_code IS NOT INITIAL.
          call_transaction( i_navigation   = navigation
                            i_key_field    = i_key_field
                            i_selected_row = i_selected_row ).

        ELSEIF     navigation-class            IS NOT INITIAL
               AND navigation-method           IS NOT INITIAL
               AND navigation-method_parameter IS NOT INITIAL.
          call_oo_method( i_navigation   = navigation
                          i_key_field    = i_key_field
                          i_selected_row = i_selected_row ).
        ENDIF.

        e_refresh_after = navigation-refresh_after.

      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE e002(zcds_alv) WITH i_object i_action.
    ENDTRY.
  ENDMETHOD.