  METHOD ensure_generation.
    DATA(view_modified_at) = ddic_access->get_last_modified_at( i_cds_view ).

    TRY.
        DATA(program) = persistence->get_report_for_cds_view( i_cds_view ).
        DATA(extensions_active_since) = VALUE timestamp( ).
        LOOP AT persistence->get_report_extensions( i_cds_view = i_cds_view i_only_active = abap_false ) INTO DATA(extension).
          extensions_active_since = nmax( val1 = extensions_active_since val2 = extension-activated_on ).
        ENDLOOP.

      CATCH zcx_cds_alv_message INTO DATA(message).
        DATA(no_program) = abap_true.
        IF program-no_generation = abap_true.
          RAISE EXCEPTION message.
        ENDIF.
    ENDTRY.

    IF     (      no_program              = abap_true
             OR ( view_modified_at        > program-generated_at )
             OR ( extensions_active_since > program-generated_at ) )
       AND program-no_generation = abap_false.

      generator->generate_report( i_cds_view ).
    ENDIF.
  ENDMETHOD.