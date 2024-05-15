  METHOD zif_cds_alv_grid_event_handler~on_menu_button.
    IF e_ucomm = standard_function_code-additional_functions_menu.
      LOOP AT additional_functions INTO DATA(function).
        e_object->add_function( fcode = function-name
                                text  = CONV #( function-text )
                                icon  = CONV #( function-icon ) ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.