  METHOD value_help_by_association.
    DATA table TYPE REF TO data.
    FIELD-SYMBOLS <table> TYPE STANDARD TABLE.

    TRY.
        DATA(target_view) = ddic_access->get_target_for_association( i_source_view      = cds_view
                                                                     i_association_name = i_association_name ).

        CREATE DATA table TYPE TABLE OF (target_view).
        ASSIGN table->* TO <table>.

        DATA(sadl_runtime) = ddic_access->get_sadl_runtime( target_view ).

        DATA(requested) = VALUE if_sadl_query_engine_types=>ty_requested(
                                    elements  = VALUE #( ( CONV #( i_fieldname ) ) )
                                    fill_data = abap_true ).

        " Sadly I know of no way to provide target parameters, e.g. by propagating source parameters at this point
        DATA(parameters) = VALUE if_sadl_query_engine_types=>ty_parameters( ).
        " TODO: variable is assigned but never used (ABAP cleaner)
        APPEND VALUE #( entity_alias = target_view ) TO parameters-entity ASSIGNING FIELD-SYMBOL(<entity>).

        " The association's join conditions are used to derive a where condition.
        " There are certain limits to this that may be adressed in future versions.
        " Field ranges from the selection screen are not used in this
        " as the logic for the where condition would quickly become way too messy.
        DATA(sadl_condition_provider) = NEW lcl_sadl_cond_provider_assoc( i_ddic_access       = ddic_access
                                                                          i_source_view       = cds_view
                                                                          i_association_name  = i_association_name
                                                                          i_source_parameters = i_parameters
                                                                          i_selected_row      = i_selected_row ).

        sadl_runtime->if_sadl_query_fetch~register_condition_provider( sadl_condition_provider ).

        sadl_runtime->fetch( EXPORTING is_requested  = requested
                                       is_parameters = parameters
                             IMPORTING et_data_rows  = <table> ).

        get_value_from_dialog( EXPORTING i_fieldname = i_fieldname
                                         i_table     = <table>
                                         i_display   = i_display
                               CHANGING  c_value     = c_value ).

      CATCH cx_sadl_static cx_sadl_contract_violation INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING previous = previous.
    ENDTRY.
  ENDMETHOD.