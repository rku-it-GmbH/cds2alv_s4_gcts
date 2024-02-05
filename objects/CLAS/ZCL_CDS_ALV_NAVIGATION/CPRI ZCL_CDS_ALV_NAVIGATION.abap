private section.

  constants:
    BEGIN OF mass_processing,
                 none  TYPE zcds_alv_nav_mass_processing VALUE space,
                 loop  TYPE zcds_alv_nav_mass_processing VALUE 'L',
                 table TYPE zcds_alv_nav_mass_processing VALUE 'T',
               END OF mass_processing .
  constants EXIT_INTERFACE type SEOITFNAME value 'ZIF_CDS_ALV_NAVIGATION' ##NO_TEXT.
  data PERSISTENCE type ref to ZIF_CDS_ALV_PERSISTENCE .
  data DDIC_ACCESS type ref to ZIF_CDS_ALV_DDIC_ACCESS .
  data LAUNCHER type ref to ZIF_CDS_ALV_REPORT_LAUNCHER .
  data IOC_CONTAINER type ref to ZIF_CDS_ALV_IOC_CONTAINER .
  data NAVIGATION_TABLE type ZCDS_ALV_NAVIGATION_TAB .
  data NAVIGATION_EXITS type ZCDS_ALV_NAVIGATION_EXIT_TAB .

  methods ASK_FOR_MISSING_PARAMETERS
    importing
      !I_TARGET_VIEW type DDSTRUCOBJNAME
    changing
      !C_PARAMETER_VALUES type ZCDS_ALV_PARAMETERS
    raising
      ZCX_CDS_ALV_MESSAGE .
  methods CALL_BOR_METHOD
    importing
      !I_NAVIGATION type ZCDS_ALV_NAV
      !I_KEY_FIELD type FIELDNAME
      !I_SELECTED_ROW type ANY
    raising
      ZCX_CDS_ALV_MESSAGE .
  methods CALL_FUNCTION_MODULE
    importing
      !I_NAVIGATION type ZCDS_ALV_NAV
      !I_KEY_FIELD type FIELDNAME optional
      !I_SELECTED_ROW type ANY optional
      !I_SELECTED_ROWS type STANDARD TABLE optional
    raising
      ZCX_CDS_ALV_MESSAGE .
  methods CALL_TRANSACTION
    importing
      !I_NAVIGATION type ZCDS_ALV_NAV
      !I_KEY_FIELD type FIELDNAME
      !I_SELECTED_ROW type ANY
    raising
      ZCX_CDS_ALV_MESSAGE .
  methods CALL_OO_METHOD
    importing
      !I_NAVIGATION type ZCDS_ALV_NAV
      !I_KEY_FIELD type FIELDNAME optional
      !I_SELECTED_ROW type ANY optional
      !I_SELECTED_ROWS type STANDARD TABLE optional
    raising
      ZCX_CDS_ALV_MESSAGE .
  methods FILL_IOC_CONTAINER .
  methods GET_OBJECT_FROM_IOC_CONTAINER
    importing
      !I_NAVIGATION_EXIT type ZCDS_ALV_NAVEXIT
    returning
      value(R_OBJECT) type ref to ZIF_CDS_ALV_NAVIGATION
    raising
      ZCX_CDS_ALV_MESSAGE .