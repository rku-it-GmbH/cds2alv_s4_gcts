  METHOD zif_cds_alv_selection_screen~get_dynpro_field.
    CLEAR: e_parameter,
           e_select_options.

    LOOP AT selection_table INTO DATA(selection)
         WHERE selname = i_sel_name.

      CASE selection-kind.
        WHEN kind-parameter.
          e_parameter = selection-low.
        WHEN kind-select_option.
          APPEND CORRESPONDING #( selection ) TO e_select_options.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.