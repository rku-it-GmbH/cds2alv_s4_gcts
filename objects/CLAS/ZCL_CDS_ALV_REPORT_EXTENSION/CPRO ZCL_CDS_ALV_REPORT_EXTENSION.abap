  PROTECTED SECTION.
    ALIASES extension_name FOR zif_cds_alv_report_extension~extension_name.

    CONSTANTS: BEGIN OF main_parameters,
                 variant               TYPE rsscr_name VALUE 'P_VARI',
                 alternative_selection TYPE rsscr_name VALUE 'P_SELEXT',
                 alternative_display   TYPE rsscr_name VALUE 'P_DISEXT',
               END OF main_parameters.

    DATA extension_parameters TYPE zcds_alv_extension_parameters.

    METHODS is_selection_active
      IMPORTING i_selection_screen TYPE REF TO zif_cds_alv_selection_screen
      RETURNING VALUE(r_is_active) TYPE abap_bool.

    METHODS is_display_active
      IMPORTING i_selection_screen TYPE REF TO zif_cds_alv_selection_screen
      RETURNING VALUE(r_is_active) TYPE abap_bool.

    METHODS get_attributes_from_screen
      IMPORTING i_selection_screen TYPE REF TO zif_cds_alv_selection_screen.

    METHODS put_attributes_to_screen
      IMPORTING i_selection_screen TYPE REF TO zif_cds_alv_selection_screen
      RAISING   zcx_cds_alv_message.
