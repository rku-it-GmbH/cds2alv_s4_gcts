  METHOD zif_cds_alv_report_strategy~write_source.
    DEFINE append_initial_line.
      APPEND | | TO r_program-source_lines.
    END-OF-DEFINITION.

    DATA source_line   LIKE LINE OF r_program-source_lines.
    DATA template_name TYPE fieldname.

    " Program Header Info
    r_program-progname = progname.
    r_program-dynpro   = '1001'.
    template_name = |_{ cds_view }|.

    " TOP Section
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |REPORT { progname }.| )
                                                 ( |TABLES: sscrfields.| )
                                                 ( |DATA: { template_name } TYPE { cds_view }.|  ) )
           TO r_program-source_lines.
    append_initial_line.

    APPEND LINES OF VALUE zcds_alv_source_lines( ( |CONSTANTS cds_view TYPE ddstrucobjname VALUE '{ cds_view }'.| )
                                                 ( |CONSTANTS title TYPE sytitle VALUE '{ description }'.| ) ) TO r_program-source_lines.
    append_initial_line.

    APPEND LINES OF VALUE zcds_alv_source_lines( ( |DATA factory TYPE REF TO zif_cds_alv_factory.             | )
                                                 ( |DATA controller TYPE REF TO zif_cds_alv_report_controller.| )
                                                 ( |DATA message TYPE REF TO zcx_cds_alv_message.             | ) ) TO r_program-source_lines.
    append_initial_line.

    APPEND LINES OF VALUE zcds_alv_source_lines(
                              ( |SELECTION-SCREEN BEGIN OF SCREEN { r_program-dynpro } AS SUBSCREEN.| )
                              ( |SELECTION-SCREEN BEGIN OF BLOCK sub.                               | ) ) TO r_program-source_lines.

    " View Parameters
    DATA parameter_counter TYPE n LENGTH 5.
    LOOP AT param_properties_tab ASSIGNING FIELD-SYMBOL(<param_properties>).
      parameter_counter = parameter_counter + 1.
      <param_properties>-sel_name = CONV rsscr_name( |P__{ parameter_counter }| ).

      source_line = |PARAMETERS { <param_properties>-sel_name } TYPE { <param_properties>-data_type } OBLIGATORY|.

      IF <param_properties>-default_value IS NOT INITIAL.
        source_line = |{ source_line } DEFAULT '{ <param_properties>-default_value }'|.
      ELSEIF <param_properties>-system_field IS NOT INITIAL.
        source_line = |{ source_line } DEFAULT sy-{ <param_properties>-system_field }|.
      ENDIF.

      source_line = |{ source_line }.|.
      APPEND source_line TO r_program-source_lines.

      INSERT VALUE #( progname = progname
                      sel_name = <param_properties>-sel_name
                      cds_view = cds_view
                      parname  = <param_properties>-parname )
             INTO TABLE r_program-parameters.
    ENDLOOP.

    " Selection Criteria (from CDS-View-Annotation Consumption.Filter)
    DATA(skip) = abap_false.
    DATA selection_counter TYPE n LENGTH 5.
    SORT field_properties_tab STABLE BY qualifier DESCENDING
                                        position ASCENDING.
    LOOP AT field_properties_tab ASSIGNING FIELD-SYMBOL(<field_properties>).
      selection_counter = selection_counter + 1.
      <field_properties>-sel_name = CONV rsscr_name( |SO_{ selection_counter }| ).

      source_line = |SELECT-OPTIONS { <field_properties>-sel_name } FOR { template_name }-{ <field_properties>-fieldname }|.

      IF <field_properties>-selection_type = selection_type-single.
        source_line = |{ source_line } NO INTERVALS|.
      ENDIF.

      IF <field_properties>-mandatory = abap_true.
        source_line = |{ source_line } OBLIGATORY|.
      ENDIF.

      IF <field_properties>-default_value IS NOT INITIAL.
        source_line = |{ source_line } DEFAULT '{ <field_properties>-default_value }'|.
      ENDIF.

      IF <field_properties>-no_display = abap_true.
        source_line = |{ source_line } NO-DISPLAY|.
      ELSE.
        skip = abap_true.
      ENDIF.

      source_line = |{ source_line }.|.
      APPEND source_line TO r_program-source_lines.

      AT END OF qualifier.
        IF skip = abap_true.
          source_line = |SELECTION-SCREEN SKIP.|.
          APPEND source_line TO r_program-source_lines.
          skip = abap_false.
        ENDIF.
      ENDAT.

      INSERT VALUE #( progname  = progname
                      sel_name  = <field_properties>-sel_name
                      cds_view  = cds_view
                      fieldname = <field_properties>-fieldname )
             INTO TABLE r_program-select_options.
    ENDLOOP.

    " Default parameters
    APPEND LINES OF VALUE zcds_alv_source_lines(
        ( |PARAMETERS p_maxrec TYPE ddshmaxrec DEFAULT 500 MODIF ID max.| )
        ( |PARAMETERS p_no_max TYPE xfeld USER-COMMAND no_max.          | )
        ( |SELECTION-SCREEN SKIP.                                       | )
        ( |PARAMETERS p_selext TYPE zcds_alv_report_extension_name AS LISTBOX visible length 40 USER-COMMAND switch_sel MODIF ID sel.| )
        ( |PARAMETERS p_disext TYPE zcds_alv_report_extension_name AS LISTBOX visible length 40 USER-COMMAND switch_dis MODIF ID dis.| )
        ( |SELECTION-SCREEN SKIP.                                       | )
        ( |PARAMETERS p_vari   TYPE slis_vari.                          | )
        ( |PARAMETERS p_split  TYPE xfeld DEFAULT abap_false.           | )
        ( |PARAMETERS p_forall TYPE xfeld NO-DISPLAY.                   | )
        ( |PARAMETERS p_mem_id TYPE zcds_alv_memory_id NO-DISPLAY.      | )
        ( |SELECTION-SCREEN SKIP.                                       | ) ) TO r_program-source_lines.

    " Extension parameters
    LOOP AT get_extension_parameters( ) INTO DATA(ext_parameter).
      APPEND |PARAMETERS { ext_parameter-parameter_name } TYPE { ext_parameter-db_field }.| TO r_program-source_lines.
    ENDLOOP.

    " End of Subscreen
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |SELECTION-SCREEN END OF BLOCK sub.                  | )
                                                 ( |SELECTION-SCREEN END OF SCREEN { r_program-dynpro }.| ) ) TO r_program-source_lines.
    append_initial_line.

    " Include in main selection screen
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |SELECTION-SCREEN BEGIN OF BLOCK main WITH FRAME TITLE text-sub.| )
                                                 ( |SELECTION-SCREEN INCLUDE BLOCKS sub.                           | )
                                                 ( |SELECTION-SCREEN END OF BLOCK main.                            | ) ) TO r_program-source_lines.
    append_initial_line.

    " LOAD-OF-PROGRAM
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |LOAD-OF-PROGRAM.                                               | )
                                                 ( |  TRY.                                                         | )
                                                 ( |      factory = zcl_cds_alv_factory=>get_instance( ).          | )
                                                 ( |      controller = factory->get_report_controller( cds_view ). | )
                                                 ( |    CATCH zcx_cds_alv_message INTO message.                    | )
                                                 ( |      MESSAGE message TYPE 'A'.                                | )
                                                 ( |  ENDTRY.                                                      | ) ) TO r_program-source_lines.
    append_initial_line.

    " INITIALIZATION
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |INITIALIZATION.                                 | )
                                                 ( |  sy-title = title.                             | )
                                                 ( |                                                | )
                                                 ( |  TRY.                                          | )
                                                 ( |      controller->initialization( ).            | )
                                                 ( |    CATCH zcx_cds_alv_message INTO message.     | )
                                                 ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.| )
                                                 ( |  ENDTRY.                                       | ) ) TO r_program-source_lines.
    append_initial_line.

    " AT SELECTION-SCREEN OUTPUT
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |AT SELECTION-SCREEN OUTPUT.                      | )
                                                 ( |  TRY.                                           | )
                                                 ( |      controller->at_selection_screen_output( ). | )
                                                 ( |    CATCH zcx_cds_alv_message INTO message.      | )
                                                 ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'. | )
                                                 ( |  ENDTRY.                                        | ) ) TO r_program-source_lines.
    append_initial_line.

    " AT-SELECTION-SCREEN
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |AT SELECTION-SCREEN.                                       | )
                                                 ( |  TRY.                                                     | )
                                                 ( |      controller->at_selection_screen( sscrfields-ucomm ). | )
                                                 ( |    CATCH zcx_cds_alv_message INTO message.                | )
                                                 ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.           | )
                                                 ( |  ENDTRY.                                                  | ) ) TO r_program-source_lines.
    append_initial_line.

    " Value help for the initial layout
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.     | )
                                                 ( |  p_vari = cl_salv_layout_service=>f4_layouts(       | )
                                                 ( |               s_key  = VALUE #( report = sy-repid ) | )
                                                 ( |               layout = p_vari )-layout.             | ) ) TO r_program-source_lines.

    " Value help (from CDS-View-Annotation Consumption.ValueHelp)
    LOOP AT param_properties_tab INTO DATA(param_properties)
         WHERE value_help = abap_true.

      APPEND LINES OF VALUE zcds_alv_source_lines(
                                ( |AT SELECTION-SCREEN ON VALUE-REQUEST FOR { param_properties-sel_name }. | )
                                ( |  TRY.                                                                  | )
                                ( |      controller->at_value_request(                                     | )
                                ( |        EXPORTING                                                       | )
                                ( |          i_sel_name = '{ param_properties-sel_name }'                  | )
                                ( |        CHANGING                                                        | )
                                ( |          c_value    = { param_properties-sel_name } ).                 | )
                                ( |    CATCH zcx_cds_alv_message INTO message.                             | )
                                ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.                        | )
                                ( |  ENDTRY.                                                               | ) ) TO r_program-source_lines.
      append_initial_line.
    ENDLOOP.

    LOOP AT field_properties_tab INTO DATA(field_properties)
         WHERE value_help = abap_true AND no_display = abap_false.

      APPEND LINES OF VALUE zcds_alv_source_lines(
                                ( |AT SELECTION-SCREEN ON VALUE-REQUEST FOR { field_properties-sel_name }-low. | )
                                ( |  TRY.                                                                      | )
                                ( |      controller->at_value_request(                                         | )
                                ( |        EXPORTING                                                           | )
                                ( |          i_sel_name = '{ field_properties-sel_name }'                      | )
                                ( |        CHANGING                                                            | )
                                ( |          c_value    = { field_properties-sel_name }-low ).                 | )
                                ( |    CATCH zcx_cds_alv_message INTO message.                                 | )
                                ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.                            | )
                                ( |  ENDTRY.                                                                   | )
                                ( |                                                                            | )
                                ( |AT SELECTION-SCREEN ON VALUE-REQUEST FOR { field_properties-sel_name }-high.| )
                                ( |  TRY.                                                                      | )
                                ( |      controller->at_value_request(                                         | )
                                ( |        EXPORTING                                                           | )
                                ( |          i_sel_name = '{ field_properties-sel_name }'                      | )
                                ( |        CHANGING                                                            | )
                                ( |          c_value    = { field_properties-sel_name }-high ).                | )
                                ( |    CATCH zcx_cds_alv_message INTO message.                                 | )
                                ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.                            | )
                                ( |  ENDTRY.                                                                   | ) ) TO r_program-source_lines.
      append_initial_line.
    ENDLOOP.

    " Help and value help for extension parameters
    LOOP AT get_extension_parameters( ) INTO ext_parameter WHERE has_value_help = abap_true.
      APPEND LINES OF VALUE zcds_alv_source_lines(
                                ( |AT SELECTION-SCREEN ON VALUE-REQUEST FOR { ext_parameter-parameter_name }.| )
                                ( |  TRY.                                                                    | )
                                ( |      controller->at_value_request(                                       | )
                                ( |        EXPORTING                                                         | )
                                ( |          i_sel_name = '{ ext_parameter-parameter_name }'                 | )
                                ( |        CHANGING                                                          | )
                                ( |          c_value    = { ext_parameter-parameter_name } ).                | )
                                ( |    CATCH zcx_cds_alv_message INTO message.                               | )
                                ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.                          | )
                                ( |  ENDTRY.                                                                 | ) ) TO r_program-source_lines.
      append_initial_line.
    ENDLOOP.

    LOOP AT get_extension_parameters( ) INTO ext_parameter WHERE has_help = abap_true.
      APPEND LINES OF VALUE zcds_alv_source_lines(
                                ( |AT SELECTION-SCREEN ON HELP-REQUEST FOR { ext_parameter-parameter_name }.| )
                                ( |  TRY.                                                                   | )
                                ( |      controller->at_help_request(                                       | )
                                ( |          i_sel_name = '{ ext_parameter-parameter_name }'                | )
                                ( |    CATCH zcx_cds_alv_message INTO message.                              | )
                                ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'.                         | )
                                ( |  ENDTRY.                                                                | ) ) TO r_program-source_lines.
      append_initial_line.
    ENDLOOP.

    " START-OF-SELECTION
    APPEND LINES OF VALUE zcds_alv_source_lines( ( |START-OF-SELECTION.                              | )
                                                 ( |  TRY.                                           | )
                                                 ( |      controller->start_of_selection(            | )
                                                 ( |          i_selection       = p_selext           | )
                                                 ( |          i_display         = p_disext           | )
                                                 ( |          i_forall          = p_forall           | )
                                                 ( |          i_memory_id       = p_mem_id           | )
                                                 ( |          i_in_split_screen = p_split ).         | )
                                                 ( |                                                 | )
                                                 ( |    CATCH zcx_cds_alv_message INTO message.      | )
                                                 ( |      MESSAGE message TYPE 'I' DISPLAY LIKE 'E'. | )
                                                 ( |  ENDTRY.                                        | ) ) TO r_program-source_lines.
  ENDMETHOD.