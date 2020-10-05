part of '../text_form_builder.dart';

class TextFieldResultList {
  final List<TextFieldResult> results;

  TextFieldResultList(this.results);

  TextFieldResult find(String id) {
    return results.firstWhere(
      (result) => result.id == id,
      orElse: () => null,
    );
  }
}
