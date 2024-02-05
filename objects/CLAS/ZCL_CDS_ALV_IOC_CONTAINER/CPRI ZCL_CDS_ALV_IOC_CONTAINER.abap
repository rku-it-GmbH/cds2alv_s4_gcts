  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_instance,
        interface TYPE seoitfname,
        filters   TYPE ty_filters,
        object    TYPE REF TO object,
      END OF ty_instance.
    TYPES ty_instances TYPE SORTED TABLE OF ty_instance WITH NON-UNIQUE KEY interface.
    TYPES:
      BEGIN OF ty_implementation,
        interface  TYPE seoitfname,
        filters    TYPE ty_filters,
        class      TYPE seoclsname,
        parameters TYPE abap_parmbind_tab,
      END OF ty_implementation.
    TYPES ty_implementations TYPE SORTED TABLE OF ty_implementation WITH NON-UNIQUE KEY interface.

    DATA parent          TYPE REF TO zif_cds_alv_ioc_container.
    DATA instances       TYPE ty_instances.
    DATA implementations TYPE ty_implementations.

    METHODS create_object
      IMPORTING i_interface     TYPE seoitfname
                i_filters       TYPE zif_cds_alv_ioc_container=>ty_filters OPTIONAL
      RETURNING VALUE(r_object) TYPE REF TO object
      RAISING   zcx_cds_alv_message.

    METHODS store_object
      IMPORTING i_interface TYPE seoitfname
                i_filters   TYPE zif_cds_alv_ioc_container=>ty_filters OPTIONAL
                i_object    TYPE REF TO object
      RAISING   zcx_cds_alv_message.

    METHODS is_interface
      IMPORTING i_parameter_type      TYPE vseoparam-type
      RETURNING VALUE(r_is_interface) TYPE abap_bool.

    METHODS get_return_type
      IMPORTING i_increase_depth_by  TYPE i DEFAULT 0
      RETURNING VALUE(r_return_type) TYPE seoitfname
      RAISING   zcx_cds_alv_message.

    METHODS check_interface
      IMPORTING i_interface TYPE seoitfname
      RAISING   zcx_cds_alv_message.

    METHODS check_class
      IMPORTING i_class TYPE seoclsname
      RAISING   zcx_cds_alv_message.

    METHODS check_implements
      IMPORTING i_class     TYPE seoclsname
                i_interface TYPE seoitfname
      RAISING   zcx_cds_alv_message.

    METHODS get_constructor_parameters
      IMPORTING i_class_name        TYPE seoclsname
      RETURNING VALUE(r_parameters) TYPE seo_parameters.