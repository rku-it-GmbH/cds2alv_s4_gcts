CLASS zcl_cds_alv_grid_event_handler DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_grid_event_handler.

    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING i_cds_view              TYPE ddstrucobjname
                i_alv_grid              TYPE REF TO cl_gui_alv_grid
                i_table_container       TYPE REF TO zif_cds_alv_table_container
                i_selection             TYPE REF TO zif_cds_alv_selection        OPTIONAL
                i_value_help            TYPE REF TO zif_cds_alv_value_help       OPTIONAL
                i_navigation            TYPE REF TO zif_cds_alv_navigation       OPTIONAL
                i_bopf_handler          TYPE REF TO zif_cds_alv_bopf_handler     OPTIONAL
                i_selection_screen      TYPE REF TO zif_cds_alv_selection_screen OPTIONAL
                i_alternative_selection TYPE REF TO zif_cds_alv_select_extension OPTIONAL
                i_field_actions         TYPE zcds_alv_field_actions              OPTIONAL
                i_update_enabled        TYPE abap_bool                           DEFAULT abap_false
                i_delete_enabled        TYPE abap_bool                           DEFAULT abap_false
                i_editable_fields       TYPE ddfieldnames                        OPTIONAL.
