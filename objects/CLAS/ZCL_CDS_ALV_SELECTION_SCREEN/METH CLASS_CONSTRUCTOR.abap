  METHOD class_constructor.
    st_options_tab = VALUE #( ( name    = selection_type-single
                                options = VALUE #( eq = abap_true ) )

                              ( name    = selection_type-interval
                                options = VALUE #( eq = abap_true
                                                   bt = abap_true ) )

                              ( name    = selection_type-range
                                options = VALUE #( bt = abap_true
                                                   cp = abap_true
                                                   eq = abap_true
                                                   ge = abap_true
                                                   gt = abap_true
                                                   le = abap_true
                                                   lt = abap_true
                                                   nb = abap_true
                                                   ne = abap_true
                                                   np = abap_true )  )  ).
  ENDMETHOD.