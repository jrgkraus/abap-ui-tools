class zcl_uitools_manip_scr definition
  public
  final
  create public .

  public section.
    methods constructor
      importing
        name type screen-name optional
        selection type screen-name optional
        group1 type screen-group1 default '*'
        group2 type screen-group1 default '*'
        group3 type screen-group1 default '*'
        group4 type screen-group1 default '*'.

    methods hide.

    methods set_noinput.

    methods set_input.

    methods unhide.

    methods set_required.

    methods set_not_required.

    methods set_dropdown_values
      importing
        values type vrm_values
      raising
        cx_static_check.

  protected section.
  private section.
      data:
        name type screen-name ,
        selection type screen-name ,
        group1 type screen-group1 ,
        group2 type screen-group1 ,
        group3 type screen-group1 ,
        group4 type screen-group1 .

    methods is_relevant
      importing
        input type screen
      returning
        value(result) type abap_bool.
    methods group_matches
      importing
        input type screen
      returning
        value(result) type abap_bool.
    methods are_groups_selected
      returning
        value(result) type abap_bool.
    methods is_group_active
      importing
        input type screen
      returning
        value(result) type abap_bool.
    methods do_groups_match
      importing
        input type screen
      returning
        value(result) type abap_bool.
endclass.



class zcl_uitools_manip_scr implementation.
  method constructor.
    me->name = name.
    me->group1 = group1.
    me->group2 = group2.
    me->group3 = group3.
    me->group4 = group4.
    me->selection = selection.
  endmethod.

  method hide.
    loop at screen.
      if is_relevant( screen ).
        screen-active = 0.
        modify screen.
      endif.
    endloop.
    if me->selection is not initial.
      set_noinput( ).
    endif.
  endmethod.

  method set_input.
    loop at screen.
      if is_relevant( screen ).
        screen-input = 1.
        modify screen.
      endif.
    endloop.

  endmethod.

  method set_noinput.
    loop at screen.
      if is_relevant( screen ).
        screen-input = 0.
        modify screen.
      endif.
    endloop.

  endmethod.

  method set_not_required.
    loop at screen.
      if is_relevant( screen ).
        screen-required = 0.
        modify screen.
      endif.
    endloop.

  endmethod.

  method set_required.
    loop at screen.
      if is_relevant( screen ).
        screen-required = 1.
        modify screen.
      endif.
    endloop.

  endmethod.

  method unhide.
    loop at screen.
      if is_relevant( screen ).
        screen-active = 1.
        modify screen.
      endif.
    endloop.

  endmethod.

  method is_relevant.
    result =
      xsdbool(
        name is not initial and input-name = name or
        group_matches( input ) or
        selection is not initial and input-name cs selection ).
  endmethod.

  METHOD group_matches.
    result = boolc(
      ( are_groups_selected( ) and
        is_group_active( input ) and
        do_groups_match( input ) ) ).
  ENDMETHOD.

  METHOD do_groups_match.
    result =
      boolc(
        ( group1 = '*' or input-group1 = group1 and
          group2 = '*' or input-group2 = group2 and
          group3 = '*' or input-group3 = group3 and
          group2 = '*' or input-group4 = group4 ) ).
  ENDMETHOD.

  METHOD is_group_active.
    result =
      boolc(
        ( input-group1 is not initial or
          input-group2 is not initial or
          input-group3 is not initial or
          input-group4 is not initial ) ).
  ENDMETHOD.

  METHOD are_groups_selected.
    result =
      boolc(
        ( group1 <> '*' or
          group2 <> '*' or
          group3 <> '*' or
          group4 <> '*' ) ).
  ENDMETHOD.

  method set_dropdown_values.
    if name is initial.
      zcl_throw=>from( 'No field specified' ).
    endif.
    data(id) = conv vrm_id( name ).
    call function 'VRM_SET_VALUES'
      exporting
        id              = id
        values          = values
      exceptions
        id_illegal_name = 1
        others          = 2.
    if sy-subrc = 1.
      zcl_throw=>from( 'Invalid field specified' ).
    endif.
  endmethod.

endclass.
