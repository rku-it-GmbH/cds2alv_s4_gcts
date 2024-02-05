  METHOD zif_cds_alv_table_container~get_table.
    ASSIGN ref_to_table->* TO FIELD-SYMBOL(<table>).
    e_table = <table>.
  ENDMETHOD.