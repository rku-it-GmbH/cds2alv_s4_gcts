  METHOD get_parent_container.
    TRY.
        r_ioc_container = ioc_containers[ cds_view = space ]-ioc_container.
      CATCH cx_sy_itab_line_not_found.
        r_ioc_container = NEW zcl_cds_alv_ioc_container( ).
        r_ioc_container->register_instance( i_interface = 'ZIF_CDS_ALV_FACTORY' i_instance = me ).
        r_ioc_container->register_implementing_class(:
          i_interface = 'ZIF_CDS_ALV_DDIC_ACCESS'        i_class = get_implementation( 'ZIF_CDS_ALV_DDIC_ACCESS' ) ),
          i_interface = 'ZIF_CDS_ALV_PERSISTENCE'        i_class = get_implementation( 'ZIF_CDS_ALV_PERSISTENCE' ) ),
          i_interface = 'ZIF_CDS_ALV_MEMORY'             i_class = get_implementation( 'ZIF_CDS_ALV_MEMORY' ) ),
          i_interface = 'ZIF_CDS_ALV_REPORT_GENERATOR'   i_class = get_implementation( 'ZIF_CDS_ALV_REPORT_GENERATOR'  ) ),
          i_interface = 'ZIF_CDS_ALV_REPORT_LAUNCHER'    i_class = get_implementation( 'ZIF_CDS_ALV_REPORT_LAUNCHER' ) ),
          i_interface = 'ZIF_CDS_ALV_NAVIGATION'         i_class = get_implementation( 'ZIF_CDS_ALV_NAVIGATION' ) ),
          i_interface = 'ZIF_CDS_ALV_AUTHORITY_CHECK'    i_class = get_implementation( 'ZIF_CDS_ALV_AUTHORITY_CHECK' ) ),
          i_interface = 'ZIF_CDS_ALV_EXTENSION_PROVIDER' i_class = get_implementation( 'ZIF_CDS_ALV_EXTENSION_PROVIDER' ) ).
        INSERT VALUE #( cds_view = space ioc_container = r_ioc_container ) INTO TABLE ioc_containers.
    ENDTRY.
  ENDMETHOD.