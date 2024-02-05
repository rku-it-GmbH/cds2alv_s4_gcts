  METHOD get_instance.
    IF singleton IS NOT BOUND.
      DATA(class) = get_implementation_static( 'ZIF_CDS_ALV_FACTORY' ).
      CREATE OBJECT singleton TYPE (class).
    ENDIF.

    r_factory = singleton.
  ENDMETHOD.