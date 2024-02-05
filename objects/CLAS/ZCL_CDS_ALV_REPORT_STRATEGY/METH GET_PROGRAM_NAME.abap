  METHOD get_program_name.
    TRY.
        " Vorhandenes Programm suchen
        r_progname = persistence->get_report_for_cds_view( cds_view )-progname.

      CATCH zcx_cds_alv_message.
        " Noch kein Programm vorhanden
        IF db_view IS NOT INITIAL.
          r_progname = replace( val = |ZCDS_ALV_V_{ db_view }| sub = '/' with = '_' occ = 0 ).
        ELSE.
          DATA(number) = persistence->get_next_program_number( cds_view ).
          r_progname = |ZCDS_ALV_N_{ sy-mandt }{ number }|.
        ENDIF.
    ENDTRY.
  ENDMETHOD.