  METHOD remove_quotes.
    r_string = replace( val = i_string sub = `'` with = `` occ = 0 ).
  ENDMETHOD.