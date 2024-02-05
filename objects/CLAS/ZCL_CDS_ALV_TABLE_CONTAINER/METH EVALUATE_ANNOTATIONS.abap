  METHOD evaluate_annotations.
    " Create Table: All elements of the CDS view + special fields (box, style, color, etc.)
    ddic_structure_descriptor = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( cds_view ) ).
    DATA(components) = ddic_structure_descriptor->get_components( ).

    special_columns = VALUE zcds_alv_special_columns( ).
    criticality_mapping_table = VALUE ty_criticality_mapping_table( ).

    special_columns-index_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-index ).
    INSERT VALUE #( name = special_columns-index_fieldname type = CAST #( cl_abap_elemdescr=>get_i( ) ) ) INTO TABLE components.

    special_columns-count_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-count ).
    INSERT VALUE #( name = special_columns-count_fieldname type = CAST #( cl_abap_elemdescr=>get_i( ) ) ) INTO TABLE components.

    special_columns-box_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-box ).
    INSERT VALUE #( name = special_columns-box_fieldname type = CAST #( cl_abap_typedescr=>describe_by_name( 'XFELD' ) ) ) INTO TABLE components.

    special_columns-system_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-system ).
    INSERT VALUE #( name = special_columns-system_fieldname type = CAST #( cl_abap_typedescr=>describe_by_name( 'SYST_SYSID' ) ) ) INTO TABLE components.

    special_columns-client_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-client ).
    INSERT VALUE #( name = special_columns-client_fieldname type = CAST #( cl_abap_typedescr=>describe_by_name( 'MANDT' ) ) ) INTO TABLE components.

    DATA(update_enabled) = xsdbool( line_exists( entity_annotations[ annoname = 'OBJECTMODEL.UPDATEENABLED' value = 'true' ] ) ).
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(delete_enabled) = xsdbool( line_exists( entity_annotations[ annoname = 'OBJECTMODEL.DELETEENABLED' value = 'true' ] ) ).

    IF update_enabled = abap_true.
      special_columns-style_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-style ).
      INSERT VALUE #( name = special_columns-style_fieldname type = CAST #( cl_abap_typedescr=>describe_by_name( 'LVC_T_STYL' ) ) ) INTO TABLE components.
    ENDIF.

    LOOP AT element_annotations INTO DATA(element_annotation).
      IF element_annotation-annoname CP 'UI.LINEITEM*.CRITICALITY'.
        IF special_columns-color_fieldname IS INITIAL.
          special_columns-color_fieldname = get_unique_fieldname( i_components = components i_fieldname = default_fieldname-color ).
          INSERT VALUE #( name = special_columns-color_fieldname type = CAST #( cl_abap_typedescr=>describe_by_name( 'LVC_T_SCOL' ) ) ) INTO TABLE components.
        ENDIF.

        INSERT INITIAL LINE INTO TABLE criticality_mapping_table ASSIGNING FIELD-SYMBOL(<criticality_mapping>).
        <criticality_mapping>-data_field = element_annotation-elementname.
        <criticality_mapping>-crit_field = remove_quotes( element_annotation-value ).
      ENDIF.

      IF element_annotation-annoname = 'OBJECTMODEL.READONLY' AND element_annotation-value = 'true'.
        INSERT CONV #( element_annotation-elementname ) INTO TABLE read_only_fields.
      ENDIF.
    ENDLOOP.

    DATA ref_to_line TYPE REF TO data.
    line_descriptor = cl_abap_structdescr=>get( components ).
    CREATE DATA ref_to_line TYPE HANDLE line_descriptor.
    ASSIGN ref_to_line->* TO FIELD-SYMBOL(<line>).

    CREATE DATA ref_to_table LIKE STANDARD TABLE OF <line> WITH EMPTY KEY.
    table_descriptor = CAST cl_abap_tabledescr( cl_abap_typedescr=>describe_by_data_ref( ref_to_table ) ).
  ENDMETHOD.