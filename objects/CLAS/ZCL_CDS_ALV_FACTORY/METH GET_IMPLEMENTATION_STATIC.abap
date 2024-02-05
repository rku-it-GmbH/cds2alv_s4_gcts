  METHOD get_implementation_static.
    r_class = get_from_customizing_static( i_interface ).
    IF r_class IS INITIAL.
      r_class = get_fallback_static( i_interface ).
    ENDIF.
  ENDMETHOD.