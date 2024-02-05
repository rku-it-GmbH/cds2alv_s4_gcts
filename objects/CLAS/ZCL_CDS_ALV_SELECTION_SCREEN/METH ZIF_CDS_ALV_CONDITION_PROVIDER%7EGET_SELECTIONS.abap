  METHOD zif_cds_alv_condition_provider~get_selections.
    CLEAR: e_where_tab,
           e_field_ranges,
           e_maxrec,
           e_no_max.

    LOOP AT selection_table INTO DATA(selection) WHERE kind = kind-select_option.
      READ TABLE selection_mappings INTO DATA(selection_mapping)
           WITH TABLE KEY progname = progname sel_name = selection-selname.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      READ TABLE e_field_ranges ASSIGNING FIELD-SYMBOL(<field_ranges>)
           WITH KEY fieldname = selection_mapping-fieldname.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO e_field_ranges ASSIGNING <field_ranges>.
        <field_ranges>-fieldname = selection_mapping-fieldname.
      ENDIF.

      IF selection-sign IS NOT INITIAL AND selection-option IS NOT INITIAL.
        APPEND CORRESPONDING #( selection ) TO <field_ranges>-selopt_t.
      ENDIF.
    ENDLOOP.

    DATA(field_ranges)  = VALUE rsds_trange( ( tablename = cds_view frange_t = e_field_ranges ) ).
    DATA(where_clauses) = VALUE rsds_twhere( ).

    CALL FUNCTION 'FREE_SELECTIONS_RANGE_2_WHERE'
      EXPORTING field_ranges  = field_ranges
      IMPORTING where_clauses = where_clauses.

    TRY.
        e_where_tab = where_clauses[ tablename = cds_view ]-where_tab.
      CATCH cx_sy_itab_line_not_found.
        CLEAR e_where_tab.
    ENDTRY.

    TRY.
        e_no_max = selection_table[ kind = kind-parameter selname = fixed_parameters-no_max ]-low.
      CATCH cx_sy_itab_line_not_found.
        e_no_max = abap_false.
    ENDTRY.

    IF e_no_max = abap_true.
      e_maxrec = 0.
    ELSE.
      TRY.
          e_maxrec = selection_table[ kind = kind-parameter selname = fixed_parameters-max_records ]-low.
        CATCH cx_sy_itab_line_not_found.
          e_maxrec = default_maxrec.
      ENDTRY.
    ENDIF.
  ENDMETHOD.