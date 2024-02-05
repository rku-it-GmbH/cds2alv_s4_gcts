CLASS zcl_cds_alv_ioc_container DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zif_cds_alv_ioc_container.

    ALIASES resolve    FOR zif_cds_alv_ioc_container~resolve.
    ALIASES ty_filters FOR zif_cds_alv_ioc_container~ty_filters.

    DATA cds_view TYPE ddstrucobjname READ-ONLY.

    METHODS constructor
      IMPORTING i_cds_view TYPE ddstrucobjname                   OPTIONAL
                i_parent   TYPE REF TO zif_cds_alv_ioc_container OPTIONAL.
