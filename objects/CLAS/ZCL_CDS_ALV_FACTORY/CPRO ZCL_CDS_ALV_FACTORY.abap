  PROTECTED SECTION.
    TYPES:
      BEGIN OF ty_ioc_container,
        cds_view      TYPE ddstrucobjname,
        ioc_container TYPE REF TO zif_cds_alv_ioc_container,
      END OF ty_ioc_container.
    TYPES:
      tt_ioc_containers TYPE HASHED TABLE OF ty_ioc_container WITH UNIQUE KEY cds_view .

    DATA ioc_containers TYPE tt_ioc_containers.

    METHODS get_container_for_cds_view
      IMPORTING
        !i_cds_view            TYPE ddstrucobjname
      RETURNING
        VALUE(r_ioc_container) TYPE REF TO zif_cds_alv_ioc_container
      RAISING
        zcx_cds_alv_message.
    METHODS get_fallback
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.
    METHODS get_from_customizing
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.
    METHODS get_implementation
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.
    METHODS get_parent_container
      RETURNING
        VALUE(r_ioc_container) TYPE REF TO zif_cds_alv_ioc_container
      RAISING
        zcx_cds_alv_message.
