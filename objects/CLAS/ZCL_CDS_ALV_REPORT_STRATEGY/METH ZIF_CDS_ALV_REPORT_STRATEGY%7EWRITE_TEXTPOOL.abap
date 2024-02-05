  METHOD zif_cds_alv_report_strategy~write_textpool.
    LOOP AT field_properties_tab INTO DATA(field_properties).
      APPEND VALUE #( id    = 'S'
                      key   = field_properties-sel_name
                      entry = |        { condense( field_properties-label ) }| )
             TO r_textpool.
    ENDLOOP.

    LOOP AT param_properties_tab INTO DATA(param_properties).
      APPEND VALUE #( id    = 'S'
                      key   = param_properties-sel_name
                      entry = |        { condense( param_properties-label ) }| )
             TO r_textpool.
    ENDLOOP.

    APPEND VALUE #( id = 'I' key = 'SUB'      entry = text-i01 ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_MAXREC' entry = |        { text-s01 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_NO_MAX' entry = |        { text-s02 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_FORALL' entry = |        { text-s03 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_MEM_ID' entry = |        { text-s04 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_SPLIT'  entry = |        { text-s05 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_SELEXT' entry = |        { text-s06 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_DISEXT' entry = |        { text-s07 }| ) TO r_textpool.
    APPEND VALUE #( id = 'S' key = 'P_VARI'   entry = |        { text-s08 }| ) TO r_textpool.

    LOOP AT get_extension_parameters( ) INTO DATA(parameter).
      INSERT VALUE #( id = 'S' key = parameter-parameter_name entry = |        { parameter-parameter_text }| )
             INTO TABLE r_textpool.
    ENDLOOP.
  ENDMETHOD.