  PROTECTED SECTION.
    CONSTANTS:
      BEGIN OF button_type,
        normal       TYPE tb_btype VALUE 0,
        menu_default TYPE tb_btype VALUE 1,
        menu         TYPE tb_btype VALUE 2,
        separator    TYPE tb_btype VALUE 3,
        radio_button TYPE tb_btype VALUE 4,
        check_box    TYPE tb_btype VALUE 5,
        menu_entry   TYPE tb_btype VALUE 6,
      END OF button_type.
    CONSTANTS:
      BEGIN OF standard_function_code,
        refresh                   TYPE ui_func VALUE 'REFRESH',
        delete                    TYPE ui_func VALUE 'DELETE',
        save                      TYPE ui_func VALUE 'SAVE',
        toggle_change_mode        TYPE ui_func VALUE 'DISPCHNG',
        additional_functions_menu TYPE ui_func VALUE 'ADD_FUNC',
      END OF standard_function_code.
    CONSTANTS:
      BEGIN OF display_mode,
        dropdown_menu TYPE zcds_alv_func_display_mode VALUE '0',
        buttons       TYPE zcds_alv_func_display_mode VALUE '1',
      END OF display_mode.

    CLASS-DATA standard_function_codes TYPE ui_functions.

    DATA cds_view                 TYPE ddstrucobjname.
    DATA ref_to_table             TYPE REF TO data.
    DATA alv_grid                 TYPE REF TO cl_gui_alv_grid.
    DATA selection                TYPE REF TO zif_cds_alv_selection.
    DATA value_help               TYPE REF TO zif_cds_alv_value_help.
    DATA navigation               TYPE REF TO zif_cds_alv_navigation.
    DATA action_handler           TYPE REF TO zif_cds_alv_action_handler.
    DATA bopf_handler             TYPE REF TO zif_cds_alv_bopf_handler.
    DATA table_container          TYPE REF TO zif_cds_alv_table_container.
    DATA selection_screen         TYPE REF TO zif_cds_alv_selection_screen.
    DATA alternative_selection    TYPE REF TO zif_cds_alv_select_extension.
    DATA field_actions            TYPE zcds_alv_field_actions.
    DATA functions                TYPE zcds_alv_functions.
    DATA standard_functions       TYPE zcds_alv_functions.
    DATA additional_functions     TYPE zcds_alv_functions.
    DATA update_enabled           TYPE abap_bool.
    DATA delete_enabled           TYPE abap_bool.
    DATA editable_fields          TYPE ddfieldnames.
    DATA functions_display_mode   TYPE zcds_alv_func_display_mode.
    DATA has_bopf_object          TYPE abap_bool.
    DATA has_behaviour_definition TYPE abap_bool.

    METHODS dispatch_standard_function
      IMPORTING i_function      TYPE ui_func
                i_selected_rows TYPE STANDARD TABLE.

    METHODS dispatch_single_action
      IMPORTING i_field_action TYPE zcds_alv_field_action
                i_selected_row TYPE any.

    METHODS dispatch_mass_action
      IMPORTING i_field_action  TYPE zcds_alv_field_action
                i_selected_rows TYPE STANDARD TABLE.

    METHODS build_function_table.

    METHODS toggle_change_mode
      RAISING zcx_cds_alv_message.

    METHODS refresh
      RAISING zcx_cds_alv_message.
