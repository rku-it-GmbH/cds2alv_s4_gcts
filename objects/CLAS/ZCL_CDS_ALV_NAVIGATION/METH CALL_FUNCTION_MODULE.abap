  METHOD call_function_module.
    DATA exceptions TYPE STANDARD TABLE OF rsexc.
    DATA exporting  TYPE STANDARD TABLE OF rsexp.
    DATA importing  TYPE STANDARD TABLE OF rsimp.
    DATA changing   TYPE STANDARD TABLE OF rscha.
    DATA tables     TYPE STANDARD TABLE OF rstbl.
    DATA input      TYPE REF TO data.

    FIELD-SYMBOLS <table> TYPE ANY TABLE.

    CALL FUNCTION 'FUNCTION_IMPORT_INTERFACE'
      EXPORTING  funcname           = i_navigation-function
      TABLES     exception_list     = exceptions
                 export_parameter   = exporting
                 import_parameter   = importing
                 changing_parameter = changing
                 tables_parameter   = tables
      EXCEPTIONS error_message      = 1
                 function_not_found = 2
                 invalid_name       = 3
                 OTHERS             = 4.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    READ TABLE importing INTO DATA(import)
         WITH KEY parameter = i_navigation-default_parameter.
    IF sy-subrc = 0.
      IF import-dbfield IS NOT INITIAL.
        CREATE DATA input TYPE (import-dbfield).
      ELSEIF import-typ IS NOT INITIAL.
        CREATE DATA input TYPE (import-typ).
      ENDIF.
    ENDIF.

    READ TABLE tables INTO DATA(table)
         WITH KEY parameter = i_navigation-default_parameter.
    IF sy-subrc = 0.
      CREATE DATA input TYPE TABLE OF (table-dbstruct).
    ENDIF.

    IF input IS NOT BOUND.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e005(zcds_alv) WITH i_navigation-default_parameter i_navigation-function.
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

    DATA(parameter_binding) = COND abap_func_parmbind_tab(
      WHEN import-parameter IS NOT INITIAL THEN VALUE #( ( name  = import-parameter
                                                           kind  = abap_func_exporting
                                                           value = input ) )
      WHEN table-parameter IS NOT INITIAL  THEN VALUE #( ( name  = table-parameter
                                                           kind  = abap_func_tables
                                                           value = input ) ) ).

    DATA(exception_binding) = VALUE abap_func_excpbind_tab( ( name = `OTHERS` value = 1 ) ).

    CALL FUNCTION i_navigation-function
      PARAMETER-TABLE parameter_binding
      EXCEPTION-TABLE exception_binding.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.