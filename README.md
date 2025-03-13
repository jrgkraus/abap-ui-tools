# Collection of tools for the classic dynpro UI of SAP

The provided class ZCL_UITOOLS can be used via inheritance or as an instance.

## Manipulate screen fields in PBO

Instead of using `loop at screen.`, you can now use the following calls to influence on the screen behaviour. The following examples are based on a class that inheritates from ZCL_UITOOLS

    " hide a field by group or name
    group( 'GR1' )->hide( ).
    field( 'MATNR' )->hide( ).
    " hide a selection or a parameter of a report screen
    selection( 'S_MATNR' )->hide( ).
    " set fields to no-input
    group( 'GR1' )->set_noinput( ).
    field( 'MATNR' )->set_noinput( ).
    " make a field obligatory
    group( 'GR1' )->set_required( ).
    field( 'MATNR' )->set_required( ).

## Set dropdown values in PBO

Using the `field( )` method, you can set dropdown values for a list box

      field( 'GROUPNR' )->set_dropdown_values(
        value #(
          ( key = '1' text = 'First group' )
          ( key = '2' text = 'Second group' )
          ( key = '3' text = 'Third group' )
          ( key = '4' text = 'Forth group' ) ) ).

## Simple Yes/No (/Cancel) queries

The methods  `ask( )` and `ask_with_cancel( )` provide a simple interface to POPUP_TO_CONFIRM

    if ask( question = 'Is this OK?' ).
      message 'OK' type 'I'.
    else.
      message 'not OK' type 'I'.
    endif.
    " verson that displays also a cancel button
    try.
        if ask_with_cancel( question = 'Is this OK?' ).
          message 'OK' type 'I'.
        else.
          message 'not OK' type 'I'.
        endif.
      catch zcx_uitools_user_cancelled into data(e).
        message e type 'I' display like 'E'.
    endtry.

Both methods provide also an optional parameter `LONGTEXT` where you can pass a longtext object created with SE61

## dependencies

The coding uses ![ZCL_THROW](https://github.com/abapify/throw), which depends on ![ZCL_ASSERTABLE_UNIT](https://github.com/abapify/assert)
