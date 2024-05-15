  METHOD zif_cds_alv_persistence~get_extension_parameters.
    SELECT * FROM zcds_alv_extpar  AS par
             JOIN zcds_alv_extpart AS text ON  par~extension_name = text~extension_name
                                           AND par~parameter_name = text~parameter_name
     WHERE par~extension_name = @i_extension_name
       AND text~spras         = @sy-langu
      INTO CORRESPONDING FIELDS OF TABLE @r_parameters.
  ENDMETHOD.