  METHOD dispatch_mass_action.
    TRY.
        DATA(refresh_after) = abap_false.

        IF     i_field_action-semantic_object IS NOT INITIAL
           AND i_field_action-semantic_action IS NOT INITIAL.
          IF navigation IS BOUND.
            navigation->navigate_to_object_mass( EXPORTING i_object        = i_field_action-semantic_object
                                                           i_action        = i_field_action-semantic_action
                                                           i_cds_view      = i_field_action-cds_view
                                                           i_key_field     = i_field_action-fieldname
                                                           i_selected_rows = i_selected_rows
                                                 IMPORTING e_refresh_after = refresh_after ).
          ENDIF.

        ELSEIF i_field_action-associationname IS NOT INITIAL.
          IF selection_screen IS BOUND.
            DATA(source_parameters) = selection_screen->get_parameters( ).
          ENDIF.

          IF navigation IS BOUND.
            navigation->navigate_via_association( i_source_view       = i_field_action-cds_view
                                                  i_association_name  = i_field_action-associationname
                                                  i_source_parameters = source_parameters
                                                  i_selected_rows     = i_selected_rows ).
          ENDIF.

        ELSEIF i_field_action-data_action IS NOT INITIAL.
          IF bopf_handler IS BOUND.
            bopf_handler->execute_action( EXPORTING i_action        = i_field_action-data_action
                                                    i_selected_rows = i_selected_rows
                                          IMPORTING e_refresh_after = refresh_after ).
          ENDIF.
        ENDIF.

        IF refresh_after = abap_true.
          refresh( ).
        ENDIF.

      CATCH zcx_cds_alv_message INTO DATA(message).
        MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.