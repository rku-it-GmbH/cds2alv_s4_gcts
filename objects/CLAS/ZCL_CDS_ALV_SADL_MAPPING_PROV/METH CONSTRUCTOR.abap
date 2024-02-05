  METHOD constructor.
    GET TIME STAMP FIELD DATA(timestamp).
    DATA(uuid) = CONV if_sadl_types=>ty_uuid( |ZCDS_ALV:{ i_entity->get_id( ) }| ).
    super->constructor( iv_uuid = uuid iv_timestamp = timestamp ).
    entity = i_entity.
  ENDMETHOD.