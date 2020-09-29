part of '../text_form_builder.dart';

/// This widget is used to mark where your [TextFormField]
/// should be built in the [Form]

class TextFormBuilderField extends Widget {
  final String id;
  final String title;
  final String value;
  final bool disabled;
  final int lines;
  final TextInputType keyboardType;
  final Function(String value) validator;
  final Function(String value) onFieldSubmitted;
  final Function(String value) onChanged;

  TextFormBuilderField({
    @required this.id,
    this.title = "",
    this.value = "",
    this.disabled = false,
    this.lines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Element createElement() {
    return null;
  }
}
