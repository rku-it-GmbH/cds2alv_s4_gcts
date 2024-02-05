  METHOD get_implementation.
    r_class = get_from_customizing( i_interface ).
    IF r_class IS INITIAL.
      r_class = get_fallback( i_interface ).
    ENDIF.
  ENDMETHOD.