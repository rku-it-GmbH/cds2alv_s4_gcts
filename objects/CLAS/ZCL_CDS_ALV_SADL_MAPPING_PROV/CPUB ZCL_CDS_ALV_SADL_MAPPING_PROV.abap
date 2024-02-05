CLASS zcl_cds_alv_sadl_mapping_prov DEFINITION PUBLIC INHERITING FROM cl_sadl_mp_entity FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING i_entity TYPE REF TO if_sadl_entity
      RAISING   cx_bsa_compile_time.
