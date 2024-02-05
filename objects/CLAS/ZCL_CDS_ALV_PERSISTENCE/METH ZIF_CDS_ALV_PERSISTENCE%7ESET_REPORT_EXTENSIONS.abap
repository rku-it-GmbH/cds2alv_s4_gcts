  METHOD zif_cds_alv_persistence~set_report_extensions.
    LOOP AT i_extensions INTO DATA(extension).
      DATA(db_data) = CORRESPONDING zcds_alv_progext( extension ).
      GET TIME STAMP FIELD db_data-activated_on.
      MODIFY zcds_alv_progext FROM @db_data.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_cds_alv_message
              MESSAGE e014(zcds_alv) WITH i_cds_view.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.