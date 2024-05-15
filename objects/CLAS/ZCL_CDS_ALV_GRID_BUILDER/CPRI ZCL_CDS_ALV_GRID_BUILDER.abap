  PRIVATE SECTION.
    TYPES: BEGIN OF ty_ui_annotation,
             index TYPE sytabix,
             key   TYPE string,
             value TYPE string,
           END OF ty_ui_annotation.
    TYPES ty_ui_annotations TYPE SORTED TABLE OF ty_ui_annotation WITH NON-UNIQUE KEY index.

    CONSTANTS function_code_prefix TYPE string VALUE 'ZZ_CDS_ALV_FC'.

    DATA update_enabled TYPE xsdboolean.
    DATA delete_enabled TYPE xsdboolean.

    METHODS sort_columns.