  METHOD get_unique_fieldname.
    IF line_exists( i_components[ name = i_fieldname ] ).
      r_fieldname = get_unique_fieldname( i_components = i_components i_fieldname = |_{ i_fieldname }| ).
    ELSE.
      r_fieldname = i_fieldname.
    ENDIF.
  ENDMETHOD.