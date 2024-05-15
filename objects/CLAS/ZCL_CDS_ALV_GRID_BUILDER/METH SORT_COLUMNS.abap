  METHOD sort_columns.
    TYPES: BEGIN OF ty_field_position,
             fieldname TYPE fieldname,
             position  TYPE lvc_colpos,
           END OF ty_field_position.

    DATA field_positions TYPE STANDARD TABLE OF ty_field_position.

    SORT fieldcatalog BY col_pos ASCENDING.
    SORT field_properties_table BY position ASCENDING.
    DATA(position) = 1.

    LOOP AT field_properties_table INTO DATA(field_properties) WHERE position IS NOT INITIAL.
      INSERT VALUE #( fieldname = field_properties-fieldname
                      position  = position )
             INTO TABLE field_positions.
      position += 1.
    ENDLOOP.

    LOOP AT fieldcatalog ASSIGNING FIELD-SYMBOL(<field>).
      TRY.
          DATA(field_position) = field_positions[ fieldname = <field>-fieldname ].
          <field>-col_pos = field_position-position.
        CATCH cx_sy_itab_line_not_found.
          <field>-col_pos = position.
          position += 1.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.