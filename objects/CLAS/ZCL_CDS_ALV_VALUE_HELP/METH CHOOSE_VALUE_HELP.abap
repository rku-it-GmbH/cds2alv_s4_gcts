  METHOD choose_value_help.
    " TODO: Choose Value Help
    DATA options TYPE STANDARD TABLE OF spopli.
    DATA answer  TYPE c LENGTH 3.

    options = VALUE #( FOR x_value_help IN c_value_helps
                       ( varoption = COND #( WHEN x_value_help-label IS NOT INITIAL THEN
                                               |{ x_value_help-value_help_index }: { x_value_help-label }|
                                             WHEN x_value_help-association_name IS NOT INITIAL THEN
                                               |{ x_value_help-value_help_index }: { x_value_help-association_name }|
                                             WHEN x_value_help-target_entity IS NOT INITIAL THEN
                                               |{ x_value_help-value_help_index }: { x_value_help-target_entity }| ) ) ).

    DELETE options WHERE varoption IS INITIAL.

    CALL FUNCTION 'POPUP_TO_DECIDE_LIST'
      EXPORTING
        textline1 = 'Choose Value Help'(001)
        titel     = 'Choose Value Help'(001)
      IMPORTING
        answer    = answer
      TABLES
        t_spopli  = options
      EXCEPTIONS
        OTHERS    = 1.
    IF sy-subrc <> 0 OR answer = 'A'.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    READ TABLE options INTO DATA(selected_option) WITH KEY selflag = abap_true.
    IF sy-subrc = 0.
      DATA(value_help_index) = CONV sytabix( substring_before( val = selected_option-varoption sub = ':' ) ).
      DELETE c_value_helps WHERE value_help_index <> value_help_index.
    ENDIF.
  ENDMETHOD.