  METHOD zif_cds_alv_ddic_access~get_ddic_fields_for_cds_view.
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING  tabname   = i_cds_view
      TABLES     dfies_tab = r_ddfields
      EXCEPTIONS OTHERS    = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    DELETE r_ddfields WHERE fieldname = '.NODE1'.
  ENDMETHOD.