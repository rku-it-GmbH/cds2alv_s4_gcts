  METHOD map_attributes_single.
    CLEAR e_source_key.

    " Use Mapping, if it exists, else MOVE-CORRESPONDING
    LOOP AT i_attributes ASSIGNING FIELD-SYMBOL(<attribute>).
      ASSIGN COMPONENT <attribute>-name OF STRUCTURE i_entity_key TO FIELD-SYMBOL(<source>).
      ASSIGN COMPONENT <attribute>-binding OF STRUCTURE e_source_key TO FIELD-SYMBOL(<target>).

      IF <source> IS ASSIGNED AND <target> IS ASSIGNED.
        <target> = <source>.
      ENDIF.

      UNASSIGN: <source>, <target>.
    ENDLOOP.
    IF sy-subrc <> 0.
      MOVE-CORRESPONDING i_entity_key TO e_source_key.
    ENDIF.
  ENDMETHOD.