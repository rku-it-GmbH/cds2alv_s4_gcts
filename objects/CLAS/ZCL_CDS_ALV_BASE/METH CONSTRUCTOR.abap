  METHOD constructor.
    cds_view = to_upper( i_cds_view ).
    ddic_access = i_ddic_access.
    persistence = i_persistence.
    memory = i_memory.
    factory = i_factory.

    ddic_access->get_annotations_for_cds_view( EXPORTING i_cds_view              = cds_view
                                               IMPORTING e_entity_annotations    = entity_annotations
                                                         e_element_annotations   = element_annotations
                                                         e_parameter_annotations = parameter_annotations ).

    TRY.
        description = remove_quotes( entity_annotations[ annoname = 'ENDUSERTEXT.LABEL' ]-value ).
      CATCH cx_sy_itab_line_not_found.
        description = cds_view.
    ENDTRY.

    ddfields = ddic_access->get_ddic_fields_for_cds_view( cds_view ).
  ENDMETHOD.