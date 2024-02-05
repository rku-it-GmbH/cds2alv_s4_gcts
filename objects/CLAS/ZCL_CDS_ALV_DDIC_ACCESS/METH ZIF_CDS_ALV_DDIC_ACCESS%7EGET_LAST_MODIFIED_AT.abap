  METHOD zif_cds_alv_ddic_access~get_last_modified_at.
    SELECT SINGLE chgdate, chgtime FROM dd02b
     WHERE strucobjn = @i_cds_view
      INTO @DATA(dd_date_time).                         "#EC CI_NOORDER
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE e007(zisu_salv) WITH i_cds_view.
    ENDIF.

    CONVERT DATE dd_date_time-chgdate TIME dd_date_time-chgtime
            INTO TIME STAMP r_modified_at TIME ZONE sy-zonlo.
  ENDMETHOD.