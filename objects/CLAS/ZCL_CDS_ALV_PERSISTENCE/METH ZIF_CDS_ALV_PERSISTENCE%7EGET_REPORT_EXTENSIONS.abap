  METHOD zif_cds_alv_persistence~get_report_extensions.
    SELECT * FROM zcds_alv_exthdr  AS hdr
             JOIN zcds_alv_exthdrt AS text ON hdr~extension_name = text~extension_name
     WHERE text~spras = @sy-langu
      INTO CORRESPONDING FIELDS OF TABLE @r_extensions.

    LOOP AT r_extensions ASSIGNING FIELD-SYMBOL(<extension>).
      <extension>-cds_view = i_cds_view.
      SELECT SINGLE active, activated_on
        FROM zcds_alv_progext
       WHERE cds_view       = @i_cds_view
         AND extension_name = @<extension>-extension_name
        INTO CORRESPONDING FIELDS OF @<extension>.
      IF sy-subrc <> 0.
        CLEAR: <extension>-active,
               <extension>-activated_on.
      ENDIF.
    ENDLOOP.

    IF i_only_active = abap_true.
      DELETE r_extensions WHERE active = abap_false.
    ENDIF.

    IF i_only_display = abap_true.
      DELETE r_extensions WHERE alternative_display = abap_false.
    ENDIF.

    IF i_only_selection = abap_true.
      DELETE r_extensions WHERE alternative_selection = abap_false.
    ENDIF.
  ENDMETHOD.