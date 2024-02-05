  METHOD get_from_customizing_static.
    SELECT SINGLE class FROM zcds_alv_iocclif WHERE interface = @i_interface INTO @r_class.
  ENDMETHOD.