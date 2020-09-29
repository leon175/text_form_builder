part of '../text_form_builder.dart';

/// This class is used for returning the `data` of
/// your [TextFormField] after submitting the form

class TextFieldResult {
  final String id;
  final String value;

  TextFieldResult(this.id, this.value);

  String toString() => "TextFieldResult($id, $value)";
}
