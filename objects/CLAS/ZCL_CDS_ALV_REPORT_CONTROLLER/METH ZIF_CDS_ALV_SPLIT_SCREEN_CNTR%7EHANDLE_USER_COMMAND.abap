  METHOD zif_cds_alv_split_screen_cntr~handle_user_command.
    CASE i_ok_code.
      WHEN ok_code-select.
        select( ).

      WHEN OTHERS.
        LOOP AT extensions INTO DATA(extension).
          extension-instance->handle_user_command( i_selection_screen = selection_screen
                                                   i_user_command     = CONV #( i_ok_code ) ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.