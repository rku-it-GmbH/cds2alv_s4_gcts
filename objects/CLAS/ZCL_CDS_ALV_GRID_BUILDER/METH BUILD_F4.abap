  METHOD build_f4.
    value_help_fields = VALUE #( FOR field_properties IN field_properties_table
                                 WHERE
                                 ( has_value_help = abap_true )
                                 ( fieldname  = field_properties-fieldname
                                   register   = abap_true
                                   getbefore  = abap_true
                                   chngeafter = abap_true ) ).
  ENDMETHOD.