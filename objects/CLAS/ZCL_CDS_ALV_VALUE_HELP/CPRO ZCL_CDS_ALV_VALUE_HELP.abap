  PROTECTED SECTION.
    DATA value_helps TYPE zcds_alv_valuehelp_definitions.

    METHODS evaluate_annotations REDEFINITION.

    METHODS value_help_by_association
      IMPORTING i_fieldname        TYPE fieldname
                i_association_name TYPE ddassociationname
                i_parameters       TYPE zcds_alv_parameters OPTIONAL
                i_field_ranges     TYPE rsds_frange_t       OPTIONAL
                i_selected_row     TYPE any                 OPTIONAL
                i_display          TYPE abap_bool
      CHANGING  c_value            TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS value_help_by_target_entity
      IMPORTING i_target_entity      TYPE ddstrucobjname
                i_target_element     TYPE fieldname
                i_additional_binding TYPE zcds_alv_valuehelp_binding_tab OPTIONAL
                i_parameters         TYPE zcds_alv_parameters            OPTIONAL
                i_field_ranges       TYPE rsds_frange_t                  OPTIONAL
                i_selected_row       TYPE any                            OPTIONAL
                i_display            TYPE abap_bool
      CHANGING  c_value              TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS get_value_from_dialog
      IMPORTING i_fieldname TYPE fieldname
                i_table     TYPE STANDARD TABLE
                i_display   TYPE abap_bool
      CHANGING  c_value     TYPE any
      RAISING   zcx_cds_alv_message.

    METHODS choose_value_help
      CHANGING c_value_helps TYPE zcds_alv_valuehelp_definitions
      RAISING  zcx_cds_alv_message.
