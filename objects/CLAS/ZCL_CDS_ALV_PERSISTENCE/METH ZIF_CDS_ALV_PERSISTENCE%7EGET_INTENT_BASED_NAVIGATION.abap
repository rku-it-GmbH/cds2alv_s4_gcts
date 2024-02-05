  METHOD zif_cds_alv_persistence~get_intent_based_navigation.
    SELECT * FROM zcds_alv_nav INTO CORRESPONDING FIELDS OF TABLE @r_navigation_table.
  ENDMETHOD.