part of '../text_form_builder.dart';

/// This class is used for returning the `options`, which
/// you can use to `build` your [TextFormField] widget

class TextFieldOptions {
  final String id;
  final String title;
  final String value;
  final bool disabled;
  final bool obscureText;
  final int lines;
  final TextInputType keyboardType;
  final Function(String value) validator;
  final Function(String value) onFieldSubmitted;
  final Function(String value) onChanged;

  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function(String value) onSaved;

  TextFieldOptions({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.disabled,
    @required this.obscureText,
    @required this.lines,
    @required this.keyboardType,
    @required this.validator,
    @required this.onFieldSubmitted,
    @required this.onChanged,
    @required this.focusNode,
    @required this.textInputAction,
    @required this.onSaved,
  });
}
