  METHOD zif_cds_alv_ddic_access~get_sadl_runtime.
    TRY.
        DATA(sadl_entity) = cl_sadl_entity_factory=>get_instance( )->get_entity(
                                iv_type = cl_sadl_entity_factory=>co_type-cds
                                iv_id   = CONV sadl_entity_id( i_cds_view ) ).

        DATA(mp) = get_mp_for_entity( sadl_entity ).
        DATA(api_factory) = cl_sadl_entity_api_factory=>create( CAST cl_sadl_mp_entity( mp ) ).
        r_sadl_runtime = api_factory->get_runtime( ).

      CATCH cx_sadl_contract_violation cx_sadl_static cx_uuid_error INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.