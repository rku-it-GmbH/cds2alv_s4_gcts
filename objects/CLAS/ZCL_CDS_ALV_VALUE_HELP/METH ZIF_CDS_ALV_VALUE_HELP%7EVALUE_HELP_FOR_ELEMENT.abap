  METHOD zif_cds_alv_value_help~value_help_for_element.
    TRY.
        e_processed = abap_false.

        DATA(value_helps_for_field) = VALUE zcds_alv_valuehelp_definitions( FOR x_value_help IN value_helps
                                                                            WHERE ( fieldname = i_fieldname )
                                                                            ( x_value_help ) ).

        IF lines( value_helps_for_field ) > 1.
          choose_value_help( CHANGING c_value_helps = value_helps_for_field ).
        ENDIF.

        DATA(value_help) = value_helps_for_field[ fieldname = i_fieldname ].

        IF     value_help-target_entity  IS NOT INITIAL
           AND value_help-target_element IS NOT INITIAL.
          value_help_by_target_entity( EXPORTING i_target_entity      = value_help-target_entity
                                                 i_target_element     = value_help-target_element
                                                 i_additional_binding = value_help-additional_binding
                                                 i_parameters         = i_parameters
                                                 i_field_ranges       = i_field_ranges
                                                 i_selected_row       = i_selected_row
                                                 i_display            = i_display
                                       CHANGING  c_value              = c_value ).

          e_processed = abap_true.

        ELSEIF value_help-association_name IS NOT INITIAL.
          value_help_by_association( EXPORTING i_fieldname        = i_fieldname
                                               i_association_name = value_help-association_name
                                               i_parameters       = i_parameters
                                               i_field_ranges     = i_field_ranges
                                               i_selected_row     = i_selected_row
                                               i_display          = i_display
                                     CHANGING  c_value            = c_value ).

          e_processed = abap_true.
        ENDIF.

      CATCH cx_sy_itab_line_not_found.
        e_processed = abap_false.
    ENDTRY.
  ENDMETHOD.