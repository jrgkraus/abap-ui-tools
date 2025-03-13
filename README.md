# Collection of tools for the classic dynpro UI of SAP

The provided class ZCL_UITOOLS can be used via inheritance or as an instance.

## Manipulate screen fields

Instead of using `loop at screen.`, you can now use the following calls to influence on the screen behaviour

    " hide a field by group or name
    group( 'GR1' )->hide( ).
    field( 'MATNR' )->hide( ).
    " hide a selection or a parameter of a report screen
    selection( 'S_MATNR' )->hide( ).
