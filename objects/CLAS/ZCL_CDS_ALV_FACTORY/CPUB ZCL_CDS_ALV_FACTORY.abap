CLASS zcl_cds_alv_factory DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_factory.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(r_factory) TYPE REF TO zif_cds_alv_factory.

    CLASS-METHODS set_instance
      IMPORTING
        !i_factory TYPE REF TO zif_cds_alv_factory.
