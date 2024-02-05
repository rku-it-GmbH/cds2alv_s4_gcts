  METHOD zif_cds_alv_selection_screen~value_help_for_field.
    IF value_help IS NOT BOUND.
      RETURN.
    ENDIF.

    TRY.
        DATA(fieldname) = selection_mappings[ progname = progname sel_name = i_sel_name ]-fieldname.

        get_selections( IMPORTING e_field_ranges = DATA(field_ranges) ).
        DATA(parameters) = get_parameters( ).

        value_help->value_help_for_element( EXPORTING i_fieldname    = fieldname
                                                      i_parameters   = parameters
                                                      i_field_ranges = field_ranges
                                            CHANGING  c_value        = c_value ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.

    TRY.
        DATA(parameter_name) = parameter_mappings[ progname = progname sel_name = i_sel_name ]-parname.

        value_help->value_help_for_parameter( EXPORTING i_parname = parameter_name
                                              CHANGING  c_value   = c_value ).

      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.