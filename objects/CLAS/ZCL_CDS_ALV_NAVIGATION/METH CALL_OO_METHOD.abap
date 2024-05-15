  METHOD call_oo_method.
    DATA(class_descriptor) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_name( i_navigation-class ) ).
    DATA(parameter_type_descriptor) = class_descriptor->get_method_parameter_type(
                                          p_method_name    = i_navigation-method
                                          p_parameter_name = i_navigation-method_parameter ).

    DATA input TYPE REF TO data.
    CREATE DATA input TYPE HANDLE parameter_type_descriptor.

    IF input IS NOT BOUND.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e033(zcds_alv) WITH i_navigation-method_parameter i_navigation-class i_navigation-method.
    ENDIF.

    ASSIGN input->* TO FIELD-SYMBOL(<input>).

    IF i_navigation-conversion_exit IS NOT INITIAL.
      DATA(conversion_function) = |CONVERSION_EXIT_{ i_navigation-conversion_exit }_INPUT|.
    ENDIF.

    IF i_selected_row IS NOT INITIAL.
      ASSIGN COMPONENT i_key_field OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<key>).
      <input> = <key>.

      IF conversion_function IS NOT INITIAL.
        CALL FUNCTION conversion_function
          EXPORTING input  = <input>
          IMPORTING output = <input>.
      ENDIF.

    ELSEIF i_selected_rows IS NOT INITIAL.
      FIELD-SYMBOLS <table> TYPE ANY TABLE.

      LOOP AT i_selected_rows ASSIGNING FIELD-SYMBOL(<selected_row>).
        ASSIGN COMPONENT i_key_field OF STRUCTURE <selected_row> TO <key>.
        ASSIGN <input> TO <table>.
        INSERT <key> INTO TABLE <table> ASSIGNING FIELD-SYMBOL(<line>).

        IF conversion_function IS NOT INITIAL.
          CALL FUNCTION conversion_function
            EXPORTING input  = <line>
            IMPORTING output = <line>.
        ENDIF.
      ENDLOOP.
    ENDIF.

    READ TABLE class_descriptor->methods INTO DATA(method) WITH KEY name = i_navigation-method.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e035(zcds_alv) WITH i_navigation-class i_navigation-method.
    ENDIF.

    DATA(parameter_binding) = VALUE abap_parmbind_tab( ( name  = i_navigation-method_parameter
                                                         kind  = cl_abap_objectdescr=>exporting
                                                         value = input ) ).

    IF method-is_raising_excps IS NOT INITIAL AND is_oo_exception( method-exceptions ) = abap_false.
      DATA(exception_binding) = VALUE abap_excpbind_tab( ( name = `OTHERS` value = 1 ) ).
    ENDIF.

    TRY.
        CASE method-is_class.
          WHEN abap_true.
            IF exception_binding IS NOT INITIAL.
              CALL METHOD (i_navigation-class)=>(i_navigation-method)
                PARAMETER-TABLE parameter_binding
                EXCEPTION-TABLE exception_binding.
              IF sy-subrc <> 0.
                RAISE EXCEPTION TYPE zcx_cds_alv_message
                      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              ENDIF.
            ELSE.
              TRY.
                  CALL METHOD (i_navigation-class)=>(i_navigation-method)
                    PARAMETER-TABLE parameter_binding.

                CATCH cx_root.
                  RAISE EXCEPTION TYPE zcx_cds_alv_message
                        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              ENDTRY.
            ENDIF.

          WHEN abap_false.
            DATA instance TYPE REF TO object.
            CREATE OBJECT instance TYPE (i_navigation-class).

            IF exception_binding IS NOT INITIAL.
              CALL METHOD instance->(i_navigation-method)
                PARAMETER-TABLE parameter_binding
                EXCEPTION-TABLE exception_binding.
              IF sy-subrc <> 0.
                RAISE EXCEPTION TYPE zcx_cds_alv_message
                      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              ENDIF.
            ELSE.
              TRY.
                  CALL METHOD instance->(i_navigation-method)
                    PARAMETER-TABLE parameter_binding.

                CATCH cx_root.
                  RAISE EXCEPTION TYPE zcx_cds_alv_message
                        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              ENDTRY.
            ENDIF.
        ENDCASE.

      CATCH cx_sy_create_object_error.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE e036(zcds_alv) WITH i_navigation-class.

      CATCH cx_sy_dyn_call_error.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE e034(zcds_alv) WITH i_navigation-class i_navigation-method.
    ENDTRY.
  ENDMETHOD.