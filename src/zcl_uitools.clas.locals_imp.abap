
class enum_answer implementation.
  method class_constructor.
    define init.
      &1 = NEW #( &2 ).
      INSERT &1 INTO TABLE gt_registry.
    end-of-definition.

    init: yes_button '1',
          no_button '2',
          cancelled 'A'.
  endmethod.

  method from_value.
    try.
        result = gt_registry[ table_line->value = value ].
      catch cx_sy_itab_line_not_found into data(lx_ex).
        zcl_throw=>from( 'illegal value for ANSWER' ).
    endtry.
  endmethod.

  method constructor.
    me->value = value.
  endmethod.

endclass.
