  METHOD zif_cds_alv_grid_builder~create_alv_grid.
    CONSTANTS save_all TYPE char01 VALUE 'A' ##NO_TEXT.

    table_container = i_table_container.

    CREATE OBJECT alv_grid
      EXPORTING
        i_parent = i_container
      EXCEPTIONS
        OTHERS   = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    build_variant( ).
    build_layout( ).
    build_fieldcatalog( ).
    build_f4( ).
    build_exclude_functions( ).
    build_event_handler( ).

    DATA(ref_to_table) = table_container->get_ref_to_table( ).
    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<table>).

    register_event_handlers( ).

    alv_grid->register_f4_for_fields( value_help_fields ).
    alv_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).

    alv_grid->set_table_for_first_display( EXPORTING  is_variant           = variant
                                                      i_save               = save_all
                                                      i_default            = xsdbool( variant-variant IS INITIAL )
                                                      is_layout            = layout
                                                      it_toolbar_excluding = exclude_functions
                                           CHANGING   it_outtab            = <table>
                                                      it_fieldcatalog      = fieldcatalog
                                                      it_sort              = sort_order
                                                      it_filter            = filter
                                           EXCEPTIONS OTHERS               = 1 ).
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    IF update_enabled = abap_true.
      alv_grid->set_ready_for_input( ).
    ENDIF.

    alv_grid->set_toolbar_interactive( ).

    e_alv_grid = alv_grid.
  ENDMETHOD.