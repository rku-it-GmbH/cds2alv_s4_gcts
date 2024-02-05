  METHOD zif_cds_alv_selection_screen~apply_selection_texts.
    CALL FUNCTION 'SELECTION_TEXTS_MODIFY'
      EXPORTING  program                     = progname
      TABLES     seltexts                    = selection_texts
      EXCEPTIONS program_not_found           = 1
                 program_cannot_be_generated = 2
                 OTHERS                      = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.