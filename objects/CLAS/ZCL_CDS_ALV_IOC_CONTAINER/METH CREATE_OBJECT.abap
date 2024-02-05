  METHOD create_object.
    DATA ref_to_object TYPE REF TO data.

    TRY.
        DATA(implementation) = implementations[ interface = i_interface filters = i_filters ].
        DATA(parameters) = VALUE abap_parmbind_tab( ).

        LOOP AT get_constructor_parameters( implementation-class ) INTO DATA(parameter).
          " Check for injected parameter
          IF line_exists( implementation-parameters[ name = parameter-sconame ]  ).
            INSERT implementation-parameters[ name = parameter-sconame ]
                   INTO TABLE parameters.
            CONTINUE.
          ENDIF.

          IF is_interface( parameter-type ).
            DATA(interface) = CONV seoitfname( parameter-type ).
            CREATE DATA ref_to_object TYPE REF TO (interface).
            ASSIGN ref_to_object->* TO FIELD-SYMBOL(<object>).

            " Remind me to allow propagation of filters when needed
            <object> ?= resolve( i_interface = interface ).

            INSERT VALUE #( name = parameter-sconame value = ref_to_object )
                   INTO TABLE parameters.
          ENDIF.
        ENDLOOP.

        CREATE OBJECT r_object TYPE (implementation-class) PARAMETER-TABLE parameters.

      CATCH cx_sy_itab_line_not_found cx_class_not_existent.
        RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e016(zcds_alv) WITH i_interface.
      CATCH cx_sy_create_object_error.
        RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e017(zcds_alv) WITH i_interface implementation-class.
    ENDTRY.
  ENDMETHOD.