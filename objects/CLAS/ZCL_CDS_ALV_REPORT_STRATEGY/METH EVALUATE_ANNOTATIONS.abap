  METHOD evaluate_annotations.
    TRY.
        db_view = to_upper( remove_quotes( entity_annotations[ annoname = 'ABAPCATALOG.SQLVIEWNAME' ]-value ) ).
      CATCH cx_sy_itab_line_not_found.
        CLEAR db_view.
    ENDTRY.

    progname = get_program_name( ).

    " Parameter Annotations
    LOOP AT ddic_access->get_parameters_for_cds_view( cds_view ) ASSIGNING FIELD-SYMBOL(<dd10bv>).
      DATA(param_properties) = VALUE ty_param_properties( ).
      param_properties-parname      = <dd10bv>-parametername.
      param_properties-data_type    = <dd10bv>-rollname.
      param_properties-system_field = <dd10bv>-systfield.

      LOOP AT parameter_annotations ASSIGNING FIELD-SYMBOL(<param_annotation>)
           WHERE parametername = <dd10bv>-parametername.
        CASE <param_annotation>-annoname.
          WHEN 'CONSUMPTION.DEFAULTVALUE'.
            param_properties-default_value = remove_quotes( <param_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELP'.
            param_properties-value_help = abap_true.

          WHEN 'ENDUSERTEXT.LABEL'.
            param_properties-label = remove_quotes( <param_annotation>-value ).
        ENDCASE.

        IF <param_annotation>-annoname CP 'CONSUMPTION.VALUEHELPDEFINITION.*'.
          param_properties-value_help = abap_true.
        ENDIF.
      ENDLOOP.

      " Selection Texts (from CDS-View-Annotation EndUser.Label or DDIC)
      IF param_properties-label IS INITIAL.
        CALL FUNCTION 'DDIF_FIELDLABEL_GET'
          EXPORTING  tabname = param_properties-data_type
          IMPORTING  label   = param_properties-label
          EXCEPTIONS OTHERS  = 0.
      ENDIF.

      APPEND param_properties TO param_properties_tab.
    ENDLOOP.

    " Field Annotations
    LOOP AT ddfields INTO DATA(ddfield) WHERE fieldname <> '.NODE1'.
      " Erlaubte Datentypen für Selektionsbilder
      " C    Zeichenfolge  (Character)
      " N    Zeichenfolge nur mit Ziffern
      " D    Datum (Date: JJJJMMTT)
      " T    Zeitpunkt (Time: HHMMSS)
      " X    Bytefolge (heXadecimal), in Ddic-Metadaten auch für INT1/2/4
      " I    Ganze Zahl (4-Byte Integer mit Vorzeichen)
      " b    1-Byte Integer, ganze Zahl <= 254
      " s    2-Byte Integer, nur für Längenfeld vor LCHR oder LRAW
      " P    Gepackte Zahl (Packed)
      " 8    Ganze Zahl (8-Byte Integer mit Vorzeichen)
      CONSTANTS allowed_types TYPE c LENGTH 10 VALUE 'CNDTXIbsP8'.

      IF ddfield-inttype NA allowed_types.
        CONTINUE.
      ENDIF.

      DATA(field_properties) = VALUE ty_field_properties( fieldname = ddfield-fieldname ).

      LOOP AT element_annotations ASSIGNING FIELD-SYMBOL(<element_annotation>)
           WHERE elementname = ddfield-fieldname.
        " only remove the index; should be sufficient for now
        IF <element_annotation>-annoname CP 'UI.SELECTIONFIELD$*$.*'.
          SPLIT <element_annotation>-annoname AT '$' INTO
                DATA(before) DATA(index) DATA(after).
          <element_annotation>-annoname = |{ before }{ after }|.
        ENDIF.

        CASE <element_annotation>-annoname.
          WHEN 'CONSUMPTION.FILTER.SELECTIONTYPE'.
            field_properties-selection_type = <element_annotation>-value.

          WHEN 'CONSUMPTION.FILTER.MULTIPLESELECTIONS'.
            field_properties-multiple_selections = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.FILTER.MANDATORY'.
            field_properties-mandatory = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'CONSUMPTION.FILTER.DEFAULTVALUE'.
            field_properties-default_value = remove_quotes( <element_annotation>-value ).

          WHEN 'CONSUMPTION.VALUEHELP' OR 'CONSUMPTION.VALUEHELPDEFINITION'.
            field_properties-value_help = abap_true.

          WHEN 'CONSUMPTION.HIDDEN'.
            field_properties-no_display = xsdbool( <element_annotation>-value = 'true' ).

          WHEN 'UI.SELECTIONFIELD.POSITION'.
            field_properties-position = <element_annotation>-value.

          WHEN 'UI.SELECTIONFIELD.QUALIFIER'.
            field_properties-qualifier = <element_annotation>-value.

          WHEN 'ENDUSERTEXT.LABEL'.
            field_properties-label = remove_quotes( <element_annotation>-value ).
        ENDCASE.
      ENDLOOP.

      IF field_properties-selection_type IS INITIAL.
        field_properties-no_display = abap_true.
      ENDIF.

      IF field_properties-label IS INITIAL.
        field_properties-label = ddfield-scrtext_m.
      ENDIF.

      APPEND field_properties TO field_properties_tab.
    ENDLOOP.
  ENDMETHOD.