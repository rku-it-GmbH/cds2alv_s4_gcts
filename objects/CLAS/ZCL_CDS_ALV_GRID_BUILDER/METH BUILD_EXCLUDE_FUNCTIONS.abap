  METHOD build_exclude_functions.
    exclude_functions = VALUE #( ( cl_gui_alv_grid=>mc_fc_loc_append_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_copy )
                                 ( cl_gui_alv_grid=>mc_fc_loc_copy_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_cut )
                                 ( cl_gui_alv_grid=>mc_fc_loc_delete_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_insert_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_move_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_paste )
                                 ( cl_gui_alv_grid=>mc_fc_loc_paste_new_row )
                                 ( cl_gui_alv_grid=>mc_fc_loc_undo ) ).
  ENDMETHOD.