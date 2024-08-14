  METHOD get_container_for_cds_view.
    TRY.
        r_ioc_container = ioc_containers[ cds_view = i_cds_view ]-ioc_container.
      CATCH cx_sy_itab_line_not_found.
        DATA(ioc_container) = NEW zcl_cds_alv_ioc_container( i_cds_view = i_cds_view i_parent = get_parent_container( ) ).
        DATA(parameters) = VALUE abap_parmbind_tab( ( name = 'I_CDS_VIEW' value = REF #( ioc_container->cds_view ) ) ).
        r_ioc_container = ioc_container.
        r_ioc_container->register_implementing_class( i_parameters = parameters:
          i_interface = 'ZIF_CDS_ALV_GRID_BUILDER'       i_class = get_implementation( 'ZIF_CDS_ALV_GRID_BUILDER' ) ),
          i_interface = 'ZIF_CDS_ALV_SELECTION'          i_class = get_implementation( 'ZIF_CDS_ALV_SELECTION' ) ),
          i_interface = 'ZIF_CDS_ALV_SELECTION_SCREEN'   i_class = get_implementation( 'ZIF_CDS_ALV_SELECTION_SCREEN' ) ),
          i_interface = 'ZIF_CDS_ALV_CONDITION_PROVIDER' i_class = get_implementation( 'ZIF_CDS_ALV_CONDITION_PROVIDER' ) ),
          i_interface = 'ZIF_CDS_ALV_VALUE_HELP'         i_class = get_implementation( 'ZIF_CDS_ALV_VALUE_HELP' ) ),
          i_interface = 'ZIF_CDS_ALV_REPORT_CONTROLLER'  i_class = get_implementation( 'ZIF_CDS_ALV_REPORT_CONTROLLER' ) ),
          i_interface = 'ZIF_CDS_ALV_REPORT_STRATEGY'    i_class = get_implementation( 'ZIF_CDS_ALV_REPORT_STRATEGY' ) ),
          i_interface = 'ZIF_CDS_ALV_ACTION_HANDLER'     i_class = get_implementation( 'ZIF_CDS_ALV_ACTION_HANDLER' ) ),
          i_interface = 'ZIF_CDS_ALV_BOPF_HANDLER'       i_class = get_implementation( 'ZIF_CDS_ALV_BOPF_HANDLER' ) ),
          i_interface = 'ZIF_CDS_ALV_TABLE_CONTAINER'    i_class = get_implementation( 'ZIF_CDS_ALV_TABLE_CONTAINER' ) ).
        INSERT VALUE #( cds_view = i_cds_view ioc_container = r_ioc_container ) INTO TABLE ioc_containers.
    ENDTRY.
  ENDMETHOD.