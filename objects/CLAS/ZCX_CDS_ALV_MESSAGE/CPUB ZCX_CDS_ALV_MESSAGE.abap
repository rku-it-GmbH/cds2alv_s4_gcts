CLASS zcx_cds_alv_message DEFINITION PUBLIC INHERITING FROM cx_static_check FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_alv_message.
    INTERFACES if_t100_dyn_msg.
    INTERFACES if_t100_message.

    ALIASES get_message FOR if_alv_message~get_message.
    ALIASES t100key     FOR if_t100_message~t100key.
    ALIASES msgty       FOR if_t100_dyn_msg~msgty.
    ALIASES msgv1       FOR if_t100_dyn_msg~msgv1.
    ALIASES msgv2       FOR if_t100_dyn_msg~msgv2.
    ALIASES msgv3       FOR if_t100_dyn_msg~msgv3.
    ALIASES msgv4       FOR if_t100_dyn_msg~msgv4.

    METHODS constructor
      IMPORTING textid    LIKE if_t100_message=>t100key OPTIONAL
                !previous LIKE previous                 OPTIONAL.
