CLASS zcl_cds_alv_report_controller DEFINITION PUBLIC INHERITING FROM zcl_cds_alv_base CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_report_controller.
    INTERFACES zif_cds_alv_split_screen_cntr.

    ALIASES ok_code FOR zif_cds_alv_split_screen_cntr~ok_code.

    METHODS constructor
      IMPORTING i_cds_view           TYPE ddstrucobjname
                i_ddic_access        TYPE REF TO zif_cds_alv_ddic_access
                i_persistence        TYPE REF TO zif_cds_alv_persistence
                i_memory             TYPE REF TO zif_cds_alv_memory
                i_factory            TYPE REF TO zif_cds_alv_factory
                i_table_container    TYPE REF TO zif_cds_alv_table_container
                i_selection_screen   TYPE REF TO zif_cds_alv_selection_screen
                i_selection          TYPE REF TO zif_cds_alv_selection
                i_builder            TYPE REF TO zif_cds_alv_grid_builder
                i_extension_provider TYPE REF TO zif_cds_alv_extension_provider
      RAISING   zcx_cds_alv_message.
