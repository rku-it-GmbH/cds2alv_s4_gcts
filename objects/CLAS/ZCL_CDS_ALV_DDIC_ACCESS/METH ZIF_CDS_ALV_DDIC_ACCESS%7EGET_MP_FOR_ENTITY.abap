  METHOD zif_cds_alv_ddic_access~get_mp_for_entity.
    TRY.
        r_mp = NEW zcl_cds_alv_sadl_mapping_prov( i_entity ).

      CATCH cx_bsa_compile_time INTO DATA(previous).
        RAISE EXCEPTION TYPE zcx_cds_alv_message
          EXPORTING
            previous = previous.
    ENDTRY.
  ENDMETHOD.