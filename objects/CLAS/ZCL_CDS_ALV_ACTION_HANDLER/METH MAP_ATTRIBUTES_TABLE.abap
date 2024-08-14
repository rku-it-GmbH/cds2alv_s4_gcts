  METHOD map_attributes_table.
    CLEAR e_source_keys.

    LOOP AT i_entity_keys ASSIGNING FIELD-SYMBOL(<entity_key>).
      APPEND INITIAL LINE TO e_source_keys ASSIGNING FIELD-SYMBOL(<source_key>).
      map_attributes_single( EXPORTING i_entity_key = <entity_key>
                                       i_attributes = i_attributes
                             IMPORTING e_source_key = <source_key> ).
    ENDLOOP.
  ENDMETHOD.