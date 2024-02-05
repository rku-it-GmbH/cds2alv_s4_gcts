  PRIVATE SECTION.
    CONSTANTS: BEGIN OF selection_type,
                 interval TYPE string VALUE '#INTERVAL' ##NO_TEXT,
                 range    TYPE string VALUE '#RANGE' ##NO_TEXT,
                 single   TYPE string VALUE '#SINGLE' ##NO_TEXT,
               END OF selection_type.

    TYPES:
      BEGIN OF ty_field_properties,
        qualifier           TYPE string,
        position            TYPE i,
        fieldname           TYPE fieldname,
        sel_name            TYPE rsscr_name,
        selection_type      TYPE string,
        multiple_selections TYPE abap_bool,
        mandatory           TYPE abap_bool,
        default_value       TYPE string,
        no_display          TYPE abap_bool,
        label               TYPE string,
        value_help          TYPE abap_bool,
      END OF ty_field_properties.
    TYPES ty_field_properties_tab TYPE STANDARD TABLE OF ty_field_properties WITH EMPTY KEY.
    TYPES:
      BEGIN OF ty_param_properties,
        parname       TYPE ddparname,
        sel_name      TYPE rsscr_name,
        data_type     TYPE rollname,
        system_field  TYPE fieldname,
        default_value TYPE string,
        label         TYPE string,
        value_help    TYPE abap_bool,
      END OF ty_param_properties.
    TYPES ty_param_properties_tab TYPE STANDARD TABLE OF ty_param_properties WITH EMPTY KEY.
    TYPES:
      BEGIN OF ty_ui_annotation,
        index TYPE sytabix,
        key   TYPE string,
        value TYPE string,
      END OF ty_ui_annotation.
    TYPES ty_ui_annotations TYPE SORTED TABLE OF ty_ui_annotation WITH NON-UNIQUE KEY index.

    DATA db_view              TYPE viewname16.
    DATA progname             TYPE progname.
    DATA field_properties_tab TYPE ty_field_properties_tab.
    DATA param_properties_tab TYPE ty_param_properties_tab.

    METHODS get_extension_parameters
      RETURNING VALUE(r_extension_parameters) TYPE zcds_alv_extension_parameters.

    METHODS get_program_name
      RETURNING VALUE(r_progname) TYPE progname
      RAISING   zcx_cds_alv_message.