  METHOD dispatch_standard_function.
    TRY.
        CASE i_function.
          WHEN standard_function_code-refresh.
            refresh( ).

          WHEN standard_function_code-toggle_change_mode.
            toggle_change_mode( ).

          WHEN standard_function_code-delete.
            IF bopf_handler IS BOUND.
              bopf_handler->delete( i_selected_rows ).
              refresh( ).
            ENDIF.

          WHEN standard_function_code-save.
            IF bopf_handler IS BOUND.
              bopf_handler->update( i_selected_rows ).
              refresh( ).
            ENDIF.
        ENDCASE.

      CATCH zcx_cds_alv_message INTO DATA(message).
        MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.