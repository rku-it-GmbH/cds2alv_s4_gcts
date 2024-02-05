  PRIVATE SECTION.
    CONSTANTS: BEGIN OF message_type,
                 info    TYPE symsgty VALUE 'I',
                 success TYPE symsgty VALUE 'S',
                 warning TYPE symsgty VALUE 'W',
                 error   TYPE symsgty VALUE 'E',
                 abort   TYPE symsgty VALUE 'A',
                 exit    TYPE symsgty VALUE 'X',
               END OF message_type.

    CONSTANTS: BEGIN OF problem_class,
                 very_high TYPE balprobcl VALUE '1',
                 high      TYPE balprobcl VALUE '2',
                 medium    TYPE balprobcl VALUE '3',
                 low       TYPE balprobcl VALUE '4',
                 others    TYPE balprobcl VALUE '5',
               END OF problem_class.

    METHODS problem_class_for_message_type
      IMPORTING i_message_type         TYPE symsgty
      RETURNING VALUE(r_problem_class) TYPE balprobcl.