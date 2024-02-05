  METHOD zif_cds_alv_condition_provider~get_parameters.
    LOOP AT parameter_mappings INTO DATA(parameter_mapping).
      READ TABLE selection_table INTO DATA(selection)
           WITH KEY selname = parameter_mapping-sel_name.
      IF sy-subrc = 0.
        INSERT VALUE #( cds_view = cds_view
                        parname  = parameter_mapping-parname
                        value    = selection-low )
               INTO TABLE r_parameters.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.