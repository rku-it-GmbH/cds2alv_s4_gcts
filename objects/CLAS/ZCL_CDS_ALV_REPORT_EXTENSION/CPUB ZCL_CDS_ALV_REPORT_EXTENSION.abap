CLASS zcl_cds_alv_report_extension DEFINITION PUBLIC ABSTRACT.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_display_extension.
    INTERFACES zif_cds_alv_report_extension.
    INTERFACES zif_cds_alv_select_extension.

    METHODS constructor
      IMPORTING i_extension_name       TYPE zcds_alv_report_extension_name
                i_extension_parameters TYPE zcds_alv_extension_parameters.
