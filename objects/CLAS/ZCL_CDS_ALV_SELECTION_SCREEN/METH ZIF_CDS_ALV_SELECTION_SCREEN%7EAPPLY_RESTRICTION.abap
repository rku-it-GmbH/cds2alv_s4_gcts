  METHOD zif_cds_alv_selection_screen~apply_restriction.
    CALL FUNCTION 'SELECT_OPTIONS_RESTRICT'
      EXPORTING  program                = progname
                 restriction            = restriction
      EXCEPTIONS too_late               = 0
                 repeated               = 0
                 selopt_without_options = 1
                 selopt_without_signs   = 2
                 invalid_sign           = 3
                 empty_option_list      = 4
                 invalid_kind           = 5
                 repeated_kind_a        = 6
                 OTHERS                 = 7.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.