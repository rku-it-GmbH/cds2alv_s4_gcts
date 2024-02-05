  METHOD zif_cds_alv_table_container~toggle_change_mode.
    in_edit_mode = xsdbool( in_edit_mode = abap_false ).
    update_style_info( ).

    i_alv_grid->get_frontend_fieldcatalog( IMPORTING et_fieldcatalog = DATA(fieldcatalog) ).

    LOOP AT fieldcatalog ASSIGNING FIELD-SYMBOL(<field>).
      IF line_exists( read_only_fields[ table_line = <field>-fieldname ] ).
        <field>-edit = abap_false.
      ELSE.
        <field>-edit = in_edit_mode.
      ENDIF.
    ENDLOOP.

    i_alv_grid->set_frontend_fieldcatalog( fieldcatalog ).
  ENDMETHOD.