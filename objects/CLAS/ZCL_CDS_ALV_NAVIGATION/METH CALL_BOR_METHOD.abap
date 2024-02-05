  METHOD call_bor_method.
    DATA objkey    TYPE swo_typeid.
    DATA object    TYPE swo_objhnd.
    DATA return    TYPE swotreturn.
    DATA container TYPE swconttab.

    ASSIGN COMPONENT i_key_field OF STRUCTURE i_selected_row TO FIELD-SYMBOL(<key>).
    objkey = <key>.

    CALL FUNCTION 'SWO_CREATE'
      EXPORTING objtype = i_navigation-object_type
                objkey  = objkey
      IMPORTING object  = object
                return  = return.
    IF return-errortype <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CALL FUNCTION 'SWO_INVOKE'
      EXPORTING object    = object
                verb      = i_navigation-object_method
      IMPORTING return    = return
      TABLES    container = container.
    IF return-errortype <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CALL FUNCTION 'SWO_FREE'
      EXPORTING object = object
      IMPORTING return = return.
    IF return-errortype <> 0.
      RAISE EXCEPTION TYPE zcx_cds_alv_message
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.