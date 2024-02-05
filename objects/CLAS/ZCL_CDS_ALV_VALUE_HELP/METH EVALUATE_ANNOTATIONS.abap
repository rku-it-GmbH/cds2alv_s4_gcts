  METHOD evaluate_annotations.
    LOOP AT element_annotations ASSIGNING FIELD-SYMBOL(<element_annotation_group>)
         GROUP BY <element_annotation_group>-elementname.

      DATA(fieldname) = CONV fieldname( <element_annotation_group>-elementname ).
      DATA(value_help) = VALUE zcds_alv_valuehelp_definition( cds_view = cds_view fieldname = fieldname ).

      LOOP AT GROUP <element_annotation_group> ASSIGNING FIELD-SYMBOL(<element_annotation>).
        CASE <element_annotation>-annoname.
          WHEN 'CONSUMPTION.VALUEHELP' OR 'CONSUMPTION.VALUEHELPDEFINITION.ASSOCIATION'.
            value_help-association_name = remove_quotes( <element_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.NAME'.
            value_help-target_entity = remove_quotes( <element_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.ELEMENT'.
            value_help-target_element = remove_quotes( <element_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.DISTINCTVALUES'.
            value_help-distinct_values = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.LABEL'.
            value_help-label = remove_quotes( <element_annotation>-value ).
        ENDCASE.

        IF <element_annotation>-annoname NP 'CONSUMPTION.VALUEHELPDEFINITION.ADDITIONALBINDING$*$.*'.
          CONTINUE.
        ENDIF.

        SPLIT <element_annotation>-annoname AT '$' INTO DATA(prefix) DATA(index) DATA(property).
        READ TABLE value_help-additional_binding ASSIGNING FIELD-SYMBOL(<additional_binding>)
             WITH KEY index = index.
        IF sy-subrc <> 0.
          INSERT VALUE #( index = index ) INTO TABLE value_help-additional_binding ASSIGNING <additional_binding>.
        ENDIF.

        CASE |{ prefix }{ property }|.
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
      ENDLOOP.

      IF    value_help-association_name IS NOT INITIAL
         OR (     value_help-target_entity  IS NOT INITIAL
              AND value_help-target_element IS NOT INITIAL ).
        INSERT value_help INTO TABLE value_helps.
      ENDIF.
    ENDLOOP.

    LOOP AT parameter_annotations ASSIGNING FIELD-SYMBOL(<parameter_annotation_group>)
         GROUP BY <parameter_annotation_group>-parametername.

      DATA(parameter_name) = CONV ddparname( <parameter_annotation_group>-parametername ).
      value_help = VALUE zcds_alv_valuehelp_definition( cds_view = cds_view parameter_name = parameter_name ).

      LOOP AT GROUP <parameter_annotation_group> ASSIGNING FIELD-SYMBOL(<parameter_annotation>).
        CASE <parameter_annotation>-annoname.
          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.NAME'.
            value_help-target_entity = remove_quotes( <parameter_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.ENTITY.ELEMENT'.
            value_help-target_element = remove_quotes( <parameter_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.DISTINCTVALUES'.
            value_help-distinct_values = xsdbool( <parameter_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.VALUEHELPDEFINITION.LABEL'.
            value_help-label = remove_quotes( <parameter_annotation>-value ).
        ENDCASE.
      ENDLOOP.

      IF     value_help-target_entity  IS NOT INITIAL
         AND value_help-target_element IS NOT INITIAL.
        INSERT value_help INTO TABLE value_helps.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.