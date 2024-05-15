  PROTECTED SECTION.
    TYPES: BEGIN OF ty_field_properties,
             fieldname           TYPE fieldname,
             fieldtype           TYPE zcds_alv_field_type,
             is_key              TYPE abap_bool,
             label               TYPE string,
             quickinfo           TYPE string,
             is_email            TYPE abap_bool,
             hidden              TYPE abap_bool,
             technical           TYPE abap_bool,
             default_aggregation TYPE string,
             position            TYPE i,
             is_hotspot          TYPE abap_bool,
             has_value_help      TYPE abap_bool,
             is_editable         TYPE abap_bool,
           END OF ty_field_properties.
    TYPES ty_field_properties_table TYPE STANDARD TABLE OF ty_field_properties WITH EMPTY KEY.

    DATA field_properties_table TYPE ty_field_properties_table.
    DATA event_handlers         TYPE zcds_alv_grid_event_handlers.
    DATA table_container        TYPE REF TO zif_cds_alv_table_container.
    DATA selection              TYPE REF TO zif_cds_alv_selection.
    DATA value_help             TYPE REF TO zif_cds_alv_value_help.
    DATA bopf_handler           TYPE REF TO zif_cds_alv_bopf_handler.
    DATA navigation             TYPE REF TO zif_cds_alv_navigation.
    DATA selection_screen       TYPE REF TO zif_cds_alv_selection_screen.
    DATA alternative_selection  TYPE REF TO zif_cds_alv_select_extension.
    DATA alv_grid               TYPE REF TO cl_gui_alv_grid.
    DATA field_actions          TYPE zcds_alv_field_actions.
    DATA editable_fields        TYPE ddfieldnames.
    DATA variant                TYPE disvariant.
    DATA layout                 TYPE lvc_s_layo.
    DATA exclude_functions      TYPE ui_functions.
    DATA fieldcatalog           TYPE lvc_t_fcat.
    DATA sort_order             TYPE lvc_t_sort.
    DATA filter                 TYPE lvc_t_filt.
    DATA value_help_fields      TYPE lvc_t_f4.

    METHODS evaluate_annotations REDEFINITION.

    METHODS build_fieldcatalog
      RAISING zcx_cds_alv_message.

    METHODS build_variant.
    METHODS build_layout.
    METHODS build_f4.
    METHODS build_exclude_functions.

    METHODS build_event_handler
      RAISING zcx_cds_alv_message.

    METHODS register_event_handlers.
