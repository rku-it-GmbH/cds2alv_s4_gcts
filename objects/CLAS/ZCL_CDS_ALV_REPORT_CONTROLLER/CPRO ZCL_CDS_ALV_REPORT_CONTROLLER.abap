  PROTECTED SECTION.
    DATA alternative_selection TYPE zcds_alv_report_extension_name.
    DATA alternative_display   TYPE zcds_alv_report_extension_name.
    DATA table_container       TYPE REF TO zif_cds_alv_table_container.
    DATA selection_screen      TYPE REF TO zif_cds_alv_selection_screen.
    DATA selection             TYPE REF TO zif_cds_alv_selection.
    DATA builder               TYPE REF TO zif_cds_alv_grid_builder.
    DATA extension_provider    TYPE REF TO zif_cds_alv_extension_provider.
    DATA extensions            TYPE zif_cds_alv_extension_provider=>ty_report_extensions.

    METHODS evaluate_annotations REDEFINITION.
