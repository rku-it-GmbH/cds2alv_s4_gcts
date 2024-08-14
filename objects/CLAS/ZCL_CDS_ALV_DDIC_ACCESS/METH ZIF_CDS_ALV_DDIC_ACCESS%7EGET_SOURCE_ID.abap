  METHOD zif_cds_alv_ddic_access~get_source_id.
    TRY.
        " This gets the correct entity ID, when ObjectModel.transactionalProcessingDelegated is used!
        " Parameter type is changed to RETURNING in newer releases!
        r_source_id = CAST cl_sadl_entity_cds( i_entity )->get_consumption_view_def( )-base_view_name.

      CATCH cx_sadl_static INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.