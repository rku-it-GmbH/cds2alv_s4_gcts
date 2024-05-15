  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF mass_processing,
        none  TYPE zcds_alv_nav_mass_processing VALUE space,
        loop  TYPE zcds_alv_nav_mass_processing VALUE 'L',
        table TYPE zcds_alv_nav_mass_processing VALUE 'T',
      END OF mass_processing.
    CONSTANTS exit_interface TYPE seoitfname VALUE 'ZIF_CDS_ALV_NAVIGATION' ##NO_TEXT.

    DATA persistence      TYPE REF TO zif_cds_alv_persistence.
    DATA ddic_access      TYPE REF TO zif_cds_alv_ddic_access.
    DATA launcher         TYPE REF TO zif_cds_alv_report_launcher.
    DATA ioc_container    TYPE REF TO zif_cds_alv_ioc_container.
    DATA navigation_table TYPE zcds_alv_navigation_tab.
    DATA navigation_exits TYPE zcds_alv_navigation_exit_tab.

    METHODS ask_for_missing_parameters
      IMPORTING i_target_view      TYPE ddstrucobjname
      CHANGING  c_parameter_values TYPE zcds_alv_parameters
      RAISING   zcx_cds_alv_message.

    METHODS call_bor_method
      IMPORTING i_navigation   TYPE zcds_alv_nav
                i_key_field    TYPE fieldname
                i_selected_row TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS call_function_module
      IMPORTING i_navigation    TYPE zcds_alv_nav
                i_key_field     TYPE fieldname      OPTIONAL
                i_selected_row  TYPE any            OPTIONAL
                i_selected_rows TYPE STANDARD TABLE OPTIONAL
      RAISING   zcx_cds_alv_message.

    METHODS call_transaction
      IMPORTING i_navigation   TYPE zcds_alv_nav
                i_key_field    TYPE fieldname
                i_selected_row TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS call_oo_method
      IMPORTING i_navigation    TYPE zcds_alv_nav
                i_key_field     TYPE fieldname      OPTIONAL
                i_selected_row  TYPE any            OPTIONAL
                i_selected_rows TYPE STANDARD TABLE OPTIONAL
      RAISING   zcx_cds_alv_message.

    METHODS fill_ioc_container.

    METHODS get_object_from_ioc_container
      IMPORTING i_navigation_exit TYPE zcds_alv_navexit
      RETURNING VALUE(r_object)   TYPE REF TO zif_cds_alv_navigation
      RAISING   zcx_cds_alv_message.

    METHODS is_oo_exception
      IMPORTING i_exceptions             TYPE abap_excpdescr_tab
      RETURNING VALUE(r_is_oo_exception) TYPE abap_bool.