  METHOD update_style_info.
    FIELD-SYMBOLS <style_table> TYPE lvc_t_styl.
    FIELD-SYMBOLS <table>       TYPE STANDARD TABLE.

    ASSIGN ref_to_table->* TO <table>.

    LOOP AT <table> ASSIGNING FIELD-SYMBOL(<row>).
      ASSIGN COMPONENT special_columns-style_fieldname OF STRUCTURE <row> TO <style_table>.
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.

      LOOP AT ddfields INTO DATA(ddfield).
        ASSIGN <style_table>[ fieldname = ddfield-fieldname ] TO FIELD-SYMBOL(<style>).
        IF sy-subrc <> 0.
          INSERT VALUE lvc_s_styl( fieldname = ddfield-fieldname ) INTO TABLE <style_table> ASSIGNING <style>.
        ENDIF.

        IF line_exists( read_only_fields[ table_line = ddfield-fieldname ] ).
          <style>-style = cl_gui_alv_grid=>mc_style_disabled.
        ELSE.
          <style>-style = SWITCH #( in_edit_mode
                                    WHEN abap_false THEN cl_gui_alv_grid=>mc_style_disabled
                                    WHEN abap_true  THEN cl_gui_alv_grid=>mc_style_enabled ).
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.