CLASS lcl_sadl_cond_provider_assoc DEFINITION
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_condition_provider .

    METHODS constructor
      IMPORTING
        !i_ddic_access       TYPE REF TO zif_cds_alv_ddic_access
        !i_source_view       TYPE ddstrucobjname
        !i_association_name  TYPE ddassociationname
        !i_source_parameters TYPE zcds_alv_parameters
        !i_selected_row      TYPE any OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA ddic_access TYPE REF TO zif_cds_alv_ddic_access.
    DATA source_view TYPE ddstrucobjname.
    DATA association_name TYPE ddassociationname.
    DATA source_parameters TYPE zcds_alv_parameters.
    DATA selected_row TYPE REF TO data.
ENDCLASS.

CLASS lcl_sadl_cond_provider_assoc IMPLEMENTATION.

  METHOD constructor.
    ddic_access = i_ddic_access.
    source_view = i_source_view.
    association_name = i_association_name.
    source_parameters = i_source_parameters.

    IF i_selected_row IS SUPPLIED AND i_selected_row IS NOT INITIAL.
      selected_row = REF #( i_selected_row ).
    ENDIF.
  ENDMETHOD.

  METHOD if_sadl_condition_provider~get_condition.
    FIELD-SYMBOLS: <curr_dd05bv> TYPE dd05bv,
                   <prev_dd05bv> TYPE dd05bv.

    CLEAR et_sadl_condition.

    IF selected_row IS BOUND.
      ASSIGN selected_row->* TO FIELD-SYMBOL(<selected_row>).
      DATA(use_selected_row) = xsdbool( <selected_row> IS ASSIGNED AND <selected_row> IS NOT INITIAL ).
    ENDIF.

    TRY.
        ddic_access->get_conditions_for_association(
          EXPORTING
            i_source_view      = source_view
            i_association_name = association_name
            i_only_constants   = xsdbool( use_selected_row = abap_false )
          IMPORTING
            e_target_view      = DATA(target_view)
            e_dd05bv_tab       = DATA(dd05bv_tab) ).

        SORT dd05bv_tab BY fdposition ASCENDING.

        LOOP AT dd05bv_tab ASSIGNING <curr_dd05bv>.
          DATA(current_index) = sy-tabix.
          DATA(range) = VALUE sabp_s_range_option( ).

          CASE <curr_dd05bv>-side_info.
            WHEN '01'. " Source element
              IF use_selected_row = abap_true.
                ASSIGN COMPONENT <curr_dd05bv>-fieldname OF STRUCTURE <selected_row> TO FIELD-SYMBOL(<source_field>).
                range-sign = 'I'.
                range-option = <curr_dd05bv>-operator.
                range-low =  <source_field>.
              ENDIF.

            WHEN '11'. " Target element

            WHEN 'L1'. " Literal
              range-sign = 'I'.
              range-option = <curr_dd05bv>-operator.
              range-low = <curr_dd05bv>-fieldname.
              range-low = replace( val = range-low sub = `'` with = `` occ =  1 ).
              range-low = replace( val = range-low sub = `'` with = `` occ = -1 ).

            WHEN 'P1'. " Parameter
              DATA(parname) = substring_after( val = <curr_dd05bv>-fieldname sub = '$' ).
              READ TABLE source_parameters INTO DATA(source_parameter)
                WITH TABLE KEY cds_view = source_view  parname = parname.
              IF sy-subrc = 0.
                range-sign = 'I'.
                range-option = <curr_dd05bv>-operator.
                range-low = source_parameter-value.
              ENDIF.

            WHEN 'S1'. " Session variable
              DATA(session_variable) = substring_after( val = <curr_dd05bv>-fieldname sub = `$SESSION.` ).
              range-sign = 'I'.
              range-option = <curr_dd05bv>-operator.
              range-low = SWITCH #( session_variable
                WHEN `SYSTEM_DATE`     THEN sy-datum
                WHEN `SYSTEM_TIME`     THEN sy-uzeit
                WHEN `SYSTEM_LANGUAGE` THEN sy-langu
                WHEN `CLIENT`          THEN sy-mandt
                WHEN `USER`            THEN sy-uname ).
          ENDCASE.

          IF range IS INITIAL.
            CONTINUE.
          ENDIF.

          cl_sadl_condition_generator=>append_sadl_condition(
            EXPORTING
              iv_attribute       = CONV #( <curr_dd05bv>-fieldname_t )
              iv_option          = range-option
              iv_low             = range-low
            CHANGING
              ct_sadl_conditions = et_sadl_condition ).

          IF <prev_dd05bv> IS ASSIGNED AND <prev_dd05bv>-and_or = 'AND'.
            APPEND VALUE #( type = if_sadl_query_engine_types=>co_condition_types-and ) TO et_sadl_condition.
          ELSEIF <prev_dd05bv> IS ASSIGNED AND <prev_dd05bv>-and_or = 'OR'.
            APPEND VALUE #( type = if_sadl_query_engine_types=>co_condition_types-or ) TO et_sadl_condition.
          ENDIF.

          READ TABLE dd05bv_tab INDEX current_index ASSIGNING <prev_dd05bv>.
        ENDLOOP.

      CATCH zcx_cds_alv_message.
        RAISE EXCEPTION TYPE cx_sadl_contract_violation
          EXPORTING
            textid = cx_sadl_contract_violation=>entity_not_found
            name   = CONV #( source_view ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.