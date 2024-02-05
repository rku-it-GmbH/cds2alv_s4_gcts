  METHOD build_fieldcatalog.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = cds_view
      CHANGING
        ct_fieldcat            = fieldcatalog
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    DELETE fieldcatalog WHERE fieldname = '.NODE1'.

    " Apply Annotations
    LOOP AT fieldcatalog ASSIGNING FIELD-SYMBOL(<field>).
      READ TABLE field_properties_table INTO DATA(field_properties)
           WITH KEY fieldname = <field>-fieldname.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      READ TABLE ddfields INTO DATA(ddfield)
           WITH KEY fieldname = <field>-fieldname.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      IF field_properties-label IS NOT INITIAL.
        <field>-reptext = field_properties-label.

        IF strlen( field_properties-label ) <= 40.
          <field>-scrtext_l = field_properties-label.
        ENDIF.
        IF strlen( field_properties-label ) <= 20.
          <field>-scrtext_m = field_properties-label.
        ENDIF.
        IF strlen( field_properties-label ) <= 10.
          <field>-scrtext_s = field_properties-label.
        ENDIF.
      ENDIF.

      IF field_properties-quickinfo IS NOT INITIAL.
        <field>-tooltip = field_properties-quickinfo.
      ENDIF.

      IF ddfield-domname = 'XFELD' OR ddfield-rollname = 'XFELD'.
        <field>-checkbox = abap_true.
      ENDIF.

      <field>-tech    = field_properties-technical.
      <field>-no_out  = field_properties-hidden.
      <field>-hotspot = field_properties-is_hotspot.
      <field>-edit    = field_properties-is_editable.
      <field>-do_sum  = SWITCH #( field_properties-default_aggregation
                                  WHEN '#MAX'  THEN 'A'
                                  WHEN '#MIN'  THEN 'B'
                                  WHEN '#AVG'  THEN 'C'
                                  WHEN '#SUM'  THEN 'X'
                                  WHEN '#NONE' THEN ' ' ).

      IF field_properties-has_value_help = abap_true.
        <field>-f4availabl = abap_true.
      ENDIF.

      " CFIELDNAME from Semantics.amount.currencyCode
      " QFIELDNAME from Semantics.quantity.unitOfMeasure
      " SP_GROUP map to UI.lineItem.qualifier
    ENDLOOP.

    IF table_container IS BOUND.
      DATA(special_columns) = table_container->get_special_columns( ).
      IF special_columns-index_fieldname IS NOT INITIAL.
        IF NOT line_exists( fieldcatalog[ fieldname = special_columns-index_fieldname ] ).
          INSERT VALUE #( fieldname = special_columns-index_fieldname
                          no_out    = abap_true
                          tech      = abap_true
                          ref_table = 'SE16N_REF'
                          ref_field = 'SE16N_LONG_LINES' )
                 INTO TABLE fieldcatalog.
        ENDIF.
      ENDIF.

      IF special_columns-count_fieldname IS NOT INITIAL.
        IF NOT line_exists( fieldcatalog[ fieldname = special_columns-count_fieldname ] ).
          INSERT VALUE #( fieldname = special_columns-count_fieldname
                          no_out    = abap_true
                          tech      = abap_true
                          ref_table = 'SE16N_REF'
                          ref_field = 'SE16N_LONG_LINES' )
                 INTO TABLE fieldcatalog.
        ENDIF.
      ENDIF.

      IF special_columns-system_fieldname IS NOT INITIAL.
        IF NOT line_exists( fieldcatalog[ fieldname = special_columns-system_fieldname ] ).
          INSERT VALUE #( fieldname = special_columns-system_fieldname
                          no_out    = abap_true
                          key       = abap_true
                          ref_table = 'SYST'
                          ref_field = 'SYSID' )
                 INTO TABLE fieldcatalog.
        ENDIF.
      ENDIF.

      IF special_columns-client_fieldname IS NOT INITIAL.
        IF NOT line_exists( fieldcatalog[ fieldname = special_columns-client_fieldname ] ).
          INSERT VALUE #( fieldname = special_columns-client_fieldname
                          no_out    = abap_true
                          key       = abap_true
                          ref_table = 'SYST'
                          ref_field = 'MANDT' )
                 INTO TABLE fieldcatalog.
        ENDIF.
      ENDIF.
    ENDIF.

    sort_columns( ).
  ENDMETHOD.