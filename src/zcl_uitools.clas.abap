class zcl_uitools definition
  public
  abstract
  create public .

  public section.
    methods ask
      importing
        question      type clike optional
        longtext      type dokhl-object optional
          preferred parameter question
      returning
        value(result) type abap_bool.

    methods ask_with_cancel
      importing
        question      type clike optional
        longtext      type dokhl-object optional
          preferred parameter question
      returning
        value(result) type abap_bool
      raising
        zcx_uitools_user_cancelled.

    methods field
      importing
        input type screen-name
      returning
        value(result) type ref to zcl_uitools_manip_scr.

    methods selection
      importing
        input type screen-name
      returning
        value(result) type ref to zcl_uitools_manip_scr.

    methods group
      importing
        first type screen-group1 default '*'
        second type screen-group1 default '*'
        third type screen-group1 default '*'
        forth type screen-group1 default '*'
          preferred parameter first
      returning
        value(result) type ref to zcl_uitools_manip_scr.

  protected section.
  private section.

    methods ask_low
      importing
        question      type clike optional
        longtext      type dokhl-object optional
        cancel_flag   type abap_bool optional
          preferred parameter question
      returning
        value(result) type abap_bool
      raising
        zcx_uitools_user_cancelled.

    methods get_system_message
      returning
        value(result) type string.
endclass.


class zcl_uitools implementation.
  method ask.
    try.
        result = ask_low(
                    question = question
                    longtext = longtext ).
      catch zcx_uitools_user_cancelled ##no_handler.
    endtry.
  endmethod.

  method ask_with_cancel.
    result = ask_low(
                question = question
                longtext = longtext
                cancel_flag = abap_true ).
  endmethod.

  method ask_low.
*  --------------------------------------------------------------------*
*   sends a yes/no question using a popup screen
*   if iv_question is set, the text will be used directly
*   if no question is given, the text is taken from the last message
*   iv_longtext can pass a long text object created with SE61
*   if user agrees: result goes to abap_true
*  --------------------------------------------------------------------*
    data answer type char1.

    data(local_question) =
      cond string(
        when question is supplied
          then question
          else get_system_message( ) ).

    call function 'POPUP_TO_CONFIRM'
      exporting
        text_question         = local_question
        diagnose_object       = longtext
        display_cancel_button = cancel_flag
      importing
        answer                = answer.

    try.
        result =
          cond #(
            when enum_answer=>from_value( answer ) = enum_answer=>no_button
            then abap_false
            when enum_answer=>from_value( answer ) = enum_answer=>yes_button
            then abap_true
            else abap_undefined ).
      catch cx_static_check into data(e).
        message e type 'I' display like 'E'.
        return.
    endtry.
    if result = abap_undefined.
      raise exception type zcx_uitools_user_cancelled.
    endif.
  endmethod.

  method get_system_message.
    message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 into result.
  endmethod.

  method field.
    result = new #( name = input ).
  endmethod.

  method group.
    result =
      new #(
        group1 = first
        group2 = second
        group3 = third
        group4 = forth ).
  endmethod.

  method selection.
    result = new #( selection = input ).
  endmethod.

endclass.
