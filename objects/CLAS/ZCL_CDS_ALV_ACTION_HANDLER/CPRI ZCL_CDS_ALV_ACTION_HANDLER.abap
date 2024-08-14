  PRIVATE SECTION.
    DATA sadl_definition     TYPE if_sadl_types=>ty_sadl_definition.
    DATA entity              TYPE REF TO if_sadl_entity.
    DATA runtime             TYPE REF TO if_sadl_entity_transactional.
    DATA transaction_manager TYPE REF TO cl_sadl_transaction_manager.

    METHODS ask_for_parameters
      CHANGING c_parameters TYPE any
      RAISING  zcx_cds_alv_message.

    METHODS map_attributes_single
      IMPORTING i_entity_key TYPE any OPTIONAL
                i_attributes TYPE if_sadl_types=>tt_sadl_attributes
      EXPORTING e_source_key TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS map_attributes_table
      IMPORTING i_entity_keys TYPE STANDARD TABLE OPTIONAL
                i_attributes  TYPE if_sadl_types=>tt_sadl_attributes
      EXPORTING e_source_keys TYPE STANDARD TABLE
      RAISING   zcx_cds_alv_message.

    METHODS instantiate
      RAISING zcx_cds_alv_message.