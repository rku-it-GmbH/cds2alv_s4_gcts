CLASS zcl_cds_alv_report_generator DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_report_generator.

    DATA factory     TYPE REF TO zif_cds_alv_factory.
    DATA ddic_access TYPE REF TO zif_cds_alv_ddic_access.
    DATA persistence TYPE REF TO zif_cds_alv_persistence.
    DATA strategy    TYPE REF TO zif_cds_alv_report_strategy.

    METHODS constructor
      IMPORTING i_factory     TYPE REF TO zif_cds_alv_factory
                i_ddic_access TYPE REF TO zif_cds_alv_ddic_access
                i_persistence TYPE REF TO zif_cds_alv_persistence.
