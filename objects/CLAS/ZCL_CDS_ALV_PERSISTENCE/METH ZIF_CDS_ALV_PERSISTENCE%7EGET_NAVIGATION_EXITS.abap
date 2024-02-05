  METHOD zif_cds_alv_persistence~get_navigation_exits.
    SELECT * FROM zcds_alv_navexit INTO CORRESPONDING FIELDS OF TABLE @r_navigation_exits.
  ENDMETHOD.