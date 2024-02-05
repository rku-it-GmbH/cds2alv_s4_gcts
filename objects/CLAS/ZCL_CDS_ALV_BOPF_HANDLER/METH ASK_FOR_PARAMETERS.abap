  METHOD ask_for_parameters.
    DATA fields TYPE STANDARD TABLE OF sval.

    DATA(descriptor) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data( c_parameters ) ).
    IF descriptor->is_ddic_type( ).
      fields = VALUE #( FOR x_ddic_field IN descriptor->get_ddic_field_list( )
                        ( tabname   = x_ddic_field-tabname
                          fieldname = x_ddic_field-fieldname
                          fieldtext = x_ddic_field-scrtext_m ) ).
    ELSE.
      fields = VALUE #( FOR x_component IN descriptor->components
                        ( tabname   = descriptor->get_relative_name( )
                          fieldname = x_component-name
                          fieldtext = x_component-name ) ).
    ENDIF.

    CALL FUNCTION 'POPUP_GET_VALUES'
      EXPORTING  popup_title     = 'Parameter eingeben'
      TABLES     fields          = fields
      EXCEPTIONS error_in_fields = 1
                 OTHERS          = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    LOOP AT fields INTO DATA(field).
      ASSIGN COMPONENT field-fieldname OF STRUCTURE c_parameters TO FIELD-SYMBOL(<parameter>).
      IF sy-subrc = 0.
        <parameter> = field-value.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.