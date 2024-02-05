  METHOD build_variant.
    variant-report   = sy-cprog.
    variant-username = sy-uname.

    IF selection_screen IS BOUND.
      selection_screen->get_dynpro_field( EXPORTING i_sel_name  = 'P_VARI'
                                          IMPORTING e_parameter = variant-variant ).
    ENDIF.
  ENDMETHOD.