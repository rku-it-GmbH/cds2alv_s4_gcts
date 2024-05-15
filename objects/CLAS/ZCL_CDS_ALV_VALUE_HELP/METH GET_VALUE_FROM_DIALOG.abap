  METHOD get_value_from_dialog.
    DATA value  TYPE dynfieldvalue.
    DATA return TYPE STANDARD TABLE OF ddshretval.

    value = c_value.
    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield        = i_fieldname
        value           = value
        value_org       = 'S'
        display         = i_display
      TABLES
        value_tab       = i_table
        return_tab      = return
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    IF return IS NOT INITIAL.
      c_value = return[ 1 ]-fieldval.
    ENDIF.
  ENDMETHOD.