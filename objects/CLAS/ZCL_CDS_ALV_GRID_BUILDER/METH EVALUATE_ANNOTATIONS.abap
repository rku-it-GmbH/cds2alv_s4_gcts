  METHOD evaluate_annotations.
    DATA(action_counter) = VALUE numc3( ).
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(keys) = VALUE ddfieldnames( ).

    " key fields from semantic key
    LOOP AT entity_annotations ASSIGNING FIELD-SYMBOL(<entity_annotation>)
         WHERE annoname CS 'OBJECTMODEL.SEMANTICKEY'.
      INSERT CONV #( to_upper( remove_quotes( <entity_annotation>-value ) ) )
             INTO TABLE keys.
    ENDLOOP.

    " Field Annotations; ReadOnly is evaluated in the end
    " UI.LineItem can be repeated, therefore it needs an inner loop
    LOOP AT element_annotations ASSIGNING FIELD-SYMBOL(<element_annotation_group>)
         GROUP BY ( elementname = <element_annotation_group>-elementname ).

      DATA(fieldname) = CONV fieldname( <element_annotation_group>-elementname ).
      DATA(field_properties) = VALUE ty_field_properties( fieldname = fieldname ).
      DATA(ui_annotations) = VALUE ty_ui_annotations( ).
      DATA(semantic_object) = VALUE zcds_alv_semantic_object( ).
      " TODO: variable is assigned but never used (ABAP cleaner)
      DATA(function) = VALUE zcds_alv_function( ).

      LOOP AT GROUP <element_annotation_group> ASSIGNING FIELD-SYMBOL(<element_annotation>).
        CASE <element_annotation>-annoname.
          WHEN 'CONSUMPTION.HIDDEN'.
            field_properties-technical = abap_true.

          WHEN 'CONSUMPTION.VALUEHELP'
            OR 'CONSUMPTION.VALUEHELPDEFINITION.ASSOCIATION'
            OR 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.NAME'.
            field_properties-has_value_help = abap_true.

          WHEN 'DEFAULTAGGREGATION'.
            field_properties-default_aggregation = <element_annotation>-value.

          WHEN 'UI.HIDDEN'.
            field_properties-hidden = abap_true.

          WHEN 'SEMANTICS.EMAIL.ADDRESS'.
            field_properties-is_email = abap_true.

          WHEN 'CONSUMPTION.SEMANTICOBJECT'.
            semantic_object = remove_quotes( <element_annotation>-value ).

          WHEN 'ENDUSERTEXT.LABEL'.
            field_properties-label = <element_annotation>-value.

          WHEN 'ENUSERTEXT.QUICKINFO'.
            field_properties-quickinfo = <element_annotation>-value.
        ENDCASE.

        IF <element_annotation>-annoname CP 'UI.LINEITEM.*'.
          INSERT VALUE #( index = 0
                          key   = <element_annotation>-annoname
                          value = <element_annotation>-value )
                 INTO TABLE ui_annotations.
        ELSEIF <element_annotation>-annoname CP 'UI.LINEITEM$*$.*'.
          SPLIT <element_annotation>-annoname AT '$' INTO
                DATA(ui_line_item) DATA(index) DATA(property).
          INSERT VALUE #( index = index
                          key   = |{ ui_line_item }{ property }|
                          value = <element_annotation>-value )
                 INTO TABLE ui_annotations.
        ENDIF.
      ENDLOOP.

      LOOP AT ui_annotations INTO DATA(ui_index) GROUP BY ui_index-index.
        DATA(field_action) = VALUE zcds_alv_field_action( cds_view  = cds_view
                                                          fieldname = fieldname ).

        LOOP AT GROUP ui_index INTO DATA(ui_annotation).
          CASE ui_annotation-key.
            WHEN 'UI.LINEITEM.POSITION'.
              field_properties-position = CONV i( ui_annotation-value ).

            WHEN 'UI.LINEITEM.TYPE'.
              field_action-fieldtype = ui_annotation-value.

            WHEN 'UI.LINEITEM.SEMANTICOBJECT'.
              semantic_object = remove_quotes( ui_annotation-value ).

            WHEN 'UI.LINEITEM.SEMANTICOBJECTACTION'.
              field_action-semantic_action = remove_quotes( ui_annotation-value ).

            WHEN 'UI.LINEITEM.TARGETELEMENT'.
              field_action-associationname = remove_quotes( ui_annotation-value ).

            WHEN 'UI.LINEITEM.DATAACTION'.
              field_action-data_action = substring_after( val = remove_quotes( ui_annotation-value )
                                                          sub = 'BOPF:' ).

            WHEN 'UI.LINEITEM.LABEL'.
              field_action-label = remove_quotes( ui_annotation-value ).

            WHEN 'UI.LINEITEM.URL'.
              field_action-url_fieldname = remove_quotes( ui_annotation-value ).

          ENDCASE.
        ENDLOOP.

        " Navigation and actions
        CASE field_action-fieldtype.
          WHEN '#STANDARD' OR space. " Hotspot for mail
            IF field_properties-is_email = abap_true.
              field_properties-is_hotspot = abap_true.
              field_action-hotspot   = abap_true.
              field_action-send_mail = abap_true.
              INSERT field_action INTO TABLE field_actions.
            ENDIF.

          WHEN '#WITH_INTENT_BASED_NAVIGATION'. " Hyperlink
            IF semantic_object IS NOT INITIAL AND field_action-semantic_action IS NOT INITIAL.
              field_properties-is_hotspot = abap_true.
              field_action-hotspot         = abap_true.
              field_action-semantic_object = semantic_object.
              INSERT field_action INTO TABLE field_actions.
            ENDIF.

          WHEN '#WITH_URL'. " Hyperlink
            IF field_action-url_fieldname IS NOT INITIAL.
              field_properties-is_hotspot = abap_true.
              field_action-hotspot = abap_true.
              INSERT field_action INTO TABLE field_actions.
            ENDIF.

          WHEN '#FOR_INTENT_BASED_NAVIGATION'. " Button
            IF semantic_object IS NOT INITIAL AND field_action-semantic_action IS NOT INITIAL.
              action_counter += 1.
              field_action-user_command    = |{ function_code_prefix }{ action_counter }|.
              field_action-semantic_object = semantic_object.

              IF field_action-label IS INITIAL.
                field_action-label = |{ field_action-semantic_object }.{ field_action-semantic_action }|.
              ENDIF.

              INSERT field_action INTO TABLE field_actions.
            ENDIF.

          WHEN '#WITH_NAVIGATION_PATH'. " Button
            IF field_action-associationname IS NOT INITIAL.
              action_counter += 1.
              field_action-user_command = |{ function_code_prefix }{ action_counter }|.

              IF field_action-label IS INITIAL.
                field_action-label = field_action-associationname.
              ENDIF.

              INSERT field_action INTO TABLE field_actions.
            ENDIF.

          WHEN '#FOR_ACTION'. " Button
            IF field_action-data_action IS NOT INITIAL.
              action_counter += 1.
              field_action-user_command = |{ function_code_prefix }{ action_counter }|.

              IF field_action-label IS INITIAL.
                field_action-label = field_action-data_action.
              ENDIF.

              INSERT field_action INTO TABLE field_actions.
            ENDIF.
        ENDCASE.
      ENDLOOP.

      " Headers
      IF field_properties-quickinfo IS INITIAL AND field_properties-label IS NOT INITIAL.
        field_properties-quickinfo = field_properties-label.
      ENDIF.

      INSERT field_properties INTO TABLE field_properties_table.
    ENDLOOP.

    " Editable fields
    update_enabled = xsdbool( line_exists( entity_annotations[ annoname = 'OBJECTMODEL.UPDATEENABLED'
                                                               value    = 'true' ] ) ).
    delete_enabled = xsdbool( line_exists( entity_annotations[ annoname = 'OBJECTMODEL.DELETEENABLED'
                                                               value    = 'true' ] ) ).

    IF update_enabled = abap_true.
      LOOP AT ddfields ASSIGNING FIELD-SYMBOL(<ddfield>).
        IF line_exists( element_annotations[ elementname = <ddfield>-fieldname
                                             annoname    = 'OBJECTMODEL.READONLY'
                                             value       = 'true' ] ).
          CONTINUE.
        ENDIF.

        READ TABLE field_properties_table ASSIGNING FIELD-SYMBOL(<field_properties>)
             WITH KEY fieldname = <ddfield>-fieldname.
        IF sy-subrc = 0.
          <field_properties>-is_editable = abap_true.
          INSERT <ddfield>-fieldname INTO TABLE editable_fields.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.