  METHOD convert_id.
    r_name = i_name.
    REPLACE '~' IN r_name WITH '_'.
    REPLACE ALL OCCURRENCES OF '/' IN r_name WITH 'x'.
  ENDMETHOD.