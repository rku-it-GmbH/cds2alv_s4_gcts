  METHOD get_attributes_from_screen.
    LOOP AT extension_parameters INTO DATA(ls_parameter) WHERE attribute_name IS NOT INITIAL.
      ASSIGN me->(ls_parameter-attribute_name) TO FIELD-SYMBOL(<attribute>).
      IF sy-subrc = 0.
        i_selection_screen->get_dynpro_field( EXPORTING i_sel_name  = ls_parameter-parameter_name
                                              IMPORTING e_parameter = <attribute> ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.