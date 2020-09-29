part of '../text_form_builder.dart';

class TextFormBuilderError implements Exception {
  final String message;

  TextFormBuilderError([this.message = "Unknown TextFormBuilderError"]);

  String toString() => message;
}
