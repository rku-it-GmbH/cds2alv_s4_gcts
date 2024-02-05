  METHOD constructor.
    persistence = i_persistence.
    ddic_access = i_ddic_access.
    launcher    = i_launcher.
    navigation_table = persistence->get_intent_based_navigation( ).
    navigation_exits = persistence->get_navigation_exits( ).
    fill_ioc_container( ).
  ENDMETHOD.