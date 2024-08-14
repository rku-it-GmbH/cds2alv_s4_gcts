  METHOD zif_cds_alv_ddic_access~get_behaviour_details.
    CLEAR: e_has_bdef, e_update_enabled, e_delete_enabled, e_editable_fields.

    DATA(metadata_provider) = cl_rap_bhv_rt_entity_metadata=>get( i_cds_view ).

    TRY.
        " ABAP 7.58
        CALL METHOD metadata_provider->('IS_TRANSACTIONAL_FROM_BDEF')
          RECEIVING
            rv_from_bdef = e_has_bdef.

      CATCH cx_sy_dyn_call_illegal_method.
        " ABAP 7.56
        CALL METHOD metadata_provider->('IS_TRANSACTIONAL')
          RECEIVING
            rv_is_transactional = e_has_bdef.
    ENDTRY.

    IF e_has_bdef = abap_false.
      RETURN.
    ENDIF.

    DATA(entity_control) = metadata_provider->get_entity_control( ).
    e_update_enabled = entity_control-update_enabled.
    e_delete_enabled = entity_control-delete_enabled.

    IF e_editable_fields IS SUPPLIED.
      LOOP AT get_ddic_fields_for_cds_view( i_cds_view ) INTO DATA(ddic_field).
        DATA(element_control) = metadata_provider->get_element_control( ddic_field-fieldname ).
        IF element_control-read_only = abap_false.
          INSERT ddic_field-fieldname INTO TABLE e_editable_fields.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.