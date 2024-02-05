  PROTECTED SECTION.
    CONSTANTS: BEGIN OF default_fieldname,
                 box    TYPE fieldname VALUE 'ALV_MARK',
                 style  TYPE fieldname VALUE 'ALV_STYLE',
                 color  TYPE fieldname VALUE 'ALV_COLOR',
                 count  TYPE fieldname VALUE 'ALV_COUNT',
                 index  TYPE fieldname VALUE 'ALV_INDEX',
                 system TYPE fieldname VALUE 'ALV_SYSTEM',
                 client TYPE fieldname VALUE 'ALV_CLIENT',
               END OF default_fieldname.

    CONSTANTS: BEGIN OF criticality,
                 neutral  TYPE c LENGTH 1 VALUE '0', " no LED
                 negative TYPE c LENGTH 1 VALUE '1', " red LED
                 critical TYPE c LENGTH 1 VALUE '2', " yellow LED
                 positive TYPE c LENGTH 1 VALUE '3', " green LED
               END OF criticality.

    TYPES: BEGIN OF ty_criticality_mapping,
             data_field TYPE fieldname,
             crit_field TYPE fieldname,
           END OF ty_criticality_mapping.
    TYPES ty_criticality_mapping_table TYPE STANDARD TABLE OF ty_criticality_mapping WITH EMPTY KEY.

    DATA in_edit_mode              TYPE abap_bool.
    DATA ref_to_table              TYPE REF TO data.
    DATA line_descriptor           TYPE REF TO cl_abap_structdescr.
    DATA table_descriptor          TYPE REF TO cl_abap_tabledescr.
    DATA ddic_structure_descriptor TYPE REF TO cl_abap_structdescr.
    DATA special_columns           TYPE zcds_alv_special_columns.
    DATA criticality_mapping_table TYPE ty_criticality_mapping_table.
    DATA read_only_fields          TYPE ddfieldnames.

    METHODS evaluate_annotations REDEFINITION.

    METHODS get_unique_fieldname
      IMPORTING i_components       TYPE abap_component_tab
                i_fieldname        TYPE fieldname
      RETURNING VALUE(r_fieldname) TYPE fieldname.

    METHODS adjust_table
      RAISING zcx_cds_alv_message.

    METHODS update_style_info.
