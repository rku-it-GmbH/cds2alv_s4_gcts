  METHOD evaluate_annotations.
    title = description.

    LOOP AT element_annotations ASSIGNING FIELD-SYMBOL(<element_annotation_group>)
         GROUP BY <element_annotation_group>-elementname.

      TYPES: BEGIN OF ty_field_properties,
               selection_type      TYPE string,
               multiple_selections TYPE abap_bool,
               mandatory           TYPE abap_bool,
               default_value       TYPE string,
               label               TYPE string,
             END OF ty_field_properties.

      DATA(fieldname) = CONV fieldname( <element_annotation_group>-elementname ).
      DATA(properties) = VALUE ty_field_properties( ).

      LOOP AT GROUP <element_annotation_group> ASSIGNING FIELD-SYMBOL(<element_annotation>).
        CASE <element_annotation>-annoname.
          WHEN 'CONSUMPTION.FILTER.SELECTIONTYPE'.
            properties-selection_type = <element_annotation>-value.

          WHEN 'CONSUMPTION.FILTER.MULTIPLESELECTIONS'.
            properties-multiple_selections = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.FILTER.MANDATORY'.
            properties-mandatory = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.FILTER.DEFAULTVALUE'.
            properties-default_value = <element_annotation>-value.

          WHEN 'ENDUSERTEXT.LABEL'.
            properties-label = remove_quotes( <element_annotation>-value ).
        ENDCASE.
      ENDLOOP.

      TRY.
          DATA(sel_name) = selection_mappings[ cds_view = cds_view fieldname = fieldname ]-sel_name. "#EC CI_HASHSEQ

          IF properties-selection_type IS NOT INITIAL.
            INSERT VALUE #( name = sel_name kind = kind-select_option )
                   INTO TABLE restriction-ass_tab ASSIGNING FIELD-SYMBOL(<restriction_ass>).

            " The options list are named after the annotation values
            <restriction_ass>-op_addy = properties-selection_type.
            <restriction_ass>-op_main = properties-selection_type.

            IF properties-selection_type = selection_type-range.
              <restriction_ass>-sg_addy = sign-all.
              <restriction_ass>-sg_main = sign-all.
            ELSE.
              <restriction_ass>-sg_addy = sign-include.
              <restriction_ass>-sg_main = sign-include.
            ENDIF.

            IF properties-multiple_selections = abap_false.
              <restriction_ass>-sg_addy = sign-no_extensions.
            ENDIF.
          ENDIF.

          " Labels (from annotation EndUserText.Label)
          IF properties-label IS NOT INITIAL.
            INSERT VALUE #( kind = 'S'
                            name = sel_name
                            text = condense( properties-label ) )
                   INTO TABLE selection_texts.
          ELSE.
            READ TABLE ddfields INTO DATA(ddfield)
                 WITH KEY fieldname = fieldname.
            IF sy-subrc = 0.
              INSERT VALUE #( kind = 'S'
                              name = sel_name
                              text = condense( ddfield-scrtext_m ) )
                     INTO TABLE selection_texts.
            ENDIF.
          ENDIF.

        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.