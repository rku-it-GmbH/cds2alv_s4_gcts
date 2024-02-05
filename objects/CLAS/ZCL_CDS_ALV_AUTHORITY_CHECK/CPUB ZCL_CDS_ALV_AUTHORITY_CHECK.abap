CLASS zcl_cds_alv_authority_check DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_authority_check.

    METHODS constructor
      IMPORTING i_ddic_access TYPE REF TO zif_cds_alv_ddic_access.
