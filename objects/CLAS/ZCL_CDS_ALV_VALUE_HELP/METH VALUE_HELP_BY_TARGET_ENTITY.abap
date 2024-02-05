  METHOD value_help_by_target_entity.
    DATA table TYPE REF TO data.
    FIELD-SYMBOLS <table> TYPE STANDARD TABLE.

    DATA(target_entity)  = to_upper( i_target_entity  ).
    DATA(target_element) = to_upper( i_target_element ).

    TRY.
        CREATE DATA table TYPE TABLE OF (target_entity).
        ASSIGN table->* TO <table>.

        DATA(sadl_runtime) = ddic_access->get_sadl_runtime( CONV #( target_entity ) ).

        DATA(ddfields) = ddic_access->get_ddic_fields_for_cds_view( CONV #( target_entity ) ).
        DATA(elements) = VALUE if_sadl_query_engine_types=>tt_requested_elements( FOR ddfield IN ddfields
                                                                                  ( CONV #( ddfield-fieldname ) ) ).
        DATA(requested) = VALUE if_sadl_query_engine_types=>ty_requested( elements  = elements
                                                                          fill_data = abap_true ).

        DATA(parameters) = VALUE if_sadl_query_engine_types=>ty_parameters( ).
        APPEND VALUE #( entity_alias = cl_sadl_entity_util=>convert( CONV #( target_entity ) ) )
               TO parameters-entity ASSIGNING FIELD-SYMBOL(<entity>).

        LOOP AT i_additional_binding INTO DATA(binding).
          DATA(target_field_range) = VALUE rsds_frange( fieldname = binding-target_element ).
          DATA(source_field_range) = VALUE rsds_frange( fieldname = binding-source_element ).

          " Element -> Element und Parameter -> Parameter
          IF binding-source_element IS NOT INITIAL.
            IF i_selected_row IS NOT INITIAL.
              ASSIGN COMPONENT binding-source_element OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<source_element>).
              IF sy-subrc = 0.
                DATA(select_options) = VALUE rsds_selopt_t( (  sign = 'I' option = 'EQ' low = <source_element> ) ).
                source_field_range = VALUE #( fieldname = binding-source_element selopt_t = select_options ).
              ENDIF.
            ELSEIF i_field_ranges IS NOT INITIAL.
              READ TABLE i_field_ranges INTO source_field_range
                   WITH KEY fieldname = binding-source_element.
            ENDIF.
            target_field_range-selopt_t = source_field_range-selopt_t.
          ELSEIF binding-source_parameter IS NOT INITIAL.
            READ TABLE i_parameters INTO DATA(source_parameter)
                 WITH TABLE KEY cds_view = cds_view parname = binding-source_parameter.
          ENDIF.

          IF binding-target_element IS NOT INITIAL.
            IF binding-usage <> '#RESULT'.
              IF target_field_range-selopt_t IS NOT INITIAL.
                sadl_runtime->if_sadl_query_fetch~register_condition_provider(
                                                                               cl_sadl_cond_prov_factory_pub=>create_basic_condition_factory(
                                                                               )->in_range(
                                                                                   name     = CONV #( target_field_range-fieldname )
                                                                                   t_ranges = CORRESPONDING #( target_field_range-selopt_t ) ) ).
              ENDIF.
            ENDIF.

            IF binding-usage <> '#FILTER'.
              APPEND CONV #( binding-target_element ) TO requested-elements.
            ENDIF.

          ELSEIF binding-target_parameter IS NOT INITIAL.
            INSERT VALUE #( name  = binding-target_parameter
                            value = source_parameter-value )
                   INTO TABLE <entity>-parameters.
          ENDIF.
        ENDLOOP.

        sadl_runtime->fetch( EXPORTING is_requested  = requested
                                       is_parameters = parameters
                             IMPORTING et_data_rows  = <table> ).

        get_value_from_dialog( EXPORTING i_fieldname = CONV #( target_element )
                                         i_table     = <table>
                                         i_display   = i_display
                               CHANGING  c_value     = c_value ).

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.