  METHOD call_browser.
    IF i_url IS INITIAL.
      RETURN.
    ENDIF.

    cl_gui_frontend_services=>execute( EXPORTING  document = i_url
                                       EXCEPTIONS OTHERS   = 1 ).
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.