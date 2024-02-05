  PROTECTED SECTION.
    CONSTANTS: BEGIN OF field_type,
                 standard                     TYPE zcds_alv_field_type VALUE '#STANDARD',
                 for_action                   TYPE zcds_alv_field_type VALUE '#FOR_ACTION',
                 for_intent_based_navigation  TYPE zcds_alv_field_type VALUE '#FOR_INTENT_BASED_NAVIGATION',
                 with_intent_based_navigation TYPE zcds_alv_field_type VALUE '#WITH_INTENT_BASED_NAVIGATION',
                 with_navigation_path         TYPE zcds_alv_field_type VALUE '#WITH_NAVIGATION_PATH',
                 with_url                     TYPE zcds_alv_field_type VALUE '#WITH_URL',
               END OF field_type.

    DATA description TYPE ddtext .
    DATA ddfields TYPE ddfields .
    DATA parameter_annotations TYPE cl_dd_ddl_annotation_service=>ty_t_para_anno_val_src_dtel .
    DATA element_annotations TYPE cl_dd_ddl_annotation_service=>ty_t_elmnt_anno_val_src_dtel .
    DATA entity_annotations TYPE cl_dd_ddl_annotation_service=>ty_t_anno_value .
    DATA ddic_access TYPE REF TO zif_cds_alv_ddic_access.
    DATA persistence TYPE REF TO zif_cds_alv_persistence.
    DATA memory TYPE REF TO zif_cds_alv_memory.
    DATA factory TYPE REF TO zif_cds_alv_factory.

    METHODS evaluate_annotations ABSTRACT
      RAISING
        zcx_cds_alv_message.

    METHODS remove_quotes
      IMPORTING
        i_string        TYPE clike
      RETURNING
        VALUE(r_string) TYPE string.