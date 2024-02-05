CLASS zcl_cds_alv_selection_screen DEFINITION PUBLIC INHERITING FROM zcl_cds_alv_base CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_condition_provider.
    INTERFACES zif_cds_alv_selection_screen.

    ALIASES read_selection_screen FOR zif_cds_alv_selection_screen~read_selection_screen.
    ALIASES get_dynpro_field      FOR zif_cds_alv_selection_screen~get_dynpro_field.
    ALIASES get_selections        FOR zif_cds_alv_selection_screen~get_selections.
    ALIASES get_parameters        FOR zif_cds_alv_selection_screen~get_parameters.

    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING i_cds_view    TYPE ddstrucobjname
                i_ddic_access TYPE REF TO zif_cds_alv_ddic_access
                i_persistence TYPE REF TO zif_cds_alv_persistence
                i_memory      TYPE REF TO zif_cds_alv_memory
                i_factory     TYPE REF TO zif_cds_alv_factory
                i_value_help  TYPE REF TO zif_cds_alv_value_help OPTIONAL
      RAISING   zcx_cds_alv_message.
