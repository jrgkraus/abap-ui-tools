*&---------------------------------------------------------------------*
*& Report zp_uitools_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_uitools_demo.

tables sscrfields.


selection-screen pushbutton /1(30) pt1 user-command p1.
selection-screen pushbutton /1(30) pt2 user-command p2.
selection-screen pushbutton /1(30) pt5 user-command p5.
selection-screen pushbutton /1(30) pt6 user-command p6.
selection-screen pushbutton /1(30) pt3 user-command p3.
selection-screen pushbutton /1(30) pt4 user-command p4.

parameters toreq as checkbox user-command dum.
parameters groupnr type char1 as listbox visible length 10 modif id gr1.
select-options selopt for groupnr.

class app definition inheriting from zcl_uitools.
  public section.
    methods demo_ask.
    methods demo_ask_with_cancel.
endclass.

class app implementation.

  method demo_ask.
    if ask( question = 'Is this OK?' ).
      message 'OK' type 'I'.
    else.
      message 'not OK' type 'I'.
    endif.
  endmethod.

  method demo_ask_with_cancel.
    try.
        if ask_with_cancel( question = 'Is this OK?' ).
          message 'OK' type 'I'.
        else.
          message 'not OK' type 'I'.
        endif.
      catch zcx_uitools_user_cancelled into data(e).
        message e type 'I' display like 'E'.
    endtry.
  endmethod.

endclass.

data application type ref to app.
data group_hidden type abap_bool.
data selopt_hidden type abap_bool.


initialization.
  pt1 = 'Hide field'.
  pt2 = 'Unhide field'.
  pt5 = 'Hide selection'.
  pt6 = 'Unhide selection'.
  pt3 = 'Ask question'.
  pt4 = 'Ask with cancel'.

  application = new app( ).

at selection-screen output.
  try.
      if group_hidden = abap_true.
        application->group( 'GR1' )->hide( ).
      endif.
      if selopt_hidden = abap_true.
        application->selection( 'SELOPT' )->hide( ).
      endif.
      if toreq = abap_true.
        application->field( 'GROUPNR' )->set_required( ).
      endif.
      application->field( 'GROUPNR' )->set_dropdown_values(
        value #(
          ( key = '1' text = 'First group' )
          ( key = '2' text = 'Second group' )
          ( key = '3' text = 'Third group' )
          ( key = '4' text = 'Forth group' ) ) ).
    catch cx_static_check into data(e).
      message e type 'I'.
  endtry.

at selection-screen.
  case sscrfields-ucomm.
    when 'P1'.
      group_hidden = abap_true.
    when 'P2'.
      group_hidden = abap_false.
    when 'P5'.
      selopt_hidden = abap_true.
    when 'P6'.
      selopt_hidden = abap_false.
    when 'P3'.
      application->demo_ask( ).
    when 'P4'.
      application->demo_ask_with_cancel( ).
    when 'P1'.
  endcase.
