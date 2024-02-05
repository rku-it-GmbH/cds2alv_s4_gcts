  METHOD get_object_from_ioc_container.
    DATA(filters) = VALUE zif_cds_alv_ioc_container=>ty_filters(
                              ( key = 'SEMANTIC_OBJECT' value = i_navigation_exit-semantic_object )
                              ( key = 'SEMANTIC_ACTION' value = i_navigation_exit-semantic_action )
                              ( key = 'CDS_VIEW'        value = i_navigation_exit-cds_view ) ).

    r_object ?= ioc_container->resolve( i_interface = exit_interface i_filters = filters ).
  ENDMETHOD.