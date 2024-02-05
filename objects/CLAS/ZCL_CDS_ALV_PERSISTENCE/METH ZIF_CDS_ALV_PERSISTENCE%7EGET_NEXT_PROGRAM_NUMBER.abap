  METHOD zif_cds_alv_persistence~get_next_program_number.
    DATA(object) =  'ZCDS_ALV_N'.
    DATA(nr_range_nr) = '00'.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING  nr_range_nr = nr_range_nr
                 object      = object
      IMPORTING  number      = r_number
      EXCEPTIONS OTHERS      = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.