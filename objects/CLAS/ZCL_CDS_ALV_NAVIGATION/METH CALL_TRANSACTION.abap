  METHOD call_transaction.
    ASSIGN COMPONENT i_key_field OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<key>).

    IF i_navigation-parameter_id IS NOT INITIAL.
      SET PARAMETER ID i_navigation-parameter_id FIELD <key>.
    ENDIF.

    CALL TRANSACTION i_navigation-transaction_code
         WITH AUTHORITY-CHECK AND SKIP FIRST SCREEN.
  ENDMETHOD.