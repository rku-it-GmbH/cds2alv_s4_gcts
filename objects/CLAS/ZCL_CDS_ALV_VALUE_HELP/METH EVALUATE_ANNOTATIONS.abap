  METHOD evaluate_annotations.
    LOOP AT element_annotations ASSIGNING FIELD-SYMBOL(<element_annotation_group>)
         GROUP BY <element_annotation_group>-elementname.

      DATA(fieldname) = CONV fieldname( <element_annotation_group>-elementname ).

      LOOP AT GROUP <element_annotation_group> ASSIGNING FIELD-SYMBOL(<element_annotation>).
        IF <element_annotation>-annoname = 'CONSUMPTION.VALUEHELP'.
          DATA(value_help) = VALUE zcds_alv_valuehelp_definition( cds_view = cds_view fieldname = fieldname ).
          value_help-association_name = remove_quotes( <element_annotation>-value ).
          INSERT value_help INTO TABLE value_helps.
        ENDIF.

        IF <element_annotation>-annoname CP 'CONSUMPTION.VALUEHELPDEFINITION$*$.*'.
          SPLIT <element_annotation>-annoname AT '$' INTO DATA(prefix) DATA(value_help_index) DATA(property).

          READ TABLE value_helps ASSIGNING FIELD-SYMBOL(<value_help>)
               WITH KEY cds_view         = cds_view
                        fieldname        = fieldname
                        value_help_index = value_help_index.
          IF sy-subrc <> 0.
            INSERT VALUE #( cds_view         = cds_view
                            fieldname        = fieldname
                            value_help_index = value_help_index )
            INTO TABLE value_helps ASSIGNING <value_help>.
          ENDIF.

          CASE |{ prefix }{ property }|.
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ASSOCIATION'.
              <value_help>-association_name = remove_quotes( <element_annotation>-value ).
            WHEN  'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.NAME'.
              <value_help>-target_entity = remove_quotes( <element_annotation>-value ).
            WHEN  'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.ELEMENT'.
              <value_help>-target_element = remove_quotes( <element_annotation>-value ).
            WHEN   'CONSUMPTION.VALUEHELPDEFINITION.DISTINCTVALUES'.
              <value_help>-distinct_values = xsdbool( <element_annotation>-value = 'true' ).
            WHEN  'CONSUMPTION.VALUEHELPDEFINITION.LABEL'.
              <value_help>-label = remove_quotes( <element_annotation>-value ).
          ENDCASE.

          IF <element_annotation>-annoname NP 'CONSUMPTION.VALUEHELPDEFINITION$*$.ADDITIONALBINDING$*$.*'.
            CONTINUE.
          ENDIF.

          SPLIT <element_annotation>-annoname AT '$' INTO prefix value_help_index DATA(add_prefix) DATA(binding_index) property.

          READ TABLE value_helps ASSIGNING <value_help>
               WITH KEY cds_view         = cds_view
                        fieldname        = fieldname
                        value_help_index = value_help_index.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.

          READ TABLE <value_help>-additional_binding ASSIGNING FIELD-SYMBOL(<additional_binding>)
               WITH KEY index = binding_index.
          IF sy-subrc <> 0.
            INSERT VALUE #( index = binding_index ) INTO TABLE <value_help>-additional_binding ASSIGNING <additional_binding>.
          ENDIF.

          CASE |{ prefix }{ add_prefix }{ property }|.
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING.LOCALPARAMETER'.
              <additional_binding>-source_parameter = remove_quotes( <element_annotation>-value ).
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING.LOCALELEMENT'.
              <additional_binding>-source_element = remove_quotes( <element_annotation>-value ).
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING.PARAMETER'.
              <additional_binding>-target_parameter = remove_quotes( <element_annotation>-value ).
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING.ELEMENT'.
              <additional_binding>-target_element = remove_quotes( <element_annotation>-value ).
            WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING.USAGE'.
              <additional_binding>-usage = <element_annotation>-value.
          ENDCASE.

        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT parameter_annotations ASSIGNING FIELD-SYMBOL(<parameter_annotation_group>)
         GROUP BY <parameter_annotation_group>-parametername.

      DATA(parameter_name) = CONV ddparname( <parameter_annotation_group>-parametername ).

      LOOP AT GROUP <parameter_annotation_group> ASSIGNING FIELD-SYMBOL(<parameter_annotation>)
           WHERE annoname CP 'CONSUMPTION.VALUEHELPDEFINITION$*$.*'.

        SPLIT <parameter_annotation>-annoname AT '$' INTO prefix value_help_index property.

        READ TABLE value_helps ASSIGNING <value_help>
             WITH KEY cds_view         = cds_view
                      parameter_name   = parameter_name
                      value_help_index = value_help_index.
        IF sy-subrc <> 0.
          INSERT VALUE #( cds_view         = cds_view
                          parameter_name   = parameter_name
                          value_help_index = value_help_index )
          INTO TABLE value_helps ASSIGNING <value_help>.
        ENDIF.

        CASE |{ prefix }{ property }|.
          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.NAME'.
            <value_help>-target_entity = remove_quotes( <parameter_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.ELEMENT'.
            <value_help>-target_element = remove_quotes( <parameter_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.DISTINCTVALUES'.
            <value_help>-distinct_values = xsdbool( <parameter_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.LABEL'.
            <value_help>-label = remove_quotes( <parameter_annotation>-value ).
        ENDCASE.
      ENDLOOP.
    ENDLOOP.

    DELETE value_helps WHERE association_name IS INITIAL AND ( target_entity IS INITIAL OR target_element IS INITIAL ).
  ENDMETHOD.