  METHOD if_alv_message~get_message.
    r_s_msg = VALUE #( msgid = t100key-msgid
                       msgno = t100key-msgno
                       msgty = msgty
                       msgv1 = msgv1
                       msgv2 = msgv2
                       msgv3 = msgv3
                       msgv4 = msgv4 ).

    r_s_msg-probclass = problem_class_for_message_type( r_s_msg-msgty ).
    GET TIME STAMP FIELD r_s_msg-time_stmp.
  ENDMETHOD.