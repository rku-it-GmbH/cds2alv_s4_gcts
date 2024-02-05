  METHOD zif_cds_alv_ddic_access~get_annotations_for_cds_view.
    cl_dd_ddl_annotation_service=>get_annos( EXPORTING entityname      = to_upper( i_cds_view )
                                             IMPORTING entity_annos    = e_entity_annotations
                                                       element_annos   = e_element_annotations
                                                       parameter_annos = e_parameter_annotations ).
  ENDMETHOD.