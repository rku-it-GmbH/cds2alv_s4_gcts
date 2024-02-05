  METHOD zif_cds_alv_selection_screen~modify_screen.
    read_selection_screen( ).

    DATA(selection_values) = VALUE vrm_values( FOR x_selection IN persistence->get_report_extensions( i_cds_view = cds_view i_only_selection = abap_true )
                                               ( key = x_selection-extension_name text = x_selection-selection_text ) ).

    IF selection_values IS NOT INITIAL.
      INSERT VALUE #( key = space text = text-sel ) INTO selection_values INDEX 1.
    ENDIF.

    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING  id     = CONV vrm_id( fixed_parameters-selection )
                 values = selection_values
      EXCEPTIONS OTHERS = 1.
    IF sy-subrc <> 0.
      CLEAR selection_values.
    ENDIF.

    DATA(display_values) = VALUE vrm_values( FOR x_display IN persistence->get_report_extensions( i_cds_view = cds_view i_only_display = abap_true )
                                             ( key = x_display-extension_name text = x_display-display_text ) ).

    IF display_values IS NOT INITIAL.
      INSERT VALUE #( key = space text = text-dis ) INTO display_values INDEX 1.
    ENDIF.

    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING  id     = CONV vrm_id( fixed_parameters-display )
                 values = display_values
      EXCEPTIONS OTHERS = 1.
    IF sy-subrc <> 0.
      CLEAR display_values.
    ENDIF.

    TRY.
        DATA(no_max) = CONV abap_bool( selection_table[ selname = fixed_parameters-no_max ]-low ).
      CATCH cx_sy_itab_line_not_found.
        no_max = abap_false.
    ENDTRY.

    DATA(alternative_display) = VALUE zcds_alv_report_extension_name( ).
    get_dynpro_field( EXPORTING i_sel_name  = fixed_parameters-display
                      IMPORTING e_parameter = alternative_display ).

    LOOP AT SCREEN.
      CASE screen-group1.
        WHEN modif_id-max.
          screen-input = SWITCH #( no_max
                                   WHEN abap_true  THEN '0'
                                   WHEN abap_false THEN '1' ).
        WHEN modif_id-sel.
          screen-active = COND #( WHEN selection_values IS INITIAL THEN '0' ELSE '1' ).
        WHEN modif_id-dis.
          screen-active = COND #( WHEN display_values IS INITIAL THEN '0' ELSE '1' ).
      ENDCASE.

      IF screen-name = fixed_parameters-split.
        screen-input = COND #( WHEN alternative_display IS INITIAL THEN '1' ELSE '0' ).
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDMETHOD.