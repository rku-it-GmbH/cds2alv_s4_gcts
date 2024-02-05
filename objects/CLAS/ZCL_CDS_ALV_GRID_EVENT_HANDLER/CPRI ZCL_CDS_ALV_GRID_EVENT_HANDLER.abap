  PRIVATE SECTION.
    METHODS call_browser
      IMPORTING i_url TYPE string
      RAISING   zcx_cds_alv_message.

    METHODS send_email
      IMPORTING i_email TYPE ad_smtpadr
      RAISING   zcx_cds_alv_message.