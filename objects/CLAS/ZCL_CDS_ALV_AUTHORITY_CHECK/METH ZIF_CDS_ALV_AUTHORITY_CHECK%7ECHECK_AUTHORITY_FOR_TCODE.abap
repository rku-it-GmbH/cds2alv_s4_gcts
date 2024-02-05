  METHOD zif_cds_alv_authority_check~check_authority_for_tcode.
    DATA tcode TYPE sytcode.

    CALL 'GET_PARAM_TCOD' ID 'PTCOD' FIELD tcode.         "#EC CI_CCALL

    IF tcode <> 'ZCDS_ALV_START'.
      RETURN.
    ENDIF.

    CALL FUNCTION 'AUTHORITY_CHECK_TCODE'
      EXPORTING  tcode  = 'ZCDS_ALV_START'
      EXCEPTIONS ok     = 0
                 not_ok = 1
                 OTHERS = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.