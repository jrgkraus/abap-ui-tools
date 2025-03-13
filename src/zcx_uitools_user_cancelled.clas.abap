class zcx_uitools_user_cancelled definition
  public
  inheriting from cx_static_check
  final
  create public .

  public section.

    interfaces if_t100_dyn_msg .
    interfaces if_t100_message .

    constants:
      begin of zcx_uitools_user_cancelled,
        msgid type symsgid value 'ZM_UITOOLS',
        msgno type symsgno value '001',
        attr1 type scx_attrname value '',
        attr2 type scx_attrname value '',
        attr3 type scx_attrname value '',
        attr4 type scx_attrname value '',
      end of zcx_uitools_user_cancelled.

    methods constructor
      importing
        !textid   like if_t100_message=>t100key optional
        !previous like previous optional .
  protected section.
  private section.
endclass.



class zcx_uitools_user_cancelled implementation.


  method constructor ##ADT_SUPPRESS_GENERATION.
    call method super->constructor
      exporting
        previous = previous.
    clear me->textid.
    if textid is initial.
      if_t100_message~t100key = zcx_uitools_user_cancelled.
    else.
      if_t100_message~t100key = textid.
    endif.
  endmethod.
endclass.
