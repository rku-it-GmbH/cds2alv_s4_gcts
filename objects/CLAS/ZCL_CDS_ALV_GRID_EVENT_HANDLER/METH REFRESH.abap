  METHOD refresh.
    FIELD-SYMBOLS <table> TYPE STANDARD TABLE.

    ASSIGN ref_to_table->* TO <table>.

    IF alternative_selection IS BOUND.
      alternative_selection->alternative_reselection( EXPORTING i_cds_view         = cds_view
                                                                i_selection_screen = selection_screen
                                                                i_table_container  = table_container
                                                      CHANGING  c_result_table     = <table> ).

    ELSEIF selection IS BOUND.
      selection->perform_reselection( CHANGING c_result_table = <table> ).
    ENDIF.

    table_container->set_table( <table> ).

    alv_grid->refresh_table_display( ).
    cl_gui_cfw=>flush( ).
  ENDMETHOD.