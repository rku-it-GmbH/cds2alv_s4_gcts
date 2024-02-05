  PRIVATE SECTION.
    CLASS-DATA singleton TYPE REF TO zif_cds_alv_factory.

    CLASS-METHODS get_fallback_static
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.
    CLASS-METHODS get_from_customizing_static
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.
    CLASS-METHODS get_implementation_static
      IMPORTING
        !i_interface   TYPE seoitfname
      RETURNING
        VALUE(r_class) TYPE seoclsname.