  PRIVATE SECTION.
    DATA entity TYPE REF TO if_sadl_entity.

    METHODS build_sadl_definition
      RAISING cx_bsa_compile_time.

    METHODS convert_id
      IMPORTING i_name        TYPE string
      RETURNING VALUE(r_name) TYPE string.