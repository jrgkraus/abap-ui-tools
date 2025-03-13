class enum_answer definition
  final
  create private.

  public section.
    class-methods:
      class_constructor,
      from_value
        importing value type char1
        returning value(result) type ref to enum_answer
        raising   cx_static_check.
    class-data:
      cancelled type ref to enum_answer,
      yes_button type ref to enum_answer,
      no_button type ref to enum_answer.
    data:
      value type char1 read-only.
  protected section.
  private section.
    methods:
      constructor importing value type char1.
    class-data:
      gt_registry type standard table of ref to enum_answer.
endclass.
