CLASS zcl_cds_alv_extension_provider DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_extension_provider.

    METHODS constructor
      IMPORTING i_persistence TYPE REF TO zif_cds_alv_persistence.
