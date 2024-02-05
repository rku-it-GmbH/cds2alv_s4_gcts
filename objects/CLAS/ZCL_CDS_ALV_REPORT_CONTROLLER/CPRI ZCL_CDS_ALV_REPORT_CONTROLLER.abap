  PRIVATE SECTION.
    METHODS default_selection
      IMPORTING i_forall       TYPE abap_bool
                i_memory_id    TYPE memory_id
      EXPORTING e_result_table TYPE STANDARD TABLE
      RAISING   zcx_cds_alv_message.

    METHODS default_display
      IMPORTING i_in_split_screen TYPE abap_bool
      RAISING   zcx_cds_alv_message.

    METHODS refresh
      RAISING zcx_cds_alv_message.

    METHODS select
      RAISING zcx_cds_alv_message.