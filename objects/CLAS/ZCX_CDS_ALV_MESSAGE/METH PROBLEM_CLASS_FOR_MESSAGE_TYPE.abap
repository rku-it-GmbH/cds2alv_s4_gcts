  METHOD problem_class_for_message_type.
    r_problem_class = SWITCH #( i_message_type
                                WHEN message_type-exit    OR message_type-abort THEN problem_class-very_high
                                WHEN message_type-error                         THEN problem_class-high
                                WHEN message_type-warning                       THEN problem_class-medium
                                WHEN message_type-success OR message_type-info  THEN problem_class-low
                                ELSE                                                 problem_class-others ).
  ENDMETHOD.