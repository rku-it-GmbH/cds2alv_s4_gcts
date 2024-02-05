CLASS zcl_cds_alv_grid_builder DEFINITION PUBLIC CREATE PUBLIC INHERITING FROM zcl_cds_alv_base.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_grid_builder.

    METHODS constructor
      IMPORTING i_cds_view         TYPE ddstrucobjname
                i_ddic_access      TYPE REF TO zif_cds_alv_ddic_access
                i_persistence      TYPE REF TO zif_cds_alv_persistence
                i_memory           TYPE REF TO zif_cds_alv_memory
                i_factory          TYPE REF TO zif_cds_alv_factory
                i_selection_screen TYPE REF TO zif_cds_alv_selection_screen
                i_selection        TYPE REF TO zif_cds_alv_selection
                i_value_help       TYPE REF TO zif_cds_alv_value_help
                i_bopf_handler     TYPE REF TO zif_cds_alv_bopf_handler
                i_navigation       TYPE REF TO zif_cds_alv_navigation
      RAISING   zcx_cds_alv_message.
