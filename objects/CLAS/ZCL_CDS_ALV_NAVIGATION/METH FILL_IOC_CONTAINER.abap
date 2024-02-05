  METHOD fill_ioc_container.
    ioc_container = NEW zcl_cds_alv_ioc_container( ).
    LOOP AT navigation_exits INTO DATA(navigation_exit).
      DATA(filters) = VALUE zif_cds_alv_ioc_container=>ty_filters(
                                ( key = 'SEMANTIC_OBJECT' value = navigation_exit-semantic_object )
                                ( key = 'SEMANTIC_ACTION' value = navigation_exit-semantic_action )
                                ( key = 'CDS_VIEW'        value = navigation_exit-cds_view ) ).

      TRY.
          ioc_container->register_implementing_class( i_interface = exit_interface
                                                      i_filters   = filters
                                                      i_class     = navigation_exit-implementing_class ).

        CATCH zcx_cds_alv_message.
          " TODO: log errors at this point
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.