CLASS zcl_cds_alv_report_launcher DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_report_launcher.

    DATA ddic_access  TYPE REF TO zif_cds_alv_ddic_access.
    DATA persistence  TYPE REF TO zif_cds_alv_persistence.
    DATA memory       TYPE REF TO zif_cds_alv_memory.
    DATA generator    TYPE REF TO zif_cds_alv_report_generator.
    DATA auth_checker TYPE REF TO zif_cds_alv_authority_check.

    METHODS constructor
      IMPORTING i_ddic_access  TYPE REF TO zif_cds_alv_ddic_access
                i_persistence  TYPE REF TO zif_cds_alv_persistence
                i_memory       TYPE REF TO zif_cds_alv_memory
                i_generator    TYPE REF TO zif_cds_alv_report_generator
                i_auth_checker TYPE REF TO zif_cds_alv_authority_check.
