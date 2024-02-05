  METHOD adjust_table.
    FIELD-SYMBOLS <table>       TYPE STANDARD TABLE.
    FIELD-SYMBOLS <color_table> TYPE lvc_t_scol.

    ASSIGN ref_to_table->* TO <table>.
    LOOP AT <table> ASSIGNING FIELD-SYMBOL(<line>).
      DATA(index) = sy-tabix.
      ASSIGN COMPONENT special_columns-index_fieldname OF STRUCTURE <line> TO FIELD-SYMBOL(<index>).
      IF sy-subrc = 0.
        <index> = index.
      ENDIF.

      ASSIGN COMPONENT special_columns-system_fieldname OF STRUCTURE <line> TO FIELD-SYMBOL(<system>).
      IF sy-subrc = 0 AND <system> IS INITIAL.
        <system> = sy-sysid.
      ENDIF.

      ASSIGN COMPONENT special_columns-client_fieldname OF STRUCTURE <line> TO FIELD-SYMBOL(<client>).
      IF sy-subrc = 0 AND <client> IS INITIAL.
        <client> = sy-mandt.
      ENDIF.

      " Setting the cell colors for criticality
      ASSIGN COMPONENT special_columns-color_fieldname OF STRUCTURE <line> TO <color_table>.
      IF sy-subrc = 0.
        LOOP AT criticality_mapping_table INTO DATA(mapping).
          ASSIGN COMPONENT mapping-crit_field OF STRUCTURE <line> TO FIELD-SYMBOL(<criticality>).
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.

          READ TABLE <color_table> ASSIGNING FIELD-SYMBOL(<color>)
               WITH KEY fname = mapping-data_field.
          IF sy-subrc <> 0.
            INSERT VALUE #( fname = mapping-data_field ) INTO TABLE <color_table> ASSIGNING <color>.
          ENDIF.

          <color>-nokeycol  = abap_true.
          <color>-color-col = SWITCH #( <criticality>
                                        WHEN criticality-neutral  THEN cl_gui_resources=>list_col_normal
                                        WHEN criticality-negative THEN cl_gui_resources=>list_col_negative
                                        WHEN criticality-critical THEN cl_gui_resources=>list_col_total
                                        WHEN criticality-positive THEN cl_gui_resources=>list_col_positive ).
        ENDLOOP.
      ENDIF.
    ENDLOOP.

    update_style_info( ).
  ENDMETHOD.