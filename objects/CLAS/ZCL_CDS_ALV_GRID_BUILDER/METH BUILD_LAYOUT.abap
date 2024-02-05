  METHOD build_layout.
    CONSTANTS row_column TYPE lvc_libox VALUE 'A' ##NO_TEXT.

    layout-col_opt    = abap_true.
    layout-cwidth_opt = abap_true.
    layout-grid_title = description.
    layout-zebra      = abap_true.

    IF table_container IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA(special_columns) = table_container->get_special_columns( ).
    IF special_columns-count_fieldname IS NOT INITIAL.
      layout-countfname = special_columns-count_fieldname.
    ENDIF.

    IF special_columns-style_fieldname IS NOT INITIAL.
      layout-stylefname = special_columns-style_fieldname.
      layout-edit       = abap_true.
    ENDIF.

    IF special_columns-box_fieldname IS NOT INITIAL.
      layout-box_fname = special_columns-box_fieldname.
      layout-sel_mode  = row_column.
    ENDIF.

    IF special_columns-info_fieldname IS NOT INITIAL.
      layout-info_fname = special_columns-info_fieldname.
    ENDIF.

    IF special_columns-color_fieldname IS NOT INITIAL.
      layout-ctab_fname = special_columns-color_fieldname.
    ENDIF.

    IF special_columns-excp_fieldname IS NOT INITIAL.
      layout-excp_fname = special_columns-excp_fieldname.
      layout-excp_led   = abap_true.
    ENDIF.
  ENDMETHOD.