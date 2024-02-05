  METHOD zif_cds_alv_selection_screen~read_selection_screen.
    DATA rsparams_tab TYPE rsparams_tt.

    rsparams_tab = CORRESPONDING #( selection_table ).
    CALL FUNCTION 'RS_REFRESH_FROM_SELECTOPTIONS'
      EXPORTING  curr_report         = progname
      TABLES     selection_table     = rsparams_tab
                 selection_table_255 = selection_table
      EXCEPTIONS OTHERS              = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.