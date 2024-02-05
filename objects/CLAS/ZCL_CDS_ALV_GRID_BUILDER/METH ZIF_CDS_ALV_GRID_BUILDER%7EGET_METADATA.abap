  METHOD zif_cds_alv_grid_builder~get_metadata.
    table_container = i_table_container.

    build_variant( ).
    build_layout( ).
    build_fieldcatalog( ).

    e_variant = variant.
    e_layout = layout.
    e_fieldcatalog = fieldcatalog.
    e_sort_order = sort_order.
    e_filters = filter.
  ENDMETHOD.