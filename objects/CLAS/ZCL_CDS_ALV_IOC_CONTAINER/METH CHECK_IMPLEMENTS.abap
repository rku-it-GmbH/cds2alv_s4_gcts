  METHOD check_implements.
    DATA(if_relations) = NEW cl_oo_if_relations( clsname = i_interface ).
    IF     NOT line_exists( if_relations->implementing_classes[ clsname = i_class ] )
       AND NOT line_exists( if_relations->subclasses[ clsname = i_class ] ).
      RAISE EXCEPTION TYPE zcx_cds_alv_message MESSAGE e029(zcds_alv) WITH i_class i_interface.
    ENDIF.
  ENDMETHOD.