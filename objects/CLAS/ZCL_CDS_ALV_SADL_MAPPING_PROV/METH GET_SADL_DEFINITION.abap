  METHOD get_sadl_definition.
    IF ms_sadl_definition IS INITIAL.
      build_sadl_definition( ).
    ENDIF.

    rs_sadl_definition = ms_sadl_definition.
  ENDMETHOD.