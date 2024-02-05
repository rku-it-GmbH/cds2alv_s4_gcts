  METHOD ask_for_missing_parameters.
    DATA(dd10bv_tab) = ddic_access->get_parameters_for_cds_view( i_target_view ).

    LOOP AT dd10bv_tab INTO DATA(dd10bv).
      " TODO: variable is assigned but never used (ABAP cleaner)
      DATA(ddfield) = VALUE dfies( ).
      CALL FUNCTION 'DDIF_FIELDINFO_GET'
        EXPORTING  tabname   = dd10bv-rollname
                   all_types = abap_true
        IMPORTING  dfies_wa  = ddfield
        EXCEPTIONS OTHERS    = 1.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      READ TABLE c_parameter_values ASSIGNING FIELD-SYMBOL(<parameter_value>)
           WITH KEY cds_view = dd10bv-strucobjn
                    parname  = dd10bv-parametername.
      IF sy-subrc <> 0.
        INSERT VALUE #( cds_view = dd10bv-strucobjn
                        parname  = dd10bv-parametername )
               INTO TABLE c_parameter_values ASSIGNING <parameter_value>.
      ENDIF.

      IF <parameter_value>-value IS INITIAL.
        CALL FUNCTION 'FOBU_POPUP_GET_VALUE'
          EXPORTING  typename        = dd10bv-rollname
                     field_value     = <parameter_value>-value
                     popup_title     = 'Parameter eingeben'
          IMPORTING  field_value_int = <parameter_value>-value
          EXCEPTIONS internal_error  = 1
                     cancelled       = 2
                     OTHERS          = 3.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_cds_alv_message
                MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.