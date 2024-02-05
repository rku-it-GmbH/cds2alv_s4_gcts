  METHOD dispatch_single_action.
    TRY.
        DATA(refresh_after) = abap_false.

        IF     i_field_action-semantic_object IS NOT INITIAL
           AND i_field_action-semantic_action IS NOT INITIAL.
          IF navigation IS BOUND.
            navigation->navigate_to_object_single( EXPORTING i_object        = i_field_action-semantic_object
                                                             i_action        = i_field_action-semantic_action
                                                             i_cds_view      = i_field_action-cds_view
                                                             i_key_field     = i_field_action-fieldname
                                                             i_selected_row  = i_selected_row
                                                   IMPORTING e_refresh_after = refresh_after ).
          ENDIF.

        ELSEIF i_field_action-url_fieldname IS NOT INITIAL.
          ASSIGN COMPONENT i_field_action-url_fieldname OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<url>).
          call_browser( to_lower( <url> ) ).
        ELSEIF i_field_action-send_mail IS NOT INITIAL.
          ASSIGN COMPONENT i_field_action-fieldname OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<email>).
          send_email( CONV #( <email> ) ).
        ENDIF.

        IF refresh_after = abap_true.
          refresh( ).
        ENDIF.

      CATCH zcx_cds_alv_message INTO DATA(message).
        MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.