  METHOD zif_cds_alv_selection_screen~set_dynpro_field.
    IF i_parameter IS NOT INITIAL.
      selection_table[ selname = i_sel_name ]-low = i_parameter.
    ELSEIF i_select_options IS NOT INITIAL.
      DELETE selection_table WHERE selname = i_sel_name.
      LOOP AT i_select_options INTO DATA(select_option).
        INSERT CORRESPONDING #( BASE ( VALUE #( selname = i_sel_name kind = 'S' ) ) select_option )
               INTO TABLE selection_table.
      ENDLOOP.
    ENDIF.

    set_new_selections( ).
  ENDMETHOD.