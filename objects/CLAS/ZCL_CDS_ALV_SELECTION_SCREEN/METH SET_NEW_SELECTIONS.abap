  METHOD set_new_selections.
    CALL FUNCTION 'SELTAB_2_SELOPTS_255'
      EXPORTING  program = progname
      TABLES     seltab  = selection_table
      EXCEPTIONS OTHERS  = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.