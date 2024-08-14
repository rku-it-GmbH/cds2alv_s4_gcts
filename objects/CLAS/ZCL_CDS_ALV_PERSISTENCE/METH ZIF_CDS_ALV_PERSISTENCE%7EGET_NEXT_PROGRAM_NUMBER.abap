  METHOD zif_cds_alv_persistence~get_next_program_number.
    DATA(object) =  'ZCDS_ALV_N'.
    DATA(nr_range_nr) = '00'.

    " Create Number Range Interval, if it does not yet exist
    DATA(interval) = VALUE inriv_tt( ).
    CALL FUNCTION 'NUMBER_RANGE_INTERVAL_LIST'
      EXPORTING
        nr_range_nr1 = nr_range_nr
        object       = object
      TABLES
        interval     = interval
      EXCEPTIONS
        OTHERS       = 0.
    IF interval IS INITIAL.
      interval = VALUE #( ( procind    = 'I'
                            nrrangenr  = nr_range_nr
                            fromnumber = '0000000000000001'
                            tonumber   = '0999999999999999' ) ).

      DATA(error_occured) = abap_false.
      DATA(error_iv) = VALUE inriv_tt( ).
      CALL FUNCTION 'NUMBER_RANGE_INTERVAL_UPDATE'
        EXPORTING
          object        = object
        IMPORTING
          error_occured = error_occured
        TABLES
          error_iv      = error_iv
          interval      = interval
        EXCEPTIONS
          OTHERS        = 1.
      IF sy-subrc <> 0 OR error_occured = abap_true.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      CALL FUNCTION 'NUMBER_RANGE_UPDATE_CLOSE'
        EXPORTING
          object          = object
        EXCEPTIONS
          no_changes_made = 0
          OTHERS          = 1.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr = nr_range_nr
        object      = object
      IMPORTING
        number      = r_number
      EXCEPTIONS
        OTHERS      = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.