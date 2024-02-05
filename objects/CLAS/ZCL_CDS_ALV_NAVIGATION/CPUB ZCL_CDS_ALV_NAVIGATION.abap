CLASS zcl_cds_alv_navigation DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_navigation.

    METHODS constructor
      IMPORTING i_persistence TYPE REF TO zif_cds_alv_persistence
                i_ddic_access TYPE REF TO zif_cds_alv_ddic_access
                i_launcher    TYPE REF TO zif_cds_alv_report_launcher.
